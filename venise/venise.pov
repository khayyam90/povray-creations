#include "colors.inc"
#include "woods.inc"
#include "textures.inc"

#declare cam_pos=<8,3,-15>;

camera
{
    location cam_pos
    look_at  <0,2,0>
}

/*#declare cam_pos=<-36,14,-2>;
camera{location cam_pos look_at cam_pos+<0,0,1>}*/


#declare C_SkyTop=rgb <31,52,159>/255;
#declare C_SkyBottom=rgb <141,165,255>/255;

sky_sphere {
    pigment {
        function {min(1,max(0,y))}
        poly_wave 0.6
        color_map{
            [0 color C_SkyBottom]
            [1 color C_SkyTop]
        }
    }
}

light_source{cam_pos White}
light_source{<200,300,-200> White}

#declare srand=seed(5);

//////////////////////////////////////
//////////// textures ////////////////
//////////////////////////////////////

#declare tex_coque=texture
{
    /*pigment{color rgb <64,0,0>/255}
    normal 
    {
       agate 
       bump_size 0.1
    }       
    finish
    {
       diffuse .3
       phong 9
       phong_size 2000
       brilliance 5
       crand .1
    }*/
    T_Wood12
}



#declare tex_ponton=texture
{
    pigment
    {
       gradient y
       color_map 
       {
          [0  color rgb <96,128,48>/255] // vert
          [.1 color rgb <96,96,48>/255] // espèce de marron
          [.12 color rgb <120,120,120>/255]    // gris
       }   
       turbulence .04
    }
    
    finish
    {
       crand .2
       diffuse .9    
    } 
    
    scale y*5 
    translate <0,-.3,0> 
}

#declare tex_baton=texture
{
    T_Wood3
    //pigment{Yellow}
}

#declare tex_pont=texture
{
   // pigment{White}
   pigment { image_map { png "rock2.png" } rotate y*45 scale .3} 
   normal
    {
       bozo
       bump_size .1
    }
    
    finish
    {
       crand .05
       diffuse .9    
    }
    
    scale .3  
}

#declare tex_barriere=texture
{
   Bronze_Metal
}

#declare tex_amarre=texture
{
   Bronze_Metal
}

#declare tex_mur1=texture
{
   pigment
   {
      gradient y
      color_map
      {
        [0  color rgb<200,200,168>/255]
        //[.07 color rgb<255,128,64>/255]
        [.3 color rgb<231,191,197>/255]
      }                                
      turbulence .01
      scale y*5
   }
   normal
   {
      bozo
      bump_size .2
   }
   finish
   {
      crand .2
   }
}

#declare tex_mur2=texture
{
    pigment{color rgb<231,191,197>/255}
    normal
   {
      bozo
      bump_size .2
   }
   finish
   {
      crand .2
   }
}

#declare tex_mur3=texture
{
   pigment
   {
      image_map { png "wall.png" } 
      //color rgb <157,79,0>/255
      rotate y*60
      scale 3
   }
   normal
   {
      bozo
      turbulence .5
      bump_size 2
   }
   finish
   {
      crand .1
   }
}

#declare tex_mur4=texture
{
   
   //pigment{image_map { jpeg "rock3.jpg" } rotate y*45 scale 5}
   pigment{color rgb <172,200,177>/255}
   normal 
   {
       bozo 
       turbulence .5
       bump_size 1
   }

   finish
   {
      crand .2
   }
}

#declare tex_mur5=texture
{
   
   pigment
   {
       gradient y
       color_map
       {[0  color rgb <172,200,177>/255]
        [.6 color rgb <182,200,187>/255]
       }
   }
   normal 
   {
       bozo 
       turbulence .5
       bump_size 1
   }

   finish
   {
      crand .2
   }
}

//////////////////////////////////
//////////// objets //////////////
//////////////////////////////////

#debug "##### reading coque #####\n"
#include "coque.inc"

#declare gondole=
union
{
   object{coque}
   object{coque scale x*-1}
   texture{tex_coque}
   scale z*-1
   translate y*-4
}

#debug "##### reading pont #####\n"
#include "pont.inc"

#declare ppont=union
{
   object{pont}
   object{pont scale <1,1,-1>}
   scale .2
   rotate y*90
}

