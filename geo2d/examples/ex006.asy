import geo2d;
unitsize(1cm);
defaultpen(fontsize(11pt));

pair B=(0,0); dot(Label("$B$",align=SW),B);
pair C=(8,0); dot(Label("$C$",align=SE),C);
pair Ma=midpoint(B--C);
pair O=interp(Ma,rotate(-90,Ma)*B,0.2); dot(Label("$O$",align=NE),O);
draw(circle1p(O,B));
pair L=midpoint(arc(O,B,C));
pair E=intersectionpoint((Ma--C),circle2p(O,L)); dot(Label("$E$",align=S),E);
pair K=reflect(O,E)*L; dot(Label("$K$",align=NE),K);
pair A=reflect(O,E)*B; dot(Label("$A$",align=NW),A);
pair M=midpoint(A--B); dot(Label("$M$",align=NW),M);
pair X=intersectionpoint((M--O),circle1p(L,B)); dot(Label("$X$",align=N),X);
pair Y=intersectionpoint(lineex(O,E,0,4),circle1p(L,B)); dot(Label("$Y$",align=SE),Y);
pair Q=reflect(L,reflect(O,C)*L)*C; dot(Label("$Q$",align=NW),Q);
pair I=incenter(A,B,C); dot(Label("$I$",align=NE),I);
pair D=extension(A,I,B,C); dot(Label("$D$",align=SW),D);

draw(arcex(L,Y,B),dashed);
draw(circle3p(A,B,D),dashed);	
draw(A--B--C--cycle^^A--D^^M--Y^^K--I^^K--Y^^C--Q^^A--Q^^Q--M);
dot(A^^B^^C^^D^^E^^I^^K^^M^^O^^X^^Y,Fill(white));
