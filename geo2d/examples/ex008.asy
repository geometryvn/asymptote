import geo2d;
unitsize(1cm);
defaultpen(fontsize(11pt));
	
pair B=(0,0); dot(Label("$B$",align=SW),B);
pair C=(6.5,0); dot(Label("$C$",align=SE),C);

pair M=midpoint(B--C);
pair O=interp(M,rotate(-90,M)*B,0.2); draw(circle1p(O,B));

pair Ma=midpoint(arc(O,B,C));
pair B1=rotate(180,O)*B; 
pair C1=rotate(180,O)*C; 
pair I=intersectionpoints(lineex(B1,C1),circle1p(Ma,B))[1];
dot(Label("$I$",align=NW),I);

pair P=rotate(180,O)*I; dot(Label("$P$",align=SE),P);
pair A=reflect(O,reflect(Ma,I)*O)*Ma; dot(Label("$A$",align=NW),A);

pair E=projection(I,C,A); dot(Label("$E$",align=NE),E);
pair F=projection(I,A,B); dot(Label("$F$",align=NW),F);

pair N=projection(excenter(B,C,A),C,A); dot(Label("$N$",align=NE),N);
pair M=projection(excenter(C,A,B),A,B); dot(Label("$M$",align=SW),M);

pair D=extension(B,C,I,rotate(90,I)*A); dot(Label("$D$",align=SW),D);
pair X=reflect(O,reflect(A,D)*O)*A; dot(Label("$X$",align=NW),X);

draw(incircle(A,B,C));
draw(circle3p(A,E,F)^^circle3p(A,M,N),dashed);
draw(A--B--C--cycle^^D--A^^D--B);
dot(A^^B^^C^^D^^E^^F^^I^^M^^N^^P^^X,Fill(white));