#debug "##### reading pillier #####\n"
#include "pillier.inc"

#debug "##### reading olivier #####\n"
#include "olivier.inc"

#debug "##### reading saule #####\n"
#include "saule.inc"

#debug "##### reading pillier2 #####\n"
#include "pillier2.inc"

#declare panneau=
triangle{<-2.1,0,0>,<2.1,0,0>,<0,4.1,0>
         pigment{image_map { png "panneau.png" } scale 4 translate <2,-.1,0>}
}    

#debug "##### building sea #####\n"
#include"transforms.inc"
#declare SeaOK=2;
#declare SeaSmoothOK=0;
#declare C_Sea=rgb <250,255,232>/255;

#macro GammaColor(Color,Gamma)
    rgb <pow(Color.red,Gamma),pow(Color.green,Gamma),pow(Color.blue,Gamma)>
#end

#if (SeaOK=1)
    #declare Resolution=1000;
#else
    #if (SeaOK=2)
        #declare Resolution=2000;
    #else
        #declare Resolution=300;
    #end        
#end
#declare SeaBase=height_field
{
    function Resolution,Resolution 
    {
        (sin(y*pi*5)+1)/3+f_ridged_mf(x*14, y*30,z, 1.2,3,6,1.18,5,1)*0.55/3
        
    }
    #if (SeaSmoothOK=1)
        smooth
    #end
}

#declare NX=40;
#declare NZ=40;
#declare SeaSurface=union
{
    #declare i=0;
    #while (i<NZ)
        #declare j=0;
        #while (j<NX)
            object{SeaBase
                #if (mod(j,2)=0)
                    scale <-1,1,1>
                    translate x
                #end
                #if (mod(i,2)=0)
                    scale <1,1,-1>
                    translate z
                #end
                #if (j=19 & i=0)
                 photons { target reflection on refraction off }
                #end
                translate x*j+z*i
                  }
            #declare j=j+1;
        #end
        #declare i=i+1;
    #end
    translate -x*NX/2
    scale <1/NX,1,1/NZ>
} 
#declare Sea=union{    
    object{SeaSurface
        hollow
        
        material 
        {
            texture
            {
                pigment
                {
                    rgbf <C_Sea.red,C_Sea.green,C_Sea.blue,0.9>
                }
                finish 
                {
                    phong 1//4
                    phong_size 100
                    specular 1//2
                    roughness 0.0005
                    ambient 0
                    diffuse 0.2      
                    reflection {0.2,1 fresnel on}
                    conserve_energy
                }
            }
            interior 
            {
                ior 1.32
                fade_distance 0.01
                fade_power 2
                media {absorption (1-C_Sea)*0.1}
            }
        }
        scale <2000,0.7,2000>
    }
    
    // sea bottom (fond pour créer une ombre)
    plane
    {
        y,0 
        translate y*-1
        texture
        {
            pigment
            {
                bozo
                scale 20
                color_map
                {
                    [0 GammaColor(C_Sea,2)]
                    [1 GammaColor(C_Sea,2)*0.5]
                }
            }
                finish
                {
                    ambient 0 diffuse 1
                }
        }
    }
}
     
/////// poteau //////////
#declare poteau_H = 1.75;
#declare poteau_R = 0.10;
#declare poteau =        
union{
 
 cylinder {<0,-poteau_H,0>,<0,poteau_H,0>,poteau_R translate<0,0,0>
          texture{pigment{spiral1 2 
                          color_map{[0.0 White]
                                    [0.5 White]
                                    [0.5 rgb<1,0,0>]
                                    [1.0 rgb<1,0,0>]}
                                    rotate<90,0,0>
                                    scale<1,0.3,1>}
                  normal {bumps 0.1 scale 0.025}
                  finish {//ambient 0.05 diffuse 0.95 
                          phong .1 
                          phong_size 30 
                          //reflection 0.05
                         }
                  }
           }
 union{
   cylinder{<0,-0.05,0>,<0,0.05,0>,poteau_R+0.02 translate<0,poteau_H.0>}
   sphere {<0,0,0>,poteau_R+0.02 translate<0,poteau_H+0.1,0> }
   //torus {1.0,0.1 scale 0.12  translate<0,poteau_H+0.01,0>}
       
