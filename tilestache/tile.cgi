#!/usr/bin/python
import os, TileStache
import sys

sys.path.append("..")
TileStache.cgiHandler(os.environ, 'tilestache.cfg', debug=True)