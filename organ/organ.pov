//#version unofficial Megapov 1.2;


#include "colors.inc" 
#include "textures.inc"
#include "shapes.inc"
#include "functions.inc"
#include "stones1.inc"
#include "woods.inc"


#declare cam_pos=<-3,3,-3>;

camera{
        location cam_pos
        look_at<3.5,2,4> 
        angle 80
}
   
//light_source{cam_pos, White}   
   
background{Black}

#declare srand=seed(5);

#declare tex_white_touch=texture{
    pigment{White}
}
                
#declare tex_black_touch=texture{
        pigment{color rgb .05}
        finish{
            reflection .1
            brilliance .1
            phong .3
            phong_size 1
        
        }
}   

#declare tex_partoche=texture{
        pigment{image_map{
           jpeg "partition.jpg"
        }}  
        normal{
        bumps 1
        }

} 

#declare tex_pupitre=texture{
     pigment{rgbt 1}
      normal {
      ripples
      turbulence .2
      normal_map {
        [0  bozo]
        [.5 ripples]
        [1  agate]
      }
 }
} 
texture{
        DMFWood6 
        rotate x*90
        scale 15
} 
  

#macro T_Stones2(Bright)
    pigment {
      granite
      color_map {
        [0.4 color rgb <0.7, 0.66, 0.65>*0.60*Bright ]
        [0.7 color rgb <0.7, 0.66, 0.65>*0.35*Bright ]
      }
      turbulence 0.6
      scale 0.4
    }

    finish {
      ambient 0.0
      diffuse 0.66
      brilliance 2.0
      specular 0.2
      roughness 0.02
    }

#end

#declare tex_lamp_metal=texture{Brass_Valley}           

#declare tex_lamp_glass=texture{pigment{Red}}

#macro touche(ty)
   #local edge = .02;
   #local fin = .8;
      union{
         Round_Box(<-.15,-.1,0>,<.15,.1,-.5>,edge, false)
         #switch(ty)
              #case (1) Round_Box(<-.05,0,-.1>,<.05,.1,fin>,edge, false) #break;
              #case (2) Round_Box(<-.05,0,-.1> ,<.15,.1,fin>,edge, false) #break;
              #case (3) Round_Box(<-.15,0,-.1>  ,<.05,.1,fin>,edge, false) #break;
              #default: #break;
         #end
         
    texture{tex_white_touch translate 10*rand(srand)}
    }        
#end

#macro clavier()
        #local diese = object{Round_Box(<-.1,-.1,0>,<.1,.18,.8>,.02,false) texture{tex_black_touch}}
        
        #macro octavio()
        union{
            object{touche(3)}
            object{touche(1) translate x*.3   translate -.01*rand(srand)}
            object{touche(2) translate x*.3*2 translate -.01*rand(srand)}
            object{touche(3) translate x*.3*3 translate -.01*rand(srand)}
            object{touche(1) translate x*.3*4 translate -.01*rand(srand)}
            object{touche(1) translate x*.3*5 translate -.01*rand(srand)}
            object{touche(2) translate x*.3*6 translate -.01*rand(srand)}  
            object{diese translate x*.15      translate -.01*rand(srand)} 
            object{diese translate x*(.15+.3) translate -.01*rand(srand)} 
            
            object{diese translate x*(.15+.3*3) translate -.01*rand(srand)} 
            object{diese translate x*(.15+.3*4) translate -.01*rand(srand)} 
            object{diese translate x*(.15+.3*5) translate -.01*rand(srand)} 
            scale .6666
        }
        #end 
        
        union{
        #local i=0;
        #while(i<6)
             object{octavio() translate x*(7*.3*i/1.5+.5)}
             #local i=i+1;
        #end  
        
        //box{<-5,0,1>,<20,-10,1.1> texture{T_Wood10}}
        difference{
           cylinder{<-5,0,1>,<20,0,1>,1}
           box{<-5,0,3>,<20,3,-3>}
           
           texture{T_Wood21 scale 15}
        }
           
        light_source{<8,-5,.5>, -10
        fade_distance 2 
        fade_power 5
        
        }   
        
        object{Round_Box(<-5,-5,-.26>,<.4,.1,2>,.1,false) texture{T_Wood21 rotate y*90 scale 15} }
        object{Round_Box(<9,-5,-.26>,<14,.1,2>,.1,false) texture{T_Wood21 rotate y*90 scale 15} }
        object{Round_Box(<0,-5,1>,<10,.1,2>,.1,false) texture{T_Wood21 rotate y*90 scale 15 } }
        
           
        scale <.6,1,1>
        translate x*1
        }
