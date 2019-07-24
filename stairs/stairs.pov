#declare      high_qual = true;

global_settings {
	max_trace_level 6
        #if (high_qual)
        radiosity {
                brightness 1.2
                count 80
                error_bound .15
                low_error_factor .2
                minimum_reuse .015
                nearest_count 10
                recursion_limit 2
                adc_bailout .01
                max_sample .5
                normal off
                always_sample off
                pretrace_start .08
                pretrace_end .01
        }              
        #end
}


#declare cam_pos=<-2, 2, -4>;
#include "colors.inc"  
#include "textures.inc"
#include "stones2.inc"

camera{
        location cam_pos
        look_at<-1,-2,0> 
}         
    
    
light_source{<0,1,4.8>, White
        //fade_distance .5
        //fade_power 2
}       

 
//////////////////////////////////////////////////////////
////////////////////// textures //////////////////////////
//////////////////////////////////////////////////////////

#declare tex_metal=texture{
	pigment{White*.5}
	finish{
		metallic
		reflection .3
		ambient .2
		phong .3
		phong_size .3
	} 
	normal{
	        bozo
	        turbulence .2
	}
}           

#declare T = 
texture{
    pigment {
        wood  turbulence 0.04
        octaves 3
        scale <0.05, .05, 1>
        color_map { 
            [0.1 rgb <0.88, 0.60, 0.4>]
            [0.9 rgb <0.60, 0.40, 0.3>]
        }
    }
    finish { 
        specular 0.25
        roughness 0.05
        ambient 0.45 
        diffuse 0.33
        reflection 0.15
    }
}
texture {
    pigment {
        wood  turbulence <0.1, 0.5, 1> 
        octaves 5
        lambda 3.25
        scale <0.15, .5, 1>
        color_map { 
            [0.0 rgbt <0.7, 0.6, 0.4, 0.100>]
            [0.1 rgbt <0.8, 0.6, 0.3, 0.500>]
            [0.1 rgbt <0.8, 0.6, 0.3, 0.650>]
            [0.9 rgbt <0.6, 0.4, 0.2, 0.975>]
            [1.0 rgbt <0.6, 0.4, 0.2, 1.000>]
        }
    rotate <5, 10, 5>
    translate -x*2
    }
    finish { 
        specular 0.25 
        roughness 0.0005
        ambient .1 
        diffuse 0.33
    } 
}
// A "coat of varnish" to modify the overall color of the wood
texture {
    pigment { rgbt <0.75, 0.15, 0.0, 0.95> }
    finish { 
        specular 0.25
        roughness 0.01
        ambient 0
        diffuse 0.33
    }
}

#declare text_cedar=texture{
        T scale 40
}
       
       
//////////////////////////////////////////////////////////
//////////////////////// scène  //////////////////////////
//////////////////////////////////////////////////////////                     

// murs
union{
       plane {x,-5}
       plane {x, 5}
       plane {z,-6}
       plane {z, 6}

    
		texture{
        	/*pigment{White}
			finish{
				ambient .2
			}*/
			T_Stone34
			scale 3000
       }
}
       
// rambarde      
#declare rayon = .1;
union{
        //cylinder{<0,-20,3>, <0,20,3>, .1}
            
        #declare demi_rambarde = union{
        intersection{
                box{<-1,-1,0>,<1,1,1>}
                torus{.8,rayon}
                translate <0,-2,3>
        }   
           
        intersection{
                box{<-1,-1,-1>,<1,1,0>}
                torus{.8,rayon}
                translate <0,1,-3>
        }     
        
        // jointures bouliques
        sphere{<-.8,1,-3>,rayon} 
        sphere{<-.8,-2,3>,rayon}
        sphere{<.8,-2,3>,rayon}
           
        cylinder{<-.8,1,-3>,<-.8,-2,3>,rayon} 
        cylinder{<.8,-2,3>,<.8,-5,-3>,rayon}  
        }
        
        object{demi_rambarde}
        object{demi_rambarde translate y*-3}
        
        #declare obj_rambarde = box{<-.01,0,-.05>,<.01,3,.05>}
        
        #declare i=0;
        #declare divise_en = 6;
        #declare pas = 6/ divise_en;
        #while (i<=6)
            object{ obj_rambarde translate <-.8,-2-i/2,-3+i>}
            object{ obj_rambarde translate <.8,-5-i/2,3-i>}
            #declare i=i+pas;
        #end
                                            
        texture{tex_metal}
}                 


// marches en métal
#declare marche = union{              
        difference{
                box{<-3,-.01,-.5>,<3,.01,.5>}
                
                #if (high_qual)
                        #declare i=-.4;
                        #while (i<.5)
                            #declare j=-3;
                            #while (j<=3)
                                cylinder{<0,-1,0>,<0,1,0>,.06  translate <j,0,i>}
                                cylinder{<0,-1,0>,<0,1,0>,.06  translate <j+.2,0,i+.2>}
                                #declare j=j+.4;
                            #end
                            #declare i=i+.4;
                        #end    
                #end
        
        } 
}         

// pallier
difference{
        box{<-6,-5.1,3>,<6,-5.2,6> }
        
        #if (high_qual)
                #declare i=-4.9;
                #while (i<=4.9)
                    #declare j=3.1;
                    #while (j<=6)
                        cylinder{<0,-1,0>,<0,1,0>, .06 translate <i,-5,j>}
                        cylinder{<0,-1,0>,<0,1,0>, .06 translate <i+.2,-5,j+.2>}
                        #declare j=j+.4;
                    #end                               
                    #declare i=i+.4;
                #end  
        #end
         
         
        texture{tex_metal}
}       

// marches
union{
#declare i=0;
#while (i<=6)
    object{marche translate <-4,-4.5+i/2,2.3-i>}  
    object{marche translate <4,-6-i/2,2.3-i>}
    #declare i=i+1;
#end  

texture{tex_metal}
}                

// support des marches                 
union{
box{<-.3,-.1,0>,<.3,.1,-10> rotate x*-26.5 translate <4,-5.5,4>}
box{<-.3,-.1,0>,<.3,.1,-10> rotate x*-26.5 translate <2,-5.5,4>}
 
        texture{tex_metal}
}                        


// panneau 3/4
/*difference{
        box{-1,1}
        box{-.98,.98}

        texture{
                pigment{
                        image_map{
                                png 
                                "panneau.png"                               
                                transmit all .5  
                        }                        
                        scale 2
                        translate <1,1,0>
                }
        }  
        //hollow
        scale .5
        translate <0,1,6.45>   
        
}
*/
              
              
#include "cedar.inc"

light_group{

object{CEDAR    scale .03 
                rotate y*90   
                scale z*-1
                translate <-.7,-.35,0>
texture{text_cedar}}               
  
//sphere{  <-3,-3,0> ,.5}
  
  
light_source{<-3,0,0> 2*White
        //spotlight point_at <-.7,.3,0> radius 30 tightness 20 falloff 10
        area_light z,y,2,5
        jitter 
}           
  
/*light_source{<3,0,0> 2*White
        //spotlight point_at <-.7,.3,0> radius 30 tightness 20 falloff 10
        area_light z,y,2,5
        jitter 
} */ 
  
  
}
