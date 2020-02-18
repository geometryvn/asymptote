import geo2d;
unitsize(1cm);
defaultpen(fontsize(11pt));

pair A=(1.2,5); dot(Label("$A$",align=NW),A);
pair B=(0,0); dot(Label("$B$",align=SW),B);
pair C=(7,0); dot(Label("$C$",align=SE),C);
pair O=center3p(A,B,C); dot(Label("$O$",align=SE),O);
path cO=circle3p(A,B,C); draw(cO);

pair M=midpoint(A--B); dot(Label("$M$",align=NW),M);
pair N=midpoint(A--C); dot(Label("$N$",align=NE),N);
pair X=scale(A,1.3)*rotate(-90,A)*O; dot(Label("$X$",align=NW),X);

pair Ob=extension(midpoint(M--B),midline(M,B),M,rotate(90,M)*X); dot(Label("$O_b$",align=SE),Ob);

pair Oc=extension(midpoint(N--C),midline(N,C),N,rotate(90,N)*X); dot(Label("$O_c$",align=SE),Oc);

draw(circle1p(Ob,B)^^circle1p(Oc,C),dashed);

pair t[]=intersectionpoints(circle1p(Ob,B),circle1p(Oc,C));

draw(A--B--C--A^^A--X^^X--M^^X--N);
dot(A^^B^^C^^M^^N^^O^^X^^Ob^^Oc^^t[1],Fill(white));
