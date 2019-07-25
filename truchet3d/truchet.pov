global_settings{
        max_trace_level  5
}

#include "colors.inc" 
#include "textures.inc"

#declare cam_pos = <7.5,4.3,3>;
                        
camera{
        location cam_pos
        look_at <8.5,1.5,6>
}                      

background{White}    

light_source{cam_pos+<-.7,1.5,0>, White} 

light_source{cam_pos+<-.5,1.7,0>, White}  

light_source{cam_pos, White}
        
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
                                                   
      

/*//brouillard de surface
fog {
        fog_type 2
        distance 5
        Red
        fog_offset -10 //le dégradé ne commencera qu'à une altitude de 10
        fog_alt .1     
} */

plane{  y, 
        -10
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
                        cylinder{<0,-5.1,0>, <0,3.1,0>,.54}
                        cylinder{<0,-5.2,0>, <0,3.2,0>,.46} 
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
/*          
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
*/



/*****************************************************
                Truchet en 3D
****************************************************/


#macro ptit_tore(pt1, pt2)
     intersection{
           torus{.5,.04
           
           #if (pt1.x = pt2.x)
                 rotate z*90 translate<0, int(pt1.y+pt2.y+1)-.5, int(pt1.z+pt2.z+1)-.5>} 
                 
           #else #if (pt1.y = pt2.y) 
                        translate<int(pt1.x+pt2.x+1)-.5, 0, int(pt1.z+pt2.z+1)-.5>}
                #else
                        rotate x*90 translate<int(pt1.x+pt2.x+1)-.5, int(pt1.y+pt2.y+1)-.5, 0>}
                #end
           #end 
           
           box{-.5,.5}     
}


#end // macro ptit_tore

#declare tore=intersection{
        torus{.5,.04}
        box{<0,-1,0>,<1,1,1>}
}

#declare un=union{
        cylinder{<-.5,0,0>,<.5,0,0>,.04}
        cylinder{<0,-.5,0>,<0,.5,0>,.04}
        cylinder{<0,0,-.5>,<0,0,.5>,.04}  
        texture{text2}
}   

#declare deux=union{
        ptit_tore(<-.5,0,0>,<0,.5,0>)    
        ptit_tore(<0,-.5,0>,<0,0,-.5>)
        ptit_tore(<.5,0,0>,<0,0,.5>) 
        texture{text2}
} 

#declare trois=union{
        ptit_tore(<-.5,0,0>,<0,0,-.5>)
        ptit_tore(<0,-.5,0>,<.5,0,0>)
        ptit_tore(<0,.5,0>,<0,0,.5>) 
        texture{text2}
}  


   

#declare i=0;
#while(i<20)
    #declare j=0;
    #while(j<20)
        #declare k=0;
        #while(k<20)
            #declare truc = 1+int(2*rand(srand));
            #switch(truc)
                #case (0) object{un   #break
                #case (1) object{deux #break 
                #case (2) object{trois #break
            
            #end
             
            rotate x*90*int(4*rand(srand))
            rotate y*90*int(4*rand(srand))
            rotate z*90*int(4*rand(srand))
            translate <i,j,k>}
        #declare k=k+1;
        #end        
        
    #declare j=j+1;
    #end
#declare i=i+1;
#end            
     
     
