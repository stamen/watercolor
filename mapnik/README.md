This is the place where are the non-database-y things required to generate the
"Watercolor" Mapnik stylesheets are kept.

At the end of the day Watercolor generates stylesheets that can be used by a program
called Mapnik to draw maps. Those maps might be a single large image for print
or a lot of small images for map tiles but as far as Mapnik is concerned there
is an image of a set size that covers a specific geographic area and a bunch of
rules (styles) for how to draw the stuff inside those boxes.

Watercolor relies on a tool called Cascadenik so that map styles can be defined using
a CSS-like syntax that is a little more friendly than the XML-based markup
language that Mapnik uses by default. With Cascadenik you define two kinds of
files: Things ending in '.mss' are where the actual look and feel for a map;
Things ending in '.mml' are where you define administrative bits like database
passwords and queries for things to show on the map.

Note that Watercolor does some fairly unique things with the Cascadenik/Mapnik/Tilestache toolchain, and is more difficult to understand than a style like Toner that uses Cascadenik and Mapnik in a more straightforward way. Do not try to learn how Cascadenik and Mapnik work by studying Watercolor!

How different is Watercolor? Specifically, Watercolor's mapnik stylesheets create unique "mask styles" (see below for details) which are then processed by the HandMaps python plugin to Tilestache. 

Stylesheets and makefiles
--
Watercolor uses a Makefile to control building the Mapnik stylesheets and generating test images. This document will not go into detail about how the `make` command works. Here are the `make` commands you need to know:

NOTE: all `make` commands should be run from the root watercolor directory, not from the watercolor/mapnik subdirectory.

First, run this command:

	make clean

…which will remove any precompiled files and establish a fresh working environment. Then, you should compile the necessary Mapnik stylesheets and update the Tilestache directory with this command: 

	make tilestache-update

Optional: There are also other `make` commands for testing changes to the stylesheet by
generating images of cities all over the world at different zoom levels. To test
your Watercolor stylesheet you would type:

	make all

Or simply:

	make

…which will generate images in the watercolor/renders/ directory.

Once you have compiled your Mapnik stylesheets and (optionally) tested them by rendering sample images, you can proceed to the README file in the Tilestache directory to generate map tiles.



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
