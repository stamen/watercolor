#!/bin/sh -ex

# SET THE FOLLOWING environment variables with the same vars. In bash,
#OGR_ENABLE_PARTIAL_REPROJECTION=TRUE
#SHAPE_ENCODING=WINDOWS-1252
#export SHAPE_ENCODING
#export OGR_ENABLE_PARTIAL_REPROJECTION

DIR=`mktemp -d stuffXXXXXX`
#for z in shps/tmp/*.*; do rm $z; done

# 10m Natuarl Earth themes
curl -L http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_roads.zip -o $DIR/ne_10m_roads.zip

for z in $DIR/*.zip; do unzip $z -d $DIR/; done
for z in $DIR/*.zip; do rm $z; done

# Spherical mercator extent and projection,
# http://proj.maptools.org/faq.html#sphere_as_wgs84
#
EXTENT="-180 -85.05112878 180 85.05112878"
P900913="+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs"

# Use http://trac.osgeo.org/gdal/wiki/ConfigOptions#OGR_ENABLE_PARTIAL_REPROJECTION
# and clip source to include only data within spherical mercator world square.
# Encoding conversion will *only work* as of GDAL 1.9.x.
#

for z in $DIR/*.shp; do 
    base="${z%.shp}"; 
    ogr2ogr -f "ESRI Shapefile" -overwrite -s_srs "+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs" --config OGR_ENABLE_PARTIAL_REPROJECTION TRUE --config SHAPE_ENCODING WINDOWS-1252 -t_srs "$P900913" -lco ENCODING=UTF-8 -clipsrc $EXTENT -segmentize 1 -skipfailures "${base}-merc.shp" "${base}.shp"; 
    shapeindex "${base}-merc"; 
    ogrinfo -so "${base}-merc.shp" "${base}-merc" | tail -n +4 > info.txt; 
    zip -j "${base}-merc.zip" "${base}-merc.dbf" "${base}-merc.index" "${base}-merc.prj" "${base}-merc.prj" "${base}-merc.shp" "${base}-merc.shx" "${base}-merc.VERSION.txt" "${base}-merc.README.html" info.txt; 
    done

mv $DIR/*-merc.zip mapnik/shp/

rm -rf $DIR