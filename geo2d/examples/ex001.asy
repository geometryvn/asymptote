import geo2d;
unitsize(1cm);
defaultpen(fontsize(11pt));

pair O=(0,0); dot(Label("$O$",align=NW),O);
pair A=(0,-3.5); dot(Label("$A$",align=SW),A);

real k=4.2;
pair B=intersectionpoints(circle1p(O,A),circle(A,k))[0]; dot(Label("$B$",align=SW),B);
pair E=reflect(O,A)*B; dot(Label("$E$",align=SE),E);
pair C=rotate(-122,O)*A; dot(Label("$C$",align=NW),C);
pair D=intersectionpoints(circle1p(O,A),circle(C,k))[0]; dot(Label("$D$",align=NE),D);

pair F=orthocenter(A,B,E); dot(Label("$F$",align=SW),F);
pair H=extension(B,D,C,E); dot(Label("$H$",align=N),H);
pair I=midpoint(B--C); dot(Label("$I$",align=NW),I);
pair J=midpoint(D--E); dot(Label("$J$",align=NE),J);
pair G=centroid(A,I,J); dot(Label("$G$",align=NW),G);
pair M=extension(O,G,F,H); dot(Label("$M$",align=SW),M);

draw(circle1p(O,A));
draw(A--B--C--D--E--A^^B--D^^C--E^^A--M^^A--I--J--A^^O--F^^O--M^^F--H);
dot(A^^B^^C^^D^^E^^F^^G^^H^^I^^J^^M^^O,Fill(white));
