#include "colors.inc"
#include "woods.inc"
#include "textures.inc"
#include "glass.inc"

#version unofficial MegaPov 1.0;


#declare cam_pos=<0,3,-10>;

camera
{
    location cam_pos
    look_at <-3,2.5,0>
}

background{White*.9}

light_source{<50,20,-100> White shadowless}
light_source{cam_pos White shadowless}

/////////////////////////////////////
///////////// textures //////////////
/////////////////////////////////////
#declare p_map1=pigment {color rgb <.4,.5,.4>  }
#declare p_map2=normal {bozo scale .1}
#declare p_map3=normal {agate}
#declare p_map4=normal {agate}
#declare p_map5=normal {agate }


#declare IRREGULAR_SKIN= 
texture{pigment {color rgb <0.1647059,0.07058824,0.04313726> transmit 0} }

#declare DARK_GRAY_MATTE= 
texture{pigment {color rgb <0.07843138,0.08627451,0.06666667> transmit 0} }

#declare OLD_PAPER_2= 
texture{pigment {color rgb <0.4235294,0.4235294,0.3607843> transmit 0} 
        normal{p_map3} 
        finish{phong 0.751634 phong_size 0 ambient rgb <0.1098039,0.1294118,0.07843138> reflection{0 metallic}}}

#declare OLDER_PAPER= 
texture{pigment {color rgb <0.3803922,0.3803922,0.345098> transmit 0} }

#declare OLD_METAL_2= 
texture{Bright_Bronze}


#declare skin2=texture{pigment {color rgb <0.1647059,0.07058824,0.04313726> transmit 0} }
#declare skin3=texture{pigment {color rgb <.5,0,0> transmit 0} }
#declare skin4=texture{pigment {color rgb <.25,0,.25> transmit 0} }
#declare skin5=texture{pigment {color rgb <0,.25,.25> transmit 0} }
#declare skin6=texture{pigment {color rgb <.2,.2,.2> transmit 0} }
#declare skin7=texture{pigment {color rgb <.7,0,0> transmit 0} }



#declare real_marble= 
 texture
    {
        pigment
        {
             bozo
             color_map  
             {[ 0.0 rgb <252,223,200>/256 ]
              [ .3  rgb <180,190,200>/256 ]
              [ .6  rgb <150,160,160>/256 ]
             }
             turbulence 0.4
             omega 0.8
             lambda 3.0
             ramp_wave
        }
        /*normal
        {
            // bumps , 1
            agate
             scale  <0.75, 0.75, 1.0>
             turbulence 0.2
             octaves 5
             omega 0.65
             lambda 3.0
             frequency 0.0
             ramp_wave
        }*/
        finish
        {
             ambient 0.15
             phong .2
             phong_size 5
        }
    }


////////////////////////////////////
//////////// objets ////////////////
////////////////////////////////////

#declare serre_livre=
union
{

  union
  {

   difference
   {
   cylinder{<0,0,0>,<0,0,5>,1 }
   box{<-1.1,0,-.1>,<1.1,1.1,5.1>} 
   box{<0,.1,-.1>,<1.1,-1.1,5.1>}
   cylinder{<0,0,-.1>,<0,0,5.1>,.5 }
   }                                
   
   box{<0,-1,0>,<2.5,-.5,5>}
      cylinder{<2.5,-1,.5>,<2.5,-.5,.5>,.5}
      cylinder{<2.5,-1,4.5>,<2.5,-.5,4.5>,.5}
      box{<3,-1,.5>,<2.5,-.5,4.5>}
   box{<-1,0,0>,<-.5,2.5,5>}
      cylinder{<-1,2.5,.5>,<-.5,2.5,.5>,.5}
      cylinder{<-1,2.5,4.5>,<-.5,2.5,4.5>,.5}
      box{<-1,3,.5>,<-.5,2.5,4.5>}
   
   //texture{real_marble}
   texture{T_Wood7}
  }
}

#declare chtite_sphere=sphere{<0,0,0>,.18}

