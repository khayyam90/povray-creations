#macro people_membre(qual,pt1,pt2,pt3, couleur)
  union
  {sphere{<0,0,0>,.23 translate pt1} // sphere haute
  #local i=0;
  #while (i<1)
      sphere{pt1 + (pt2-pt1)*i, .2}
      #declare i=i+.1/qual;
  #end
   
  sphere{<0,0,0>,.22 translate pt2}  // sphere médiane 
  
  #local i=0;
  #while (i<1)
      sphere{pt2 + (pt3-pt2)*i, .2}
      #declare i=i+.1/qual;
  #end
   
  sphere{<0,0,0>,.16 translate pt3}   // sphere basse
  texture{couleur scale 3 rotate <50,30,50>*rand(srand)}
  }
#end // macro people_membre


#macro bonhomme(p1,p2,p3,p4,p5,p6,p11,p12,p13,p14,p15,p16, couleur, qual)
union
{

   sphere{<0,-.07,0>,.45
   texture{couleur scale 3 rotate <50,30,50>*rand(srand)}
   }   //4
   difference            // 5
   {
      sphere
      {
          <0,0,0>,.5 scale <1.2,3,.6>
      
      }      
      box{<2,1,2>,<-2,2,-2>}
      box{<2,-.3,2>,<-2,-3,-2>}
      box{<-1,-.5,-.25>,<1,1.1,-.5>}
  scale<1,.4,1.5>
  translate<0,-.6,0>
  texture{couleur scale 3 rotate <50,30,50>*rand(srand)}
  }
  
  // bras
  people_membre(qual,<.7,.95,0>,p12,p13, couleur)
  people_membre(qual,<-.7,.95,0>,p15,p16, couleur)                                                        
  
  // torse
  lathe
  {
      quadratic_spline
      6,<.5,1.5>, <0,1.5>,<.5,1.1>,<.45,.5>,<.3,.1>,<0,0>
      texture{couleur scale 3 rotate <50,30,50>*rand(srand)}
  }
       
  // tête
  lathe
  {
      quadratic_spline
      5,<0,.8>,<.1,.8>,<.4,.65>,<.39,.35>,<.3,0>
      scale <1,1.2,1.1> 
      translate y*1.35
      texture{couleur scale 3 rotate <50,30,50>*rand(srand)}
  }
  
  // jambes
  people_membre(qual,<.35,-.8,0>,p2,p3, couleur)
  people_membre(qual,<-.35,-.8,0>,p5,p6, couleur)

//scale <1,1.1,1>                                             
//texture{couleur scale 3 rotate <50,30,50>*rand(srand)}
//pigment{couleur}
}
#end // macro bonhomme