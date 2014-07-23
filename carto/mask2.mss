Map {
  background-color: #00f;
}

#land,#country-shapes-110m,#country-shapes-50m,#country-shapes-10m {
  polygon-fill: #000; 
}

#water-bodies-low,#water-bodies-med,#water-bodies-high {
  [zoom=8][area>25000000] { polygon-fill: #00f; }
  [zoom=9][area>5000000] { polygon-fill: #00f; }
  [zoom=10][area>1000000] { polygon-fill: #00f; }
  [zoom=11][area>200000] { polygon-fill: #00f; }
  [zoom=12][area>100000] { polygon-fill: #00f; }
  [zoom>=13] { polygon-fill: #00f; }
}

#lakes-10m, #lakes-50m, #lakes-110m {
  polygon-fill: #00f;
}

#buildings-med[area>10000] {
  polygon-fill: #0f0;
}

#buildings-high {
  [zoom=14][area>8000] { polygon-fill: #0f0; }
  [zoom=15][area>6000] { polygon-fill: #0f0; }
  [zoom=16][area>4000] { polygon-fill: #0f0; }
  [zoom=17][area>1000] { polygon-fill: #0f0; }
  [zoom>17] { polygon-fill: #0f0; }
}

#ne-roads {
  [zoom=5][scalerank=3] {
   	line-width: 2.85;
    line-color: #f00;
  }
  
  [zoom=6] {
    [scalerank=3],[scalerank=4],[type='Beltway'],[scalerank<=5][expressway=1] {
      	line-width: 3.8;
    	line-color: #f00;
    }
  }
  
  [zoom=7] {
    [type!='Ferry Route'] {
      	line-width: 4;
    	line-color: #f00;
    }
    
    ::over[scalerank=3],[scalerank=4],[type='Beltway'],[scalerank<=5][expressway=1] {
      	line-width: 6;
    	line-color: #000;
    }
  }
  
  [zoom=8] {
    [type!='Ferry Route'] {
      	line-width: 4;
    	line-color: #f00;
    }    
    
    [scalerank=3],[scalerank=4],[type='Beltway'],[scalerank<=6][expressway=1] {
      line-color: #000;
  	  line-width: 6; 
    }
  }
}

#tunnels,
#roads,
#bridges,
{
  [zoom=9] {
    [kind='highway'] {
      line-width: 7;
	  line-color: #000; 
    }
    
    [kind='major_road'] {
      line-width: 4;
	  line-color: #f0f; 
    }
  }

  [zoom=10] {
    [kind='highway'] {
      line-width: 5;
	  line-color: #000; 
    }
    
    [kind='major_road'] {
      line-width: 4;
	  line-color: #000; 
    }
  }

  [zoom=11] {
    [kind='highway'] {
      line-width: 5.5;
	  line-color: #000; 
    }
    
    [kind='major_road'] {
      line-width: 4.0;
	  line-color: #000; 
    }
  }

  [zoom=12] {
    [kind='highway'] {
      line-width: 6.25;
	  line-color: #000; 
    }
    
    [kind='major_road'] {
      line-width: 4.00;
	  line-color: #000; 
    }
  }

  [zoom=13] {
    [kind='highway'] {
      line-width: 7.5;
	  line-color: #000; 
    }
    
    [kind='major_road'] {
      line-width: 4.0;
	  line-color: #000; 
    }
  }

  [zoom=14] {
    [kind='highway'] {
      line-width: 8;
	  line-color: #000; 
    }
    
    [kind='major_road'] {
      line-width: 5;
	  line-color: #000; 
    }
  }

  [zoom=15] {
    [kind='highway'] {
      line-width: 8.0;
	  line-color: #000; 
    }
    
    [kind='major_road'] {
      line-width: 5.5;
	  line-color: #000; 
    }

    [kind='minor_road'] {
      line-width: 3.0;
	  line-color: #000; 
    }
  }

  [zoom=16] {
    [kind='highway'] {
      line-width: 9.0;
	  line-color: #000; 
    }
    
    [kind='major_road'] {
      line-width: 7.0;
	  line-color: #000; 
    }

    [kind='minor_road'] {
      line-width: 4.0;
	  line-color: #000; 
    }
  }

  [zoom=17] {
    [kind='highway'] {
      line-width: 15.0;
	    line-color: #000; 
    }
    
    [kind='major_road'] {
      line-width: 13.0;
	  line-color: #000; 
    }

    [kind='minor_road'] {
      line-width: 7.0;
	  line-color: #000; 
    }
  }
}

