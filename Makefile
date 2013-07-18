# Previews:
# - final: http://brillo.stamen/~geraldine/watercolors_hires/index.html
# - for troubleshooting (no edge texture, or inner glow, but uses the "colors"): http://brillo.stamen/~geraldine/watercolor_hires/masks.html
#
# There are 5 layers:
#
# They are used as mask layers for further coloring and texturing in TileStache.
# The MSS just defined B+W #000 and #fff colors on objects to say "draw this, don't draw this".
#
# To add more layers, 
#  - setup new MML+MSS combos in self-titled directories. 
#  - Add them to the "stack" in the tilestache.cfg and 
#  - prep the Mapnik XML by adding new targets in the Makefile. See the STYLES variable.
#
# The colors come later in these files:
#  - tilestache_z15textures.cfg
# "stack": [
#              {"src": "mask_water", "type": "watercolor", "zoom": "0-2", "edge_thresh": 75, "disp_tile": "textures/watertest1.jpg"},
#              {"src": "mask_water", "type": "watercolor", "zoom": "3-99", "edge_thresh": 75, "disp_tile": "textures/watercolor_tile_water0.jpg"},
#              {"src": "mask_ground", "type": "watercolor", "zoom": "0-99", "disp_tile": "textures/watercolor_tile_ground0.jpg"},
#              {"src": "mask_green", "type": "watercolor", "zoom": "0-99", "disp_tile": "textures/watercolor_tile_green0.jpg"},
#              {"src": "mask_civic", "type": "watercolor", "zoom": "0-99", "disp_tile": "textures/watercolor_tile_civic0.jpg"},
#              {"src": "mask_motorways", "type": "watercolor", "zoom": "15-99", "edge_gauss": 4, "edge_thresh": 120, "disp_tile": "textures/watercolor_tile_motorways0.jpg"}
#            ]
# Where the image file gives it color and fill texture, like: "textures/watertest1.jpg"
#
# Map masks:
#  - mask_civic
#  - mask_green
#  - mask_ground
#  - mask_motorways -- only for super big roads zoomed in when they are purple
#  - mask_water
# They are stored in folders with their own MML and MSS.
#  - style_base is the master template that describes the MML layers and potential MSS 
#    stylings. But it's not actually used for rendering.
# NOTE: Roads are usually drawn by implying their negative presence in the other masks. This is defined in the ../stylebase/roads.mss
#
# If you want to modify the "roughness" of the edge of things, either mod the "defaults" or the layer overrides for:
# This should mostly affect the edge of your B+W mask, but if the numbers are too high, it'll impact the middle of your mask, too.
#				"edge_tile": "textures/paper_tile_256_1.jpg", ---- another texture file that determines roughness of the edge
#				"edge_mult": 0.4, - to combine the edge_tile image into the layer mask. 0 = none. 1.0 = mostly ignore the mask. (don't use 1; 0.1 and .3 is good range)
#				"edge_gauss": 6, - blur the edge of the B+W mask before the edge texture is added. useful range of 3 to 10. Higher values = slower to process.
#				"edge_thresh": 120, - range of 0 to 255. Below this number = TRUE; Above = FALSE. Based on the contrast in your original edge_tile image. This turns the combination of the B+W mask + texture back into B+W.
#				"outline_gauss": 15, - like an inner glow, how wide
#				"outline_mult": 0.7, - like an inner glow, how dark 
#				"aa_mult": 2 - a scale factor that we can now ignore, was used for anti-aliasing.
# 


LOWER_MANHATTAN_LATLON = 40.7064 -73.9969

8x10 = 2250 2850
11x14 = 3000 3900
16x20 = 4350 5550
24x30 = 6600 8400
30x40 = 8100 11100




all: renders/z15t_ny_z12.jpg renders/z15t_ny_z14.jpg renders/z15t_ny_z15.jpg renders/z15t_ny_z16.jpg

all-cities: london \
			new_york \
			berlin \
			chicago \
			amsterdam \
			toronto \
			portland \
			singapore \
			paris \
			sydney \
			tokyo \
			sanfrancisco 



cascadenik-compile.py:
	chmod a+rwx $@

mapnik/mask_set_1/style.xml: mapnik/mask_set_1/style.mml cascadenik-compile.py
	./cascadenik-compile.py -x 4 mapnik/mask_set_1/style.mml $@
	chmod a+r $@