#declare dice=
difference
{
    superellipsoid{.2}
    object{chtite_sphere translate <0,0,-1>} //1
    
    object{chtite_sphere translate <.5,.4,1>} // 6
    object{chtite_sphere translate <.5,-.4,1>}  
    object{chtite_sphere translate <0,-.4,1>}
    object{chtite_sphere translate <0,.4,1>}
    object{chtite_sphere translate <-.5,.4,1>}
    object{chtite_sphere translate <-.5,-.4,1>}
    
    object{chtite_sphere translate <1,.4,-.4>}  // 4
    object{chtite_sphere translate <1,-.4,-.4>}
    object{chtite_sphere translate <1,-.4,.4>}
    object{chtite_sphere translate <1,.4,.4>}
   
    object{chtite_sphere translate <-1,.4,-.4>} // 3
    object{chtite_sphere translate <-1,0,0>}
    object{chtite_sphere translate <-1,-.4,.4>}
    
    object{chtite_sphere translate <-.4,1,.4>} // 2
    object{chtite_sphere translate <.4,1,-.4>}
    
    object{chtite_sphere translate <-.4,-1,.4>} // 5
    object{chtite_sphere translate <.4,-1,.4>}
    object{chtite_sphere translate <.4,-1,-.4>}
    object{chtite_sphere translate <-.4,-1,-.4>}
    object{chtite_sphere translate <0,-1,0>}
    
    texture{T_Wood7}
    //texture{real_marble}
}    

/////////////////////////////////////
//////////// scène //////////////////
/////////////////////////////////////




#declare srand=seed(5);

#include "men.inc"


object
{
   bonhomme(0,<.4,-1,-1.1> ,<.4,-2,-1.6>,
         0,<-.4,-2.2,-.2>,<-.4,-2,1>,
         0,<.5,.6,-1.2>   ,<.1,.9,-2>,
         0,<-.5,.7,-1.2>  ,<-.1,.9,-2>,
         T_Wood7, 60)
   rotate y*90
   translate <.5,2.8,1>

}
         
/// meuf
object
{
   bonhomme(0,<.4,-2,-.2> ,<.4,-3,0>,
         0,<-.4,-2,-.3>,<-.4,-3,0>,
         0,<.5,.4,-1.2>   ,<.1,.7,-2>,
         0,<-.6,.2,-.3>  ,<-.1,.8,-.6>,
         T_Wood7, 60)
   rotate y*-90
   translate <-6,3.7,1>
}



light_group
{
    light_source{<0,2,-10> Red}
    #include "ROSE_pov.inc"
    object
    { 
       ROSE
       rotate x*180
       rotate y*40
       scale .004
       translate <-1.2,2.8,.8>
    }
}



// étagère
union
{
   box
   {
      <-30,0,-3>,<10,-.7,10>
      texture
      {
       T_Wood29 
   
       normal {bozo}
       finish
       {
          reflection .1
          phong .2
          phong_size 2
       } 
       scale 4
      } 
   } // planche horizontale
   box
   {
      <-30,-15,10>,<10,15,11> 
      texture
      {
       T_Wood29 
   
       normal {bozo}
       finish
       {
          reflection .1
          phong .2
          phong_size 2
       }
       rotate x*90  
       scale 4
   
      } 
   }
   
}


/////////////////////////////////////////////////////
//////////////////// books //////////////////////////
/////////////////////////////////////////////////////

#include "OLDBOOK_pov.inc"
object
{      
    //OLDBOOK
    vieux_bouquin(skin2, DARK_GRAY_MATTE, OLD_PAPER_2, OLDER_PAPER, OLD_METAL_2)
    OLDBOOK
    rotate y*90
    scale .02
    translate <-10,-.1,-7>
}

object
{      
    //OLDBOOK
    vieux_bouquin(IRREGULAR_SKIN, DARK_GRAY_MATTE, OLD_PAPER_2, OLDER_PAPER, OLD_METAL_2)
    OLDBOOK
    rotate y*90
    rotate z*1
    scale .02
    translate <-12.5,-.1,-7>
}    


object
{      
    //OLDBOOK
    vieux_bouquin(IRREGULAR_SKIN, DARK_GRAY_MATTE, OLD_PAPER_2, OLDER_PAPER, OLD_METAL_2)
    OLDBOOK
    rotate y*90
    rotate z*1
    scale .02
    translate <5,-.1,-7>
}    

