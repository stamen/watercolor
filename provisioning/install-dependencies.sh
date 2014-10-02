#!/bin/sh
set -e

sudo apt-add-repository -y ppa:chris-lea/node.js
sudo apt-add-repository -y ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install -y nodejs make mapnik-utils git unzip gdal-bin zip python-pip python-dev python-numpy python-scipy imagemagick python-modestmaps
sudo pip install tilestache nik4
cd ~/
npm install carto millstone interp@0.1.0 js-yaml@3.2.1

