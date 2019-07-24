// ***********************************************
// LINK INCLUDE FILE FOR PERSISTENCE OF VISION 3.x
// ***********************************************
//
// Created by Chris Colefax, 20 April 1998
//
// See "Link.txt" for more information.
//
// ***********************************************

// CHECK THAT BOTH LINK POINTS HAVE BEEN DEFINED
// *********************************************
   #declare _LN_tempver = version; #version 3.0
   #declare _LN_warning = ""
   #ifndef (link_point1) #declare _LN_warning = "You must define link_point1 and link_point2 to link together!\r\n" #end
   #ifndef (link_point2) #declare _LN_warning = "You must define link_point1 and link_point2 to link together!\r\n" #end
   #if (strcmp(_LN_warning, "")!=0) #warning _LN_warning #else

   #ifndef (camera_sky) #declare camera_sky = <0.01, 1, 0>; #end
   #ifndef (link_looseness) #declare link_looseness = 1; #end

// CALC GLOBAL ROTATIONS TO CONVERT SKY DIRECTION INTO +Y
// ******************************************************
   #declare _LN_grotx = degrees(atan2(vlength(camera_sky * <1, 0, 1>), camera_sky.y))
   #declare _LN_groty = degrees(atan2(camera_sky.x, camera_sky.z))
   #declare _LN_link_point2 = vrotate(vrotate(link_point2 - link_point1, -y * _LN_groty), -x * _LN_grotx)

// CALC TRANSFORMATIONS TO CONVERT POINTS INTO XY PLANE
// ****************************************************
   #declare _LN_grotax = -degrees(atan2(_LN_link_point2.z, _LN_link_point2.x));
   #declare _LN_link_point2 = vrotate(_LN_link_point2, -y * _LN_grotax)
   #if (_LN_link_point2.x = 0) #declare _LN_link_point2 = _LN_link_point2.y * <1/100, 1, 0>; #end

// DETERMINE HIGHEST POINT AND THIRD POINT (WITH RESPECT TO LOOSENESS)
// *******************************************************************
   #declare _LN_X1 = 0 #declare _LN_Y1 = 0
   #declare _LN_X2 = _LN_link_point2.x #declare _LN_Y2 = _LN_link_point2.y
   #if (_LN_Y2 <= 0)
      #declare _LN_X3 = 2 * _LN_X2
      #declare _LN_Y3 = (2 * _LN_Y2) + (link_looseness * abs(_LN_X2))
   #else
      #declare _LN_X3 = -_LN_X2
      #declare _LN_Y3 = -_LN_Y2 + (link_looseness * abs(_LN_X2))
   #end

// DETERMINE QUADRATIC FUNCTION THAT FITS THREE POINTS
// ***************************************************
   #declare _LN_A = ((_LN_Y1-_LN_Y3)/((_LN_X1*_LN_X1)-(_LN_X3*_LN_X3))+((_LN_Y2-_LN_Y3)*(_LN_X3-_LN_X1))/(((_LN_X1*_LN_X1)-(_LN_X3*_LN_X3))*(_LN_X2-_LN_X3)))/(1-(((_LN_X3*_LN_X3)-(_LN_X2*_LN_X2))*(_LN_X3-_LN_X1))/(((_LN_X1*_LN_X1)-(_LN_X3*_LN_X3))*(_LN_X2-_LN_X3)))
   #declare _LN_B = ((_LN_Y2-_LN_Y3)+(_LN_A*((_LN_X3*_LN_X3)-(_LN_X2*_LN_X2))))/(_LN_X2-_LN_X3)
   #declare _LN_C = _LN_Y3-(_LN_A*(_LN_X3*_LN_X3))-(_LN_B*_LN_X3)

