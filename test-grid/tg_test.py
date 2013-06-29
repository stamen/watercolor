import os, sys
import json
import PIL.Image

os.system("tilestache-compose.py")

config = 'tilestache.cfg'
tilestache_layer = 'watercolor'
handmaps_layer = "mask_water"
center = "51.507553 -0.008271"
zoom = "12"
dimensions = "1024 512"
destination = "test_grids/test_grid_1.png"
temp_dir = "/".join(destination.split('/')[:-1]) + '/temp_images/temp'
suffix = ".png"

display_tile = "textures/1024_black.png"

grid_size = [5, 5]

x_var = "edge_mult"
y_var = "edge_thresh"


x_vals = [.2, .4, .6, .8, 1.0]
y_vals = [20, 40, 60, 80, 100]


    
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
                
        print temp_defaults

        cfg["layers"][tilestache_layer]["provider"]["kwargs"]["defaults"] = temp_defaults

        stack = [{"src": handmaps_layer,
                 "type": "watercolor",
                 "zoom": "0-99",
                 "disp_tile": display_tile}]
        cfg["layers"][tilestache_layer]["provider"]["kwargs"]["stack"] = stack

        temp_cfg = "temp.cfg"
        o = open(temp_cfg, 'w')
        json.dump(cfg, o, sort_keys=True, indent=4)
        o.close()


        tag = str(x) + "-" + str(y)
        
        os.system("rm -f -r cache/watercolor")
        print "RUNNING: " + "tilestache-compose.py -c " + temp_cfg + \
                  " -l " + tilestache_layer + " -n " + center + \
                  " -z " + zoom + " -d " + dimensions + \
                  " " + temp_dir + tag + suffix
        os.system("tilestache-compose.py -c " + temp_cfg + \
                  " -l " + tilestache_layer + " -n " + center + \
                  " -z " + zoom + " -d " + dimensions + \
                  " " + temp_dir + tag + suffix)

im = PIL.Image.open(temp_dir + '0-0.png')
comp = PIL.Image.new("RGB", (im.size[0] * grid_size[0], im.size[1] * grid_size[1]), '#fff')


for x in range(grid_size[0]):
    for y in range(grid_size[1]):
        im = PIL.Image.open(temp_dir + str(x) + '-' + str(y) + '.png')
        comp.paste(im, (im.size[0] * x, im.size[1] * y))

comp.save(destination)