// bouquin rouge penché
object
{      
    //OLDBOOK
    vieux_bouquin(skin7, DARK_GRAY_MATTE, OLD_PAPER_2, OLDER_PAPER, OLD_METAL_2)
    OLDBOOK
    rotate y*90
    scale <.5,1,1>
    //rotate z*-7
    scale .02
    //translate <2,.1,-6>
    translate <3,.1,-7>
}     



#declare i=0;
#while (i<13)

object
{      
    //OLDBOOK
    vieux_bouquin(
    #switch (i)
        #case (0) skin2 #break
        #case (1) skin3 #break
        #case (2) IRREGULAR_SKIN #break
        #case (3) skin6 #break
        #case (4) skin2 #break
        #case (5) skin4 #break
        #case (6) IRREGULAR_SKIN #break
        #case (7) skin5 #break
        #case (8) skin6 #break    
        #case (9) skin3 #break
        #case (10) skin2 #break
        #case (11) IRREGULAR_SKIN #break
        #case (12) skin6 #break
    #end
    DARK_GRAY_MATTE, OLD_PAPER_2, OLDER_PAPER, OLD_METAL_2)
    OLDBOOK
    rotate y*90
    rotate z*1
    scale .02
    scale <.5+.5*rand(srand),1,1>
    translate <-14+i*1.8,-14,-6>
}
             
#declare i=i+1;
#end


union
{
text {
    ttf "mtcorsva.ttf" "Romeo & Juliet" 1, 0
    rotate y*-86
    translate <-8.8,7.5,.5>
  }
  
  
text {
    ttf "mtcorsva.ttf" "by" 1, 0
    scale .6
    rotate y*-86
    translate <-8.72,6.3,1.8>
  }
  
text {
    ttf "mtcorsva.ttf" "William Shakespeare" 1,0
    rotate y*-86
    
    scale z*.9
    translate <-8.85,5,-.3>
  }

text {
    ttf "mtcorsva.ttf" "Romeo & Juliet - William Shakespeare" 1, 0
    rotate z*90
    rotate y*-10
    scale .4
    translate <-9.4,3,-.64-1>
  }
      
  
text {
    ttf "balth.ttf" "in 80 days" 1, 0
    rotate z*90
    scale .4
    translate <-8.5,-4.5,-.75>
  }
  
text {
    ttf "balth.ttf" "pauv raie" 1, 0
    rotate z*90
    scale .4
    translate <-10.4,-4.5,-.75>
  }

texture{Bright_Bronze}
}


/////////////////////////////////////////////////////
//////////////// bibelot ////////////////////////////
/////////////////////////////////////////////////////

                                                     
#declare demi_sablier=
union
{
    difference
    {
       lathe
       {
          cubic_spline
          39,
          #local i=1;
          #while (i<=39)
              <2*i/40, acos(2*i/40)>
              #local i=i+1;
          #end
       scale y*.987
       }                   
          
       box{<-2,.1,-2>,<2,-.1,2>}
       texture { Glass2 }
       //interior{ I_Glass_Dispersion1}
   }  
   cylinder{<0,.1,0>,<0,-.1,0>,1.5 texture{T_Wood2} finish{crand .1}}

}

#declare sablier=
union
{
    object{demi_sablier}
    object{demi_sablier scale <1,-1,1> translate <0,2.9,0>}
    union
    {
       cylinder{<1.3,0,0>,<1.3,3,0>,.1 rotate y*40}
       cylinder{<1.3,0,0>,<1.3,3,0>,.1 rotate y*130}
       cylinder{<1.3,0,0>,<1.3,3,0>,.1 rotate y*210}
       cylinder{<1.3,0,0>,<1.3,3,0>,.1 rotate y*300}
       texture{T_Wood2}
       finish{crand .1}
    }
}

object{sablier rotate y*-15 scale 1.7*<1,1.5,1> translate <-5.5,.3,7.5>}

cone
{
    <-5.5,.1,7.5>,2, <-5.5,2.5,7.5>,0 
    pigment{White}
    finish{crand .4}
}


object{serre_livre translate <-7.85,1,0>}
object{serre_livre scale <-1,1,1> translate <1.4,1,0>}

object
{
   dice 
   scale 1 
   rotate y*45 rotate z*45 
   translate <.4,1.9,4>
}    

object
{
   dice 
   scale 1 
   rotate y*45 rotate z*45 
   translate <-6.5,1.9,4>
}