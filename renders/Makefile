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
#
#1       Shanghai        17,836,133[5]   Core districts[6]       2,605.8 6,845    China  31.2454/121.4531
SHANGHAI_LATLON = 31.2454 121.4531
#2       Karachi 13,052,000[5] [7]       City District   3,527   5,700    Pakistan       24.8764/67.0284
KARACHI_LATLON = 24.8764 67.0284
#3       Mumbai  12,478,447[8]   Municipal Corporation   603     20,694   India  19.0763/72.8759
MUMBAI_LATLON = 19.0763 72.8759
#4       Beijing 11,716,000[5]   Core districts[9]       1,368.32        7,400    China  39.9592/116.3400
BEIJING_LATLON = 39.9592 116.3400
#5       Moscow  11,551,930[10]  Federal City    1,091[11]       10,588   Russia 55.7573/37.7047
MOSCOW_LATLON = 55.7573 37.7047
#6       São Paulo       11,316,149[12]  Municipality    1,523   7,383    Brazil -23.5905/-46.5872
SAOPAULO_LATLON = -23.5327 -46.6842 
#7       Tianjin 11,090,314[5]   All districts   7,422   1,494    China  39.1116/117.2396
TIANJIN_LATLON = 39.1116 117.2396
#8       Guangzhou       11,070,654[5]   All districts[13]       3,843   2,881    China  23.1135/113.2603
GUANGZHOU_LATLON = 23.1135 113.2603
#9       Delhi   11,007,835[8]   Municipal Corporation   1,397.29        7,877.9  India  28.6443/77.0910
DELHI_LATLON = 28.6145 77.2195
#10      Seoul   10,575,447[14]  Special City    605.25[15]      17,473   South Korea    37.5572/126.9774
SEOUL_LATLON = 37.5923 126.8067
#11      Shenzhen        10,357,938[5]   All districts   1,989   5,201    China  22.5487/114.1059
SHENZHEN_LATLON = 22.5487 114.1059
#12      Jakarta 9,588,198[16]   Special capital district        662.33  14,476   Indonesia      -6.2375/106.8204
JAKARTA_LATLON = -6.17539 106.82171
#13      Tokyo   8,887,608[17]   23 Special Wards[18]    617.18  14,400   Japan  35.6706/139.7409
TOKYO_LATLON = 35.6730 139.7076 
#14      Mexico City     8,873,017[19]   Federal District        1,485.49[20]    5,973    Mexico 19.3230/-99.1250
MEXICOCITY_LATLON = 19.4306 -99.1573
#15      Istanbul        8,803,468[21]   City proper     1,831   7,166    Turkey 41.0197/28.9529
ISTANBUL_LATLON = 41.0456 28.6951 
#16      Kinshasa        8,754,000[22]   City-Province[23]       2,016   4,342    Democratic Republic of the Congo       -4.3322/15.2918
KINSHASA_LATLON = -4.2998 15.2439
#17      Bangalore       8,425,970[8]    Municipal Corporation   709.5[24]       11,876   India  12.9559/77.6210
BANGALORE_LATLON = 12.97848 77.59117
#18      Dongguan        8,220,237[5]    Prefecture-level city   2,465   3,335    China  23.0465/113.7358
DONGGUAN_LATLON = 23.0465 113.7358
#19      New York City   8,175,133[25]   City proper     789.4   10,356   United States  40.7070/-73.9726
#20      Lagos   7,937,932[26]   statistical area        999.6   7,938    Nigeria        6.4447/3.4121
LAGOS_LATLON = 6.4546 3.3938
#21      London  7,825,200[27]   Greater London[28]      1,580   4,863    United Kingdom 51.4742/-0.1413
#

RIO_LATLON = -22.9057 -43.2527
BAGHDAD_LATLON = 33.3560 44.402
DAMASCAS_LATLON = 33.5125 36.3098
VERSAILLES_LATLON = 48.8035 2.1209
HOCHIMIHN_LATLON = 10.5319 106.8575
SWEDEN_LATLON = 59.2741 18.5742