mapnik/mask_set_2/style.xml: mapnik/mask_set_2/style.mml cascadenik-compile.py
	./cascadenik-compile.py -x 4 mapnik/mask_set_2/style.mml $@
	chmod a+r $@

tilestache/tilestache.cfg: mapnik/mask_set_1/style.xml mapnik/mask_set_2/style.xml
	rm -f -r tilestache/cache/watercolor
	touch tilestache/tilestache.cfg



renders/z15t_ny_z12.jpg: tilestache/tilestache.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n $(LOWER_MANHATTAN_LATLON) -z 12 -d $(8x10) $@

renders/z15t_ny_z14.jpg: tilestache/tilestache.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n $(LOWER_MANHATTAN_LATLON) -z 14 -d $(11x14) $@
	
renders/z15t_ny_z15.jpg: tilestache/tilestache.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n $(LOWER_MANHATTAN_LATLON) -z 15 -d $(16x20) $@

renders/z15t_ny_z16.jpg: tilestache/tilestache.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n $(LOWER_MANHATTAN_LATLON) -z 16 -d $(24x30) $@



london: \
	renders/london_z10_8x10.jpg \
	renders/london_z10_11x14.jpg \
	renders/london_z13_16x20.jpg \
	renders/london_z15_30x40.jpg \
	renders/london_z15_large.jpg

renders/london_z10_8x10.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 51.5076 -0.1233 -z 10 -d 2850 2250 renders/london_z10_8x10.jpg

renders/london_z10_11x14.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 51.5076 -0.1233 -z 10 -d 3900 3000 renders/london_z10_11x14.jpg
	
renders/london_z13_16x20.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 51.5076 -0.1233 -z 13 -d 5550 4350 renders/london_z13_16x20.jpg
	
renders/london_z15_30x40.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 51.5076 -0.1233 -z 15 -d 11100 8100 renders/london_z15_30x40.jpg
	
renders/london_z15_large.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 51.5076 -0.1233 -z 15 -d 13100 10100 renders/london_z15_large.jpg
	
	
new_york: \
	renders/newyork_z12_8x10.jpg \
	renders/newyork_z13_11x14.jpg \
	renders/newyork_z13_16x20.jpg \
	renders/newyork_z15_30x40.jpg \
	renders/newyork_z15_large.jpg 
	
renders/newyork_z12_8x10.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 40.7554 -73.9728 -z 12 -d 2250 2850 renders/newyork_z12_8x10.jpg

renders/newyork_z13_11x14.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 40.7554 -73.9728 -z 13 -d 3000 3900 renders/newyork_z13_11x14.jpg

renders/newyork_z13_16x20.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 40.7554 -73.9728 -z 13 -d 4350 5550 renders/newyork_z13_16x20.jpg

renders/newyork_z15_30x40.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 40.7554 -73.9728 -z 15 -d 8100 11100 renders/newyork_z15_30x40.jpg

renders/newyork_z15_large.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 40.7554 -73.9728 -z 15 -d 12100 14800 renders/newyork_z15_large.jpg


berlin: \
	renders/berlin_z12_8x10.jpg \
	renders/berlin_z12_11x14.jpg \
	renders/berlin_z13_16x20.jpg \
	renders/berlin_z15_30x40.jpg \
	renders/berlin_z15_large.jpg 

renders/berlin_z12_8x10.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 52.5247 13.3900 -z 12 -d 2850 2250 renders/berlin_z12_8x10.jpg

renders/berlin_z12_11x14.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 52.5247 13.3900 -z 12 -d 3900 3000 renders/berlin_z12_11x14.jpg

renders/berlin_z13_16x20.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 52.5247 13.3900 -z 13 -d 5550 4350 renders/berlin_z13_16x20.jpg

renders/berlin_z15_30x40.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 52.5247 13.3900 -z 15 -d 11100 8100 renders/berlin_z15_30x40.jpg

renders/berlin_z15_large.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 52.5247 13.3900 -z 15 -d 16100 13100 renders/berlin_z15_large.jpg
	
		
chicago: \
	renders/chicago_z13_8x10.jpg \
	renders/chicago_z13_11x14.jpg \
	renders/chicago_z13_16x20.jpg \
	renders/chicago_z15_30x40.jpg \
	renders/chicago_z15_large.jpg 

