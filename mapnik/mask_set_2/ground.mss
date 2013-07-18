Map { map-bgcolor: #00f; }

.coast { polygon-fill: #000; line-width: 0.5; line-color: #000} /* not sure why, but doing the same line-width here ends up with a bigger space around water */

.water-bodies[zoom=8][area>25000000],
.water-bodies[zoom=9][area>5000000],
.water-bodies[zoom=10][area>1000000],
.water-bodies[zoom=11][area>200000],
.water-bodies[zoom=12][area>100000],
.water-bodies[zoom>=13] 
{ 
	polygon-fill: #00f; line-width: 1; line-color: #000; 
}

.lakes-110m[zoom<3],
.lakes-50m[zoom>=3][zoom<6][scalerank<3],
.lakes-50m[zoom>=6][zoom<6],
.lakes-10m[zoom>=6][zoom<8]
{
    polygon-fill: #00f; line-width: 1; line-color: #000; 
}

.buildings[zoom=13][area>10000],
.buildings[zoom=14][area>8000],
.buildings[zoom=15][area>6000],
.buildings[zoom=16][area>4000],
.buildings[zoom=17][area>1000],
.buildings[zoom>17]  
{ 
	polygon-fill: #0f0; 
}