/* WATER color */
Map { map-bgcolor: #000; }

/* LAND color */
#coast[zoom>=9], #land[zoom<9] { polygon-fill: #ff0; }

.green-areas[zoom=10][area>5000000],
.green-areas[zoom=11][area>500000],
.green-areas[zoom=12][area>200000],
.green-areas[zoom=12][area>50000],
.green-areas[zoom=13][area>20000],
.green-areas[zoom=14][area>5000],
.green-areas[zoom>14]{ polygon-fill: #0f0; }


.civic-areas[zoom=10][area>5000000],
.civic-areas[zoom=11][area>500000],
.civic-areas[zoom=12][area>200000],
.civic-areas[zoom=12][area>50000],
.civic-areas[zoom=13][area>20000],
.civic-areas[zoom=14][area>5000],
.civic-areas[zoom>14] { polygon-fill: #00f; }

.parking-areas[zoom=10][area>5000000],
.parking-areas[zoom=11][area>500000],
.parking-areas[zoom=12][area>200000],
.parking-areas[zoom=12][area>50000],
.parking-areas[zoom=13][area>20000],
.parking-areas[zoom=14][area>5000],
.parking-areas[zoom>14] { polygon-fill: #00f; }