renders/chicago_z13_8x10.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 41.8745 -87.6621 -z 13 -d 2250 2850 renders/chicago_z13_8x10.jpg

renders/chicago_z13_11x14.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 41.8745 -87.6621 -z 13 -d 3000 3900 renders/chicago_z13_11x14.jpg

renders/chicago_z13_16x20.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 41.8839 -87.6394 -z 13 -d 4350 5550 renders/chicago_z13_16x20.jpg

renders/chicago_z15_30x40.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 41.8839 -87.6394 -z 15 -d 8100 11100 renders/chicago_z15_30x40.jpg

renders/chicago_z15_large.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 41.8839 -87.6394 -z 15 -d 10100 13100 renders/chicago_z15_large.jpg
	
	
amsterdam: \
	renders/amsterdam_z13_8x10.jpg \
	renders/amsterdam_z13_11x14.jpg \
	renders/amsterdam_z13_16x20.jpg \
	renders/amsterdam_z14_30x40.jpg

renders/amsterdam_z13_8x10.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 52.3729 4.8946 -z 13 -d 2850 2250 renders/amsterdam_z13_8x10.jpg

renders/amsterdam_z13_11x14.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 52.3729 4.8946 -z 13 -d 3900 3000 renders/amsterdam_z13_11x14.jpg

renders/amsterdam_z13_16x20.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 52.3729 4.8946 -z 13 -d 5550 4350 renders/amsterdam_z13_16x20.jpg

renders/amsterdam_z14_30x40.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 52.3747 4.9001 -z 14 -d 11100 8100 renders/amsterdam_z14_30x40.jpg
	
	
toronto: \
	renders/toronto_z12_8x10.jpg \
	renders/toronto_z12_11x14.jpg \
	renders/toronto_z13_16x20.jpg \
	renders/toronto_z15_30x40.jpg \
	renders/toronto_z15_large.jpg 

renders/toronto_z12_8x10.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 43.6727 -79.3854 -z 12 -d 2850 2250 renders/toronto_z12_8x10.jpg

renders/toronto_z12_11x14.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 43.6727 -79.3854 -z 12 -d 3900 3000 renders/toronto_z12_11x14.jpg

renders/toronto_z13_16x20.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 43.6727 -79.3854 -z 13 -d 5550 4350 renders/toronto_z13_16x20.jpg

renders/toronto_z15_30x40.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 43.6727 -79.3854 -z 15 -d 11100 8100 renders/toronto_z15_30x40.jpg

renders/toronto_z15_large.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 43.6561 -79.3873 -z 15 -d 15100 12100 renders/toronto_z15_large.jpg
	
	
portland: \
	renders/portland_z13_8x10.jpg \
	renders/portland_z13_11x14.jpg \
	renders/portland_z14_16x20.jpg \
	renders/portland_z15_30x40.jpg

renders/portland_z13_8x10.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 45.5243 -122.6797 -z 13 -d 2850 2250 renders/portland_z13_8x10.jpg

renders/portland_z13_11x14.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 45.5243 -122.6797 -z 13 -d 3900 3000 renders/portland_z13_11x14.jpg

renders/portland_z14_16x20.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 45.5243 -122.6797 -z 14 -d 5550 4350 renders/portland_z14_16x20.jpg

renders/portland_z15_30x40.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 45.5243 -122.6797 -z 15 -d 11100 8100 renders/portland_z15_30x40.jpg
	
	
singapore: \
	renders/singapore_z11_8x10.jpg \
	renders/singapore_z12_11x14.jpg \
	renders/singapore_z12_16x20.jpg \
	renders/singapore_z13_30x40.jpg \
	renders/singapore_z13_large.jpg

renders/singapore_z11_8x10.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 1.3866 103.8218 -z 11 -d 2850 2250 renders/singapore_z11_8x10.jpg

renders/singapore_z12_11x14.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 1.3777 103.8218 -z 12 -d 3900 3000 renders/singapore_z12_11x14.jpg

renders/singapore_z12_16x20.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 1.3698 103.8218 -z 12 -d 5550 4350 renders/singapore_z12_16x20.jpg

renders/singapore_z13_30x40.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 1.3698 103.8218 -z 13 -d 11100 8100 renders/singapore_z13_30x40.jpg

renders/singapore_z13_large.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 1.3698 103.8218 -z 13 -d 12100 10100 renders/singapore_z13_large.jpg


