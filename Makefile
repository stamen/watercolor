# Previews:
# - final: http://brillo.stamen/~geraldine/handmaps/index.html
# - for troubleshooting (no edge texture, or inner glow, but uses the "colors"): http://brillo.stamen/~geraldine/handmaps/masks.html
#
# TODO
#
# - Adjust textures, colors.
# - General map compilation: what map features should be shown when.
# ----- NAIP imagery?
# ----- texturea at zooms 0 to 6 for continent land
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
#  - tilestache.cfg
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


16TH_MISSION = 37.76519 -122.4174
SFO_LATLON = 37.807613 -122.279891
NYC_LATLON = 40.756749 -73.998284
LON_LATLON = 51.507553 -0.008271
TOKYO_LATLON = 35.6595 139.7004
CAI_LATLON = 30.056466 31.221428
BEI_LATLON = 39.904214 116.407413
IST_LATLON = 41.00527 28.97696
AMS_LATLON = 52.370215 4.895167
ADE_LATLON = -34.928726 138.599945
PAR_LATLON = 48.856614 2.352221

all: index.html

mapnik/mask_set_1/style.xml: mapnik/mask_set_1/style.mml
	cascadenik-compile.py mapnik/mask_set_1/style.mml $@
	chmod a+r $@

mapnik/mask_set_2/style.xml: mapnik/mask_set_2/style.mml
	cascadenik-compile.py mapnik/mask_set_2/style.mml $@
	chmod a+r $@

tilestache/tilestache.cfg: mapnik/mask_set_1/style.xml mapnik/mask_set_2/style.xml
	rm -f -r tilestache/cache/watercolor
	touch tilestache/tilestache.cfg

tokyo: \
	renders/low-zoom-world-1.jpg renders/low-zoom-world-2.jpg \
	renders/low-zoom-world-tokyo-3.jpg renders/low-zoom-world-tokyo-4.jpg \
	renders/low-zoom-world-tokyo-5.jpg \
	renders/low-zoom-world-tokyo-6.jpg \
	renders/low-zoom-world-tokyo-7.jpg \
	renders/low-zoom-world-tokyo-8.jpg \
	renders/low-zoom-world-tokyo-9.jpg \
	renders/tokyo-10.jpg renders/tokyo-11.jpg renders/tokyo-12.jpg \
	renders/tokyo-13.jpg renders/tokyo-14.jpg renders/tokyo-15.jpg \
	renders/tokyo-16.jpg renders/tokyo-17.jpg renders/tokyo-18.jpg \
	renders/tokyo-19.jpg
	touch index.html


index.html: \
	renders/low-zoom-world-1.jpg renders/low-zoom-world-2.jpg \
	renders/low-zoom-world-usa-3.jpg renders/low-zoom-world-berlin-3.jpg \
	renders/low-zoom-world-tokyo-3.jpg renders/low-zoom-world-usa-4.jpg \
	renders/low-zoom-world-berlin-4.jpg renders/low-zoom-world-tokyo-4.jpg \
	renders/low-zoom-world-dc-5.jpg renders/low-zoom-world-berlin-5.jpg \
	renders/low-zoom-world-tokyo-5.jpg renders/low-zoom-world-oakland-5.jpg \
	renders/low-zoom-world-dc-6.jpg renders/low-zoom-world-berlin-6.jpg \
	renders/low-zoom-world-tokyo-6.jpg renders/low-zoom-world-oakland-6.jpg \
	renders/low-zoom-world-dc-7.jpg renders/low-zoom-world-berlin-7.jpg \
	renders/low-zoom-world-tokyo-7.jpg renders/low-zoom-world-oakland-7.jpg \
	renders/low-zoom-world-dc-8.jpg renders/low-zoom-world-berlin-8.jpg \
	renders/low-zoom-world-tokyo-8.jpg renders/low-zoom-world-oakland-8.jpg \
	renders/low-zoom-world-dc-9.jpg renders/low-zoom-world-berlin-9.jpg \
	renders/low-zoom-world-tokyo-9.jpg renders/low-zoom-world-oakland-9.jpg \
	renders/sanfrancisco-10.jpg renders/sanfrancisco-11.jpg renders/sanfrancisco-12.jpg \
	renders/sanfrancisco-13.jpg renders/sanfrancisco-14.jpg renders/sanfrancisco-15.jpg \
	renders/sanfrancisco-16.jpg renders/sanfrancisco-17.jpg renders/sanfrancisco-18.jpg \
	renders/newyork-10.jpg renders/newyork-11.jpg renders/newyork-12.jpg \
	renders/newyork-13.jpg renders/newyork-14.jpg renders/newyork-15.jpg \
	renders/newyork-16.jpg renders/newyork-17.jpg renders/newyork-18.jpg \
	renders/london-10.jpg renders/london-11.jpg renders/london-12.jpg \
	renders/london-13.jpg renders/london-14.jpg renders/london-15.jpg \
	renders/london-16.jpg renders/london-17.jpg renders/london-18.jpg \
	renders/tokyo-10.jpg renders/tokyo-11.jpg renders/tokyo-12.jpg \
	renders/tokyo-13.jpg renders/tokyo-14.jpg renders/tokyo-15.jpg \
	renders/tokyo-16.jpg renders/tokyo-17.jpg renders/tokyo-18.jpg \
	renders/16th-mission-10.jpg renders/16th-mission-11.jpg renders/16th-mission-12.jpg \
	renders/16th-mission-13.jpg renders/16th-mission-14.jpg renders/16th-mission-15.jpg \
	renders/16th-mission-16.jpg renders/16th-mission-17.jpg renders/16th-mission-18.jpg \
	renders/newyork-19.jpg renders/sanfrancisco-19.jpg renders/london-19.jpg \
	renders/tokyo-19.jpg renders/16th-mission-19.jpg
	touch index.html