SANFRANCISCO_LATLON = 37.7974 -122.4388 
#SANFRANCISCO_LATLON = 37.7749 -122.4183
SFO_LATLON = 37.807613 -122.279891
NYC_LATLON = 40.7501 -74.0406
LONDON_LATLON = 51.4916 -0.3018
CAI_LATLON = 30.056466 31.221428
AMSTERDAM_LATLON = 52.370215 4.895167
ADE_LATLON = -34.928726 138.599945
PARIS_LATLON = 48.8583 2.3214 
ROME_LATLON = 41.90263 12.46197 
SYDNEY_LATLON = -33.85535 151.20909
FARGO_LATLON = 46.8554 -96.8000
CHICAGO_LATLON = 41.8800 -87.6612
HALIFAX_LATLON = 44.6866 -63.7106
BERLIN_LATLON = 52.5148 13.3594
MAUI_LATLON = 20.772 -157.355

TILESTACHE_CONFIG = /usr/local/watercolor/tilestache/tilestache-tilefarm.cfg
TILESTACHE_COMPOSE = python /home/jeff/TileStache/scripts/tilestache-compose.py

WIDTH_300 = 7500
HEIGHT_300 = 5000
WIDTH_150 = 3414
HEIGHT_150 = 2245

TILE_RADIUS = 14

