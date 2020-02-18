import geo2d;
unitsize(1cm);
defaultpen(fontsize(11pt));

pair A=(0.6,4.8); dot(Label("$A$",align=NW),A);
pair B=(0,0); dot(Label("$B$",align=SW),B);
pair C=(6.5,0); dot(Label("$C$",align=SE),C);

pair I=incenter(A,B,C); dot(Label("$I$",align=NE),I);
pair O=center3p(A,B,C); dot(Label("$O$",align=SE),O);
pair H=orthocenter(A,B,C); dot(Label("$H$",align=SW),H);

pair M=midpoint(B--C); dot(Label("$M$",align=SE),M);
pair N=midpoint(C--A); dot(Label("$N$",align=NE),N);
pair P=midpoint(A--B); dot(Label("$P$",align=NW),P);

pair D=extension(N,reflect(B,I)*N,P,reflect(C,I)*P); dot(Label("$D$",align=NW),D);
pair E=extension(M,reflect(A,I)*M,P,reflect(C,I)*P); dot(Label("$E$",align=SW),E);
pair F=extension(N,reflect(B,I)*N,M,reflect(A,I)*M); dot(Label("$F$",align=SE),F);
pair T=midpoint(O--H);

draw(A--B--C--cycle^^D--E^^E--F^^D--F^^H--O^^A--I);
dot(A^^B^^C^^D^^E^^F^^H^^I^^M^^N^^P^^O^^T,Fill(white));
