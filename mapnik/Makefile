SFO_LATLON = 37.816293 -122.202987
NYC_LATLON = 40.756749 -73.998284
LON_LATLON = 51.507553 -0.008271
MOS_LATLON = 55.882322 37.724175

all: index.html mask_set_1/style.xml mask_set_2/style.xml

index.html: \
	renders/sanfrancisco-6-mask1.png  renders/sanfrancisco-6-mask2.png  \
	renders/sanfrancisco-8-mask1.png  renders/sanfrancisco-8-mask2.png  \
	renders/sanfrancisco-10-mask1.png renders/sanfrancisco-10-mask2.png \
	renders/sanfrancisco-12-mask1.png renders/sanfrancisco-12-mask2.png \
	renders/sanfrancisco-14-mask1.png renders/sanfrancisco-14-mask2.png \
	renders/sanfrancisco-16-mask1.png renders/sanfrancisco-16-mask2.png



renders/sanfrancisco-6-mask1.png: mask_set_1/style.xml
	python mapnik-render.py mask_set_1/style.xml $(SFO_LATLON) 6 1024 512 $@

renders/sanfrancisco-8-mask1.png: mask_set_1/style.xml
	python mapnik-render.py mask_set_1/style.xml $(SFO_LATLON) 8 1024 512 $@

renders/sanfrancisco-10-mask1.png: mask_set_1/style.xml
	python mapnik-render.py mask_set_1/style.xml $(SFO_LATLON) 10 1024 512 $@

renders/sanfrancisco-12-mask1.png: mask_set_1/style.xml
	python mapnik-render.py mask_set_1/style.xml $(SFO_LATLON) 12 1024 512 $@

renders/sanfrancisco-14-mask1.png: mask_set_1/style.xml
	python mapnik-render.py mask_set_1/style.xml $(SFO_LATLON) 14 1024 512 $@

renders/sanfrancisco-16-mask1.png: mask_set_1/style.xml
	python mapnik-render.py mask_set_1/style.xml $(SFO_LATLON) 16 1024 512 $@


renders/sanfrancisco-6-mask2.png: mask_set_2/style.xml
	python mapnik-render.py mask_set_2/style.xml $(SFO_LATLON) 6 1024 512 $@

renders/sanfrancisco-8-mask2.png: mask_set_2/style.xml
	python mapnik-render.py mask_set_2/style.xml $(SFO_LATLON) 8 1024 512 $@

renders/sanfrancisco-10-mask2.png: mask_set_2/style.xml
	python mapnik-render.py mask_set_2/style.xml $(SFO_LATLON) 10 1024 512 $@

renders/sanfrancisco-12-mask2.png: mask_set_2/style.xml
	python mapnik-render.py mask_set_2/style.xml $(SFO_LATLON) 12 1024 512 $@

renders/sanfrancisco-14-mask2.png: mask_set_2/style.xml
	python mapnik-render.py mask_set_2/style.xml $(SFO_LATLON) 14 1024 512 $@

renders/sanfrancisco-16-mask2.png: mask_set_2/style.xml
	python mapnik-render.py mask_set_2/style.xml $(SFO_LATLON) 16 1024 512 $@



mask_set_1/style.xml: mask_set_1/style.mml datasources.ini style-base/road_widths.mss mask_set_1/ground.mss mask_set_1/roads.mss
	cascadenik-compile.py mask_set_1/style.mml $@
	chmod a+r $@

mask_set_2/style.xml: mask_set_2/style.mml datasources.ini style-base/road_widths.mss mask_set_2/ground.mss mask_set_2/roads.mss
	cascadenik-compile.py mask_set_2/style.mml $@
	chmod a+r $@

clean:
	rm -f renders/sanfrancisco-*.png
