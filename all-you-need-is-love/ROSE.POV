//-------------------------------------------------
//POV-Ray Main scene file
//This file has been created by PoseRay v3.0.2.272
//3D model to POV-Ray/Moray Converter.
//Author: FlyerX
//Email: flyer_2000@excite.com
//Web: http://user.txcyber.com/~sgalls/
//----------------------------------------------------
//Files needed to run the POV-Ray scene:
//POV-Ray configuration file:ROSE_pov.ini Open this file in POV-Ray and press run to obtain the render
//POV-Ray Scene file:ROSE.pov
//POV-Ray geometry mesh file:ROSE_pov.inc
//POV-Ray material file:ROSE_pov_mat.inc
//----------------------------------------------------
//Files used in PoseRay for the creation of this scene:
//3D model file: ROSE.3DS
//Material file: ROSE.mtl
//Camera file: 
//Lights file: 
//----------------------------------------------------
//Model Statistics:
//Number of vertices............. 850
//Number of normals.............. 850
//Number of UV coordinates....... 0
//Number of materials............ 3
//Number of unique groups........ 1
//Number of polygons............. 982
//Number of valid triangles...... 982
//Number of line segments........ 0
//Bounding Box....... from x,y,z=(-200.0173,-402.9792,-34.76262)
//                      to x,y,z=(-18.28336,-76.12196,94.27454)
//Bounding Box size.... dx,dy,dz=(181.7339,326.8573,129.0372)
//Bounding box diagonal.......... 395.6179
//Bounding box center..... x,y,z=(-109.1503,-239.5506,29.75596)
//Memory allocated for geometry.. 105112 Bytes
// 
//-------------------------------------------------
//IMPORTANT:
//This file was designed to run with the following command line options: 
// +W631 +H428 +FN +AM1 +A0.3 -UA
//if you are not using an INI file copy and paste the text above to the command line box before rendering
 
#include "colors.inc"
#include "skies.inc"
#include "textures.inc"
#include "ROSE_pov.inc" //the geometry is in this file
 
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
        location <3.051758E-5,0,1186.854>
        look_at <3.051758E-5,0,1185.854>
        angle 25.20314 // horizontal FOV angle
        rotate <0,0,180.2781> //roll
        rotate <13.31555,0,0> //pitch
        rotate <0,-178.1664,0> //yaw
        translate <-109.1503,-239.5506,29.75596>
        }
 
//PoseRay default Light attached to the camera
light_source {
              <3.051758E-5,0,1186.854> //light position
              color rgb <1,1,1>*1.5
              parallel
              point_at <3.051758E-5,0,0>
              rotate <0,0,180.2781> //roll
              rotate <13.31555,0,0> //elevation
              rotate <0,-178.1664,0> //rotation
             }
 
//A Colored Background
background { color rgb<0.8313726,0.8156863,0.7843137>  }
 
//Assembled object that is contained in F:\Sources\pov\all you need is love\ROSE_pov.inc
object{
      ROSE
      }
//-------------------------------------------------
