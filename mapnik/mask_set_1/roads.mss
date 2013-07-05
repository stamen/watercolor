/* 

mask_set1
• white outlined colors
-- create the background colors (parks, civic areas, ground)
-- get cut out of the ground (they have a white casing in the rendered images)
-- most roads with white casing...
-- implied road inline colors (or white)

*/

/*
Roads at the mid-zooms
*/

/*
.ne_10m_roads_inline[zoom=5][scalerank=3]
{
	line-width: 1;
    line-color: #f00;
}
*/


/*
.ne_10m_roads_inline[zoom=6][scalerank=3],
.ne_10m_roads_inline[zoom=6][scalerank=4],
.ne_10m_roads_inline[zoom=6][type="Beltway"],
.ne_10m_roads_inline[zoom=6][scalerank<=5][expressway=1]
{
	line-width: 1;
    line-color: #f00;
}
*/


.ne_10m_roads_inline[zoom=7][scalerank=3],
.ne_10m_roads_inline[zoom=7][scalerank=4],
.ne_10m_roads_inline[zoom=7][type="Beltway"],
.ne_10m_roads_inline[zoom=7][scalerank<=5][expressway=1]
{
    line-color: #f00;
	line-width: 5;
}


.ne_10m_roads_inline[zoom=8][scalerank=3],
.ne_10m_roads_inline[zoom=8][scalerank=4],
.ne_10m_roads_inline[zoom=8][type="Beltway"],
.ne_10m_roads_inline[zoom=8][scalerank<=6][expressway=1]
{
	line-color: #f00;
	line-width: 5;
}


/*
Roads at the detailed-city-zooms
*/


/*//////// Zoom Level 9 */
#z10-roads[zoom=9][kind=highway][render=inline] { 
	line-width: 4;
	line-color: #f00; 
}
#z10-roads[zoom=9][kind=major_road][render=inline] { 
	line-width: 0; 
	line-color: #f0f; 
}


/*//////// Zoom Level 10 */
#z10-roads[zoom=10][kind=highway][render=inline]    { line-width: 5.00; line-color: #f00; }
#z10-roads[zoom=10][kind=major_road][render=inline] { line-width: 4.25; line-color: #f0f; }


/*//////// Zoom Level 11 */
#z11-roads[zoom=11][kind=highway][render=inline]    { line-width: 5.50; line-color: #f00; }
#z11-roads[zoom=11][kind=major_road][render=inline] { line-width: 4.25; line-color: #f0f; }


/*//////// Zoom Level 12 */
#z12-roads[zoom=12][kind=highway][is_link=no][render=inline] { line-width: 6.25; line-color: #f00; }
#z12-roads[zoom=12][kind=major_road][render=inline]          { line-width: 4.50; line-color: #f0f; }


/*//////// Zoom Level 13 */
#z13-roads[zoom=13][kind=highway][is_link=no][render=inline] { line-width: 7.5; line-color: #f00; }
#z13-roads[zoom=13][kind=major_road][render=inline]          { line-width: 4.5; line-color: #f0f; }


/*//////// Zoom Level 14 */
#z14-roads[zoom=14][kind=highway][render=inline]    { line-width: 8.0; line-color: #f00; }
#z14-roads[zoom=14][kind=major_road][render=inline] { line-width: 5.7; line-color: #f0f; }


/*//////// Zoom Level 15 */
#z15plus-roads[zoom=15][kind=highway][render=inline]    { line-width: 8.0; line-color: #f00; }
#z15plus-roads[zoom=15][kind=major_road][render=inline] { line-width: 6.0; line-color: #f0f; }
#z15plus-roads[zoom=15][kind=minor_road][render=inline] { line-width: 4.0; line-color: #0ff; }


/*//////// Zoom Level 16 */
#z15plus-roads[zoom=16][kind=highway][render=inline]    { line-width: 9.00;  line-color: #f00; }
#z15plus-roads[zoom=16][kind=major_road][render=inline] { line-width: 7.25; line-color: #f0f; }
#z15plus-roads[zoom=16][kind=minor_road][render=inline] { line-width: 4.00;  line-color: #0ff; }


/*//////// Zoom Level 17 */
#z15plus-roads[zoom=17][kind=highway][render=inline]    { line-width: 15; line-color: #f00; }
#z15plus-roads[zoom=17][kind=major_road][render=inline] { line-width: 11; line-color: #f0f; }
#z15plus-roads[zoom=17][kind=minor_road][render=inline] { line-width:  7; line-color: #0ff; }


/*//////// Zoom Level 18 */
#z15plus-roads[zoom>=18][kind=highway][render=inline]    { line-width: 28; line-color: #f00; }
#z15plus-roads[zoom>=18][kind=major_road][render=inline] { line-width: 18; line-color: #f0f; }
#z15plus-roads[zoom>=18][kind=minor_road][render=inline] { line-width: 13; line-color: #0ff; }