// CALCULATE LENGTH OF QUADRATIC
// *****************************
   #if (_LN_A = 0) #declare _LN_length = vlength(<_LN_X2, _LN_Y2, 0>)
      #else #declare _LN_length = (((_LN_X2/4)+(_LN_B/(8*_LN_A)))*sqrt(4+(16*_LN_A*_LN_A*_LN_X2*_LN_X2)+(16*_LN_A*_LN_X2*_LN_B)+(4*_LN_B*_LN_B))+(log(((_LN_X2+(_LN_B/(2*_LN_A)))+sqrt((_LN_X2*_LN_X2)+_LN_X2*_LN_B/_LN_A+(_LN_B*_LN_B/(4*_LN_A*_LN_A))+(1/(4*_LN_A*_LN_A))))/(1/(2*_LN_A)))/(4*_LN_A)))
      #declare _LN_length = _LN_length - (((_LN_X1/4)+(_LN_B/(8*_LN_A)))*sqrt(4+(16*_LN_A*_LN_A*_LN_X1*_LN_X1)+(16*_LN_A*_LN_X1*_LN_B)+(4*_LN_B*_LN_B))+(log(((_LN_X1+(_LN_B/(2*_LN_A)))+sqrt((_LN_X1*_LN_X1)+_LN_X1*_LN_B/_LN_A+(_LN_B*_LN_B/(4*_LN_A*_LN_A))+(1/(4*_LN_A*_LN_A))))/(1/(2*_LN_A)))/(4*_LN_A)))
   #end

// CHECK LINK OPTIONS AND ASSIGN DEFAULTS
// **************************************
   #ifndef (link_object) #declare link_object = cylinder {<-.55, 0, 0>, <.55, 0, 0>, .25 pigment {rgb <1, 1, 1>}} #end
   #ifdef (link_count) #declare _LN_count = link_count
      #else #ifdef (link_size) #declare _LN_count = int(_LN_length / link_size)
      #else #declare _LN_count = 20 #end #end
   #if (_LN_count < 4) #declare _LN_count = 4 #end
   #ifdef (link_twist) #declare _LN_rotinc = link_twist * (abs(link_twist) < 1 ? 180 : 1)
      #else #ifdef (total_link_twist) #declare _LN_rotinc = total_link_twist / _LN_count
      #else #declare _LN_rotinc = 0 #end #end
   #ifndef (link_seed) #declare _LN_rand = seed(0) #else #declare _LN_rand = seed(link_seed) #end
   #ifndef (link_size_turb) #declare link_size_turb = 0 #end
   #ifndef (link_twist_turb) #declare link_twist_turb = 0 #end
   #ifndef (scale_links) #declare scale_links = true #end
   #ifndef (rotate_links) #declare rotate_links = true #end

// POSITION LINK OBJECTS
// *********************
   union {
      #declare _LN_cpoint = <0, 0, 0>
      #declare _LN_lrotx = 0
      #declare _LN_lscale = _LN_length / (_LN_count - 1)

      #declare _LN_X = _LN_X1 #while (_LN_X <= _LN_X2)
         #declare _LN_opoint = _LN_cpoint
         #declare _LN_cpoint = <_LN_X, _LN_A*_LN_X*_LN_X + _LN_B*_LN_X + _LN_C, 0>
         #declare _LN_lrotz = degrees(atan2(2*_LN_A*_LN_X + _LN_B, 1))
         #declare _LN_cscale = _LN_lscale * (1 + (rand(_LN_rand) - .5) * link_size_turb)
         object {link_object
            #if (scale_links != false)  scale _LN_cscale #end
            rotate <_LN_lrotx, 0, (rotate_links = false ? 0 :_LN_lrotz)>
            translate _LN_cpoint}
         #declare _LN_lrotx = _LN_lrotx + _LN_rotinc + (rand(_LN_rand) - .5) * link_twist_turb * 360
      #declare _LN_X = (_LN_cpoint + vrotate(x * _LN_cscale, z * _LN_lrotz)).x
      #end

// MOVE UNIONED LINKS INTO POSITION
// ********************************
   rotate y * _LN_grotax
   rotate <_LN_grotx, _LN_groty, 0>
   translate link_point1}

   #end
   #version _LN_tempver
