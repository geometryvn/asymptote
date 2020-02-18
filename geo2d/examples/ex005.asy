import geo2d;
unitsize(1cm);
defaultpen(fontsize(11pt));

pair A=(1.2,4.5); dot(Label("$A$",align=NW),A);
pair B=(0,0); dot(Label("$B$",align=SW),B);
pair C=(6,0); dot(Label("$C$",align=SE),C);
pair O=center3p(A,B,C); dot(Label("$O$",align=SE),O);
path cO=circle3p(A,B,C); draw(cO);

pair E=projection(B,C,A); dot(Label("$E$",align=NE),E);
pair F=projection(C,A,B); dot(Label("$F$",align=NW),F);

pair P=extension(B,C,A,rotate(90,A)*O); dot(Label("$P$",align=SW),P);
pair Q=extension(E,F,A,parallel(A,B,C)); dot(Label("$Q$",align=NE),Q);
pair M=midpoint(B--C); dot(Label("$M$",align=SW),M);

draw(A--B--C--A^^B--E^^C--F^^A--M^^A--P^^P--B^^A--Q^^Q--F^^P--Q);
dot(A^^B^^C^^E^^F^^M^^O^^P^^Q,Fill(white));
