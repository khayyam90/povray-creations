#include "colors.inc"
#include "glass.inc"
#include "textures.inc"

global_settings {
    assumed_gamma 1
    max_trace_level 5
    ambient_light White
    photons {
        count 150000
        max_trace_level 9
        media 100, 2
    }
}

background{White}

box{<-1000,-1000,-30>,<1000,1000,-30> 
    texture {
        pigment {checker color rgb<230,230,0>/255, color rgb < 0.2, 0, 0.4>}
        finish {brilliance 0.25}
    scale 2
    }
   }

#declare cam_pos = <0,1.5,3>;             
             
camera { perspective
         location    cam_pos
         look_at <0,.7,0> 
         } 
         
#declare k=0;
#while (k<3)
 
 light_source {<5*cos(radians(120*k)), -5, 5*sin(radians(120*k))> rgb White}
 light_source {<5*cos(radians(120*k)), 5, 5*sin(radians(120*k))>  rgb White}


#declare k=k+1;
#end


#macro diamant(nb)
     
union
{         
   #declare i=0;
   #while(i<nb)
   
   triangle{<0,1,0>,<.7*cos(radians(i*360/nb)),1,.7*sin(radians(i*360/nb))>,<.7*cos(radians((i+1)*360/nb)),1,.7*sin(radians((i+1)*360/nb))>}
   polygon{5, <.7*cos(radians(i*360/nb)),1,.7*sin(radians(i*360/nb))>, 
              <.7*cos(radians((i+1)*360/nb)),1,.7*sin(radians((i+1)*360/nb))>,
              <cos(radians((i+1)*360/nb)),.8,sin(radians((i+1)*360/nb))>,
              <cos(radians(i*360/nb)),.8,sin(radians(i*360/nb))>,
              <.7*cos(radians(i*360/nb)),1,.7*sin(radians(i*360/nb))>
          }
   polygon{5, <cos(radians((i+1)*360/nb)),.8,sin(radians((i+1)*360/nb))>,
              <cos(radians(i*360/nb)),.8,sin(radians(i*360/nb))>,
              <cos(radians(i*360/nb)),.7,sin(radians(i*360/nb))>,
              <cos(radians((i+1)*360/nb)),.7,sin(radians((i+1)*360/nb))>,
              <cos(radians((i+1)*360/nb)),.8,sin(radians((i+1)*360/nb))>
          }
   triangle{<cos(radians(i*360/nb)),.7,sin(radians(i*360/nb))>,<cos(radians((i+1)*360/nb)),.7,sin(radians((i+1)*360/nb))>, <0,-.3,0>}
             
               
   #declare i=i+1;            
   #end            
   texture { Glass2 }


interior{ I_Glass_Dispersion1}
finish{phong 1
      }
translate <0,.3,0>
}
                                   
#end



object{
diamant(15)
scale <1.1,1.5,1.1>
translate <0,-.5,0>
}