   texture{pigment{color White}
           normal {bumps 0.3 scale 0.025}
           finish {ambient 0.15 diffuse 0.85 phong 1 reflection 0.05}}}
}     

// lampadaire
#debug "##### reading lampadaire #####\n"
#include "lampadaire.inc"

#declare lampad=union
{
    object
    {    
       lampadaire 
       scale <.15,.08,.1>
    }
}    

#declare lam1=union
{
    #declare rayon=1;
    union
    {
    #local i=0;
    #while (i<5)
       box{<rayon*sin(radians(36)),0,rayon*cos(radians(32))>,<-rayon*sin(radians(36)),.1,rayon*cos(radians(32))-.1> rotate y*72*i*y texture{Bronze_Metal}}
       box{<rayon*sin(radians(36)),1,rayon*cos(radians(32))>,<-rayon*sin(radians(36)),.9,rayon*cos(radians(32))-.1> rotate y*72*i*y texture{Bronze_Metal}}
       cylinder{<rayon*sin(radians(36)),0,rayon*cos(radians(32))-.05>,<rayon*sin(radians(36)),1,rayon*cos(radians(32))-.05>,.05 rotate y*72*i*y texture{Bronze_Metal}}        
       
       cylinder{<rayon*sin(radians(36)),.95,rayon*cos(radians(32))-.05>,<0,2,0>,.05 rotate y*72*i*y texture{Bronze_Metal}}               
       #local i=i+1;
    #end
    
    #local i=0;
    #while (i<5)
       polygon{4,<rayon*sin(radians(36)),0,rayon*cos(radians(32))>,
                 <-rayon*sin(radians(36)),.1,rayon*cos(radians(32))-.1>,
                 <-rayon*sin(radians(36)),.9,rayon*cos(radians(32))-.1>,
                 <rayon*sin(radians(36)),1,rayon*cos(radians(32))>
               rotate y*72*i
               texture{Glass2}
              }
       polygon{3, <-rayon*sin(radians(36)),.9,rayon*cos(radians(32))-.1>,
                  <rayon*sin(radians(36)),1,rayon*cos(radians(32))>,
                  <0,2,0>
               rotate y*72*i
               texture{Glass2}
              }
       #local i=i+1;
    #end
    
    polygon{5,
            #local i=0;
            #while (i<5)
               <rayon*sin(radians(36+72*i)),0,rayon*cos(radians(32+72*i))>
               #local i=i+1;
            #end
            texture{Glass2}
           }
    }
}

#declare lampad=union
{
    object
    {    
       lampadaire 
       scale <.15,.08,.1>
       texture{Bronze_Metal}
    }
    object
    {
       lam1  
       scale <.2,.3,.2>
       translate <0,-.9,-2.1>
    }
    
}

///////////////////////////////////
///////////// macros //////////////
///////////////////////////////////

#macro baton(nb_iterations, detail, rayon, hauteur)

#local MySpline=spline
{
   natural_spline
   #local i=0;
   #local j=<0,0,0>;       
   #local amplitude=rayon/3;
   #while (i<nb_iterations)
      #local tmp1=amplitude*rand(srand);
      #local tmp2=amplitude*rand(srand);
      
      #local j=<j.x+tmp1-amplitude/2 , i*hauteur/nb_iterations, j.z+tmp2-amplitude/2>;
      i/nb_iterations, j
      #local i=i+1;
   #end
}

#declare tab1= array[detail][2];
#declare tab2= array[detail][2];

// 'init'
#local i=0;
#while (i<detail)
  #declare tab1[i][0]=(.9+.1*rand(srand))*rayon*cos(radians(360/detail*i));
  #declare tab1[i][1]=(.9+.1*rand(srand))*rayon*sin(radians(360/detail*i));
  #local i=i+1;
#end

