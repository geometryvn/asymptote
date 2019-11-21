import geometry;

arc g2arcX(point O, point A, point B){
	circle c=circle(O,abs(O-A));
	return arc(c,A,B);
}

circle g2circle1p(point O, point A){
	return circle(O,abs(O-A));
}

path g2line(point A=(0,0), point B=(0,0), real a=0.1, real b=a){
	return (a*(A-B)+A)--(b*(B-A)+B);
}

arc[] g2egg(point A, point B){
	arc[] tmp;
	real r=abs(A-B); line l=line(A,B);
	point C=rotate(180,B)*A; point D=rotate(180,C)*B;
	point[] a={A,B,C,D}, p, q;
	for (int i=0; i<=2; ++i) p[i]=rotate(60,a[i])*a[i+1];
	for (int i=0; i<p.length; ++i) q[i]=reflect(l)*p[i];
	
	point K=rotate(180,p[0])*a[0];
	point L=reflect(line(A,B))*K;
	point M=rotate(180,D)*intersectionpoint(K--D,circle(D,r));
	point N=rotate(180,D)*intersectionpoint(L--D,circle(D,r));
	
	tmp.push(g2arcX(D,M,N));

	circle cD=circle(D,r);
	point Q=rotate(180,q[1])*intersectionpoint(K--q[1],circle(q[1],r));	
	point P=rotate(180,p[1])*intersectionpoint(L--p[1],circle(p[1],r));
	
	tmp.push(g2arcX(L,N,P)); tmp.push(g2arcX(K,Q,M));
	
	point R=reflect(perpendicular(C,line(p[0],D)))*D;	
	point S=reflect(perpendicular(C,line(q[0],D)))*D; 	
	point U=intersectionpoint(g2line(S,p[0],0,1),g2circle1p(S,P)); 	
	point V=reflect(line(A,B))*U;
	
	tmp.push(g2arcX(S,P,U)); tmp.push(g2arcX(R,V,Q));

	point O=midpoint(p[0]--q[0]);
	point I=intersectionpoint(p[2]--O, R--V);
	point J=reflect(line(A,B))*I;
	point X=intersectionpoint(g2line(p[2],I,0,2),g2circle1p(I,V));	
	point Y=reflect(line(A,B))*X;
	
	tmp.push(g2arcX(J,U,Y)); tmp.push(g2arcX(I,X,V));
	tmp.push(g2arcX(O,Y,X));
	return tmp;
}

void g2r(point A, point B){
	arc[] ar=g2egg(A,B);
	draw(ar[0],3bp+red);
	draw(ar[1]^^ar[2],3bp+0.4green);
	draw(ar[3]^^ar[4],3bp+heavymagenta);
	draw(ar[5]^^ar[6],3bp+1.2blue);
	draw(ar[7],3bp+red);
}
