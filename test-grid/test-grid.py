from Handmaps.functions2 import watercolorize
import TileStache
import optparse
from PIL import Image
import sys, os

optparser = optparse.OptionParser(usage="""%prog [options]
""")

defaults = {
    'buffer': 10,
    'config_path': 'tilestache.cfg',
    'layer': 'watercolor',
    'source_file': "test_grids/source.png",
    'texture_file': "textures/watercolor_tile_ground0.png",
    'columns': 10,
    'rows': 10,
    'x_variable': ('edge_mult', '0.0', '1'),
    'y_variable': ('edge_thresh', '0', '256')
}

optparser.set_defaults(**defaults)

optparser.add_option('-b', '--buffer', dest='buffer', type='int',
                     help='Buffer between tiles in the grid. Default value is "%(buffer)s".' % defaults)

optparser.add_option('-s', '--source', dest='source_file', type='string',
                     help='Black and white source mask. Default value is "%(source_file)s".' % defaults)

optparser.add_option('-t', '--texture', dest='texture_file', type='string',
                     help='Texture file. Default value is "%(texture_file)s".' % defaults)

optparser.add_option('-f', '--config', dest='config_path', type='string',
                     help='File name of tilestache config file (used for the default variables). Default value is "%(config_path)s".' % defaults)

optparser.add_option('--l', '--layer', dest='layer', type='string',
                     help='Flayer in the config file to reference. Default value is "%(layer)s".' % defaults)

optparser.add_option('-r', '--rows', dest='rows', type='int',
                     help='Number of rows in the grid. Default value is %(rows)d.' % defaults)

optparser.add_option('-c', '--columns', dest='columns', type='int',
                     help='Number of columns in the grid. Default value is %(columns)d.' % defaults)

optparser.add_option('-x', '--xvariable', dest='x_variable', nargs = 3, type='string',
                     help='Horizontal variable, in format "variable name" "start value" "end value". Default value is %(x_variable)s.' % defaults)

optparser.add_option('-y', '--yvariable', dest='y_variable', nargs = 3, type='string',
                     help='Vertical variable, in format "variable name" "start value" "end value". Default value is %(y_variable)s.' % defaults)

if __name__ == '__main__':

    opts, args = optparser.parse_args()

    try:
        buff = opts.buffer
        source = opts.source_file
        texture = opts.texture_file
        config_path = opts.config_path
        layer = opts.layer
        columns = opts.columns
        rows = opts.rows
        output = args[0]
        xvar = opts.x_variable[0]
        xvar_start = float(opts.x_variable[1])
        xvar_end = float(opts.x_variable[2])
        yvar = opts.y_variable[0]
        yvar_start = float(opts.y_variable[1])
        yvar_end = float(opts.y_variable[2])
        
        o_format = output[-4:]
        assert o_format in ('.png', '.jpg')
        i_format = source[-4:]
        assert i_format in ('.png', '.jpg')
        c_format = config_path[-4:]
        assert c_format in ('.cfg')

    except Exception, e:
        print >> sys.stderr, e
        print >> sys.stderr, 'Usage: python test-grid.py <output>'
        sys.exit(1)

    try:
        config = TileStache.parseConfigfile(config_path)
        default_vars = config.layers[layer].provider.defaults
    except Exception, e:
        print >> sys.stderr, e
        print >> sys.stderr, 'Error parsing config file'
        sys.exit(1)

    mask = Image.open(source)
    print "edge:", default_vars['edge_tile']
    edge_texture = Image.open(default_vars['edge_tile'])
    display_texture = Image.open(texture)

    grid = Image.new("RGB", (mask.size[0] * columns + buff * (columns - 1), mask.size[1] * rows + buff * (rows - 1)), "#FFFFFF")

    for i in range(columns):
        current_xvar = (xvar_end - xvar_start) / (columns - 1) * i + xvar_start
        for j in range(rows):
            current_yvar = (yvar_end - yvar_start) / (rows - 1) * j + yvar_start

            c = default_vars.copy()
            c[xvar] = current_xvar
            c[yvar] = current_yvar

            new_im = watercolorize(mask, edge_texture, display_texture, 16,
                                   c['edge_mult'], c['edge_gauss'],
                                   c['edge_thresh'], c['outline_gauss'],
                                   c['outline_mult'], c['aa_mult'])

            grid.paste(new_im, ((new_im.size[0] + buff) * i, (new_im.size[1] + buff) * j), new_im)

    grid.save(output)







