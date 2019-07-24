global_settings{
        max_trace_level  5 
}

#include "colors.inc" 
#include "textures.inc"

//#declare cam_pos = <7.5,4.3,3>;
#declare cam_pos = <7.5,5,3>;  
  
                        
camera{
        location cam_pos
        look_at <8.5,1.5,6>
}                      

background{White}    

light_source{cam_pos+<-.7,1.5,0>, White
                area_light <.2,0,0>,<0,0,.2>,4,4
                } 

light_source{cam_pos+<-.5,1.7,0>, White
                area_light <.2,0,0>,<0,0,.2>,4,4
                }  

light_source{cam_pos, White
                area_light <.2,0,0>,<0,0,.2>,4,4 

}
        
#declare srand=seed(15);
  
#declare Metallic_Finish =
    finish {
        metallic
        ambient 0.4
        diffuse 0.75
        specular 0.85
        roughness 0.01
        reflection 0.5   // .05
        brilliance 3   // 1.5
    }
  
#declare text2=texture{
    pigment { rgb <0.55, 0.5, 0.45> }
    finish { Metallic_Finish } 
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
        reflection 0.05
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
        translate <10,10,10>
}

plane{  y, 
        -1000
         pigment{Red}}     
      

/***************************************************
          pavage de Truchet en 2D
***************************************************/


#declare quart_torus=intersection{
     torus{.5,.04}
     box{<0,1,0>,<1,-1,1>}
     translate y*3
}
                   
#declare quart_cylinder=union{
        intersection{
                difference{
                        cylinder{<0,-500.1,0>, <0,3.1,0>,.54}
                        cylinder{<0,-500.2,0>, <0,3.2,0>,.46} 
                }         
                box{0,<1,3,1>}
        }                     
        intersection{
                torus{.5,.04 }
                box{0,<1,3,1>} 
                translate y*3
        } 
        //object{quart_torus rotate y*180 translate z*1}        
}      

      
                     
#declare obj1=union{        
         object{quart_cylinder texture{text2}}
         object{quart_cylinder rotate y*180 translate <1,0,1> texture{text2}}
}      

#declare obj2=union{
         object{quart_cylinder rotate y*90  translate z*1 texture{text2}}
         object{quart_cylinder rotate y*270 translate x*1 texture{text2}}
}  

#declare obj3=union{         
         box{<0,0,.46>,<1,3,.54>}   cylinder{<0,3,.5>,<1,3,.5>,.04}
         box{<.46,0,0>,<.54,3,1>}    cylinder{<.5,3,0>,<.5,3,1>,.04}
         texture{text2}         
} 
          
#declare i=0;
#while (i<20)
    #declare j=0;
    #while (j<20)
        #declare truc = int(3*rand(srand));
        #switch (truc)
            #case (0) object{obj1   #break
            #case (1) object{obj2   #break
            #case (2) object{obj3   #break
        #end
        
        translate <i,0,j>}
         
    #declare j=j+1;
    #end
#declare i=i+1;
#end   


// on rajoute le gus 
#include "cedar.pov"
#declare gus1 = union{
        object{gus1_1}   
        object{gus1_2}
        object{gus1_3}
        object{gus1_4}
        object{gus1_5}
        object{gus1_6}
        object{gus1_7}
        object{gus1_8}
        object{gus1_9}
        object{gus1_10}
        
        object{gus1_11}   
        object{gus1_12}
        object{gus1_13}
        object{gus1_14}
        object{gus1_15}
        object{gus1_16}
        object{gus1_17}
        object{gus1_18}
        object{gus1_19}
        object{gus1_20}
        
        object{gus1_21}   
        object{gus1_22}
        object{gus1_23}
        object{gus1_24}
        object{gus1_25}
        object{gus1_26}
        object{gus1_27}
        object{gus1_28}
        object{gus1_29}
        texture{text_cedar}
}     

object{
        gus1  
        scale .03   
        translate <8.5,3.34,5.2>
        }