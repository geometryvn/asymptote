struct ccc{
	int i;
	hyperbola hp; //i=1
	ellipse el; //i=-1
	line l; //i=0
}

point[] intersectionpoints(line l, hyperbola h){
	point[] op;
	coordsys R = coordsys(h);
	point A = intersectionpoint(l, h.A1), B = intersectionpoint(l, h.A2);
	point M = .5 *(A+B);
	
	bool tgt = M @ h;
	
	if(tgt) {
		if(M @ l) op.push(M);
	} else {
		real[] eq = changecoordsys(defaultcoordsys, equation(h)).a;
		pair[] tp = intersectionpoints(locate(l.A), locate(l.B), eq);
		point inter;
		for (int i = 0; i < tp.length; ++i) {
			inter = point(R, tp[i]/R);
			if(inter @ l) op.push(inter);
		}
	}
	
	return op;
}

point[] intersectionpoints(hyperbola h, line l){
	return intersectionpoints(l,h);
}

ccc [] locuscc(circle ca, circle cb){
	ccc [] tmp;
	if (abs(ca.r-cb.r)<epsgeo){
		ccc t;
		t.i=0;
		t.l = bisector(ca.C,cb.C);
		tmp.push(t);
	} else{
		real m=abs(ca.r-cb.r)/2, n=abs(ca.r+cb.r)/2;
		ccc tm,tn;
		if (epsgeo< abs(ca.C-cb.C)-2*m){
			tm.i=1;
			tm.hp=hyperbola(ca.C,cb.C,m);
		} else if (2*m-abs(ca.C-cb.C)>epsgeo){
			tm.i=-1;
			tm.el=ellipse(ca.C,cb.C,m);
		} else {
			tm.i=0;
			tm.l=line(ca.C,cb.C);
		}
		tmp.push(tm);
		
		if (epsgeo < abs(ca.C-cb.C)-2*n){
			tn.i=1;
			tn.hp=hyperbola(ca.C,cb.C,n);
		} else if (2*n-abs(ca.C-cb.C)>epsgeo){
			tn.i=-1;
			tn.el=ellipse(ca.C,cb.C,n);
		} else {
			tn.i=0;
			tn.l=line(ca.C,cb.C);
		}
		tmp.push(tn);
	}
	return tmp;
}

point [] ips(ccc la, ccc lb){
	point [] tmp;
	
	if (la.i==0 & lb.i==0){
		tmp.push(intersectionpoint(la.l,lb.l));
	}
	
	if (la.i==0 & lb.i==1){
		point [] t=intersectionpoints(la.l,lb.hp);
		for(int i=0; i<t.length; ++i) tmp.push(t[i]);
	}
	
	if (la.i==0 & lb.i==-1){
		point [] t=intersectionpoints(la.l,lb.el);
		for(int i=0; i<t.length; ++i) tmp.push(t[i]);
	}
	
	if (la.i==1 & lb.i==0){
		point [] t=intersectionpoints(la.hp,lb.l);
		for(int i=0; i<t.length; ++i) tmp.push(t[i]);
	}
	
	if (la.i==1 & lb.i==1){
		point [] t=intersectionpoints(la.hp,lb.hp);
		for(int i=0; i<t.length; ++i) tmp.push(t[i]);
	}
	
	if (la.i==1 & lb.i==-1){
		point [] t=intersectionpoints(la.hp,lb.el);
		for(int i=0; i<t.length; ++i) tmp.push(t[i]);
	}
	
	if (la.i==-1 & lb.i==0){
		point [] t=intersectionpoints(la.el,lb.l);
		for(int i=0; i<t.length; ++i) tmp.push(t[i]);
	}
	
	if (la.i==-1 & lb.i==1){
		point [] t=intersectionpoints(la.el,lb.hp);
		for(int i=0; i<t.length; ++i) tmp.push(t[i]);
	}
	
	if (la.i==-1 & lb.i==-1){
		point [] t=intersectionpoints(la.el,lb.el);
		for(int i=0; i<t.length; ++i) tmp.push(t[i]);
	}
	
	return tmp;

}

point [] ips(ccc [] la, ccc [] lb){
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

bool check(point p, ccc la){
	bool tmp=false;
	if (la.i==0) {
		if (p @ la.l) tmp=true;
	}
	
	if (la.i==1) {
		if (p @ la.hp) tmp=true;
	}
	
	if (la.i==-1) {
		if (p @ la.el) tmp=true;
	}
	return tmp;
}

//Trả về tâm các đường tròn tiếp xúc với ca, cb, cc
point [] ccccenter(circle ca, circle cb, circle cc){
	point [] tmp;
	ccc [] lab=locuscc(ca,cb), lac=locuscc(ca,cc), lbc=locuscc(cb,cc);
	point []p=ips(lab,lac);
	
	for (int i=0; i<p.length; ++i){
		for (int j=0; j<lbc.length; ++j){
			if (check(p[i],lbc[j])) tmp.push(p[i]);
		}
	}
	
	for (int i=0; i<tmp.length; ++i){
		for(int j=i+1; j<tmp.length; ++j){
			if (tmp[j] == tmp[i]) tmp.delete(j);
		}
	}
	//Loại tâm trùng với các tâm của ca, cb,
	for (int i=0; i<tmp.length; ++i){
		if (tmp[i]==ca.C | tmp[i]==cb.C | tmp[i]== cc.C) tmp.delete(i);
	}
	
	return tmp;
}

//Trả về các đường tròn tâm p, tiếp xúc với c
circle [] circlepc(point p, circle c){
	circle [] tmp;
	point [] t=intersectionpoints(line(c.C,p),c);
	for(int i=0; i<t.length;++i){
		if (abs(p-t[i])>epsgeo) tmp.push(circle(p,abs(p-t[i])));
	} 
	return tmp;
}

bool tangent(circle ca, circle cb){
	bool tmp=false;
	real m=abs(ca.r+cb.r-abs(ca.C-cb.C)), n=abs(abs(ca.r-cb.r)-abs(ca.C-cb.C));
	if (m<epsgeo | n<epsgeo) tmp=true;
	return tmp;
}

//Trả về các đường tròn tiếp xúc với 3 đường tròn ca, cb, cc
circle [] tangents(circle ca, circle cb, circle cc){
	circle [] tmp;
	point [] cp=ccccenter(ca,cb,cc);
	for (int i=0; i<cp.length; ++i){
		circle []cx=circlepc(cp[i],ca);
		for (int j=0; j<cx.length; ++j){
			if (tangent(cx[j],cb) & tangent(cx[j],cc)) tmp.push(cx[j]);
		}
	}
	
	return tmp;
}
