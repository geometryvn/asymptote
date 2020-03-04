import geometry;

//01
line parallel(line l, point m){
	return parallel(m,l);
}
//02
line perpendicular(line l, point m){
	return perpendicular(m,l);
}

//Trả về điểm chia ab theo tỷ số k
point hmconj(real k, point a, point b){
	point tmp;
	if (k!=-1) tmp=((a.x+k*b.x)/(1+k),(a.y+k*b.y)/(1+k));
	else tmp=midpoint(a--b);
	return tmp;
}

//Kiểm tra tiếp xúc của đường thẳng và đường tròn
bool tangent(line l, circle c){
	point T=projection(l)*c.C;
	return (T @ l);
}

bool tangent(circle c, line l){
	return tangent(l,c);
}

//Kiểm tra tiếp xúc của hai đường tròn.
bool tangent(circle c1, circle c2){
	bool tmp=false;
	point T[]=intersectionpoints(c1, line(c1.C,c2.C));
	if ((T[0] @ c2) | (T[1] @ c2)) tmp=true;
	return tmp;
}

bool concurrent(line l1, line l2, line l3){
	point T;
	if (parallel(l1,l2)==false) {
		T=intersectionpoint(l1, l2);
	}
	return (T @ l3);
}

//Trả về tâm vị tự của hai đường tròn c1, c2
point [] homocenter(circle c1, circle c2){
	point [] tmp;
	point P1=relpoint(c1,0.25), Q1=relpoint(c1,-0.25), P2=relpoint(c2,0.25);
	tmp.push(intersectionpoint(line(c1.C,c2.C), line(Q1,P2)));
	if (parallel(line(c1.C,c2.C),line(P1,P2))==false){
		tmp.push(intersectionpoint(line(c1.C,c2.C), line(P1,P2)));
	}
	return tmp;
}

//Trả về cặp tiếp tuyến trong (i=0) và cặp tiếp tuyến ngoài i khác 0
line [] tangents(circle c1, circle c2, int i=0){
	line [] tmp;

	point V[]=homocenter(c1,c2);
	if (i==0) tmp=tangents(c1,V[0]);
	else if (V.length==2) tmp=tangents(c1,V[1]);

	return tmp;
}


//Trả về đường tròn tâm O đi qua A.
circle circle1p(point O, point A){
	return circle(O,abs(O-A));
}

//Đường tròn tâm O tiếp xúc với đường thẳng m
circle circlePL(point O, line m)
{	circle pl;
	if (O @ m == false) pl=circle(O,distance(O,m));
	return pl;
}

//Trả về tâm đường tròn 9 điểm của tam giác t.
point n9center(triangle t){
	real A = t.alpha(), B = t.beta(), C = t.gamma();
	return point(trilinear(t,Cos(B-C),Cos(C-A),Cos(A-B)));
}

//Trả về đường tròn 9 điểm của tam giác t
circle n9circle(triangle t){
	return circle1p(n9center(t),midpoint(t.BC));
}

//Trả về tâm đường tròn Mixtilinear
//http://mathworld.wolfram.com/MixtilinearIncircles.html
point mixcenter(point A, point B, point C){
	triangle t=triangle(A,B,C);
	real A = t.alpha(), B = t.beta(), C = t.gamma();
	return point(trilinear(t,(1+Cos(A)-Cos(B)-Cos(C))/2,1,1));
}

//Trả về bán kính đường tròn Mixtilinear
real mixradius(point A, point B, point C){
	triangle t=triangle(A,B,C);
	real A = t.alpha();
	return(incircle(t).r/(Cos(A/2)^2));
}

//Trả về tâm đường tròn Mixtilinear theo cạnh
point mixcenter(side side){
	point op;
	triangle t = side.t;
	int n = abs(side.n) - 1;
	if(n == 1) op = mixcenter(t.A, t.B, t.C);
	else if(n == 2) op = mixcenter(t.B, t.C, t.A);
	else op = mixcenter(t.C, t.A, t.B);
	return op;
}

//Trả về đường tròn Mixtilinear theo cạnh
circle mixcircle(side side){
	circle ci;
	triangle t = side.t;
	int n = abs(side.n) - 1;
	if(n == 1) ci = circle(mixcenter(t.A,t.B,t.C),mixradius(t.A,t.B,t.C));
	else  if(n == 2) ci = circle(mixcenter(t.B,t.C,t.A),mixradius(t.B,t.C,t.A));
	else ci = circle(mixcenter(t.C,t.A,t.B),mixradius(t.C,t.A,t.B));
	return ci;
}


//Nagel point
point nagel(triangle t){
//	real a=t.a(), b=t.b(), c=t.c();
	real f(real a, real b, real c){
		return (b+c-a)/a;
	}
	return point(trilinear(t,f));
}


//http://mathworld.wolfram.com/FeuerbachTriangle.html
//-Sin^2((B-C)/2):Cos^2((C-A)/2):Cos^2((A-B)/2)
point Fapoint(triangle t) {
	//real a=t.a(), b=t.b(), c=t.c();
	real A = t.alpha(), B = t.beta(), C = t.gamma();
	return point(trilinear(t,-Sin(B/2-C/2)^2,Cos(C/2-A/2)^2,Cos(A/2-B/2)^2));
}

point Feexpoint(point A, point B, point C) {
	triangle t=triangle(A,B,C);
	real A = t.alpha(), B = t.beta(), C = t.gamma();
	return point(trilinear(t,-Sin(B/2-C/2)^2,Cos(C/2-A/2)^2,Cos(A/2-B/2)^2));
}


path arcex(point O, point A, point B, int a=10, real b=a){
	return arc((pair)O,rotate(-a,O)*(pair)A,rotate(b,O)*(pair)B);
}