renders/16th-mission-10.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(16TH_MISSION) -z 10 -d 1024 512 $@

renders/16th-mission-11.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(16TH_MISSION) -z 11 -d 1024 512 $@

renders/16th-mission-12.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(16TH_MISSION) -z 12 -d 1024 512 $@

renders/16th-mission-13.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(16TH_MISSION) -z 13 -d 1024 512 $@

renders/16th-mission-14.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(16TH_MISSION) -z 14 -d 1024 512 $@

renders/16th-mission-15.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(16TH_MISSION) -z 15 -d 1024 512 $@

renders/16th-mission-16.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(16TH_MISSION) -z 16 -d 1024 512 $@

renders/16th-mission-17.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(16TH_MISSION) -z 17 -d 1024 512 $@

renders/16th-mission-18.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(16TH_MISSION) -z 18 -d 1024 512 $@

renders/16th-mission-19.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(16TH_MISSION) -z 19 -d 1024 512 $@


renders/low-zoom-world-1.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 0 0 -z 1 -d 1024 600 $@

renders/low-zoom-world-2.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 0 0 -z 2 -d 1024 600 $@

renders/low-zoom-world-usa-3.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 38 -90 -z 3 -d 1024 600 $@

renders/low-zoom-world-usa-4.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 38 -90 -z 4 -d 1024 600 $@


renders/low-zoom-world-dc-5.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 38.8893 -77.0502 -z 5 -d 1024 600 $@

renders/low-zoom-world-dc-6.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 38.8893 -77.0502 -z 6 -d 1024 600 $@

renders/low-zoom-world-dc-7.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 38.8893 -77.0502 -z 7 -d 1024 600 $@

renders/low-zoom-world-dc-8.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 38.8893 -77.0502 -z 8 -d 1024 600 $@

renders/low-zoom-world-dc-9.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 38.8893 -77.0502 -z 9 -d 1024 600 $@


renders/low-zoom-world-berlin-3.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 52.5096 13.3765 -z 3 -d 1024 600 $@

renders/low-zoom-world-berlin-4.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 52.5096 13.3765 -z 4 -d 1024 600 $@

renders/low-zoom-world-berlin-5.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 52.5096 13.3765 -z 5 -d 1024 600 $@

renders/low-zoom-world-berlin-6.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 52.5096 13.3765 -z 6 -d 1024 600 $@

renders/low-zoom-world-berlin-7.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 52.5096 13.3765 -z 7 -d 1024 600 $@

renders/low-zoom-world-berlin-8.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 52.5096 13.3765 -z 8 -d 1024 600 $@

renders/low-zoom-world-berlin-9.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 52.5096 13.3765 -z 9 -d 1024 600 $@


renders/low-zoom-world-tokyo-3.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 35.6595 90 -z 3 -d 1024 600 $@

renders/low-zoom-world-tokyo-4.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 35.6595 135 -z 4 -d 1024 600 $@

renders/low-zoom-world-tokyo-5.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 35.6595 139.7004 -z 5 -d 1024 600 $@

renders/low-zoom-world-tokyo-6.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 35.6595 139.7004 -z 6 -d 1024 600 $@

renders/low-zoom-world-tokyo-7.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 35.6595 139.7004 -z 7 -d 1024 600 $@

renders/low-zoom-world-tokyo-8.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 35.6595 139.7004 -z 8 -d 1024 600 $@

renders/low-zoom-world-tokyo-9.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 35.6595 139.7004 -z 9 -d 1024 600 $@


renders/low-zoom-world-oakland-5.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 37.8043 -122.2712 -z 5 -d 1024 600 $@

renders/low-zoom-world-oakland-6.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 37.8043 -122.2712 -z 6 -d 1024 600 $@