#end // macro clavier
       

#declare func_part = function{-x*pow(2,-5*x)}

#declare half_partoche=mesh{
           #declare j=0;
           #declare pasj=.1;
           #declare pasi=.01;
           
           #while(j<.9)          
           
           #declare i=0;
           #while(i<1)
               triangle{<i,j,func_part(i,0,0)>,<i+pasi,j,func_part(i+pasi,0,0)>,<i,j+pasj,func_part(i,0,0)>
               uv_vectors <i,j>,<i+pasi,j>,<i,j+pasj>
               }
               triangle{<i+pasi,j,func_part(i+pasi,0,0)>,<i,j+pasj,func_part(i,0,0)>,<i+pasi,j+pasj,func_part(i+pasi,0,0)>
               uv_vectors <i+pasi,j>,<i,j+pasj>,<i+pasi,j+pasj>
               }
               #declare i=i+pasi;
           #end 
           
               #declare j=j+pasj;
           #end   
           
           texture{tex_partoche}
} 
 
#declare partoche=union{
      object{half_partoche}
      object{half_partoche scale <-1,1,1>}
}


#declare pupitre=union{
       cylinder{<-2.5,0,0>,<-2.5,.05,0>,.3}
       cylinder{<2.5,0,0>,<2.5,.05,0>,.3}
       box{<-2.8,0,0>,<2.8,1.8,.2>}
       box{<-2.5,0,-.3>,<2.5,.05,0>} 
       
       cylinder{<-2.65,1.8,0>,<-2.65,1.8,.2>,.15} 
       cylinder{<2.65,1.8,0>,<2.65,1.8,.2>,.15}
       box{<2.65,1.8,0>,<-2.65,1.95,.15>}
        
       object{partoche scale 2} 
        
       texture{tex_pupitre}
}   


#declare lamp=union{
       light_source{
            <-2.5,3.5,1> (Yellow+White)/4
            fade_distance 3
            fade_power 1.5
       } 
}     


