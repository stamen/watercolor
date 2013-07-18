"""
This script will generate a set of zoom-specific files with tilestache-seed
commands from a bounding box file.

    python seed_parser.py -t '-c /usr/local/tilefarm/gunicorn/tilestache-watercolor.cfg -l watercolor ' -b 'twitter_bbox.tsv'


"""


import csv
from optparse import OptionParser

parser = OptionParser(usage="""%prog [options]

Generates a set of tilestache-seed commands from a bounding box file.
One file is created per zoom level.""")

defaults = {'outfile': 'seed_script_', 'low_zoom': 9}

parser.set_defaults(**defaults)

parser.add_option('-b', '--bbox_data', dest='bbox_data',
                  help='Path to bounding box file, typically required.')

parser.add_option('-t', '--tilestache_args', dest='tilestache_args',
                  help='Arguments to pass to tilestache, typically required.')

parser.add_option('-z', '--low_zoom', dest='low_zoom', type='int',
                  help='Lowest zoom to render. Default value is %s' % defaults['low_zoom'])

parser.add_option('-o', '--outfile', dest='outfile',
                  help= 'Prefix for output file. Default value is %s' % repr(defaults['outfile']))

if __name__ == '__main__':
    (options, args) = parser.parse_args()

    try:
        # check required options
                  

        if options.tilestach_args is None:
            raise Exception('Missing required tilestache arguments (--tilestache_args) parameter.')
        elif options.bbox_data is None:
            raise Exception('Missing required bounding box path (--bbox_data) parameter.')
                 

    except:
        pass

    f = open(options.bbox_data)

    if options.bbox_data[-3:] == 'csv':
        bbox_dialect = 'excel'
    elif options.bbox_data[-3:] == 'tsv':
        bbox_dialect = 'excel-tab'
    else:
        raise Exception('bbox_data must be a .csv or .tsv file')
                  
    reader = csv.DictReader(f, dialect = bbox_dialect)


    z_dict = {}

    for line in reader:
        
        if line['zoom_start'] not in z_dict:
            z_dict[line['zoom_start']] = ''

        zooms = range(9, int(line['zoom_start']) + 1)
        script_line = 'sudo -u www-data tilestache-seed.py ' + options.tilestache_args + \
                      '-b ' + ' '.join([line['bottom'], line['left'], line['top'], line['right']]) + \
                      ' -e jpg ' + ' '.join(map(str, zooms)) + '\n'
        z_dict[line['zoom_start']] += script_line

    f.close()

    for i in z_dict:
        text = z_dict[i]
        f = open(options.outfile + i + '.txt', 'w')
        f.write(text)
        f.close()
