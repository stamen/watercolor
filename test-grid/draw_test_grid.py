import os, sys, shutil
import json
import PIL.Image
import optparse
from numpy import arange
from tempfile import mkstemp, mkdtemp

class BadComposure(Exception):
    pass

optparser = optparse.OptionParser(usage="""%prog [options]
""")

defaults = {
    'config': 'tilestache.cfg',
    'tilestache_layer': 'watercolor',
    'handmaps_layer': "mask_water",
    
    'center': (51.507553, -0.008271),
    'zoom': 12,
    'dimensions': (1024, 512),
    
    'display_tile': "textures/1024_black.png",
    'x_var': 'edge_mult',
    'y_var': 'edge_thresh',
    'x_vals': (.1, .6, 5),
    'y_vals': (40.0, 120.0, 5)
}

optparser.set_defaults(**defaults)

optparser.add_option('-c', '--config', dest='config',
                     help='Path to configuration file.',
                     type = 'string', action = 'store')

optparser.add_option('-t', '--tilestache', dest='tilestache_layer',
                     help='Name of tilestache layer (in tilestache.cfg). Default %default.',
                     type = 'string', action = 'store')

optparser.add_option('-l', '--handmaps', dest='handmaps_layer',
                     help='Name of handmaps layer. Default %default.',
                     type = 'string', action = 'store')

optparser.add_option('-n', '--center', dest='center',
                     help='Geographic center of map. Default %.4f, %.4f.' % defaults['center'],
                     nargs=2, type='float', action='store')

optparser.add_option('-z', '--zoom', dest='zoom',
                     help='Zoom level. Default %(zoom)d.' % defaults,
                     type='int', action='store')

optparser.add_option('-d', '--dimensions', dest='dimensions',
                     help='Width and height of rendered map. Default value is %d, %d.' % defaults['dimensions'],
                     nargs=2, type='int', action = 'store')

optparser.add_option('-r', '--texture', dest='display_tile',
                     help='Path to texture used to fill the mask. Default %default.',
                     type = 'string', action = 'store')


optparser.add_option('-x', '--xvar', dest='x_var',
                     help='Name of handmaps layer. Default %default.',
                     type = 'string', action = 'store')

optparser.add_option('-v', '--xvals', dest='x_vals',
                     help='Geographic center of map. Default %.4f, %.4f, %d' % defaults['x_vals'],
                     nargs=3, type='float', action='store')

optparser.add_option('-y', '--yvar', dest='y_var',
                     help='Name of handmaps layer. Default %default.',
                     type = 'string', action = 'store')

optparser.add_option('-w', '--yvals', dest='y_vals',
                     help='Geographic center of map. Default %.4f, %.4f, %d' % defaults['y_vals'],
                     nargs=3, type='float', action='store')



if __name__ == '__main__':

    opts, args = optparser.parse_args() 

    try:
        destination = args[0]
    except IndexError:
        raise BadComposure('Error: Missing output file.')
    
    temp_dir = mkdtemp(dir = '.', prefix = "temp-images-") + '/'
    
    prefix = "temp_"
    suffix = ".png"

    config = opts.config
    tilestache_layer = opts.tilestache_layer
    handmaps_layer = opts.handmaps_layer

    center = str(opts.center[0]) + " " + str(opts.center[1])
    zoom = str(opts.zoom)
    dimensions = str(opts.dimensions[0]) + " " + str(opts.dimensions[1])

    display_tile = opts.display_tile

    x_var = opts.x_var
    y_var = opts.y_var


    grid_size = (int(opts.x_vals[2]), int(opts.y_vals[2]))

    x_min = opts.x_vals[0]
    x_max = opts.x_vals[1]
    x_step = (x_max - x_min) / (grid_size[0] - 1)

    y_min = opts.y_vals[0]
    y_max = opts.y_vals[1]
    y_step = (y_max - y_min) / (grid_size[1] - 1)

    x_vals = arange(x_min, x_max + x_step, x_step)
    y_vals = arange(y_min, y_max + y_step, y_step)
    
    for x in range(grid_size[0]):
        for y in range(grid_size[1]):


            ## create temp cfg file
            f = open(config)
            cfg = json.load(f)
            f.close()

            temp_defaults = cfg["layers"][tilestache_layer]["provider"]["kwargs"]["defaults"]

            for default in temp_defaults:
                
                if default == x_var:
                    temp_defaults[default] = x_vals[x]
                if default == y_var:
                    temp_defaults[default] = y_vals[y]
                    
##            print temp_defaults

            cfg["layers"][tilestache_layer]["provider"]["kwargs"]["defaults"] = temp_defaults

            stack = [{"src": handmaps_layer,
                     "type": "watercolor",
                     "zoom": "0-99",
                     "disp_tile": display_tile}]
            cfg["layers"][tilestache_layer]["provider"]["kwargs"]["stack"] = stack

            handle, temp_cfg = mkstemp(dir='.', prefix='tmp-tilestache-config-', suffix='.cfg')
            os.close(handle)
            o = open(temp_cfg, 'w')
            json.dump(cfg, o, sort_keys=True, indent=4)
            o.close()


            tag = str(x) + "-" + str(y)
            
            os.system("rm -f -r cache/watercolor")
##            print "RUNNING: " + "tilestache-compose.py -c " + temp_cfg + \
##                      " -l " + tilestache_layer + " -n " + center + \
##                      " -z " + zoom + " -d " + dimensions + \
##                      " " + temp_dir + prefix + tag + suffix
            os.system("tilestache-compose.py -c " + temp_cfg + \
                      " -l " + tilestache_layer + " -n " + center + \
                      " -z " + zoom + " -d " + dimensions + \
                      " " + temp_dir + prefix + tag + suffix)
            os.unlink(temp_cfg)

    im = PIL.Image.open(temp_dir + prefix + '0-0.png')
    comp = PIL.Image.new("RGB", (im.size[0] * grid_size[0], im.size[1] * grid_size[1]), '#fff')


    for x in range(grid_size[0]):
        for y in range(grid_size[1]):
            im = PIL.Image.open(temp_dir + prefix + str(x) + '-' + str(y) + '.png')
            comp.paste(im, (im.size[0] * x, im.size[1] * y))

    comp.save(destination)

    shutil.rmtree(temp_dir, True)
##    os.system("rm -f -r " + "/".join(temp_dir.split("/")))
##    os.system("rm -f " + temp_cfg)
    
