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

xml: mask1.xml mask2.xml terrain-labels.xml

%: %.mml
	cp $< project.mml

land: data/osmdata/land-polygons-complete-3857.zip data/osmdata/simplified-land-polygons-complete-3857.zip
	unzip -o data/osmdata/land-polygons-complete-3857.zip -d shp/
	shapeindex shp/land-polygons-complete-3857/land_polygons.shp
	unzip -o data/osmdata/simplified-land-polygons-complete-3857.zip -d shp/
	shapeindex shp/simplified-land-polygons-complete-3857/simplified_land_polygons.shp

%.mml: %.yml .env *.mss
	@cat $< | (set -a && source .env && interp) | js-yaml > $@

%.xml: %.mml
	carto -l $< > $@

data/osmdata/%:
	mkdir -p data/osmdata
	curl -sL http://data.openstreetmapdata.com/$(@:data/osmdata/%=%) -o $@
