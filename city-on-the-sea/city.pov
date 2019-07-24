/* La cité sur la mer par khayyam août 2004
Le profil de la cité suit une courbe de Gauss
*/

#include "colors.inc"

background { color White }  

#declare cam_pos = <10,10,100>;             
             
camera { perspective
         location    cam_pos
         look_at <10,15,0> 
         } 
         
light_source {<0,100,300> rgb .5 }         
light_source {<0,100,300> rgb .5}

light_source {<0,300,0> rgb 1}
light_source {<-100,70,0> color rgb .5}
//light_source {<0,70,-100> color rgb .5}

/////////// ciel \\\\\\\\\\\
/*#declare C_SkyTop=rgb <31,52,159>/255;
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
}*/
#include "skies.inc"
sky_sphere {S_Cloud2 scale 0.8}

fog{fog_type   2   distance 25  color rgb <0.2, 0.3, 0.7>
    fog_offset 0.1 fog_alt  1.0 turbulence 0.2}

////////// scène \\\\\\\\\
#declare srand=seed(4);

#macro alea()
   #declare taille=rand(srand);
#end

#declare tour=
cylinder {  <0,0,0>,<0,1,0>1}

#declare coupole=
union
{
      difference
      {
      sphere {<0,0,0>,1}
      box{<1,0,1>,<-1,1,-1>}
      }
      difference
      {
      sphere {<0,0,0>,1}
      box{<1,0,1>,<-1,-1,-1>}
      translate y*.4
      }
      #declare i=0;
      #while (i<20)
          cylinder {<0,0,0>,<0,.4,0>,.03
                    translate <.97,0,0>
                    rotate y*360/20*i
                   }
          #declare i=i+1;
      #end
}   



#macro building(ax,ay,indice)
union
{
#declare hauteur_tour = 10*indice+10*rand(srand);
#declare taille_coupole = .5+.4*rand(srand);
#declare hauteur_coupole= .2+.3*rand(srand);
object{tour 
       scale <taille_coupole/10,hauteur_tour,taille_coupole/10>
      }
object{coupole 
       scale <taille_coupole,hauteur_coupole,taille_coupole> 
       translate y*hauteur_tour
      }
pigment{White}

translate <ax,0,ay>
}
#end    

#debug "##### building city #####`\n"
#declare i=0;
#while (i<4000) 
   // pos normales
   #declare posx = 200*rand(srand)-100;
   #declare posz = 200*rand(srand)-100;
   // pos recentrées
   #if (rand(srand)>.7)
   #declare posx = 100*rand(srand)-50;
   #declare posz = 100*rand(srand)-50;
   #end
   
   building(posx,posz,4*exp(-posx*posx/500-posz*posz/500))
   //building(posx,posz,abs(posz*posx)/100)
   #declare i=i+1;
#end


////////////// water \\\\\\\\\\\\\\\
#debug "##### building water #####\n"
#include "transforms.inc"
plane 
{
   y,0
   material 
   {
       texture 
       {
            pigment 
            {
               color rgbt <0.2, 0.7, 0.3, 0.5>
            }
            finish 
            {
               ambient 0.2
               diffuse 0.0
               reflection 
               {
                   0.0, 1.0
                   fresnel on
               }
               specular 0.4
               roughness 0.003
            }
            normal 
            {
               function 
               {
                   f_ridged_mf(x, y, z, 0.1, 3.0, 7, 0.7, 0.7, 2)
               } 
               0.8
               scale 0.13
            }
       }
       interior 
       {
            ior 1.3
       }
   }
scale 3  
} 