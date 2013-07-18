import sys
import glob
import os.path
import mapnik
import pyproj
import PIL.Image
import ModestMaps

if __name__ == '__main__':
    try:
        stylesheet, lat, lon, zoom, width, height, output = sys.argv[1:]
        zoom = int(zoom)
        center = ModestMaps.Geo.Location(float(lat), float(lon))
        dimensions = ModestMaps.Core.Point(int(width), int(height))
        format = output[-4:]
        
        assert zoom >= 0 and zoom <= 20
        assert format in ('.png', '.jpg')

    except Exception, e:
        print >> sys.stderr, e
        print >> sys.stderr, 'Usage: python mapnik-render.py <stylesheet> <lat> <lon> <zoom> <width> <height> <output jpg/png>'
        sys.exit(1)

    for ttf in glob.glob(os.path.dirname(os.path.realpath(__file__)) + '/fonts/*.ttf'):
        mapnik.FontEngine.register_font(ttf)

    osm = ModestMaps.OpenStreetMap.Provider()
    map = ModestMaps.mapByCenterZoom(osm, center, zoom, dimensions)
    
    srs = {'proj': 'merc', 'a': 6378137, 'b': 6378137, 'lat_0': 0, 'lon_0': 0, 'k': 1.0, 'units': 'm', 'nadgrids': '@null', 'no_defs': True}
    gym = pyproj.Proj(srs)

    northwest = map.pointLocation(ModestMaps.Core.Point(0, 0))
    southeast = map.pointLocation(dimensions)
    
    left, top = gym(northwest.lon, northwest.lat)
    right, bottom = gym(southeast.lon, southeast.lat)
    
    map = mapnik.Map(dimensions.x, dimensions.y)
    mapnik.load_map(map, stylesheet)
    map.zoom_to_box(mapnik.Envelope(left, top, right, bottom))
    
    img = mapnik.Image(dimensions.x, dimensions.y)
    
    mapnik.render(map, img)
    
    img = PIL.Image.fromstring('RGBA', (dimensions.x, dimensions.y), img.tostring())
    
    if format == '.jpg':
        img.save(output, quality=85)
    else:
        img.save(output)
