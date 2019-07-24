//-------------------------------------------------
//POV-Ray Main scene file
//This file has been created by PoseRay v3.0.2.272
//3D model to POV-Ray/Moray Converter.
//Author: FlyerX
//Email: flyer_2000@excite.com
//Web: http://user.txcyber.com/~sgalls/
//----------------------------------------------------
//Files needed to run the POV-Ray scene:
//POV-Ray configuration file:OLDBOOK_pov.ini Open this file in POV-Ray and press run to obtain the render
//POV-Ray Scene file:OLDBOOK.pov
//POV-Ray geometry mesh file:OLDBOOK_pov.inc
//POV-Ray material file:OLDBOOK_pov_mat.inc
//NOISE_I.SXP
//ISTONE2.CEL
//----------------------------------------------------
//Files used in PoseRay for the creation of this scene:
//3D model file: OLDBOOK.3DS
//Material file: OLDBOOK.mtl
//Camera file: 
//Lights file: 
//----------------------------------------------------
//Model Statistics:
//Number of vertices............. 1354
//Number of normals.............. 1354
//Number of UV coordinates....... 1354
//Number of materials............ 5
//Number of unique groups........ 1
//Number of polygons............. 2516
//Number of valid triangles...... 2516
//Number of line segments........ 0
//UV boundaries........ from u,v=(-1.69474E38,-1.69474E38)
//                        to u,v=(2.756254,3.394208)
//Bounding Box....... from x,y,z=(-726.5104,2.797821,-56.20575)
//                      to x,y,z=(-264.2893,585.5358,84.55795)
//Bounding Box size.... dx,dy,dz=(462.221,582.7379,140.7637)
//Bounding box diagonal.......... 756.9982
//Bounding box center..... x,y,z=(-495.3998,294.1668,14.1761)
//Memory allocated for geometry.. 231344 Bytes
// 
//-------------------------------------------------
//IMPORTANT:
//This file was designed to run with the following command line options: 
// +W631 +H428 +FN +AM1 +A0.3 -UA
//if you are not using an INI file copy and paste the text above to the command line box before rendering
 
#include "colors.inc"
#include "skies.inc"
#include "textures.inc"
#include "OLDBOOK_pov.inc" //the geometry is in this file
 
global_settings {
  //This setting is for alpha transparency to work properly.
  //Increase by a small amount if transparent areas appear dark.
   max_trace_level 10
 
}
 
//CAMERA PoseRayCAMERA
camera {
        perspective
        up <0,1,0>
        right <-1.474299,0,0>
        location <3.051758E-5,0,2270.995>
        look_at <3.051758E-5,0,2269.995>
        angle 25.20314 // horizontal FOV angle
        rotate <0,0,179.5747> //roll
        rotate <2.970148,0,0> //pitch
        rotate <0,92.23453,0> //yaw
        translate <-495.3998,294.1668,14.1761>
        }
 
//PoseRay default Light attached to the camera
light_source {
              <3.051758E-5,0,2270.995> //light position
              color rgb <1,1,1>*1.5
              parallel
              point_at <3.051758E-5,0,0>
              rotate <0,0,179.5747> //roll
              rotate <2.970148,0,0> //elevation
              rotate <0,92.23453,0> //rotation
             }
 
//A Colored Background
background { color rgb<0.8313726,0.8156863,0.7843137>  }
 
//Assembled object that is contained in F:\Sources\pov\all you need is love\OLDBOOK_pov.inc
object{
      OLDBOOK
      }
//-------------------------------------------------
