//Một số hàm asymptote.
//Version 2 of 01/01/2020
//Quân.T nhóm Quán Hình. email: quanhinh9@gmail.com
//https://www.facebook.com/groups/205466756603509/
//http://asymptote.sourceforge.net/doc/index.html

//Phép vị tự
transform scale(pair center, real k){
	return shift(center)*scale(k)*shift(-center);
}

//Phép nghịch đảo
pair inverse(real k, pair A, pair M){
	return A + k/conj(M - A);
}

//Trọng tâm G
pair centroid(pair A,pair B,pair C){
	return (A+B+C)/3;
}

//Hình chiếu vuông góc của điểm P lên AB
pair projection(pair P, pair A, pair B){
	return midpoint(P--reflect(A,B)*P);
}

//Trực tâm H của tam giác ABC
pair orthocenter(pair A, pair B, pair C){
	return extension(B, reflect(C,A)*B, C, reflect(A,B)*C);
}

//Đường tròn tâm O, bán kính OA	
path circle1p(pair O, pair A){
	return circle(O,abs(O-A));
}

//Đường tròn đường kính AB
path circle2p(pair A, pair B){
	return circle(midpoint(A--B),abs(midpoint(A--B)-A));
}

//Tâm ngoại tiếp O của tam giác ABC
pair center3p(pair A, pair B, pair C){
	pair mAB=midpoint(A--B);
	pair mAC=midpoint(A--C);
	return extension(mAB, rotate(90,mAB)*A, mAC, rotate(90,mAC)*A);
}

//Đường tròn ngoại tiếp của tam giác ABC
path circle3p(pair A, pair B, pair C){
	pair O=center3p(A,B,C);
	return circle(O, abs(O-A));
}

//Tâm nội tiếp I
pair incenter(pair A, pair B, pair C)
{
	return extension(A, A+dir(A--B,A--C), B, B+dir(B--A,B--C));
}

//Đường tròn nội tiếp của tam giác ABC
path incircle(pair A, pair B, pair C)
{
	pair I=incenter(A,B,C);
	return circle(I, abs(I-projection(I,B,C)));
}

//Tâm bàng tiếp Ia
pair excenter(pair A, pair B, pair C){
   	return extension(B, B+rotate(90)*dir(B--A,B--C),C, C+rotate(90)*dir(C--A,C--B));
}

// Đường tròn bàng tiếp
path excircle(pair A, pair B, pair C)
{
	pair Ia=excenter(A,B,C);
	return circle(Ia, abs(Ia-projection(Ia,B,C)));
}  

//Điểm liên hợp đẳng giác của P đối với tam giác ABC
pair isoconj(pair P, pair A, pair B, pair C){
	pair I=incenter(A,B,C);
	return extension(B, reflect(B,I)*P, C, reflect(C,I)*P);
}

//Tâm đường tròn Mixtilinear nội
pair inmixcenter(pair A, pair B, pair C){
	pair I=incenter(A, B,C);
	pair Z=extension(A, B, I, rotate(90,I)*A);
	return extension(A, I, Z, rotate(90,Z)*A);
}

//Tiếp điểm của đường tròn Mixtilinear nội
pair inmixt(pair A, pair B, pair C){
	pair I=incenter(A,B,C);
	pair P=midpoint(I--excenter(A,B,C));
	pair O=center3p(A,B,C);
	pair Q=rotate(180,O)*P;
	return extension(Q, I, O, inmixcenter(A,B,C));
}

//Đường tròn Mixtilinear nội
path inmixcircle(pair A, pair B, pair C){
	pair I=incenter(A, B,C);
	pair Z=extension(A, B, I, rotate(90,I)*A);
	pair K=extension(A, I, Z, rotate(90,Z)*A);
	return circle(K, abs(K-Z));
}

//Tâm Mixtilinear ngoại
pair exmixcenter(pair A, pair B, pair C){
	pair Ia=excenter(A, B,C);
	pair Z=extension(A, B, Ia, rotate(90,Ia)*A);
	return extension(A, Ia, Z, rotate(90,Z)*A);
}

//Tiếp điểm Mixtilinear ngoại
pair exmixt(pair A, pair B, pair C){
	pair Ia=excenter(A, B,C);
	pair P=midpoint(incenter(A,B,C)--Ia);
	pair O=center3p(A,B,C);
	pair Q=rotate(180,O)*P;
	return extension(Q,Ia,O,exmixcenter(A,B,C));
}

//Đường tròn Mixtilinear ngoại
path exmixcircle(pair A, pair B, pair C){
	pair Ia=excenter(A,B,C);
	pair Z=extension(A, B, Ia, rotate(90,Ia)*A);
	pair Ka=extension(A, Ia, Z,rotate(90,Z)*A);
	return circle(Ka, abs(Ka-Z));
}