#declare lamp2=union{
        #declare chaine=union{
              #declare i=0;
              #while (i<30)
                     torus{.05,.02 rotate x*90 rotate y*i*360*rand(srand) translate y*i*.09}
                     #declare i=i+1;   
              #end
              texture{tex_lamp_metal}
        }
     
     #declare flamme=
 cone{
  <0,0,0>,1,<0,2,0>,.3
  pigment{ rgbf 1}
   interior {
                media {
                method 2 intervals 2 samples 3,3  // megapov, or increase intervals and samples
                absorption <.33,.5,.67>*2 
                emission <.6,.6,.3>*1.67
                //scattering {2,<.75,.67,.5>*2 
                //extinction .133
                //}
                density {spherical turbulence <.1,.2,.15>*1.5
                        density_map {
                        [0 rgb 0]
												[.15 rgb <1.5,1,.5>*3]
												[.5 rgb <1.25,.5,.75>*2]
												[.7 rgb<0,.05,.5>*6]
                        } scale <.85,1.5,.85> translate -.25*y}
                }
                media {
                method 2 intervals 2 samples 3,3  // megapov, or increase intervals and samples
                absorption <.36,.33,.167>*3 
                emission <.8,.8,.3>*1.133
                //scattering {1,<.25,.33,.75>*3 
                //extinction .67
                //}
                density {spherical turbulence <.1,.2,.15>*.5
                        density_map {
                        [0 rgb 0][.3 rgb <0,.05,1.15>*6]
                        } scale <.7,.3,.7> translate -.9*y}
                }
       }
 hollow
 }
     
   difference{
        sphere{<0,0,0>,1}
        sphere{<0,0,0>,.95}
        box{<-2,-.8,-2>,<2,2,2>}
        #declare i=0;
        #while (i<360)
               cylinder{<0,-3,-1>,<0,0,0>,.02 rotate i*y}  
               cylinder{<0,-2.5,-1>,<0,0,0>,.02 rotate i*y}             
               #declare i=i+10;
        #end
        
        scale 2
        texture{tex_lamp_metal}
        
   } 
        #declare i=0;
        #while (i<4)
                object{chaine translate x*.8 rotate z*17 rotate y*90*i translate y*-1.7}
                #declare i=i+1;
        #end 
        
        object{flamme translate y*-1.6} 
        light_source{<0,-1.6,0>, (White+Yellow)/2 fade_distance 1
        area_light <0,.3,0>,<.5,0,.5>,3,2
        }
               

}

       
#declare organ_registers=union{
    #declare register=union{
        cylinder{<0,0,-.05>,<0,0,1>,.05}
        cylinder{<0,0,-.1>,<0,0,-.05>,.08}
        torus{.08,.01 rotate x*90 translate z*-.12}
        
        texture{Sandalwood scale 3}
    } 
    
    box{<-5,1.5,6>,<9,3.25,6.1>}
    
    #declare i=0;
    #while (i<4)
        box{<-5,1.8+1.5/4*i,5.8>,<9,1.8+1.5/4*i+.1,6>}
        object{register translate<-3,1.8+1.5/4*i+.2,6> #if (rand(srand)>.6) translate z*-.7 #end} 
        object{register translate<-2.5,1.8+1.5/4*i+.2,6> #if (rand(srand)>.6) translate z*-.7 #end}
        object{register translate<-2,1.8+1.5/4*i+.2,6> #if (rand(srand)>.6) translate z*-.7 #end}
                
        object{register translate<7,1.8+1.5/4*i+.2,6> #if (rand(srand)>.6) translate z*-.7 #end} 
        object{register translate<6.5,1.8+1.5/4*i+.2,6> #if (rand(srand)>.6) translate z*-.7 #end}
        object{register translate<6,1.8+1.5/4*i+.2,6> #if (rand(srand)>.6) translate z*-.7 #end}                             
        #declare i=i+1;
    #end
      
    texture{Tinny_Brass}
                    
}

#declare RX = seed(1121);
#declare RY = seed(1232);
#declare RZ = seed(1343);
#declare RA = seed(100);
 
#macro Stone_B_01(Xsz, Ysz, Zsz, Round)
object {
  #local fnBox = function { f_superellipsoid(x,y,z,Round, Round) }

  #local fnNoise =
  function {
    pigment {
      granite
      color_map { [0 rgb 0.0][1 rgb 0.27] }
      scale 5
      warp { turbulence 0.3 }
      scale 0.2
      scale 0.52
    }
  }
  

  #local DX=rand(RA)*5;
  #local DY=rand(RA)*5;
  #local DZ=rand(RA)*5;

  isosurface{
    function { - fnBox(x/(Xsz*0.5), y/(Ysz*0.5), z/(Zsz*0.5)) +
         fnNoise((x+DX), (y+DY), (z+DZ)).hf }
    contained_by{ box{ -<Xsz*0.5, Ysz*0.5, Zsz*0.5>*1.1, <Xsz*0.5, Ysz*0.5, Zsz*0.5>*1.1 } }

    //eval
    accuracy 0.006
    max_gradient 20

    scale 1.046

    texture {
      T_Stones2(1.26-rand(RX)*0.52)
      translate <rand(RX), rand(RY), rand(RZ)>*10
    }
  }
}
#end 
 
#declare wall = union{
        #declare BlockX=0.4;
        #declare BlockY=0.25;
        #declare BlockZ=0.208;
        #declare BrickRound=0.1;
        
        #local i=-10;
        #while (i<10)
            #local j=0;
            #while (j<10)
            
            object{Stone_B_01(BlockX, BlockY, BlockZ, BrickRound) scale <2/.4, 1/.25, 1/.208> translate <2*j,i,0>
            #if (mod(i,2)=0) translate x*1 #end
            
            }
                #local j=j+1;
            #end
            #local i=i+1;
        #end
} 
 
 
 
//plane{z,0 translate z*6 texture{PinkAlabaster}} 
//plane{x,0 translate x*8 texture{PinkAlabaster}}
 
object{lamp}
object{lamp2 translate <6,7,3>}        
object{clavier() translate x*-3.3} 
object{clavier() translate <-3.3,.6,.8>}   
object{clavier() translate <-3.3,1.2,1.6>} 
object{pupitre translate <1,2.5,3> rotate x*20} 
object{organ_registers translate y*-.5}

object{wall translate <-10,0,7>} 
object{wall rotate y*90 translate <7,0,6>} 
        
#declare camera_location  =cam_pos;
#declare camera_sky       = <0,1,0>;
#declare camera_look_at   =<2.5,2,4>+<25,0,0>;
#declare camera_direction =(camera_location - camera_look_at)/50;
      
#declare streak_type = 4;               
#declare effect_location = <6,5.8,3>;
#declare effect_type = "Headlight2" #include "LENS.INC"     
                                                               
