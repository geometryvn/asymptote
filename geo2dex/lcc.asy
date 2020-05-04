import geometry;

struct lcc{
	int i; //i=1 pa, i=0, line l
	parabola pa;
	line l;
}

//Trả về 02 parabola là tập hợp tâm các đường tròn tiếp xúc với đường thẳng m và đường tròn c
lcc [] locuslc(line m, circle c){
	lcc [] tmp;
	line n=perpendicular(c.C,m);
	point []p=intersectionpoints(n,c);
	point q=intersectionpoint(n,m);
	point []v; //Đỉnh của parabola
	for (int i=0; i<p.length;++i) {
		lcc px;
		v[i]=0.5(q+p[i]);
		if (v[i] == c.C) {
			px.i=0;
			px.l=n;
		} else {
			px.i=1;
			px.pa=parabola(c.C,v[i]);
		}
		
		tmp.push(px);
	
	}
	return tmp;
}

//Giao của hai lcc
point [] ips(lcc la, lcc lb){
	point [] tmp;
	
	if (la.i==0 & lb.i==0){
		tmp.push(intersectionpoint(la.l,lb.l));
	}
	
	if (la.i==0 & lb.i==1){
		point [] t=intersectionpoints(la.l,lb.pa);
		for(int i=0; i<t.length; ++i) tmp.push(t[i]);
	}
	
	if (la.i==1 & lb.i==0){
		point [] t=intersectionpoints(la.pa,lb.l);
		for(int i=0; i<t.length; ++i) tmp.push(t[i]);
	}
	
	if (la.i==1 & lb.i==1){
		point [] t=intersectionpoints(la.pa,lb.pa);
		for(int i=0; i<t.length; ++i) tmp.push(t[i]);
	}
	
	return tmp;
}

point [] ips(lcc [] la, lcc [] lb){
	point [] tmp;
	
	for (int i=0; i<la.length; ++i){
		for (int j=0; j<lb.length; ++j){
			point [] t = ips(la[i],lb[j]);
			for (int k=0; k<t.length;++k) tmp.push(t[k]);
		}
	}
	
	for (int i=0; i<tmp.length; ++i){
		for(int j=i+1; j<tmp.length; ++j){
			if (tmp[j] == tmp[i]) tmp.delete(j);
		}
	}
	
	return tmp;
}

//Trả về tâm các đường tròn tiếp xúc với m, ca, cb
point [] lcccenter(line m, circle ca, circle cb){
	point [] tmp;
	lcc [] la=locuslc(m,ca), lb=locuslc(m,cb);
	point []p=ips(la,lb);

	for (int i=0; i<p.length; ++i){
		if (p[i] @ m ==false) tmp.push(p[i]);
	}

    //Loại các tâm trùng nhau
	for (int i=0; i<tmp.length; ++i){
		for(int j=i+1; j<tmp.length; ++j){
			if (tmp[j] == tmp[i]) tmp.delete(j);
		}
	}
	
    //Loại tâm trùng với các tâm của ca, cb
	for (int i=0; i<tmp.length; ++i){
		if (tmp[i]==ca.C | tmp[i]==cb.C) tmp.delete(i);
	}

	return tmp;
}

circle [] tangents(line m, circle ca, circle cb){
	circle [] tmp;
	point [] center=lcccenter(m,ca,cb);
	for (int i=0; i<center.length; ++i) tmp.push(circle(center[i],distance(center[i],m)));
	return tmp;
}
