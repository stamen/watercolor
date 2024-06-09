Watercolor
=====

This repo originally existed in subversion and was moved to git by Seth Fitzsimmons on June 28, 2013. Alan McConchie did some updates and documentation of Watercolor for 2013.

Originally, Stamen never planned to make this repository public (unlike the original [Toner](https://github.com/stamen/toner-carto) and [Terrain](https://github.com/stamen/terrain-classic) styles) so there was never any documentation. But at some point, a few people were asking about it, so we switched the repo so anyone can view it, but documentation is still lacking.

Also, there are a few different branches, and it's not clear which is the best place to start if someone were to try to pick up Watercolor again today. Possibly useful branches are:
* [deploy-2014](https://github.com/stamen/watercolor/tree/deploy-2014)
* [mapisart](https://github.com/stamen/watercolor/tree/mapisart)
* [watercolor-2013](https://github.com/stamen/watercolor/tree/watercolor-2013)

You may also be interested in the version of the Watercolor code that is archived in the permanent collection of the Cooper Hewitt (the Smithsonian Design Museum). Their copy of the repository is here: https://github.com/CooperHewittCollection/watercolor

If you are only interested in _using_ the archive of existing watercolor tiles (instead of trying to run this code to generate your own new tiles) you can access those tiles either from the Cooper Hewitt's servers, or via Stadia Maps.
* Using the tiles via Cooper Hewitt: https://github.com/CooperHewittCollection/watercolor_examples
* Using the tiles via Stadia Maps: https://stadiamaps.com/stamen/

If you just want to learn more explanation about how we made this map, check out:
* The original [annoucement blog post](https://stamen.com/maps-stamen-com-is-live-4e4dde30dd72/)
* Our [Watercolor Process](https://stamen.com/watercolor-process-3dd5135861fe/) blog post
* The [Watercolor Textures](https://stamen.com/watercolor-textures-15de97a4ad8b/) blog post

Getting Started
--

Watercolor is made up of several parts. Watercolor primarily uses data from two sources: Natural 
Earth 2.0 and OpenStreetMap. 

 Getting started with Watercolor involves three main stages:

1. Install Watercolor and all its dependencies (both data and software). The current document 
(the one you're reading right now) explains how to do this. Read this first.
 
2. After you have everything installed, you should go to the README file in the 'mapnik' 
directory to learn about Cascadenik and to start generating the "Watercolor" Mapnik stylesheets. 
Do this second. At this point you will be able to generate static map images.

3. Then, after you have built your Mapnik stylesheets and tested them, you should go to the 
README file in the 'tilestache' directory to start generating and serving map tiles. Do this 
third. This step is only required if you want to create map tiles.


Dependencies
--

The short version is: There are a lot.

The long version is: The gritty details of installing some of the tools that
Watercolor uses are outside the scope of this document. We've tried to give you the
shape of what you need to do and linked to the available documentation elsewhere. 
The instructions provided should work on ubuntu 12.04. You may need to make some 
modifications depending on your specific operating system and hardware.

Software Dependencies (required)
--

* A PostGIS database (http://postgis.refractions.net/) We use PostgreSQL 9.1 and PostGIS 2.0

		sudo apt-get install postgresql-9.1-postgis

* The osm2pgsql application for importing OpenStreetMap in to PostGIS (http://wiki.openstreetmap.org/wiki/Osm2pgsql). 

		sudo apt-get install osm2pgsql

* Python 2.6 or higher (http://www.python.org/)

		sudo apt-get install python

* Mapnik and the Mapnik Python bindings (http://mapnik.org/).

		sudo apt-get install python-mapnik

* The ModestMaps Python libraries (http://pypi.python.org/pypi/ModestMaps/)

		sudo apt-get install python-modestmaps

* The Cascadenik Python libraries (http://pypi.python.org/pypi/cascadenik/)

		sudo pip install cssutils
		sudo pip install cascadenik

* The Requests Python libraries (http://docs.python-requests.org/en/latest/)

    sudo pip install requests

* The pyproj Python libraries, required for using using the 'mapnik-render.py' script (http://pypi.python.org/pypi/pyproj)

		sudo pip install pyproj

* The Python Imaging Libraries (PIL), required for using the 'mapnik-render.py' script (http://pypi.python.org/pypi/PIL/)

		sudo apt-get install python-imaging

* The SciPy Python libraries, required for using the 'mapnik-render.py' script (http://www.scipy.org/)

		sudo pip install scipy

* The TileStache Python libraries (http://pypi.python.org/pypi/TileStache/)

		sudo pip install tilestache

* The GDAL libraries and utlities (http://www.gdal.org/)

		sudo apt-get install gdal-bin
		
* The gunicorn WSGI web server framework (http://www.gunicorn.org/)

		sudo pip install gunicorn

Data Dependencies (required)
--

* A PostGIS database called 'planet_osm' containing OSM data (loaded by the osm2pgsql script) and
  coastline using the spherical mercator projection (EPSG:900913). See below for
  details.
  
A quick guide to setting up your databases (for PostgreSQL 9.x):

	createuser --no-superuser --no-createdb --no-createrole osm
	createdb --owner=osm planet_osm 
	psql -d planet_osm -c "CREATE EXTENSION postgis;"
	echo "ALTER TABLE spatial_ref_sys OWNER TO osm;" | psql -d planet_osm
	echo "ALTER TABLE geometry_columns OWNER TO osm;" | psql -d planet_osm


OpenStreetMap (OSM)
--

OSM publishes freely available downloads of their entire dataset at
http://planet.openstreetmap.org. Instructions for installing and setting up OSM
are outside the scope of this document but the OSM site has thorough
documentation available at: http://wiki.openstreetmap.org/wiki/PostGIS

If you don't want to install the entire OSM planet database but want to render
tiles for a smaller area you can also use the MirrorOSM tile provider in
TileStache to retrieve and store OSM data in PostGIS. Details are available over
here:

http://www.tilestache.org/doc/TileStache.Goodies.Providers.MirrorOSM.html

Or, you can download an extract from the geofabrik.de servers. For example:

	wget http://download.geofabrik.de/asia/japan-latest.osm.pbf

Then load it into your database like so: (you may need to increase the cache size 
depending on your hardware)

	osm2pgsql -d planet_osm -U osm -r pbf japan-latest.osm.pbf -C 6000

You will also need to add a copy of the OSM coastline to your planet_osm
database. The OSM coastline is distributed as a shapefile that you will need to
import using the 'shp2pgsql' program:

Download the file:

	wget http://tile.openstreetmap.org/processed_p.tar.bz2
	
Unzip it:

	bzip2 -d processed_p.tar.bz2
	tar xvf processed_p.tar

Load it into your planet_osm database:

	shp2pgsql processed_p.shp coastline | psql -U osm planet_osm

Natural Earth
--

NaturalEarth is a public domain map dataset of various cultural and vector
datasets. It is available for download at: http://www.naturalearthdata.com/. Watercolor uses 
Natural Earth 2.0 (released November 2012) and should be compatible with any future minor 
releases (2.x).

Watercolor uses many, but not all of the datasets in NaturalEarth, so you should use this script 
(located in the main watercolor directory) to download all the datasets that Watercolor requires:

	download_data.sh

This script downloads the NaturalEarth datasets Watercolor uses as shapefiles, and 
reprojects them from EPSG:4326 (WGS84 lat/lon) into EPSG:900913 (sometimes known as 
"spherical mercator" which really just means "good for making map tiles"). The 
downloaded and reprojected files are stored in the 'watercolor/mapnik/shp/'
directory, in compressed (zip) format. You do not need to unzip these files or load
them into your database: mapnik can read them as-is.

Data overview
--
An overview of data sources, storage locations, download and import methods (in progress)


| Data              | Zoom  | Source    | Download method | Input method        | Storage loc | Mask set |
| ----------------- | ----- | --------- | --------- | ------------------- | ----------- | --- |
| Coastline (low z) | 1-7   | NatEarth  | dl script | n/a                 | Zipped shp  | 1,2 |
| Coastline (high z)| 8-19  | OSM       | wget url  | shp2pgsql           | planet db   | 1,2 |
| Lakes (TODO)      | ???   | NatEarth  | dl script | n/a                 | Zipped shp  | 2   |
| Roads (low z)     | 6-8   | NatEarth  | dl script | n/a                 | Zipped shp  | 1,2 |
| Roads (high z)    | 9-19  | OSM       | wget url  | osm2pgsql           | planet db   | 1,2 |


