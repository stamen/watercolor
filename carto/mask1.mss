Map {
  background-color: black;
}

#land,#country-shapes-110m,#country-shapes-50m,#country-shapes-10m {
  polygon-fill: #ff0; 
}

#green-areas-low,#green-areas-med,#green-areas-high {
  polygon-fill: #0f0;
}

#ne-roads {
  [zoom=7] {
    [scalerank=3],[scalerank=4],[type='Beltway'],[scalerank<=5][expressway=1] {
      line-color: #f00;
  	  line-width: 5; 
    }
  }
  
  [zoom=8] {
    [scalerank=3],[scalerank=4],[type='Beltway'],[scalerank<=6][expressway=1] {
      line-color: #f00;
  	  line-width: 5; 
    }
  }
}

#roads {
  [zoom=9] {
    [kind='highway'] {
      line-width: 4;
	  line-color: #f00; 
    }
  }
  
  [zoom=10] {
    [kind='highway'] {
      line-width: 5.00; 
      line-color: #f00;
    }
    
    [kind='major_road'] {
      line-width: 4.25; 
      line-color: #f0f;
    }
  }
  
  [zoom=11] {
    [kind='highway'] {
      line-width: 5.50; 
      line-color: #f00;
    }
    
    [kind='major_road'] {
      line-width: 4.25; 
      line-color: #f0f;
    }
  }
  
  [zoom=12] {
    [kind='highway'] {
      line-width: 6.25; 
      line-color: #f00;
    }
    
    [kind='major_road'] {
      line-width: 4.50; 
      line-color: #f0f;
    }
  }
  
  [zoom=13] {
    [kind='highway'] {
      line-width: 7.5; 
      line-color: #f00;
    }
    
    [kind='major_road'] {
      line-width: 4.50; 
      line-color: #f0f;
    }
  }
  
  [zoom=14] {
    [kind='highway'] {
      line-width: 8.0; 
      line-color: #f00;
    }
    
    [kind='major_road'] {
      line-width: 5.7; 
      line-color: #f0f;
    }
  }
  
  [zoom=15] {
    [kind='highway'] {
      line-width: 8.0; 
      line-color: #f00;
    }
    
    [kind='major_road'] {
      line-width: 6.0; 
      line-color: #f0f;
    }
    
    [kind='minor_road'] {
      line-width: 4.0; 
      line-color: #0ff;
    }
  }
  
  [zoom=16] {
    [kind='highway'] {
      line-width: 9.0; 
      line-color: #f00;
    }
    
    [kind='major_road'] {
      line-width: 7.25; 
      line-color: #f0f;
    }
    
    [kind='minor_road'] {
      line-width: 4.00; 
      line-color: #0ff;
    }
  }
  
  [zoom=17] {
    [kind='highway'] {
      line-width: 15.0; 
      line-color: #f00;
    }
    
    [kind='major_road'] {
      line-width: 11.0; 
      line-color: #f0f;
    }
    
    [kind='minor_road'] {
      line-width: 7.0; 
      line-color: #0ff;
    }
  }
  
  [zoom>=18] {
    [kind='highway'] {
      line-width: 28.0; 
      line-color: #f00;
    }
    
    [kind='major_road'] {
      line-width: 18.0; 
      line-color: #f0f;
    }
    
    [kind='minor_road'] {
      line-width: 13.0; 
      line-color: #0ff;
    }
  }
}