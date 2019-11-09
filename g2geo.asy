import geometry;

//Đường tròn tâm O, bán kinh OA
circle g2circle1p(point O, point A)
{
	return circle(O,abs(O-A));
}

path g2line(point A=(0,0), point B=(0,0), real a=0.1, real b=a)
{
	return (a*(A-B)+A)--(b*(B-A)+B);
}

//Đường tròn tâm O tiếp xúc với đường thẳng m
circle g2circlePL(point O, line m)
{	circle pl;
	if (O @ m == false) pl=circle(O,distance(O,m));
	return pl;
}

//Trung điểm cung BC
point g2midarc(point O, point B, point C)
{
	return midpoint(arc((pair)O,(pair)B,(pair)C));
}

//Cung AB + 10^o
path g2arc(point O, point A, point B, int a=10, real b=a)
{
	pair o=O, a=rotate(-a,o)*A, b=rotate(b,o)*B;
	return arc(o,a,b);
}
