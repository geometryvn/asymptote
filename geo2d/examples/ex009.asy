import geo2d;
unitsize(1cm);
defaultpen(fontsize(11pt));
	
pair A=(1.1,4); dot(Label("$A$",align=NW),A);
pair B=(0,0); dot(Label("$B$",align=SW),B);
pair C=(6,0); dot(Label("$C$",align=SE),C);
pair O=center3p(A,B,C); dot(Label("$O$",align=NE),O);
draw(circle3p(A,B,C));
pair D=projection(excenter(A,B,C),B,C); dot(Label("$D$",align=SE),D);
pair E=projection(excenter(B,C,A),C,A); dot(Label("$E$",align=NE),E);	
pair F=projection(excenter(C,A,B),A,B); dot(Label("$F$",align=NW),F);

pair L=reflect(center3p(A,B,E), center3p(A,C,F))*A; dot(Label("$L$",align=SW),L);
pair L1=midpoint(arc(O,B,C)); dot(L1);

pair M=reflect(center3p(B,C,F),center3p(B,A,D))*B; dot(Label("$M$",align=NE),M);

pair N=reflect(center3p(C,A,D),center3p(C,B,E))*C; dot(Label("$N$",align=NW),N);
pair K=midpoint(A--D); dot(Label("$K$",align=NE),K);
pair I=midpoint(B--E); dot(Label("$I$",align=NW),I);
pair J=midpoint(C--F); dot(Label("$J$",align=NE),J);

pair T=extension(I,M,J,N); //dot(Label("$T$",align=NW),T);

draw(A--B--C--A^^A--L1^^A--D^^B--E^^C--F^^K--L^^I--M^^J--N);
draw(circle3p(A,B,E)^^circle3p(A,C,F),dashed);

draw(circle3p(B,C,F)^^circle3p(B,A,D),dashed+red);
draw(arcex(center3p(C,A,D),A,C)^^arcex(center3p(C,B,E),C,B),dashed+blue);

dot(A^^B^^C^^D^^E^^F^^I^^J^^K^^L^^M^^N^^O^^T,Fill(white));
