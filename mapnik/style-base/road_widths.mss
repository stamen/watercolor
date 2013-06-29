/* 

style_base
-- these are subtracted out of backgrounds in both mask_set1 and mask_set2: water, buildings, etc.
-- casing for general roads (also see mask_set1)
-- casing for bridges at higher zooms
-- IMPORTANT!!!
-- you also need to modify the styles in MASK_SET1 to create the color inline part

*/




/*
Roads at the mid-zooms
*/

/*
.ne_10m_roads_casing[zoom=5][scalerank=3]
{
	line-width: 2;
    line-color: #000;
}

/*
.ne_10m_roads_casing[zoom=6][scalerank=3],
.ne_10m_roads_casing[zoom=6][scalerank=4],
.ne_10m_roads_casing[zoom=6][roadtype="Beltway"],
.ne_10m_roads_casing[zoom=6][scalerank<=5][type_2="Expressway"]
{
	line-width: 2;
    line-color: #000;
}
*/

/*
.ne_10m_roads_casing[zoom=7]
{
	line-width: 2;
}
*/
.ne_10m_roads_casing[zoom=7][scalerank=3],
.ne_10m_roads_casing[zoom=7][scalerank=4],
.ne_10m_roads_casing[zoom=7][roadtype="Beltway"],
.ne_10m_roads_casing[zoom=7][scalerank<=5][type_2="Expressway"]
{
	line-width: 5;
    line-color: #000;
}

/*
.ne_10m_roads_casing[zoom=8]
{
	line-width: 2;
}
*/
.ne_10m_roads_casing[zoom=8][scalerank=3],
.ne_10m_roads_casing[zoom=8][scalerank=4],
.ne_10m_roads_casing[zoom=8][roadtype="Beltway"],
.ne_10m_roads_casing[zoom=8][scalerank<=6][type_2="Expressway"]
{
	line-color: #000;
	line-width: 5;
}


/*
Roads at the detailed-city-zooms
*/


/*//////// Zoom Level 9 */
#z10-roads[zoom=9][kind=highway][render=outline]    { line-width: 5; line-color: #000000; }
#z10-roads[zoom=9][kind=major_road][render=outline] { line-width: 0; line-color: #000000; }

/*//////// Zoom Level 10 */
#z10-roads[zoom=10][kind=highway][render=outline]    { line-width: 5; line-color: #000000; }
#z10-roads[zoom=10][kind=major_road][render=outline] { line-width: 4; line-color: #000000; }

/*//////// Zoom Level 11 */
#z11-roads[zoom=11][kind=highway][render=outline]    { line-width: 5.5; line-color: #000000; }
#z11-roads[zoom=11][kind=major_road][render=outline] { line-width: 4.0; line-color: #000000; }

/*//////// Zoom Level 12 */
#z12-roads[zoom=12][kind=highway][is_link=no][render=outline] { line-width: 6.25; line-color: #000000; }
#z12-roads[zoom=12][kind=major_road][render=outline] 		  { line-width: 4.00; line-color: #000000; }

/*//////// Zoom Level 13 */
#z13-roads[zoom=13][kind=highway][is_link=no][render=outline] { line-width: 7.5; line-color: #000000; }
#z13-roads[zoom=13][kind=major_road][render=outline] 		  { line-width: 4.0; line-color: #000000; }

/*//////// Zoom Level 14 */
#z14-roads[zoom=14][kind=highway][render=outline]    { line-width: 8; line-color: #000000; }
#z14-roads[zoom=14][kind=major_road][render=outline] { line-width: 5; line-color: #000000; }

/*//////// Zoom Level 15 */
#z15plus-roads[zoom=15][kind=highway][render=outline]    { line-width: 8.0; line-color: #000000; }
#z15plus-roads[zoom=15][kind=major_road][render=outline] { line-width: 5.5; line-color: #000000; }
#z15plus-roads[zoom=15][kind=minor_road][render=outline] { line-width: 3.0; line-color: #000000; }

/*//////// Zoom Level 16 */
#z15plus-roads[zoom=16][kind=highway][render=outline]    { line-width: 9; line-color: #000000; }
#z15plus-roads[zoom=16][kind=major_road][render=outline] { line-width: 7; line-color: #000000; }
#z15plus-roads[zoom=16][kind=minor_road][render=outline] { line-width: 4; line-color: #000000; }

/*//////// Zoom Level 17 */
#z15plus-roads[zoom=17][kind=highway][render=outline] { line-width: 15; line-color: #000000; }
#z15plus-roads[zoom=17][kind=major_road][render=outline] { line-width: 13; line-color: #000000; }
#z15plus-roads[zoom=17][kind=minor_road][render=outline] { line-width: 7; line-color: #000000; }

/*//////// Zoom Level 18 */
#z15plus-roads[zoom>=18][kind=highway][render=outline] { line-width: 28; line-color: #000000; }
#z15plus-roads[zoom>=18][kind=major_road][render=outline] { line-width: 19; line-color: #000000; }
#z15plus-roads[zoom>=18][kind=minor_road][render=outline] { line-width: 13; line-color: #000000; }