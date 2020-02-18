import geo2d;
unitsize(1cm);
defaultpen(fontsize(11pt));

pair A=(0.2,3.5); dot(Label("$A$",align=NW),A);
pair D=(0,0); dot(Label("$D$",align=SW),D);
pair C=(7,0); dot(Label("$C$",align=SE),C);
pair O=center3p(A,C,D); dot(Label("$O$",align=SE),O);
path cO=circle3p(A,C,D); draw(cO);
pair B=rotate(-70,O)*A; dot(Label("$B$",align=NW),B);
pair P=extension(A,C,B,D); dot(Label("$P$",align=NW),P);

real angle=70;
pair E=extension(A,B,P,rotate(-angle,P)*A); dot(Label("$E$",align=NW),E);
pair F=extension(C,D,P,rotate(angle,P)*D); dot(Label("$F$",align=SW),F);

path cP=circle3p(P,E,F); draw(cP,dashed);

pair T=extension(E,F,P,rotate(90,P)*center3p(P,E,F)); //dot(Label("$T$",align=SW),T);

pair X=intersectionpoints(cO,circle1p(T,P))[0]; dot(Label("$X$",align=NE),X);
pair Y=reflect(O,T)*X; dot(Label("$Y$",align=NW),Y);

pair O1=extension(O,X,P,center3p(P,E,F)); draw(circle1p(O1,P));
pair O2=extension(O,Y,P,center3p(P,E,F)); draw(circle1p(O2,P));

draw(A--B--C--D--A^^A--C^^B--D^^P--E^^P--F);
dot(A^^B^^C^^D^^E^^F^^O^^P^^X^^Y,Fill(white));