//Gergonne Point Ge
pair gepoint(pair A, pair B, pair C){
	pair I=incenter(A,B,C);
	return extension(B, projection(I,C,A), C, projection(I,A,B));
}

//Nine Point Center N9
pair n9point(pair A, pair B, pair C){
	return midpoint(orthocenter(A,B,C)--center3p(A,B,C));
}

//Đường tròn Nine Point - Euler
path n9circle(pair A, pair B, pair C){
	pair N9=n9point(A,B,C);
	return circle(N9,abs(N9-midpoint(B--C)));
}

//Điểm Feuerback nội Fe
pair fepoint(pair A, pair B, pair C){
	pair M=midpoint(B--C);
	pair I=incenter(A, B,C);
	pair D=midpoint(I--reflect(B,C)*I);
	pair D1=reflect(A,I)*D;
	return reflect(I, reflect(M,D1)*I)*D1;
    //return intersectionpoint(n9circle(A,B,C),incircle(A,B,C));
}

//Điểm Feuerback ngoại Fa
pair feexpoint(pair A, pair B, pair C){
	pair M=midpoint(B--C);
	pair Ia=excenter(A, B,C);
	pair Da=midpoint(Ia--reflect(B,C)*Ia);
	pair D1=reflect(A,Ia)*Da;
	return reflect(Ia, reflect(M,D1)*Ia)*D1;
    //return intersectionpoint(n9circle(A,B,C),excircle(A,B,C));
}

//Nagel Point Na
pair napoint(pair A,pair B,pair C){
	pair E=projection(excenter(B,C,A),C,A);
	pair F=projection(excenter(C,A,B),A,B);
	return extension(B, E, C, F);
}

//Spieker Point Sp
pair sppoint(pair A,pair B,pair C){	
	pair Ma=midpoint(B--C);
	pair Mb=midpoint(C--A);
	pair Mc=midpoint(A--B);
	return incenter(Ma, Mb, Mc);
}

//Kosnita Point Ka
pair kapoint(pair A,pair B,pair C){	
	pair O=center3p(A,B,C);
	return extension(B, center3p(O,C,A), C, center3p(O,A,B));
}

//Schiffler Point Sc
pair scpoint(pair A,pair B,pair C){	
	pair I=incenter(A,B,C);
	return extension(orthocenter(A,B,C), center3p(A,B,C), orthocenter(I,B,C), center3p(I,B,C));
}

//Lemoine Point Le
pair lepoint(pair A,pair B,pair C){	
	return isoconj(centroid(A,B,C), A, B, C);
}

//Humpty Point Hm
pair hmpoint(pair A, pair B, pair C){
	return projection(orthocenter(A,B,C), A, midpoint(B--C));
}

//Mittenpunkt Point Mi
pair mipoint(pair A,pair B, pair C){
	pair G=centroid(A,B,C);
	pair Ge=gepoint(A,B,C);
	return scale(Ge, 3/2)*G;
}

//Điểm Steiner của tam giác ABC
//https://en.wikipedia.org/wiki/Steiner_point_(triangle)
pair steinerpoint(pair A,pair B, pair C){
	pair O=center3p(A,B,C);
	pair Le=lepoint(A,B,C);
	pair Oa=reflect(B,C)*O; pair La=reflect(B,C)*Le;
	pair Ob=reflect(C,A)*O; pair Lb=reflect(C,A)*Le;
	pair Oc=reflect(A,B)*O; pair Lc=reflect(A,B)*Le;
	pair E=extension(Oa, La, Oc, Lc);
	pair F=extension(Oa, La, Ob, Lb);
	return extension(B, E, C, F);
}

//Điểm Anti-Steiner của P đối với tam giác ABC
pair antisteinerpoint(pair P, pair A, pair B, pair C){
	pair H=orthocenter(A,B,C);
	return extension(reflect(C,A)*H, reflect(C,A)*P, reflect(A,B)*H, reflect(A,B)*P);
}

//Lấy điểm N sao cho MN || AB
pair parallel(pair M, pair A, pair B){
	return rotate(90,M)* reflect(A,B)*M;
}

//Lấy điểm N sao cho MN vuông góc với AB
pair perpendicular(pair M, pair A, pair B){
	pair Mp = projection(M,A,B);
	pair A=Mp == A ? B : A;
	return rotate(90,Mp)*A;
}

//Đường thẳng AB
path lineex(pair A, pair B, real a=0.1, real b=a){
	return (a*(A-B)+A)--(b*(B-A)+B);
}

//Trả về điểm trên trung trực đoạ n AB
pair midline(pair A, pair B){
	return rotate(90,midpoint(A--B))*A;
}

//Cung AB + 10^o
path arcex(pair O, pair A, pair B, int a=10, real b=a){
	return arc(O,rotate(-a,O)*A,rotate(b,O)*B);
}