paris: \
	renders/paris_z12_8x10.jpg \
	renders/paris_z13_11x14.jpg \
	renders/paris_z13_16x20.jpg \
	renders/paris_z14_30x40.jpg \
	renders/paris_z14_large.jpg

renders/paris_z12_8x10.jpg:	tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 48.8546 2.3438 -z 12 -d 2850 2250 renders/paris_z12_8x10.jpg

renders/paris_z13_11x14.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 48.8546 2.3438 -z 13 -d 3900 3000 renders/paris_z13_11x14.jpg

renders/paris_z13_16x20.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 48.8546 2.3438 -z 13 -d 5550 4350 renders/paris_z13_16x20.jpg

renders/paris_z14_30x40.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 48.8620 2.3010 -z 14 -d 11100 8100 renders/paris_z14_30x40.jpg

renders/paris_z14_large.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 48.8582 2.3495 -z 14 -d 14100 11100 renders/paris_z14_large.jpg
	
	
sydney: \
	renders/sydney_z12_8x10.jpg \
	renders/sydney_z13_11x14.jpg \
	renders/sydney_z13_16x20.jpg \
	renders/sydney_z14_30x40.jpg

renders/sydney_z12_8x10.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n -33.8553 151.2084 -z 12 -d 2850 2250 renders/sydney_z12_8x10.jpg

renders/sydney_z13_11x14.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n -33.8553 151.2084 -z 13 -d 3900 3000 renders/sydney_z13_11x14.jpg

renders/sydney_z13_16x20.jpg: tilestache/tilestache_z15textures.cfg	 
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n -33.8553 151.2084 -z 13 -d 5550 4350 renders/sydney_z13_16x20.jpg

renders/sydney_z14_30x40.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n -33.8553 151.2084 -z 14 -d 11100 8100 renders/sydney_z14_30x40.jpg
	
	
tokyo: \
	renders/tokyo_z12_8x10.jpg \
	renders/tokyo_z12_11x14.jpg \
	renders/tokyo_z13_16x20.jpg \
	renders/tokyo_z13_30x40.jpg

renders/tokyo_z12_8x10.jpg:	tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 35.6829 139.7729 -z 12 -d 2250 2850 renders/tokyo_z12_8x10.jpg

renders/tokyo_z12_11x14.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 35.6829 139.7729 -z 12 -d 3000 3900 renders/tokyo_z12_11x14.jpg

renders/tokyo_z13_16x20.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 35.6940 139.7735 -z 13 -d 4350 5550 renders/tokyo_z13_16x20.jpg

renders/tokyo_z13_30x40.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 35.6940 139.7735 -z 13 -d 8100 11100 renders/tokyo_z13_30x40.jpg
	
	
sanfrancisco: \
	renders/sanfrancisco_z12_8x10.jpg \
	renders/sanfrancisco_z13_11x14.jpg \
	renders/sanfrancisco_z13_16x20.jpg \
	renders/sanfrancisco_z13_30x40.jpg \
	renders/sanfrancisco_z14_large.jpg

renders/sanfrancisco_z12_8x10.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 37.7590 -122.4414 -z 12 -d 2250 2850 renders/sanfrancisco_z12_8x10.jpg

renders/sanfrancisco_z13_11x14.jpg: tilestache/tilestache_z15textures.cfg
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 37.7590 -122.4414 -z 13 -d 3000 3900 renders/sanfrancisco_z13_11x14.jpg

renders/sanfrancisco_z13_16x20.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 37.7590 -122.4414 -z 13 -d 4350 5550 renders/sanfrancisco_z13_16x20.jpg

renders/sanfrancisco_z13_30x40.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 37.7815 -122.3894 -z 13 -d 8100 11100 renders/sanfrancisco_z13_30x40.jpg

renders/sanfrancisco_z14_large.jpg: tilestache/tilestache_z15textures.cfg	
	python handmaps-compose.py -i . -c tilestache/tilestache_z15textures.cfg -l watercolor -n 37.7590 -122.4414 -z 14 -d 9100 12100 renders/sanfrancisco_z14_large.jpg





	
clean:
	rm -f mapnik/mask_set_1/style.xml
	rm -f mapnik/mask_set_2/style.xml
	rm -f -r tilestache/cache/watercolor
	rm -f renders/*.jpg
	touch tilestache/tilestache.cfg