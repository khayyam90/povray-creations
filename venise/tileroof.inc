/************************************************************************* 

tileroof.inc
v.1.0  

Author: Gennady Obukhov 
obukhov@mail.com 
http://propro.ru/go/
date: June 19 2003
Walnut Creek, California

*************************************************************************/

/*************************************************************************

								Tile.
					Creates single mesh tile								
					
n 		- number of faces. Big number makes smooth surface
maxR 	- maximim radius
minR 	- minimum radius
depth 	- length in z direction
base 	- make flat tile's base								

*************************************************************************/

#macro Tile(n, maxR, minR, depth, base)
    #local counter=0;
    #local a = 180/n;
	#local b = <0, 0, a>;

	#local P1 = <maxR, 0, 0>;
	#local P2 = vrotate(P1, b);
	#local P3 = <minR, 0, 0>;
	#local P4 = vrotate(P1, b);

	#declare T = mesh {
    	#while (counter < n)
    		#local b = <0, 0, a*counter>;
    		#local d = <0, 0, b.z + a>;
    		#local P1 = <maxR, 0, 0>;
    		#local P11 = vrotate(P1, b);
			#local P2 = vrotate(P1, d);
			#local P3 = <minR, 0, 0>;
			#local P33 = vrotate(P3, b);
			#local P4 = vrotate(P3, d);
			
			// front
			triangle{<P11.x, P11.y, 0>, <P4.x, P4.y, 0>, <P33.x, P33.y, 0>}
			triangle{<P11.x, P11.y, 0>, <P2.x, P2.y, 0>, <P4.x, P4.y, 0>}
			
			// top
			triangle{<P11.x, P11.y, 0>, <P2.x, P2.y, 0>, <P33.x, P33.y, depth>}
			triangle{<P33.x, P33.y, depth>, <P2.x, P2.y, 0>, <P4.x, P4.y, depth>}
			
			// base
			#if(base = 1 & counter = 0)
				triangle{<P11.x, P11.y, 0>, <P11.x, P11.y, depth>, <P33.x, P33.y, depth>}
			#end
			#if(base = 1 & counter = (n - 1))
				triangle{<P2.x, P2.y, 0>, <P2.x, P2.y, depth>, <P33.x, P33.y, depth>}
			#end
			
        	#declare counter = counter + 1;
    	#end
    };  
#end

/*************************************************************************

								Roof1
								
				Creates rectangle roof pane in x-z plane. 
			The whole roof is a union of duplicated mesh tile.
								
f 	- number of faces in a single tile
k 	- minR/maxR
w 	- roof width (x)
d 	- roof depth (z)
nx 	- number of tiles in x direction
nz 	- number of tiles in z direction
bs 	- 1 - show flat tile's base 0 - hide flat tile's base
pg 	- pigment
r 	- random number seed for random texture arrangement							

*************************************************************************/

#macro Roof1(f, k, w, d, nx, nz, bs, pg, r)
	#local iw = w/nx;
	#local id = d/nz;
	#local counter=0;
	
	Tile(f, iw/2, (iw/2) * k, 1, bs)
	union {
		#while (counter < nx)
			#local counter1=0;
			#while (counter1 < nz)
				object{
					T
		  			scale<1, 1, id>
		  			translate<iw/2 + (iw*counter), 0, id*counter1>
		  		}   
		  		#declare counter1 = counter1 + 1;
			#end
			#declare counter = counter + 1;
		#end
	    texture{
	    	pigment{pg scale<iw, iw, id> translate x * iw * (int(10 * rand(seed(r))))}		  		
			finish{diffuse 0.66} 
		}
	}	
#end

/*************************************************************************

								Roof2
								
				Creates rectangle roof pane in x-z plane. 
					The whole roof is a single mesh.
								
f 	- number of faces in a single tile
k 	- minR/maxR
w 	- roof width (x)
d 	- roof depth (z)
nx 	- number of tiles in x direction
nz 	- number of tiles in z direction
bs 	- 1 - show flat tile's base 0 - hide flat tile's base
pg 	- pigment
r 	- random number seed for random texture arrangement							

*************************************************************************/

#macro Roof2(f, k, w, d, nx, nz, bs, pg, r)
	#local iw = w/nx;
	#local id = d/nz;
	#local counter=0;
	
	#declare Roof = mesh {
		#while (counter < nx)
			#local counter1=0;
			#local ix = iw/2 + (iw * counter); 
			#while (counter1 < nz)
				#local maxR = iw/2;
				#local minR = (iw/2) * k;
				#local depth = id;
   				#local a = 180/f;
				#local b = <0, 0, a>;
				#local P1 = <maxR, 0, 0>;
				#local P2 = vrotate(P1, b);
				#local P3 = <minR, 0, 0>;
				#local P4 = vrotate(P1, b);
				#local counter2=0;
				#local iz = id * counter1;
				#local iz1 = id * (counter1 + 1);
   				#while (counter2 < f)
   					#local b = <0, 0, a*counter2>;
   					#local d = <0, 0, b.z + a>;
   					#local P1 = <maxR, 0, 0>;
   					#local P11 = vrotate(P1, b);
					#local P2 = vrotate(P1, d);
					#local P3 = <minR, 0, 0>;
					#local P33 = vrotate(P3, b);
					#local P4 = vrotate(P3, d);
					#local v1 = <P11.x + ix, P11.y, iz>;
					#local v2 = <P4.x + ix, P4.y, iz>;
					#local v3 = <P33.x + ix, P33.y, iz>;
					#local v4 = <P2.x + ix, P2.y, iz>;
					#local v5 = <P33.x + ix, P33.y, iz1>;
					#local v6 = <P4.x + ix, P4.y, iz1>;
					#local v7 = <P11.x + ix, P11.y, iz1>;
					#local v8 = <P2.x + ix, P2.y, iz1>;
					
					// front                      
					triangle{v1, v2, v3}
					triangle{v1, v4, v2}
			
					// top
					triangle{v1, v4, v5}
					triangle{v5, v4, v6}
			
					// base
					#if(bs = 1 & counter2 = 0)
						triangle{v1, v7, v5}
					#end
					#if(bs = 1 & counter2 = (f - 1))
						triangle{v4, v8, v5}
					#end

       				#local counter2 = counter2 + 1;
   				#end
		  		#local counter1 = counter1 + 1;
			#end
			#local counter = counter + 1;
		#end
	    texture{
	    	pigment{pg scale<iw, iw, id> translate x * iw * (int(10 * rand(seed(r))))}
			finish{diffuse 0.66} 
		}
	}