mesh
{
  #local i=0;
  #while (i<nb_iterations)
      // 'recopie'
      #local j=0;
      #while (j<detail)
         #declare tab2[j][0]=tab1[j][0];
         #declare tab2[j][1]=tab1[j][1];
         #local j=j+1;
      #end
  
      #local j=0;
      #while (j<detail)                
         triangle{<MySpline(i/nb_iterations).x+tab1[j][0],i*hauteur/nb_iterations,MySpline(i/nb_iterations).z+tab1[j][1]>,<MySpline(i/nb_iterations).x+tab1[mod(j+1,detail)][0],i*hauteur/nb_iterations    ,MySpline(i/nb_iterations).z+tab1[mod(j+1,detail)][1]>,<MySpline((i+1)/nb_iterations).x+tab2[mod(j+1,detail)][0],(i+1)*hauteur/nb_iterations,MySpline((i+1)/nb_iterations).z+tab2[mod(j+1,detail)][1]>}
         triangle{<MySpline(i/nb_iterations).x+tab1[j][0],i*hauteur/nb_iterations,MySpline(i/nb_iterations).z+tab1[j][1]>,<MySpline((i+1)/nb_iterations).x+tab2[j][0]          ,(i+1)*hauteur/nb_iterations,MySpline((i+1)/nb_iterations).z+tab2[j][1]>          ,<MySpline((i+1)/nb_iterations).x+tab2[mod(j+1,detail)][0],(i+1)*hauteur/nb_iterations,MySpline((i+1)/nb_iterations).z+tab2[mod(j+1,detail)][1]>}
         #local j=j+1;
      #end
  
      #local i=i+1;
  #end

}               
              
#end // macro baton

#macro fenetre(pt1,pt2,nb_a_faire,epaisseur)
/*#local pt1=<-1,-1,0>;
#local pt2=<1,1,0>;
#local nb_a_faire=20;*/
#local i=0;
union
{
#while (i<pt2.x-pt1.x)
   cylinder{<pt1.x+i,pt1.y,0>,<pt2.x,pt2.y-i,0>,epaisseur scale z*.2}
   cylinder{<pt1.x,pt1.y+i,0>,<pt2.x-i,pt2.y,0>,epaisseur scale z*.2}
   
   #if (i!=0)
   cylinder{<pt1.x,pt1.y+i,0>,<pt1.x+i,pt1.y,0>,epaisseur scale z*.2}
   cylinder{<pt2.x,pt2.y-i,0>,<pt2.x-i,pt2.y,0>,epaisseur scale z*.2}
   #end
   #local i=i+(pt2.x-pt1.x)/nb_a_faire;
#end
cylinder{<pt1.x,pt2.y,0>,<pt2.x,pt1.y,0>, epaisseur scale z*.2}
translate z*pt1.z
texture{T_Wood2}
}

#end // macro fenetre
     
////////////////////////////////////
///////////// scène ////////////////
////////////////////////////////////

object{Sea translate <0,-.5,-15>}   
//plane{y,0 pigment{Blue}}


object{gondole scale .3  rotate x*-2 rotate z*2 translate <6,.3,-.5>}
object{gondole scale .3  rotate x*-4 rotate z*3 translate <3,.3,.5>}
object{gondole scale .3  rotate x*-1 rotate z*-2 translate <0,.3,.5>}
object{gondole scale .3  rotate x*-2 rotate z*1 translate <-3,.3,-.5>}
object{gondole scale .3  rotate x*-2 rotate z*0 translate <-6,.3,0>}
object{gondole scale .3  rotate x*2  rotate z*2  translate <-9,.3,.5>}

object{poteau scale 1.5 translate <1,1,3>}
object{poteau scale 1.5 translate <8,1,3>}
object{poteau scale 1.5 translate <-5.1,1,3>}
object{poteau scale 1.5 translate <-12,1,3>}


// ponton1
#declare i=-20;

union
{
#while (i<15)
  #declare j=-5;
  #while (j<1.7)
     #declare k=7;   
     #while (k<12)
        superellipsoid
        {
           .05
           scale <1,.5,1>
           translate <i,j,k>
           #if (mod(j,2)=0) translate <1,0,0> #end
        }       
        #declare k=k+2;
     #end
     #declare j=j+1;
  #end
  #declare i=i+2;
#end

// pierre angulaire
superellipsoid{.05 scale <.5,.5,1> translate <-20.5,0,7> }

texture{tex_ponton}
translate <1,0,1>
}

// amarres
   #declare link_looseness = 1.5;
   #include "LINKOBJS.INC"       
   
   #declare link_object = Rope
   #declare link_count = 60;
   #declare link_twist = -.1;

