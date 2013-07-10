Watercolor masks and mapnik styles
====

Watercolor uses two special mapnik styles ('mask_set_1' and 'mask_set_2') that are used as inputs to the TileStache module that produces the "watercolor effect". Each of these styles encodes a specific data layer (roads, water, etc) as a color channel. See below for specifics of each layer. Both 'mask_set_1' and 'mask_set_2' rely on 'style_base' to control the thickness of road casings.

NOTE: layer order is defined in tilestache.cfg, not here.



mask_set_1 (white outlined colors)
-- 

* create the background colors (parks, civic areas, ground)
* get cut out of the ground (they have a white casing in the rendered images)
* most roads with white casing...
* implied road inline colors (or white)

mask_set_1 layers:

* water: #000;
* land:	#ff0;
* green areas: #0f0;
* civic areas: #00f;
* parking areas: #00f;
* roads: #f00;
* major roads: #f0f;
* minor roads: #0ff;

![mask_set_1](mask_set_1/test.png?raw=true "mask_set_1")


mask_set_2 (overlay colors)
--
* buildings
* some roads that multiply into the background color (these are usually roads without casing)
* water

mask_set_2 layers:

* land: #000;
* water: #00f;
* lakes: #00f;
* buildings: #0f0;
* roads: #f00;
* roads casing: #000

![mask_set_2](mask_set_2/test.png?raw=true "mask_set_2")


style_base (road thicknesses to create casings)
--
* these are subtracted out of backgrounds in both mask_set_1 and mask_set_2: water, buildings, etc.
* casing for general roads (also see mask_set_1)
* casing for bridges at higher zooms
* IMPORTANT!!! you also need to modify the styles in mask_set_1 to create the color inline part
