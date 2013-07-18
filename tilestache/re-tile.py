"""
sudo -u www-data python re-tile.py url http://tile.stamen.com/watercolor/preview.html#10/36.0115/-120.1488
sudo -u www-data python re-tile.py file listofurls.txt
"""

import logging
from sys import argv
from re import compile, I
from os.path import join, dirname
from json import load

from ModestMaps import mapByCenterZoom
from ModestMaps.Geo import Location
from ModestMaps.Core import Coordinate, Point
from ModestMaps.OpenStreetMap import Provider

from TileStache import getTile
from TileStache.Config import buildConfiguration

import datetime
from boto.cloudfront import CloudFrontConnection

AWS_ACCESS_KEY = '00QZAC9BFHDXDHZD9J02'
AWS_SECRET_ACCESS_KEY = 'd8tFjtdMOCn7SqBwtKyZ1Ikrz1nWJQPzskwHv6pC'
AWS_CF_DISTRIBUTION_ID = 'E7V4W5U1EUF2K'

file_list = []

maps_pat = compile(r'^http://maps.stamen.com/(?P<layer>[\w\-]+)/#(?P<zoom>\d+)/(?P<lat>-?\d+(\.\d+)?)/(?P<lon>-?\d+(\.\d+)?)$', I)
farm_pat = compile(r'^http://tilefarm.stamen.com/(?P<layer>[\w\-]+)/(preview\.html)?#(?P<zoom>\d+)/(?P<lat>-?\d+(\.\d+)?)/(?P<lon>-?\d+(\.\d+)?)$', I)
tile_pat = compile(r'^http://tile.stamen.com/(?P<layer>[\w\-]+)/(preview\.html)?#(?P<zoom>\d+)/(?P<lat>-?\d+(\.\d+)?)/(?P<lon>-?\d+(\.\d+)?)$', I)
hash_pat = compile(r'^http://maps.stamen.com/#(?P<layer>[\w\-]+)/(?P<zoom>\d+)/(?P<lat>-?\d+(\.\d+)?)/(?P<lon>-?\d+(\.\d+)?)$', I)

cfg_file = "./tilestache-self-contained.cfg"


def remakeTile(url):
    if maps_pat.match(url):
        match = maps_pat.match(url)
    elif farm_pat.match(url):
        match = farm_pat.match(url)
    elif tile_pat.match(url):
        match = tile_pat.match(url)
    elif hash_pat.match(url):
        match = hash_pat.match(url)
    else:
        print 'failed to find match so exiting'
        return
    
    osm = Provider()
    layer = match.group('layer')
    center = Location(float(match.group('lat')), float(match.group('lon')))
    zoom = int(match.group('zoom'))
    
    mmap = mapByCenterZoom(osm, center, zoom, Point(1300, 1300))
    
    ul = osm.locationCoordinate(mmap.pointLocation(Point(0, 0))).zoomTo(zoom)
    lr = osm.locationCoordinate(mmap.pointLocation(mmap.dimensions)).zoomTo(zoom)
    
    coords = []
    
    for row in range(int(ul.row), int(lr.row + 1)):
        for column in range(int(ul.column), int(lr.column + 1)):
            coords.append(Coordinate(row, column, zoom))
    
    print "Remaking " + str(len(coords)) + " tiles."
    cfg_dict = load(open(cfg_file))
       
    if layer in cfg_dict['layers']:
        config = buildConfiguration(cfg_dict, dirname(argv[0]))
        layer = config.layers[layer]
           
        for coord in coords:
            # get tiles with for a number of tries
            getTileLoop(layer, coord, 5)
                
        return

def getTileLoop(layer, coord, tries):
    try:
        getTile(layer, coord, layer.preview_ext, True)
    except:
        tries -= 1
        if tries > 0:
            print str(coord) + " tile failed so trying " + str(tries) + " more time(s)."
            getTileLoop(layer, coord, tries)
        else:
            print str(coord) + " tile failed but out of tries."
def invalidateCloudfront():
    
    
    return
    

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)

    if argv[1] == 'url':
        print "Found " + str(len(argv[2:])) + " urls to remake."
        i = 0
        total = len(argv[2:])
        for url in argv[2:]:
            i += 1
            print str(i) + " of " + str(total)
            remakeTile(url)
    elif argv[1] == 'file':
        f = open(argv[2],'r')
        rows = f.readlines()

        print "Found " + str(len(rows)) + " urls to remake."
        i = 0
        total = len(rows)
        for url in rows:
            i += 1
            print str(i) + " of " + str(total)
            remakeTile(url)
    else:
        print "try: sudo -u www-data python re-tile.py file listofurls.txt"
        print "or:  sudo -u www-data python re-tile.py url http://tile.stamen.com/watercolor/preview.html#10/36.0115/-120.1488"
