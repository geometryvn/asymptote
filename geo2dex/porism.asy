//Đa giác lưỡng tâm (n=3, 4, 5, 6)

import geometry;
//import geo2dadv;
unitsize(1cm);
defaultpen(fontsize(11pt));

real [] solve(real a, real b, real c){
	real dt=b^2-4*a*c, x[];
	if (dt>=0){
		x.push((-b+sqrt(dt))/(2*a));
		x.push((-b-sqrt(dt))/(2*a));
	}
	return x;
}

real [] solve(real a=1, real b, real c, real d){
	real dt, k;
	real x[];
	dt=b^2-3*a*c;
	k=(9*a*b*c-2*(b^3)-27*a^2*d)/(2*sqrt(abs(dt)^3));
	if (dt>0){
		if(abs(k)<=1){
			x[0]=(2*sqrt(dt)*cos(acos(k)/3)-b)/(3*a);
			x[1]=(2*sqrt(dt)*cos(acos(k)/3-2*pi/3)-b)/(3*a);
			x[2]=(2*sqrt(dt)*cos(acos(k)/3+2*pi/3)-b)/(3*a);
		} else {
			real m=(abs(k)+sqrt(k^2-1))^(1/3), n=(abs(k)-sqrt(k^2-1))^(1/3);
			x[0]=sqrt(abs(dt))*abs(k)*(m+n)/(3*a*k)-b/(3*a);
		}
		
	} else if(dt==0){
		x[0]=(-b+(b^3-27*a^2*d)^(1/3))/(3*a);
	} else {
		real p=(k+sqrt(k^2+1))^(1/3), q=(k-sqrt(k^2+1))^(1/3);
		x[0] = sqrt(abs(dt))*(p+q)/(3*a)-b/(3*a);
	}

	return x;

}

struct porism{
	circle c;
	point [] v;
	path pt;
}


porism twocenter(int n=3, circle c, real d=0.3*c.r, real a=0.3, real i=0){
	porism tmp;
	if (n==3){	
		real r=(c.r^2-d^2)/(2*c.r);
		point I=relpoint(circle(c.C,d),i);
		tmp.c=circle(I,r);
		
		point A=relpoint(c,a);
		point t=intersectionpoints(circle(A,I),circle(I,r))[0];
		line ta=line(A,t);
		point B=reflect(perpendicular(c.C,ta))*A;
		line tb=reflect(line(B,I))*ta;
		point C=reflect(perpendicular(c.C,tb))*B;
		tmp.v.push(A); tmp.v.push(B); tmp.v.push(C);
		tmp.pt=(A--B--C--cycle);
		
	}
	
	if (n==4){
		real r=(1/(c.r-d)^2+1/(c.r+d)^2)^(-1/2);
		point I=relpoint(circle(c.C,d),i);
		tmp.c=circle(I,r);
		point A=relpoint(c,a);
		point t=intersectionpoints(circle(A,I),circle(I,r))[0];
		line ta=line(A,t);
		point B=reflect(perpendicular(c.C,ta))*A;
		line tb=reflect(line(B,I))*ta;
		point C=reflect(perpendicular(c.C,tb))*B;
		line tc=reflect(line(C,I))*tb;
		point D=reflect(perpendicular(c.C,tc))*C;
		tmp.v.push(A); tmp.v.push(B); tmp.v.push(C); tmp.v.push(D);
		tmp.pt=(A--B--C--D--cycle);
	}
	
	if (n==5){
		real p=1/(c.r+d), q=1/(c.r-d);
		real t[]=solve(1,-(p+q),-(p+q)^2,(p+q)*(p-q)^2);
		real r=abs(1/t[2]);
		point I=relpoint(circle(c.C,d),i);
		tmp.c=circle(I,r);
		point A=relpoint(c,a);
		point t=intersectionpoints(circle(A,I),circle(I,r))[0];
		line ta=line(A,t);
		point B=reflect(perpendicular(c.C,ta))*A;
		line tb=reflect(line(B,I))*ta;
		point C=reflect(perpendicular(c.C,tb))*B;
		line tc=reflect(line(C,I))*tb;
		point D=reflect(perpendicular(c.C,tc))*C;
		line td=reflect(line(D,I))*tc;
		point E=reflect(perpendicular(c.C,td))*D;
		tmp.v.push(A); tmp.v.push(B); tmp.v.push(C); tmp.v.push(D); tmp.v.push(E);
		tmp.pt=(A--B--C--D--E--cycle);
	}
	
	if (n==6){
		point I=relpoint(circle(c.C,d),i);
		real m=16*d^2*c.r^2, n=4*(c.r^2+d^2)*(c.r^2-d^2)^2, p=-3*(c.r^2-d^2)^4;
		real x[]=solve(m,n,p);
		real r=sqrt(abs(x[0]));
		tmp.c=circle(I,r);
		
		point A=relpoint(c,a);
		line ta=tangents(circle(I,r),A)[0];
		point B=reflect(perpendicular(c.C,ta))*A;
		line tb=reflect(line(B,I))*ta;
		point C=reflect(perpendicular(c.C,tb))*B;
		line tc=reflect(line(C,I))*tb;
		point D=reflect(perpendicular(c.C,tc))*C;
		line td=reflect(line(D,I))*tc;
		point E=reflect(perpendicular(c.C,td))*D;
		line te=reflect(line(E,I))*td;
		point F=reflect(perpendicular(c.C,te))*E;
		tmp.pt=(A--B--C--D--E--F--cycle);
	}
	
	return tmp;
}


point O=(0,0); dot(Label("$O$",align=NE),O);
real R=6;
circle co=circle(O,R); draw(co);

porism p3=twocenter(3,co, a=0.2);
draw(p3.c,red); draw(p3.pt,red);

porism p4=twocenter(4,co, i=0.1);
draw(p4.c,green); draw(p4.pt,green);

porism p5=twocenter(5,co,a=0.4,i=0.2);
draw(p5.c,blue); draw(p5.pt,blue);

porism p6=twocenter(6,co,a=0.7,i=0.4);
draw(p6.c,cyan); draw(p6.pt,2bp+cyan);
