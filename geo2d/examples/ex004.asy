import geo2d;
unitsize(1cm);
defaultpen(fontsize(11pt));

pair C=(1.5,5); dot(Label("$C$",align=NW),C);
pair A=(0,0); dot(Label("$A$",align=SW),A);
pair B=(6.5,0); dot(Label("$B$",align=SE),B);
pair O=center3p(A,B,C); dot(Label("$O$",align=SE),O);
path cO=circle3p(A,B,C); draw(cO);
pair M=midpoint(A--B); dot(Label("$M$",align=SW),M);
pair N=reflect(O,reflect(C,M)*O)*C; dot(Label("$N$",align=SE),N);
pair P=extension(A,C,M,parallel(M,B,N)); dot(Label("$P$",align=SW),P);
pair Q=extension(B,C,M,parallel(M,A,N)); dot(Label("$Q$",align=SE),Q);
pair p[]=intersectionpoints(cO,circle2p(P,O));
pair Y=extension(Q,M,P,p[1]); dot(Label("$Y$",align=NE),Y);
pair q[]=intersectionpoints(cO,circle2p(Q,O));
pair X=extension(P,M,Q,q[1]); dot(Label("$X$",align=NW),X);
pair Z=extension(P,Y,Q,X); dot(Label("$Z$",align=SW),Z);

draw(A--B--C--A^^C--N^^M--P^^M--Q^^N--A^^N--B^^P--A^^Q--B^^P--Y^^Q--X);
dot(A^^B^^C^^M^^N^^O^^P^^Q^^X^^Y^^Z,Fill(white));