#declare i=<-10,.9,7>;
#while (i.x<8)
   torus{.3,.05 texture{tex_amarre} rotate x*90 translate i}
   sphere{ i+<0,.3,0>,.1 texture{tex_amarre}}
   
      #if (i.x!=6)
      #declare link_point1 = i+<.25,0,0>;
      #declare link_point2 = i+<3.75,0,0>;
      #include "LINK.INC"
      #end
   #declare i=i+<4,0,0>;
#end

// ponton2
union
{
#declare i=-50;
#while (i<-30)
  #declare j=-5;
  #while (j<1.7)
     #declare k=7;   
     #while (k<12)
        superellipsoid
        {
           .05
           scale <1,.5,1>
           translate <i,j,k>
           #if (mod(j,2)=0) translate <1,0,0> #end
        }       
        #declare k=k+2;
     #end
     #declare j=j+1;
  #end
  #declare i=i+2;
#end

superellipsoid{.05 scale <.5,.5,3> translate <-30.5,1,9>}

translate <0,0,1>
texture{tex_ponton}
}


object{  baton(100,50,.08,5)    texture{tex_baton}   translate <7.3,-1.7,-3>}
object{  baton(150,50,.08,4.5)  texture{tex_baton}   translate <4.3,-2,-2>}
object{  baton(150,50,.08,5)    texture{tex_baton}   translate <-2  ,-1.7,-3>}
object{  baton(75,50,.08,4)    texture{tex_baton}   translate <-5,-2,-2>}

object
{
   ppont 
   scale <1.8,1.5,1.3>
   translate <-25,1,9.3>
   texture{tex_pont}
}

///  barrière
#declare i=<-17,1.3,8>;
#while (i.x<10)
  object{pillier scale <.1,.2,.1> translate i texture{tex_ponton}}
  #declare i=i+<3.5,0,0>;
#end

cylinder{<-17,2.3,8>,<-3,2.3,8>,.05 texture{tex_barriere}}
cylinder{<4,2.3,8>,<11,2.3,8>,.05   texture{tex_barriere}}
                                        
                                        
////////////////////////////////////////
////////////// maisons /////////////////
////////////////////////////////////////
                                        
                                        
// maison1                                        
union
{
  difference
  {
   box{<-20,0,12>,<15,6,12.5> }
   box{<-15,3,11>,<-13,5,12.6>}
   box{<-9,3,11>,<-7,5,12.6>}
   box{<6,3,11>,<8,5,12.6>}
   
   box{<-1.5,0,11>,<2.5,4,12.6>}
   cylinder{<0,4,11>,<0,4,12.6>,1 scale x*2 translate x*.5}
  }

box{<-20,0,12>,<-19,6,40>}   // mur gauche
box{<-20,0,40>,<15,6,41>}    // arrière
box{<-20.2,5.5,11.8>,<15,6,41>}  // plafond
                                                           
texture{tex_mur1 translate y*-3.5}
}                                                           

fenetre(<-15.1,2.9,12.2>,<-13.1,5.1,1.22>,5,.05)
fenetre(<-9.1,2.9,12.2>,<-7.1,5.1,12.2>,5,.05)
fenetre(<5.9,2.9,12.2>,<8.1,5.1,12>,5,.05)


box{<-5.9,0,12.5>,<2.6,5,12.6> 
    pigment { image_map {png "porte.png" } 
          translate <2,-4,0>
          scale 3.5
          translate <2.2,1.5,0>
          } 
   }


// 1er étage de la premiere maison

difference
{
    box{<-10,6,18>,<15,10,18.5> }
    box{<-6,8,17.5>,<-3.5,9.5,19>}
    box{<4,8,17.5>,<6.5,9.5,19>}
    texture{tex_mur2}
}
box{<-10,6,20>,<15,10,20.5> texture{tex_mur2}} // faux fond
box{<-10,6,18>,<-9.5,10,40> texture{tex_mur2}}

fenetre(<-6,7,18.2>,<-3.5,9.5,18.2>,8,.05)
fenetre(<4,7,18.2>,<6.5,9.5,18.2>,8,.05)

#declare i=<-19.5,6,12.5>;
#while (i.x<16)
    object{pillier2 scale <.12,.15,.12> translate i 
           pigment{image_map { png "rock3.png" } rotate 360*y*rand(srand)}
          }
    #declare i=i+<1,0,0>;
