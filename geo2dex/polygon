import geometry;
unitsize(1cm);
defaultpen(fontsize(11pt));

struct polygon{
	point []v;
}

pen [] pc={red,green,blue,cyan,orange,purple,yellow,magenta,royalblue,olive};
pen [] qc;
for (int i=0; i<500; ++i){
	int k=i % 10;
	qc[i]=pc[k];
}

int n=100, k=11;
point O=(0,0); point A=(0,5);

polygon hp;
hp.v[0]=A;
for (int i=1; i<k;++i){
	hp.v[i]=rotate(360*i/k,O)*hp.v[0];
}

void draw(polygon hp){
	hp.v.push(hp.v[0]);
	for (int i=0; i<k; ++i) draw(hp.v[i]--hp.v[i+1],0.4qc[i]);
}

polygon rot(polygon hp, real m=0.98, real angle = 1){
	polygon tmp;
	for (int i=0; i<k;++i){
		tmp.v[i]=rotate(angle,O)*scale(m,O)*hp.v[i];
	}
	return tmp;
}

polygon poly(polygon hp, int n){
	if (n==1) return rot(hp);
	return rot(poly(hp,(n-1))); 
}

for (int i=1; i<n; ++i ) draw(poly(hp,i));
