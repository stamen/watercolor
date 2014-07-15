# use PGDATABASE PGHOST etc.
SHELL := /bin/bash
PATH := $(PATH):node_modules/.bin

mml: watercolor-masks

install:
	mkdir -p ${HOME}/Documents/MapBox/project
	ln -sf "`pwd`" ${HOME}/Documents/MapBox/project/watercolor-masks
	echo DATABASE_URL=postgres:///osm > .env

clean:
	rm -f *.mml *.xml

mask1: mask1.mml
	# delete project.mml to signal TM1 that it's changed
	rm -f project.mml
	ln -s $@.mml project.mml

mask2: mask2.mml
	# delete project.mml to signal TM1 that it's changed
	rm -f project.mml
	ln -s $@.mml project.mml

data/land-polygons-complete-3857.zip:
	mkdir -p data
	curl -sL http://data.openstreetmapdata.com/land-polygons-complete-3857.zip -o $@

data/simplified-land-polygons-complete-3857.zip:
	mkdir -p data
	curl -sL http://data.openstreetmapdata.com/simplified-land-polygons-complete-3857.zip -o $@

land: data/land-polygons-complete-3857.zip data/simplified-land-polygons-complete-3857.zip
	cd shp/ && unzip -o ../data/land-polygons-complete-3857.zip
	cd shp/ && shapeindex land-polygons-complete-3857/land_polygons.shp
	cd shp/ && unzip -o ../data/simplified-land-polygons-complete-3857.zip
	cd shp/ && shapeindex simplified-land-polygons-complete-3857/simplified_land_polygons.shp

mask1.mml: mask1.yml .env
	cat $< | (set -a && source .env && interp) > $@

mask1.xml: mask1.mml
	carto -l $< > $@

mask2.mml: mask2.yml .env
	cat $< | (set -a && source .env && interp) > $@

mask2.xml: mask2.mml
	carto -l $< > $@