#end
box{<-20,7.4,12>,<15,7.5,13> 
    pigment{image_map { png "rock3.png" } }
   }

#declare i=<-19.5,6,12.5>;
#while (i.z<40)
    object{pillier2 scale <.12,.15,.12> translate i 
           pigment{image_map { png "rock3.png" } rotate 360*y*rand(srand)}
          }
    #declare i=i+<0,0,1>;
#end
box{<-20,7.4,12>,<-19,7.5,40> 
    pigment{image_map { png "rock3.png" } }
   }
   
   
object{OLIVIER scale 8 translate <-17,7,22>}
object{SAULE scale 8 translate <-16,7,14>}

#declare parasol = mesh {
	#include "parasol.msh"
	//uv_mapping
	//texture { pigment { checker color rgb<1, .5, .2> color rgb<1, .8 ,.4> scale <1/10, 1/10, 1/10>} }
        pigment
	{
	   gradient x
	   color_map
	   {   
	      [0  color rgb <0,128,192>/255]
	      [.5 color rgb <0,128,192>/255]
	      [.5 color rgb <0,255,0>/255]
	      [1  color rgb <0,255,0>/255]	   
	   }
	scale .1
	}
}    

object{parasol scale <15,3,9> translate <0,8.4,19>}  
cylinder{<-8.5,6,17>,<-8.5,10,17>,.1 texture{tex_barriere}}
cylinder{<9,6,17>,<9,10,17>,.1 texture{tex_barriere}}      


object{lampad
       translate <-16,5.3,10.8>
       texture{tex_barriere}}
       
object{lampad
       translate <3,5.3,10.8>
       texture{tex_barriere}}


// maison2

// rdc
box{<-29.9,-5,12>,<-50,6,40> texture{tex_mur3}}

// premier étage
union
{
box{<-29.8,6,11.8>,<-50,8,40> }
#local i=<-29.8,8,12.2>;
#while (i.z<60)
   cylinder{i-<.4,0,0>,i+<-.4,2,0>,.2}
   difference
   {
      torus{1,.2 rotate x*90 rotate y*90}
      box{<-1,0,-2>,<1,-2,2>}
      translate i+<-.4,2,1>
   }
   #local i=i+<0,0,2>;
#end


#local i=<-29.8,8,12.2>;
#while (i.x>-50)
    cylinder{i-<.4,0,0>,i+<-.4,2,0>,.2}
    difference
    {
       torus{1,.2 rotate x*90}
       box{<-2,0,-1>,<2,-2,1>}
       translate i+<-1.4,2,0>
    }
    
    #local i=i-<2,0,0>;
#end


box{<-50,8,15>,<-33,11,60>}
texture{tex_mur4}}                          

object{lampad
       translate <-32,6.5,10.8>
       texture{tex_barriere}}

// deuxième étage
box{<-30,11.2,12>,<-50,12,60> texture{tex_mur5}}
triangle{<-30,12,12>,<-41.5,12,12>,<-35.5,14,12> texture{tex_mur5}}


                            
object{panneau scale .4 rotate y*-10 translate <-12,2.5,2.8>}

/// toit \\\
#include "tileroof.inc"

#local Pgm1 = pigment{color rgb<1, 0.6, 0.4>}
#local Pgm2 = pigment{
	cells
	color_map{
		[0.0 0.2 color rgb<1, 0.6, 0.4> color rgb<0.8, 0.4, 0.2>]
		[0.2 0.4 color rgb<1, 0.7, 0.5> color rgb<1, 0.5, 0.3>]
		[0.4 0.8 color rgb<0.9, 0.6, 0.4> color rgb<0.8, 0.4, 0.3>]
		[0.8 1.0 color rgb<1, 0.65, 0.45> color rgb<0.95, 0.55, 0.35>]
	}	
}

object{Roof1(20, 0.75, 40, 8, 120, 14,1, Pgm2, 111) 
       scale 1 
       rotate x*-20 
       rotate y*-90
       translate<-28, 11.3, 11>}    
       
object{Roof1(20, 0.75, 40, 8, 120, 14,1, Pgm2, 111) 
       scale 1 
       rotate x*-20 
       rotate y*90
       translate<-43, 11.3, 51>}





