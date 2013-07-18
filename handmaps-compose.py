import ModestMaps
import TileStache
from PIL import Image
from optparse import OptionParser

parser = OptionParser(usage="""tilestache-compose.py [options] file

There are three ways to set a map coverage area.

1) Center, zoom, and dimensions: create a map of the specified size,
   centered on a given geographical point at a given zoom level:

   tilestache-compose.py -c config.json -l layer-name -d 800 800 -n 37.8 -122.3 -z 11 out.jpg

2) Extent and dimensions: create a map of the specified size that
   adequately covers the given geographical extent:

   tilestache-compose.py -c config.json -l layer-name -d 800 800 -e 36.9 -123.5 38.9 -121.2 out.png

3) Extent and zoom: create a map at the given zoom level that covers
   the precise geographical extent, at whatever pixel size is necessary:
   
   tilestache-compose.py -c config.json -l layer-name -e 36.9 -123.5 38.9 -121.2 -z 9 out.jpg""")

defaults = dict(center=(37.8044, -122.2712), zoom=14, dimensions=(900, 600), verbose=True)

parser.set_defaults(**defaults)

parser.add_option('-c', '--config', dest='config',
                  help='Path to configuration file.')

parser.add_option('-l', '--layer', dest='layer',
                  help='Layer name from configuration.')

parser.add_option('-n', '--center', dest='center', nargs=2,
                  help='Geographic center of map. Default %.4f, %.4f.' % defaults['center'], type='float',
                  action='store')

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

parser.add_option('-i', '--include-path', dest='include_paths',
                  help="Add the following colon-separated list of paths to Python's include path (aka sys.path)")

parser.add_option('-x', '--ignore-cached', action='store_true', dest='ignore_cached',
                  help='Re-render every tile, whether it is in the cache already or not.')

if __name__ == '__main__':

    (options, args) = parser.parse_args()
    tiledim = 256

    width, height = options.dimensions
    zoom = options.zoom
    zoom += 2

    config = TileStache.parseConfigfile(options.config)

    provider = config.layers['watercolor'].provider
    proj = config.layers['watercolor'].projection
    srs = proj.srs
    
    centerloc = ModestMaps.Geo.Location(options.center[0], options.center[1])
    center = proj.locationCoordinate(centerloc)
    center = center.zoomTo(zoom)

    column_offset = width / 2 / tiledim
    row_offset = height / 2 / tiledim

    ul = ModestMaps.Geo.Coordinate(center.row - row_offset,
                                   center.column - column_offset,
                                   zoom)
    br = ModestMaps.Geo.Coordinate(center.row + row_offset,
                                   center.column + column_offset,
                                   zoom)

    ulpoint = proj.coordinateProj(ul)
    brpoint = proj.coordinateProj(br)

    xmin, ymin = ulpoint.x, ulpoint.y
    xmax, ymax = brpoint.x, brpoint.y

    print 'starting', args[0]
    im = provider.renderArea(width, height, srs, xmin, ymin, xmax, ymax, zoom)
    print 'render finished' 
    im.save(args[0])
