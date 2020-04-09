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

//hline: cung geodesic đ qua A, B. A, B phân biệt và không trùng hc.C
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
