import ModestMaps
import TileStache
from PIL import Image
from optparse import OptionParser

parser = OptionParser(usage="""tilestache-compose.py [options] file
   tilestache-compose.py -c config.json -l layer-name -e 36.9 -123.5 38.9 -121.2 -z 9 out.jpg""")

defaults = dict(center=(37.8044, -122.2712), zoom=14, dimensions=(900, 600), verbose=True)

parser.set_defaults(**defaults)

parser.add_option('-c', '--config', dest='config',
                  help='Path to configuration file.')

parser.add_option('-l', '--layer', dest='layer',
                  help='Layer name from configuration.')

parser.add_option('-e', '--extent', dest='extent', nargs=4,
                  help='Geographic extent of map. Two lat, lon pairs', type='float',
                  action='store')

parser.add_option('-z', '--zoom', dest='zoom',
                  help='Zoom level. Default %(zoom)d.' % defaults, type='int',
                  action='store')

parser.add_option('-d', '--dimensions', dest='dimensions', nargs=2,
                  help='Pixel width, height of output image. Default %d, %d.' % defaults['dimensions'], type='int',
                  action='store')

parser.add_option('-v', '--verbose', dest='verbose',
                  help='Make a bunch of noise.',
                  action='store_true')

parser.add_option('-x', '--ignore-cached', action='store_true', dest='ignore_cached',
                  help='Re-render every tile, whether it is in the cache already or not.')

if __name__ == '__main__':

    (options, args) = parser.parse_args()
    tiledim = 256

    width, height = options.dimensions
    zoom = options.zoom

    config = TileStache.parseConfigfile(options.config)

    provider = config.layers['watercolor'].provider
    proj = config.layers['watercolor'].projection
    srs = proj.srs

    extent = options.extent
    bl = proj.locationProj(ModestMaps.Geo.Location(extent[0],extent[1]))
    ur = proj.locationProj(ModestMaps.Geo.Location(extent[2],extent[3]))
    xmin, ymin = bl.x, bl.y
    xmax, ymax = ur.x, ur.y

    print 'starting', args[0]
    im = provider.renderArea(width, height, srs, xmin, ymin, xmax, ymax, zoom)
    print 'render finished'
    im.save(args[0])