renders/low-zoom-world-oakland-7.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 37.8043 -122.2712 -z 7 -d 1024 600 $@

renders/low-zoom-world-oakland-8.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 37.8043 -122.2712 -z 8 -d 1024 600 $@

renders/low-zoom-world-oakland-9.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n 37.8043 -122.2712 -z 9 -d 1024 600 $@


renders/sanfrancisco-10.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(SFO_LATLON) -z 10 -d 1024 512 $@

renders/sanfrancisco-11.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(SFO_LATLON) -z 11 -d 1024 512 $@

renders/sanfrancisco-12.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(SFO_LATLON) -z 12 -d 1024 512 $@

renders/sanfrancisco-13.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(SFO_LATLON) -z 13 -d 1024 512 $@

renders/sanfrancisco-14.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(SFO_LATLON) -z 14 -d 1024 512 $@

renders/sanfrancisco-15.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(SFO_LATLON) -z 15 -d 1024 512 $@

renders/sanfrancisco-16.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(SFO_LATLON) -z 16 -d 1024 512 $@

renders/sanfrancisco-17.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(SFO_LATLON) -z 17 -d 1024 512 $@

renders/sanfrancisco-18.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(SFO_LATLON) -z 18 -d 1024 512 $@

renders/sanfrancisco-19.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(SFO_LATLON) -z 19 -d 1024 512 $@



renders/newyork-10.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(NYC_LATLON) -z 10 -d 1024 512 $@

renders/newyork-11.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(NYC_LATLON) -z 11 -d 1024 512 $@

renders/newyork-12.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(NYC_LATLON) -z 12 -d 1024 512 $@

renders/newyork-13.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(NYC_LATLON) -z 13 -d 1024 512 $@

renders/newyork-14.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(NYC_LATLON) -z 14 -d 1024 512 $@

renders/newyork-15.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(NYC_LATLON) -z 15 -d 1024 512 $@

renders/newyork-16.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(NYC_LATLON) -z 16 -d 1024 512 $@

renders/newyork-17.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(NYC_LATLON) -z 17 -d 1024 512 $@

renders/newyork-18.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(NYC_LATLON) -z 18 -d 1024 512 $@

renders/newyork-19.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(NYC_LATLON) -z 19 -d 1024 512 $@



renders/london-10.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(LON_LATLON) -z 10 -d 1024 512 $@

renders/london-11.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(LON_LATLON) -z 11 -d 1024 512 $@

renders/london-12.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(LON_LATLON) -z 12 -d 1024 512 $@

renders/london-13.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(LON_LATLON) -z 13 -d 1024 512 $@

renders/london-14.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(LON_LATLON) -z 14 -d 1024 512 $@

renders/london-15.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(LON_LATLON) -z 15 -d 1024 512 $@

renders/london-16.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(LON_LATLON) -z 16 -d 1024 512 $@

renders/london-17.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(LON_LATLON) -z 17 -d 1024 512 $@

renders/london-18.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(LON_LATLON) -z 18 -d 1024 512 $@

renders/london-19.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(LON_LATLON) -z 19 -d 1024 512 $@



renders/tokyo-10.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(TOKYO_LATLON) -z 10 -d 1024 512 $@

renders/tokyo-11.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(TOKYO_LATLON) -z 11 -d 1024 512 $@

renders/tokyo-12.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(TOKYO_LATLON) -z 12 -d 1024 512 $@

renders/tokyo-13.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(TOKYO_LATLON) -z 13 -d 1024 512 $@

renders/tokyo-14.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(TOKYO_LATLON) -z 14 -d 1024 512 $@

renders/tokyo-15.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(TOKYO_LATLON) -z 15 -d 1024 512 $@

renders/tokyo-16.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(TOKYO_LATLON) -z 16 -d 1024 512 $@

renders/tokyo-17.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(TOKYO_LATLON) -z 17 -d 1024 512 $@

renders/tokyo-18.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(TOKYO_LATLON) -z 18 -d 1024 512 $@

renders/tokyo-19.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(TOKYO_LATLON) -z 19 -d 1024 512 $@





renders/cairo-10.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(CAI_LATLON) -z 10 -d 1024 512 $@

renders/cairo-11.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(CAI_LATLON) -z 11 -d 1024 512 $@

renders/cairo-12.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(CAI_LATLON) -z 12 -d 1024 512 $@

renders/cairo-13.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(CAI_LATLON) -z 13 -d 1024 512 $@

renders/cairo-14.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(CAI_LATLON) -z 14 -d 1024 512 $@

renders/cairo-15.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(CAI_LATLON) -z 15 -d 1024 512 $@

renders/cairo-16.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(CAI_LATLON) -z 16 -d 1024 512 $@

renders/cairo-17.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(CAI_LATLON) -z 17 -d 1024 512 $@