preload1:
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(LAGOS_LATLON) $(LAGOS_LATLON) -p $(TILE_RADIUS) -e jpg 17 16 14 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(LONDON_LATLON) $(LONDON_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 17 14 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(SHANGHAI_LATLON) $(SHANGHAI_LATLON) -p $(TILE_RADIUS) -e jpg 14 15 16 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(KARACHI_LATLON) $(KARACHI_LATLON) -p $(TILE_RADIUS) -e jpg 14 15 16 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(MUMBAI_LATLON) $(MUMBAI_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(BEIJING_LATLON) $(BEIJING_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(MOSCOW_LATLON) $(MOSCOW_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 13 12 11 10 16
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(SAOPAULO_LATLON) $(SAOPAULO_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 17 14 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(TIANJIN_LATLON) $(TIANJIN_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 17 12 11 10 13
preload2:
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(GUANGZHOU_LATLON) $(GUANGZHOU_LATLON) -p $(TILE_RADIUS) -e jpg 14 15 16 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(SEOUL_LATLON) $(SEOUL_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 17 12 11 10 13
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(SHENZHEN_LATLON) $(SHENZHEN_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 17 12 11 10 13
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(JAKARTA_LATLON) $(JAKARTA_LATLON) -p $(TILE_RADIUS) -e jpg 14 15 16 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(TOKYO_LATLON) $(TOKYO_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 12 11 10 13
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(MEXICOCITY_LATLON) $(MEXICOCITY_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 12 11 10 13
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(ISTANBUL_LATLON) $(ISTANBUL_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 12 11 10 13
preload3:
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(KINSHASA_LATLON) $(KINSHASA_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 17 14 12 11 10 13
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(BANGALORE_LATLON) $(BANGALORE_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 12 11 10 13
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(DONGGUAN_LATLON) $(DONGGUAN_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 12 11 10 13
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(LAGOS_LATLON) $(LAGOS_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 12 11 10 13
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(NYC_LATLON) $(NYC_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 12 11 10 13
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(AMSTERDAM_LATLON) $(AMSTERDAM_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 12 11 10 13
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(PARIS_LATLON) $(PARIS_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 17 14 13 12 11 10
preload4:
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(SANFRANCISCO_LATLON) $(SANFRANCISCO_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(CAI_LATLON) $(CAI_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(ADE_LATLON) $(ADE_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(RIO_LATLON) $(RIO_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(BAGHDAD_LATLON) $(BAGHDAD_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(DAMASCAS_LATLON) $(DAMASCAS_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 13 12 11 10
preload5:
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(BERLIN_LATLON) $(BERLIN_LATLON) -p $(TILE_RADIUS) -e jpg 16 15 14 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(HALIFAX_LATLON) $(HALIFAX_LATLON) -p $(TILE_RADIUS) -e jpg 13 12 11 10 14 15
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(SYDNEY_LATLON) $(SYDNEY_LATLON) -p $(TILE_RADIUS) -e jpg 17 16 15 14 13 12 11 10
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(DELHI_LATLON) $(DELHI_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 13 12 11 10
	
preload6:
	tilestache-seed.py -c $(TILESTACHE_CONFIG) -l watercolor --enable-retries --error-list=tileerror.log -b $(MAUI_LATLON) $(MAUI_LATLON) -p $(TILE_RADIUS) -e jpg 15 16 14 13 12 11 10

tokyo: \
	tokyo/tokyo-12.jpg \
	tokyo/tokyo-13.jpg \
	tokyo/tokyo-14.jpg \
	tokyo/tokyo-15.jpg \
	tokyo/tokyo-16.jpg 

tokyo/tokyo-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TOKYO_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
tokyo/tokyo-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TOKYO_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
tokyo/tokyo-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TOKYO_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
tokyo/tokyo-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TOKYO_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
tokyo/tokyo-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TOKYO_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
tokyo/tokyo-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TOKYO_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
tokyo/tokyo-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TOKYO_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
tokyo/tokyo-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TOKYO_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@


newyork: \
	newyork/newyork-13.jpg \
	newyork/newyork-14.jpg \
	newyork/newyork-15.jpg \
	newyork/newyork-16.jpg \
	newyork/newyork-17.jpg 

newyork/newyork-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(NYC_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@
newyork/newyork-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(NYC_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
newyork/newyork-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(NYC_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
newyork/newyork-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(NYC_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
newyork/newyork-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(NYC_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
newyork/newyork-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(NYC_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
newyork/newyork-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(NYC_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
newyork/newyork-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(NYC_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@





rome: \
	rome/rome-12.jpg \
	rome/rome-13.jpg \
	rome/rome-14.jpg \
	rome/rome-15.jpg \
	rome/rome-16.jpg 

rome/rome-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ROME_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
rome/rome-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ROME_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
rome/rome-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ROME_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
rome/rome-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ROME_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
rome/rome-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ROME_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
rome/rome-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ROME_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
rome/rome-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ROME_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
rome/rome-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ROME_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@




chicago: \
	chicago/chicago-12.jpg \
	chicago/chicago-13.jpg \
	chicago/chicago-14.jpg \
	chicago/chicago-15.jpg \
	chicago/chicago-16.jpg 

chicago/chicago-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(CHICAGO_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
chicago/chicago-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(CHICAGO_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
chicago/chicago-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(CHICAGO_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
chicago/chicago-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(CHICAGO_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
chicago/chicago-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(CHICAGO_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
chicago/chicago-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(CHICAGO_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
chicago/chicago-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(CHICAGO_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
chicago/chicago-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(CHICAGO_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@




fargo: \
	fargo/fargo-12.jpg \
	fargo/fargo-13.jpg \
	fargo/fargo-14.jpg \
	fargo/fargo-15.jpg \
	fargo/fargo-16.jpg 

fargo/fargo-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(FARGO_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
fargo/fargo-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(FARGO_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
fargo/fargo-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(FARGO_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
fargo/fargo-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(FARGO_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
fargo/fargo-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(FARGO_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
fargo/fargo-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(FARGO_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
fargo/fargo-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(FARGO_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
fargo/fargo-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(FARGO_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@




sydney: \
	sydney/sydney-12.jpg \
	sydney/sydney-13.jpg \
	sydney/sydney-14.jpg \
	sydney/sydney-15.jpg \
	sydney/sydney-16.jpg 

sydney/sydney-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SYDNEY_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
sydney/sydney-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SYDNEY_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
sydney/sydney-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SYDNEY_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
sydney/sydney-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SYDNEY_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
sydney/sydney-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SYDNEY_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
sydney/sydney-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SYDNEY_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
sydney/sydney-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SYDNEY_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
sydney/sydney-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SYDNEY_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@


sanfrancisco: \
	sanfrancisco/sanfrancisco-12.jpg \
	sanfrancisco/sanfrancisco-13.jpg \
	sanfrancisco/sanfrancisco-14.jpg \
	sanfrancisco/sanfrancisco-15.jpg \
	sanfrancisco/sanfrancisco-16.jpg 

sanfrancisco/sanfrancisco-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SANFRANCISCO_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
sanfrancisco/sanfrancisco-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SANFRANCISCO_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
sanfrancisco/sanfrancisco-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SANFRANCISCO_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
sanfrancisco/sanfrancisco-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SANFRANCISCO_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
sanfrancisco/sanfrancisco-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SANFRANCISCO_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
sanfrancisco/sanfrancisco-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SANFRANCISCO_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
sanfrancisco/sanfrancisco-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SANFRANCISCO_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
sanfrancisco/sanfrancisco-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SANFRANCISCO_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





london: \
	london/london-15.jpg \
	london/london-13.jpg \
	london/london-16.jpg \
	london/london-17.jpg \
	london/london-14.jpg

london/london-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LONDON_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
london/london-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LONDON_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
london/london-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LONDON_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
london/london-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LONDON_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
london/london-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LONDON_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
london/london-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LONDON_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
london/london-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LONDON_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
london/london-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LONDON_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





shanghai:\
	shanghai/shanghai-16.jpg \
	shanghai/shanghai-13.jpg \
	shanghai/shanghai-15.jpg \
	shanghai/shanghai-17.jpg \
	shanghai/shanghai-14.jpg

shanghai/shanghai-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHANGHAI_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
shanghai/shanghai-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHANGHAI_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
shanghai/shanghai-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHANGHAI_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
shanghai/shanghai-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHANGHAI_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
shanghai/shanghai-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHANGHAI_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
shanghai/shanghai-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHANGHAI_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
shanghai/shanghai-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHANGHAI_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
shanghai/shanghai-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHANGHAI_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





karachi:\
	karachi/karachi-15.jpg \
	karachi/karachi-12.jpg \
	karachi/karachi-13.jpg \
	karachi/karachi-16.jpg \
	karachi/karachi-14.jpg \
	karachi/karachi-17.jpg

karachi/karachi-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KARACHI_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
karachi/karachi-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KARACHI_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
karachi/karachi-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KARACHI_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
karachi/karachi-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KARACHI_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
karachi/karachi-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KARACHI_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
karachi/karachi-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KARACHI_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
karachi/karachi-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KARACHI_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
karachi/karachi-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KARACHI_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





mumbai: \
	mumbai/mumbai-13.jpg \
	mumbai/mumbai-12.jpg \
	mumbai/mumbai-14.jpg \
	mumbai/mumbai-15.jpg \
	mumbai/mumbai-16.jpg \
	mumbai/mumbai-17.jpg

mumbai/mumbai-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MUMBAI_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
mumbai/mumbai-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MUMBAI_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
mumbai/mumbai-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MUMBAI_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
mumbai/mumbai-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MUMBAI_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
mumbai/mumbai-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MUMBAI_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
mumbai/mumbai-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MUMBAI_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
mumbai/mumbai-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MUMBAI_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
mumbai/mumbai-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MUMBAI_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@






paris: \
	paris/paris-17.jpg \
	paris/paris-18.jpg \
	paris/paris-16.jpg \
	paris/paris-12.jpg \
	paris/paris-13.jpg \
	paris/paris-15.jpg \
	paris/paris-14.jpg

paris/paris-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(PARIS_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
paris/paris-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(PARIS_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
paris/paris-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(PARIS_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
paris/paris-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(PARIS_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
paris/paris-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(PARIS_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
paris/paris-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(PARIS_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
paris/paris-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(PARIS_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
paris/paris-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(PARIS_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





beijing:\
	beijing/beijing-12.jpg \
	beijing/beijing-17.jpg \
	beijing/beijing-16.jpg \
	beijing/beijing-15.jpg \
	beijing/beijing-14.jpg \
	beijing/beijing-13.jpg

beijing/beijing-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BEIJING_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
beijing/beijing-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BEIJING_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
beijing/beijing-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BEIJING_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
beijing/beijing-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BEIJING_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
beijing/beijing-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BEIJING_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
beijing/beijing-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BEIJING_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
beijing/beijing-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BEIJING_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
beijing/beijing-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BEIJING_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





moscow: \
	moscow/moscow-17.jpg \
	moscow/moscow-16.jpg \
	moscow/moscow-15.jpg \
	moscow/moscow-13.jpg \
	moscow/moscow-12.jpg \
	moscow/moscow-14.jpg

moscow/moscow-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MOSCOW_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
moscow/moscow-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MOSCOW_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
moscow/moscow-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MOSCOW_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
moscow/moscow-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MOSCOW_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
moscow/moscow-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MOSCOW_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
moscow/moscow-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MOSCOW_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
moscow/moscow-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MOSCOW_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
moscow/moscow-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MOSCOW_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





saopaulo:\
	saopaulo/saopaulo-15.jpg \
	saopaulo/saopaulo-16.jpg \
	saopaulo/saopaulo-12.jpg \
	saopaulo/saopaulo-17.jpg \
	saopaulo/saopaulo-14.jpg \
	saopaulo/saopaulo-13.jpg

saopaulo/saopaulo-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SAOPAULO_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
saopaulo/saopaulo-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SAOPAULO_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
saopaulo/saopaulo-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SAOPAULO_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
saopaulo/saopaulo-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SAOPAULO_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
saopaulo/saopaulo-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SAOPAULO_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
saopaulo/saopaulo-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SAOPAULO_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
saopaulo/saopaulo-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SAOPAULO_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
saopaulo/saopaulo-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SAOPAULO_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





tianjin:\
	tianjin/tianjin-16.jpg \
	tianjin/tianjin-12.jpg \
	tianjin/tianjin-17.jpg \
	tianjin/tianjin-15.jpg \
	tianjin/tianjin-14.jpg \
	tianjin/tianjin-13.jpg

tianjin/tianjin-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TIANJIN_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
tianjin/tianjin-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TIANJIN_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
tianjin/tianjin-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TIANJIN_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
tianjin/tianjin-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TIANJIN_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
tianjin/tianjin-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TIANJIN_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
tianjin/tianjin-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TIANJIN_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
tianjin/tianjin-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TIANJIN_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
tianjin/tianjin-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(TIANJIN_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@




guangzhou: \
	guangzhou/guangzhou-17.jpg \
	guangzhou/guangzhou-12.jpg \
	guangzhou/guangzhou-13.jpg \
	guangzhou/guangzhou-16.jpg \
	guangzhou/guangzhou-15.jpg \
	guangzhou/guangzhou-14.jpg

guangzhou/guangzhou-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(GUANGZHOU_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
guangzhou/guangzhou-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(GUANGZHOU_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
guangzhou/guangzhou-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(GUANGZHOU_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
guangzhou/guangzhou-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(GUANGZHOU_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
guangzhou/guangzhou-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(GUANGZHOU_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
guangzhou/guangzhou-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(GUANGZHOU_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
guangzhou/guangzhou-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(GUANGZHOU_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
guangzhou/guangzhou-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(GUANGZHOU_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





delhi: \
	delhi/delhi-17.jpg \
	delhi/delhi-16.jpg \
	delhi/delhi-15.jpg \
	delhi/delhi-13.jpg \
	delhi/delhi-15.jpg \
	delhi/delhi-14.jpg

delhi/delhi-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DELHI_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
delhi/delhi-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DELHI_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
delhi/delhi-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DELHI_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
delhi/delhi-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DELHI_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
delhi/delhi-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DELHI_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
delhi/delhi-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DELHI_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
delhi/delhi-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DELHI_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
delhi/delhi-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DELHI_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





seoul: \
	seoul/seoul-12.jpg \
	seoul/seoul-13.jpg \
	seoul/seoul-16.jpg \
	seoul/seoul-15.jpg \
	seoul/seoul-14.jpg

seoul/seoul-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SEOUL_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
seoul/seoul-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SEOUL_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
seoul/seoul-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SEOUL_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
seoul/seoul-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SEOUL_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
seoul/seoul-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SEOUL_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
seoul/seoul-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SEOUL_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
seoul/seoul-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SEOUL_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
seoul/seoul-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SEOUL_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





shenzhen:\
	shenzhen/shenzhen-13.jpg \
	shenzhen/shenzhen-12.jpg \
	shenzhen/shenzhen-16.jpg \
	shenzhen/shenzhen-15.jpg \
	shenzhen/shenzhen-14.jpg

shenzhen/shenzhen-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHENZHEN_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
shenzhen/shenzhen-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHENZHEN_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
shenzhen/shenzhen-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHENZHEN_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
shenzhen/shenzhen-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHENZHEN_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
shenzhen/shenzhen-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHENZHEN_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
shenzhen/shenzhen-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHENZHEN_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
shenzhen/shenzhen-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHENZHEN_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
shenzhen/shenzhen-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(SHENZHEN_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





jakarta:\
	jakarta/jakarta-12.jpg \
	jakarta/jakarta-13.jpg \
	jakarta/jakarta-14.jpg \
	jakarta/jakarta-17.jpg \
	jakarta/jakarta-16.jpg \
	jakarta/jakarta-15.jpg

jakarta/jakarta-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(JAKARTA_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
jakarta/jakarta-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(JAKARTA_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
jakarta/jakarta-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(JAKARTA_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
jakarta/jakarta-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(JAKARTA_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
jakarta/jakarta-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(JAKARTA_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
jakarta/jakarta-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(JAKARTA_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
jakarta/jakarta-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(JAKARTA_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
jakarta/jakarta-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(JAKARTA_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





mexicocity:\
	mexicocity/mexicocity-15.jpg \
	mexicocity/mexicocity-17.jpg \
	mexicocity/mexicocity-13.jpg \
	mexicocity/mexicocity-12.jpg \
	mexicocity/mexicocity-16.jpg \
	mexicocity/mexicocity-14.jpg

mexicocity/mexicocity-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MEXICOCITY_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
mexicocity/mexicocity-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MEXICOCITY_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
mexicocity/mexicocity-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MEXICOCITY_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
mexicocity/mexicocity-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MEXICOCITY_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
mexicocity/mexicocity-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MEXICOCITY_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
mexicocity/mexicocity-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MEXICOCITY_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
mexicocity/mexicocity-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MEXICOCITY_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
mexicocity/mexicocity-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MEXICOCITY_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





istanbul:\
	istanbul/istanbul-17.jpg \
	istanbul/istanbul-12.jpg \
	istanbul/istanbul-13.jpg \
	istanbul/istanbul-14.jpg \
	istanbul/istanbul-16.jpg \
	istanbul/istanbul-15.jpg

istanbul/istanbul-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ISTANBUL_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
istanbul/istanbul-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ISTANBUL_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
istanbul/istanbul-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ISTANBUL_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
istanbul/istanbul-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ISTANBUL_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
istanbul/istanbul-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ISTANBUL_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
istanbul/istanbul-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ISTANBUL_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
istanbul/istanbul-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ISTANBUL_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
istanbul/istanbul-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(ISTANBUL_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





kinshasa:\
	kinshasa/kinshasa-16.jpg \
	kinshasa/kinshasa-12.jpg \
	kinshasa/kinshasa-11.jpg \
	kinshasa/kinshasa-15.jpg \
	kinshasa/kinshasa-14.jpg \
	kinshasa/kinshasa-17.jpg \
	kinshasa/kinshasa-13.jpg

kinshasa/kinshasa-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KINSHASA_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
kinshasa/kinshasa-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KINSHASA_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
kinshasa/kinshasa-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KINSHASA_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
kinshasa/kinshasa-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KINSHASA_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
kinshasa/kinshasa-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KINSHASA_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
kinshasa/kinshasa-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KINSHASA_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
kinshasa/kinshasa-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KINSHASA_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
kinshasa/kinshasa-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(KINSHASA_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





bangalore: \
	bangalore/bangalore-16.jpg \
	bangalore/bangalore-13.jpg \
	bangalore/bangalore-15.jpg \
	bangalore/bangalore-14.jpg \
	bangalore/bangalore-17.jpg

bangalore/bangalore-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BANGALORE_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
bangalore/bangalore-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BANGALORE_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
bangalore/bangalore-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BANGALORE_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
bangalore/bangalore-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BANGALORE_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
bangalore/bangalore-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BANGALORE_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
bangalore/bangalore-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BANGALORE_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
bangalore/bangalore-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BANGALORE_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
bangalore/bangalore-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BANGALORE_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





dongguan: \
	dongguan/dongguan-16.jpg \
	dongguan/dongguan-17.jpg \
	dongguan/dongguan-15.jpg \
	dongguan/dongguan-14.jpg \
	dongguan/dongguan-13.jpg

dongguan/dongguan-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DONGGUAN_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
dongguan/dongguan-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DONGGUAN_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
dongguan/dongguan-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DONGGUAN_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
dongguan/dongguan-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DONGGUAN_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
dongguan/dongguan-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DONGGUAN_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
dongguan/dongguan-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DONGGUAN_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
dongguan/dongguan-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DONGGUAN_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
dongguan/dongguan-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DONGGUAN_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





lagos: \
	lagos/lagos-16.jpg \
	lagos/lagos-17.jpg \
	lagos/lagos-12.jpg \
	lagos/lagos-15.jpg \
	lagos/lagos-14.jpg \
	lagos/lagos-13.jpg

lagos/lagos-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LAGOS_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
lagos/lagos-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LAGOS_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
lagos/lagos-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LAGOS_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
lagos/lagos-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LAGOS_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
lagos/lagos-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LAGOS_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
lagos/lagos-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LAGOS_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
lagos/lagos-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LAGOS_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
lagos/lagos-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(LAGOS_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





berlin: \
	berlin/berlin-16.jpg \
	berlin/berlin-12.jpg \
	berlin/berlin-17.jpg \
	berlin/berlin-15.jpg \
	berlin/berlin-14.jpg \
	berlin/berlin-13.jpg

berlin/berlin-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BERLIN_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
berlin/berlin-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BERLIN_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
berlin/berlin-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BERLIN_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
berlin/berlin-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BERLIN_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
berlin/berlin-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BERLIN_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
berlin/berlin-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BERLIN_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
berlin/berlin-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BERLIN_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
berlin/berlin-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BERLIN_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@







halifax: \
	halifax/halifax-16.jpg \
	halifax/halifax-12.jpg \
	halifax/halifax-17.jpg \
	halifax/halifax-15.jpg \
	halifax/halifax-14.jpg \
	halifax/halifax-13.jpg

halifax/halifax-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(HALIFAX_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
halifax/halifax-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(HALIFAX_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
halifax/halifax-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(HALIFAX_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
halifax/halifax-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(HALIFAX_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
halifax/halifax-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(HALIFAX_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
halifax/halifax-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(HALIFAX_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
halifax/halifax-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(HALIFAX_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
halifax/halifax-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(HALIFAX_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@







maui: \
	maui/maui-08.jpg \
	maui/maui-09.jpg \
	maui/maui-10.jpg \
	maui/maui-11.jpg \
	maui/maui-12.jpg \
	maui/maui-13.jpg \
	maui/maui-14.jpg \
	maui/maui-15.jpg \
	maui/maui-16.jpg \
	maui/maui-17.jpg \
	maui/maui-18.jpg 

maui/maui-08.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MAUI_LATLON) -z 8 -d $(WIDTH_150) $(HEIGHT_150) $@
maui/maui-09.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MAUI_LATLON) -z 9 -d $(WIDTH_150) $(HEIGHT_150) $@
maui/maui-10.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MAUI_LATLON) -z 10 -d $(WIDTH_150) $(HEIGHT_150) $@
maui/maui-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MAUI_LATLON) -z 11 -d 6000 6000 $@
maui/maui-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MAUI_LATLON) -z 12 -d $(WIDTH_150) $(HEIGHT_150) $@
maui/maui-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MAUI_LATLON) -z 13 -d $(WIDTH_150) $(HEIGHT_150) $@
maui/maui-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MAUI_LATLON) -z 14 -d $(WIDTH_150) $(HEIGHT_150) $@
maui/maui-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MAUI_LATLON) -z 15 -d $(WIDTH_150) $(HEIGHT_150) $@
maui/maui-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MAUI_LATLON) -z 16 -d $(WIDTH_150) $(HEIGHT_150) $@
maui/maui-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MAUI_LATLON) -z 17 -d $(WIDTH_150) $(HEIGHT_150) $@
maui/maui-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(MAUI_LATLON) -z 18 -d $(WIDTH_150) $(HEIGHT_150) $@






rio: \
	rio/rio-16.jpg \
	rio/rio-12.jpg \
	rio/rio-17.jpg \
	rio/rio-15.jpg \
	rio/rio-14.jpg \
	rio/rio-13.jpg

rio/rio-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(RIO_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
rio/rio-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(RIO_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
rio/rio-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(RIO_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
rio/rio-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(RIO_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
rio/rio-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(RIO_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
rio/rio-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(RIO_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
rio/rio-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(RIO_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
rio/rio-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(RIO_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





baghdad: \
	baghdad/baghdad-16.jpg \
	baghdad/baghdad-17.jpg \
	baghdad/baghdad-11.jpg \
	baghdad/baghdad-12.jpg \
	baghdad/baghdad-15.jpg \
	baghdad/baghdad-14.jpg \
	baghdad/baghdad-13.jpg

baghdad/baghdad-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BAGHDAD_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
baghdad/baghdad-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BAGHDAD_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
baghdad/baghdad-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BAGHDAD_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
baghdad/baghdad-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BAGHDAD_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
baghdad/baghdad-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BAGHDAD_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
baghdad/baghdad-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BAGHDAD_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
baghdad/baghdad-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BAGHDAD_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
baghdad/baghdad-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(BAGHDAD_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





damascas:\
	damascas/damascas-15.jpg \
	damascas/damascas-16.jpg \
	damascas/damascas-15.jpg \
	damascas/damascas-13.jpg \
	damascas/damascas-17.jpg \
	damascas/damascas-14.jpg

damascas/damascas-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DAMASCAS_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
damascas/damascas-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DAMASCAS_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
damascas/damascas-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DAMASCAS_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
damascas/damascas-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DAMASCAS_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
damascas/damascas-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DAMASCAS_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
damascas/damascas-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DAMASCAS_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
damascas/damascas-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DAMASCAS_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
damascas/damascas-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(DAMASCAS_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





amsterdam: \
	amsterdam/amsterdam-17.jpg \
	amsterdam/amsterdam-16.jpg \
	amsterdam/amsterdam-13.jpg \
	amsterdam/amsterdam-12.jpg \
	amsterdam/amsterdam-11.jpg \
	amsterdam/amsterdam-15.jpg \
	amsterdam/amsterdam-14.jpg

amsterdam/amsterdam-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(AMSTERDAM_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
amsterdam/amsterdam-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(AMSTERDAM_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
amsterdam/amsterdam-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(AMSTERDAM_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
amsterdam/amsterdam-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(AMSTERDAM_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
amsterdam/amsterdam-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(AMSTERDAM_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
amsterdam/amsterdam-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(AMSTERDAM_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
amsterdam/amsterdam-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(AMSTERDAM_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
amsterdam/amsterdam-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(AMSTERDAM_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@





versailles: \
	versailles/versailles-18.jpg \
	versailles/versailles-15.jpg \
	versailles/versailles-14.jpg \
	versailles/versailles-17.jpg \
	versailles/versailles-16.jpg

versailles/versailles-11.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(VERSAILLES_LATLON) -z 11 -d $(WIDTH_300) $(HEIGHT_300) $@
versailles/versailles-12.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(VERSAILLES_LATLON) -z 12 -d $(WIDTH_300) $(HEIGHT_300) $@
versailles/versailles-13.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(VERSAILLES_LATLON) -z 13 -d $(WIDTH_300) $(HEIGHT_300) $@
versailles/versailles-14.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(VERSAILLES_LATLON) -z 14 -d $(WIDTH_300) $(HEIGHT_300) $@
versailles/versailles-15.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(VERSAILLES_LATLON) -z 15 -d $(WIDTH_300) $(HEIGHT_300) $@
versailles/versailles-16.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(VERSAILLES_LATLON) -z 16 -d $(WIDTH_300) $(HEIGHT_300) $@
versailles/versailles-17.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(VERSAILLES_LATLON) -z 17 -d $(WIDTH_300) $(HEIGHT_300) $@
versailles/versailles-18.jpg:
	$(TILESTACHE_COMPOSE) -c $(TILESTACHE_CONFIG) -l watercolor -n $(VERSAILLES_LATLON) -z 18 -d $(WIDTH_300) $(HEIGHT_300) $@