#end

/*************************************************************************

								SaveRoof
								
				Saves tile roof as a single mesh in specified file.
								
f 	- number of faces in a single tile
k 	- minR/maxR
w 	- roof width (x)
d 	- roof depth (z)
nx 	- number of tiles in x direction
nz 	- number of tiles in z direction
bs 	- 1 - show flat tile's base 0 - hide flat tile's base
pg 	- pigment type 0 - single color, 1 - multi-color
r 	- random number seed for random texture arrangement
filename - name of the file							

*************************************************************************/

#macro SaveRoof(f, k, w, d, nx, nz, bs, pg, r, filename)
	#local iw = w/nx;
	#local id = d/nz;
	#local counter=0;
	#fopen Output filename write
	#write(Output, "#declare Roof = mesh {\n")
	#debug concat("Writing to file ", filename, "...\n")
	
	#while (counter < nx)
		#local counter1=0;
		#local ix = iw/2 + (iw * counter); 
		#while (counter1 < nz)
			#local maxR = iw/2;
			#local minR = (iw/2) * k;
			#local depth = id;
			#local a = 180/f;
			#local b = <0, 0, a>;
			#local P1 = <maxR, 0, 0>;
			#local P2 = vrotate(P1, b);
			#local P3 = <minR, 0, 0>;
			#local P4 = vrotate(P1, b);
			#local counter2=0;
			#local iz = id * counter1;
			#local iz1 = id * (counter1 + 1);
			#while (counter2 < f)
				#local b = <0, 0, a*counter2>;
				#local d = <0, 0, b.z + a>;
				#local P1 = <maxR, 0, 0>;
				#local P11 = vrotate(P1, b);
				#local P2 = vrotate(P1, d);
				#local P3 = <minR, 0, 0>;
				#local P33 = vrotate(P3, b);
				#local P4 = vrotate(P3, d);
				#local v1 = <P11.x + ix, P11.y, iz>;
				#local v2 = <P4.x + ix, P4.y, iz>;
				#local v3 = <P33.x + ix, P33.y, iz>;
				#local v4 = <P2.x + ix, P2.y, iz>;
				#local v5 = <P33.x + ix, P33.y, iz1>;
				#local v6 = <P4.x + ix, P4.y, iz1>;
				#local v7 = <P11.x + ix, P11.y, iz1>;
				#local v8 = <P2.x + ix, P2.y, iz1>;
					
				// front                      
				#write(Output, "triangle{", v1, ",", v2, ",", v3, "}\n")
				#write(Output, "triangle{", v1, ",", v4, ",", v2, "}\n")
				#write(Output, "triangle{", v1, ",", v4, ",", v5, "}\n")
				#write(Output, "triangle{", v5, ",", v4, ",", v6, "}\n")
								
				// base
				#if(bs = 1 & counter2 = 0)
					#write(Output, "triangle{", v1, ",", v7, ",", v5, "}\n")
				#end
				#if(bs = 1 & counter2 = (f - 1))
					#write(Output, "triangle{", v4, ",", v8, ",", v5, "}\n")
				#end

   				#local counter2 = counter2 + 1;
			#end
	  		#local counter1 = counter1 + 1;
		#end
		#local counter = counter + 1;
	#end
	#if(pg = 0)
		#write(Output, "texture{pigment{color rgb<1, 0.6, 0.4>} finish{diffuse 0.66}}\n")
	#else
		#local v9 = <iw, iw, id>;
		#write(Output, "texture{pigment{cells color_map{[0.0 0.2 color rgb<1, 0.6, 0.4> color rgb<0.8, 0.4, 0.2>]")
		#write(Output, "[0.2 0.4 color rgb<1, 0.7, 0.5> color rgb<1, 0.5, 0.3>]")
		#write(Output, "[0.4 0.8 color rgb<0.9, 0.6, 0.4> color rgb<0.8, 0.4, 0.3>]")
		#write(Output, "[0.8 1.0 color rgb<1, 0.65, 0.45> color rgb<0.95, 0.55, 0.35>]}")
		#write(Output, "scale", v9, " translate x * ", iw, " * (int(10 * rand(seed(", r, "))))}")
		#write(Output, "finish{diffuse 0.66}}")
	#end
	#write(Output, "}")
	#fclose Output     
	#debug "Done"
#end
