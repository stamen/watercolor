from PIL import Image, ImageChops
from functions import arr2img, watercolorize, get_outlines, get_shadows, simplemask, get_color_masks
import json
import TileStache
from TileStache.Providers import Mapnik
from ModestMaps.Core import Point
import os
import numpy
import tempfile
from urlparse import urljoin, urlparse
from os.path import realpath

class Provider:

    def __init__(self, layer, defaults=None, sources=None, stack=None):
        # create a new provider for a layer
        self.layer = layer
        self.defaults = defaults
        self.sources = sources
        self.stack = stack

        self.opened_images = dict()

    def parseZoom(self, zoomString):
        spl = zoomString.split("-")
        if len(spl) == 1:
            return [int(spl[0])]
        else:
            return range(int(spl[0]), int(spl[1]) + 1)

    def open_image(self, filename):
        """
        """

        filename = realpath(filename)

        if filename not in self.opened_images:
            while True:
                a = Image.open(filename)
                try:
                    a.load()
                    self.opened_images[filename] = a
                    break
                except:
                    pass

        return self.opened_images[filename]

    def get_texture_offsets(self, texture, xmin, ymax, zoom):

        texture_width, texture_height = texture.size

        # exact coordinate of upper-left corner of the selected area
        ul_coord = self.layer.projection.projCoordinate(Point(xmin, ymax))

        # pixel position, in the current render area, of the top-left
        # corner of a 1024x1024 texture image assuming 256x256 tiles.
        texture_x_offset = int(round(ul_coord.zoomTo(zoom + 8).column) % texture_width)
        texture_y_offset = int(round(ul_coord.zoomTo(zoom + 8).row) % texture_height)

        # pixel positions adjusted to cover full image by going negative
        texture_x_offset = texture_x_offset and (texture_x_offset - texture_width)
        texture_y_offset = texture_y_offset and (texture_y_offset - texture_height)

        return texture_x_offset, texture_y_offset

    def renderArea(self, width, height, srs, xmin, ymin, xmax, ymax, zoom):
        """ Return an object with a PIL-like save() method for an area
        """

        # comp is the final destination image that eventually gets returned
        comp = Image.new("RGB", (width, height), "#FFFFFF")

        #
        # Set up a dictionary of color-keyed channels from Mapnik renderings.
        # Variable mapnik_style is likely one of "mask_set_1" or "mask_set_2",
        # referring to files like mask_set_1/style.xml for Mapnik.
        #
        # Color_dict looks like:
        #   {"mask_set_1": {"0xff9900": "civic", ...}, "mask_set_2": {...}}
        #
        # Mapnik_layers looks like:
        #   {"mask_set_1": ["0xff9900", "0x990099", ...], "mask_set_2": [...]}
        #
        mapnik_layers = {}
        color_dict = {}


        for source_name in self.sources:
            mapnik_style = self.sources[source_name]["layer"]
            source_color = self.sources[source_name]["color"]

            if mapnik_style not in mapnik_layers:
                mapnik_layers[mapnik_style] = []
            if mapnik_style not in color_dict:
                color_dict[mapnik_style] = {}

            mapnik_layers[mapnik_style].append(source_color)
            color_dict[mapnik_style][source_color] = source_name

        #
        # Set up a dictionary of Numpy channels for each source, e.g. "civic".
        # Variable source_dict is a simple mapping from source name to array.
        #
        # source_dict looks like:
        #   {"civic": <numpy int64 array>, "green": <numpy int64 array>, ...}
        #
        source_dict = {}

        for layer in mapnik_layers.keys():

            ##      style_path = os.path.abspath("mask_set_1/style.xml")
            ##      prov = Mapnik(self.layer, style_path)
            prov = self.layer.config.layers[layer].provider

            while True:
                mapnik_area = prov.renderArea(width, height, srs, xmin, ymin, xmax, ymax, zoom)
                mapnik_alpha = mapnik_area.getpixel((0,0))[-1]
                if mapnik_alpha != 0:
                    break


            # masks is a dictionary of color channel arrays
            masks = get_color_masks(mapnik_area, mapnik_layers[layer])

            for color in masks:
                source_dict[color_dict[layer][color]] = masks[color]

        #
        # We've now set up all of our sources as numpy arrays arranged
        # in dictionaries for easy reference. Move on to parsing the "stack",
        # to create colored composite output and apply textures.
        #
        stack = [cel for cel in self.stack if zoom in self.parseZoom(cel["zoom"])]

        #
        # Loop over each cel in the stack, now that we know
        # it's part of our selected zoom level.
        #
        for cel_local in stack:
            print '\tworking on cel', cel_local['source']
            cel = self.defaults.copy()
            cel.update(cel_local)

            #
            # Parse the absolute paths for edge and display tiles.
            # Edge tiles are typically noise JPEGs used to wobble the edges.
            # Display tiles are typically 1024x0124 watercolor scan JPEGs.
            #
            edge_url = urljoin(self.layer.config.dirpath, cel["edge_tile"])
            cel["edge_tile"] = urlparse(edge_url).path

            disp_url = urljoin(self.layer.config.dirpath, cel["disp_tile"])
            cel["disp_tile"] = urlparse(disp_url).path

            #
            # Source is a list of source names like "civic", some of which are
            # prefixed with a minus sign to mean that they are to be subtracted.
            # For example, "ground -water" means ground areas without any water.
            #
            source = cel['source'].split(" ")

            start_arr = numpy.zeros(source_dict[source[0]].shape)

            for s in source:
                if s.startswith('-'):
                    temp_arr = source_dict[s[1:]]
                    start_arr = ((start_arr == 0xff) & (temp_arr != 0xff)) * 0xff
                else:
                    temp_arr = source_dict[s]
                    start_arr = ((start_arr == 0xff) | (temp_arr == 0xff)) * 0xff

            #
            # Start array uses traditional white-on, black-off coloration.
            # Mask PIL image is the opposite: block means on, white means off.
            #
            mask = arr2img(0xff - start_arr)

            if cel["type"] == "watercolor":
                comp = self.apply_watercolor_cel(comp, mask, cel, xmin, ymax, zoom)

            elif cel["type"] == "overlay":
                comp.paste(mask, (0, 0), mask)

            else:
                raise NotImplementedError('"%s" cel type is no longer / was never supported' % cel['type'])

        return comp

    def apply_watercolor_cel(self, base, mask, cel, xmin, ymax, zoom):
        """ Apply a new watercolor cel to the base.

            In some cases, base is modified in-place, in others a copy is
            returned. Best to just use the return of this function to overwrite
            its first arguments, e.g. thing = apply(thing, ...).
        """


        edger = self.open_image(cel["edge_tile"])
        texture = self.open_image(cel["disp_tile"])
        edger_offsets = self.get_texture_offsets(edger, xmin, ymax, zoom)
        texture_offsets = self.get_texture_offsets(texture, xmin, ymax, zoom)

        buff = self.layer.metatile.buffer

        output = watercolorize(mask,
                               edger,
                               edger_offsets,
                               texture,
                               texture_offsets,
                               buff,
                               cel["edge_mult"],
                               cel["edge_gauss"],
                               cel["edge_thresh"],
                               cel["outline_gauss"],
                               cel["outline_mult"])


        if cel["blend_mode"] == "multiply":
            output_rgb = Image.new("RGBA", output.size, "#ffffff")
            output_rgb.paste(output, None, output)
            output_rgb = output_rgb.convert("RGB")

            base = ImageChops.multiply(base, output_rgb)

        elif cel["blend_mode"] == "normal":
            base.paste(output, None, output)

        else: ## default to multiply if not set
            output_rgb = Image.new("RGBA", output.size, "#ffffff")
            output_rgb.paste(output, None, output)
            output_rgb = output_rgb.convert("RGB")

            base = ImageChops.multiply(base, output_rgb)

        return base
