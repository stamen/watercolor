/* 

mask_set2
• overlay colors
-- buildings
-- some roads that multiply into the background color (these are usually roads without casing)
-- water
*/

/*
Roads at the mid-zooms
*/

.ne_10m_roads_inline[zoom=5][scalerank=3]
{
	line-width: 2.85;
    line-color: #f00;
}


.ne_10m_roads_inline[zoom=6][scalerank=3],
.ne_10m_roads_inline[zoom=6][scalerank=4],
.ne_10m_roads_inline[zoom=6][roadtype="Beltway"],
.ne_10m_roads_inline[zoom=6][scalerank<=5][type_2="Expressway"]
{
	line-width: 3.8;
    line-color: #f00;
}


.ne_10m_roads_casing[zoom=7]
{
	line-width: 4;
    line-color: #f00;
}
.ne_10m_roads_casing[zoom=7][scalerank=3],
.ne_10m_roads_casing[zoom=7][scalerank=4],
.ne_10m_roads_casing[zoom=7][roadtype="Beltway"],
.ne_10m_roads_casing[zoom=7][scalerank<=5][type_2="Expressway"]
{
	line-width: 6;
    line-color: #000;
}

.ne_10m_roads_casing[zoom=8]
{
	line-width: 4;
	line-color: #f00;
}
.ne_10m_roads_casing[zoom=8][scalerank=3],
.ne_10m_roads_casing[zoom=8][scalerank=4],
.ne_10m_roads_casing[zoom=8][roadtype="Beltway"],
.ne_10m_roads_casing[zoom=8][scalerank<=6][type_2="Expressway"]
{
	line-width: 6;
    line-color: #000;
}



/*
Roads at the detailed-city-zooms
*/


/*//////// Zoom Level 9 */
#z10-roads[zoom=9][kind=highway][render=inline] { 
	line-width: 7;
    line-color: #000;
}
#z10-roads[zoom=9][kind=major_road][render=outline] { 
	line-width: 4;
	line-color: #f0f; 
}