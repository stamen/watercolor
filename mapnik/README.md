Watercolor masks and mapnik styles
====

NOTE: layer order is defined in tilestache.cfg, not here.


mask_set_1 (white outlined colors)
-- 

* create the background colors (parks, civic areas, ground)
* get cut out of the ground (they have a white casing in the rendered images)
* most roads with white casing...
* implied road inline colors (or white)

![mask_set_1](mask_set_1/test.png?raw=true "mask_set_1")


mask_set_2 (overlay colors)
--
* buildings
* some roads that multiply into the background color (these are usually roads without casing)
* water

![mask_set_2](mask_set_2/test.png?raw=true "mask_set_2")


style_base
--
* these are subtracted out of backgrounds in both mask_set_1 and mask_set_2: water, buildings, etc.
* casing for general roads (also see mask_set_1)
* casing for bridges at higher zooms

IMPORTANT!!!
--
* you also need to modify the styles in mask_set_1 to create the color inline part
