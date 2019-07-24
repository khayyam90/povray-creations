//-------------------------------------------------
//POV-Ray Materials list
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
 
 
//Map definitions =================
#declare p_map1=pigment {color rgb <.4,.5,.4>  }
#declare p_map2=normal {bozo scale .1}
#declare p_map3=normal {agate}
#declare p_map4=normal {agate}
#declare p_map5=normal {agate }
 
//Material definitions =============================
#declare IRREGULAR_SKIN= 
texture{pigment {color rgb <0.1647059,0.07058824,0.04313726> transmit 0} }
texture{pigment{p_map1} 
        normal{p_map2} 
        finish{phong 0.3228758 phong_size 200 ambient rgb <0.1098039,0.09411765,0.05098039> reflection{0 metallic}}}
//================================================== 
#declare DARK_GRAY_MATTE= 
texture{pigment {color rgb <0.07843138,0.08627451,0.06666667> transmit 0} }
texture{pigment{p_map1} 
        finish{phong 0.1006536 phong_size 0 ambient rgb <0.09019608,0.09019608,0.06666667> reflection{0 metallic}}}
//================================================== 
#declare OLD_PAPER_2= 
texture{pigment {color rgb <0.4235294,0.4235294,0.3607843> transmit 0} 
        normal{p_map3} 
        finish{phong 0.751634 phong_size 0 ambient rgb <0.1098039,0.1294118,0.07843138> reflection{0 metallic}}}
//================================================== 
#declare OLDER_PAPER= 
texture{pigment {color rgb <0.3803922,0.3803922,0.345098> transmit 0} }
texture{pigment{p_map1} 
        normal{p_map4} 
        finish{phong 0.7019608 phong_size 0 ambient rgb <0.1019608,0.1098039,0.08235294> reflection{0 metallic}}}
//================================================== 
#declare OLD_METAL_2= 
texture{pigment{Red}}

//================================================== 
