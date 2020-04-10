//Hyperbolic geometry using the Poincaré disc model
//Tran Quan 012020
//Tham khảo: https://ium.mccme.ru/postscript/f10/geometry1-lect-7.pdf

import geometry;

//Định nghĩa đường tròn (hc)
circle hc=circle((point)(0,0),7); 

//Trả về đường tròn đi qua cung ar
circle circle(arc ar){
	point a=relpoint(ar,0), b=relpoint(ar,1), m=midpoint(ar);
	return circle(m,a,b);
}

//Định nghĩa struc hgeo. Biến finite được sử dụng điểm kiểm tra hgeo là đoạn thẳng seg hay cung tròn ar
struct hgeo{
	bool finite;
	arc ar;
	segment seg;
}

//hline: cung geodesic đi qua A, B. A, B phân biệt và không trùng hc.C
hgeo hline(point A, point B){
	hgeo tmp;
	if (hc.C @ line(A,B)==false){
		tmp.finite=true;
		point P=inversion(hc)*A, mp=midpoint(P--A);
		point j=intersectionpoint(bisector(A,B),perpendicular(mp,line(hc.C,A)));
		circle cp=circle(j,abs(j-A));
		
		point t[]=intersectionpoints(hc,cp);
		if (A @ arc(cp,t[0],t[1])) tmp.ar= arc(cp,t[0],t[1]);
		else tmp.ar=arc(cp,t[1],t[0]);
	} else {
		tmp.finite=false;
		point t[]=intersectionpoints(hc,line(A,B));
		tmp.seg=segment(t[0],t[1]);
	}
	
	return tmp;
}

//hsegment: đoạn geodesic đi qua A, B. A, B phân biệt và không trùng hc.C
hgeo hsegment(point A, point B){
	hgeo tmp;
	
	if (hc.C @ line(A,B)==false){
		tmp.finite=true;
		point P=inversion(hc)*A, mp=midpoint(P--A);
		point j=intersectionpoint(bisector(A,B),perpendicular(mp,line(hc.C,A)));
		circle cp=circle(j,abs(j-A));
		
		point M=midpoint(A--B);
		point N=intersectionpoint(M--hc.C,cp);
		if (N @ arc(cp,A,B)) tmp.ar= arc(cp,A,B);
		else tmp.ar=arc(cp,B,A);	
	} else {
		tmp.finite=false;
		tmp.seg=segment(A,B);
	}
	
	return tmp;
}

//Đường tròn tâm A đi qua B
circle hcircle(point A, point B){
	point P=inversion(hc)*A;
	point R=inversion(circle(A,P))*B;
	point N=intersectionpoint(bisector(segment(B,R)),line(hc.C,A));
	return circle(N,abs(N-B));
}

//Trung trực AB geodesic
// Không xét trường hợp A == B, A@ hc, B @ hc
hgeo hbisector(point A, point B){
	circle cA=hcircle(A,B), cB=hcircle(B,A);
	point p[]=intersectionpoints(cA,cB);
	return hline(p[0],p[1]);
}

//Trung điểm của geodesic AB
point hmidpoint(point A, point B){
	point tmp;
	hgeo lAB=hline(A,B), sAB=hbisector(A,B);
	if (lAB.finite && sAB.finite) tmp=intersectionpoint(lAB.ar,sAB.ar);
	if (lAB.finite && (sAB.finite==false)) tmp=intersectionpoints(lAB.ar,sAB.seg)[0];
	
	if ((lAB.finite==false) && sAB.finite) tmp=intersectionpoints(lAB.seg,sAB.ar)[0];
	if ((lAB.finite==false) && (sAB.finite==false)) tmp=intersectionpoint(lAB.seg,sAB.seg);
	
	return tmp;
}

//Tâm đường tròn ngoại tiếp tam giác ABC.
point hcenter(point A, point B, point C){
	point tmp;
	hgeo mCA=hbisector(C,A), mAB=hbisector(A,B);
	if (mCA.finite & mAB.finite) tmp=intersectionpoint(mCA.ar,mAB.ar);
	if (mCA.finite & (mAB.finite==false)) tmp=intersectionpoints(mCA.ar,mAB.seg)[0];
	
	if ((mCA.finite==false) & mAB.finite) tmp=intersectionpoints(mCA.seg,mAB.ar)[0];
	
	if ((mCA.finite==false) && (mAB.finite==false)) tmp=intersectionpoint(mCA.seg,mAB.seg);
	
	return tmp;
}

//Đường tròn ngoại tiếp tam giác ABC
circle hcircle(point A, point B, point C){
	return circle(A,B,C);
}