renders/cairo-18.jpg: tilestache/tilestache.cfg
	tilestache-compose.py -i . -c tilestache/tilestache.cfg -l watercolor -n $(CAI_LATLON) -z 18 -d 1024 512 $@
	
	
	
	
	
renders/beijing-10.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(BEI_LATLON) -z 10 -d 1024 512 $@

renders/beijing-11.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(BEI_LATLON) -z 11 -d 1024 512 $@

renders/beijing-12.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(BEI_LATLON) -z 12 -d 1024 512 $@

renders/beijing-13.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(BEI_LATLON) -z 13 -d 1024 512 $@

renders/beijing-14.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(BEI_LATLON) -z 14 -d 1024 512 $@

renders/beijing-15.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(BEI_LATLON) -z 15 -d 1024 512 $@

renders/beijing-16.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(BEI_LATLON) -z 16 -d 1024 512 $@

renders/beijing-17.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(BEI_LATLON) -z 17 -d 1024 512 $@

renders/beijing-18.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(BEI_LATLON) -z 18 -d 1024 512 $@
	
	
	
	
renders/istanbul-10.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(IST_LATLON) -z 10 -d 1024 512 $@

renders/istanbul-11.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(IST_LATLON) -z 11 -d 1024 512 $@

renders/istanbul-12.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(IST_LATLON) -z 12 -d 1024 512 $@

renders/istanbul-13.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(IST_LATLON) -z 13 -d 1024 512 $@

renders/istanbul-14.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(IST_LATLON) -z 14 -d 1024 512 $@

renders/istanbul-15.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(IST_LATLON) -z 15 -d 1024 512 $@

renders/istanbul-16.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(IST_LATLON) -z 16 -d 1024 512 $@

renders/istanbul-17.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(IST_LATLON) -z 17 -d 1024 512 $@

renders/istanbul-18.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(IST_LATLON) -z 18 -d 1024 512 $@
	
	
	
	
renders/amsterdam-10.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(AMS_LATLON) -z 10 -d 1024 512 $@

renders/amsterdam-11.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(AMS_LATLON) -z 11 -d 1024 512 $@

renders/amsterdam-12.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(AMS_LATLON) -z 12 -d 1024 512 $@

renders/amsterdam-13.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(AMS_LATLON) -z 13 -d 1024 512 $@

renders/amsterdam-14.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(AMS_LATLON) -z 14 -d 1024 512 $@

renders/amsterdam-15.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(AMS_LATLON) -z 15 -d 1024 512 $@

renders/amsterdam-16.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(AMS_LATLON) -z 16 -d 1024 512 $@

renders/amsterdam-17.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(AMS_LATLON) -z 17 -d 1024 512 $@

renders/amsterdam-18.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(AMS_LATLON) -z 18 -d 1024 512 $@
	
	
	
	
renders/adelaide-10.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(ADE_LATLON) -z 10 -d 1024 512 $@

renders/adelaide-11.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(ADE_LATLON) -z 11 -d 1024 512 $@

renders/adelaide-12.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(ADE_LATLON) -z 12 -d 1024 512 $@

renders/adelaide-13.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(ADE_LATLON) -z 13 -d 1024 512 $@

renders/adelaide-14.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(ADE_LATLON) -z 14 -d 1024 512 $@

renders/adelaide-15.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(ADE_LATLON) -z 15 -d 1024 512 $@

renders/adelaide-16.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(ADE_LATLON) -z 16 -d 1024 512 $@

renders/adelaide-17.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(ADE_LATLON) -z 17 -d 1024 512 $@

renders/adelaide-18.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(ADE_LATLON) -z 18 -d 1024 512 $@
	
	
	
	
renders/paris-10.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(PAR_LATLON) -z 10 -d 1024 512 $@

renders/paris-11.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(PAR_LATLON) -z 11 -d 1024 512 $@

renders/paris-12.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(PAR_LATLON) -z 12 -d 1024 512 $@

renders/paris-13.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(PAR_LATLON) -z 13 -d 1024 512 $@

renders/paris-14.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(PAR_LATLON) -z 14 -d 1024 512 $@

renders/paris-15.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(PAR_LATLON) -z 15 -d 1024 512 $@

renders/paris-16.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(PAR_LATLON) -z 16 -d 1024 512 $@

renders/paris-17.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(PAR_LATLON) -z 17 -d 1024 512 $@

renders/paris-18.jpg: Tilestache/tilestache.cfg
	tilestache-compose.py -i . -c Tilestache/tilestache.cfg -l watercolor -n $(PAR_LATLON) -z 18 -d 1024 512 $@
	
	
	
clean:
	rm -f mapnik/mask_set_1/style.xml
	rm -f mapnik/mask_set_2/style.xml
	rm -f -r tilestache/cache/watercolor
	rm -f renders/*.jpg
	touch tilestache/tilestache.cfg
