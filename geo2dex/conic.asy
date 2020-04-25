import geometry;

//Coefficients of the conic equation to matrix 3x3
real [][] tomatrix(conic c){
	real []a = equation(c).a;
	real [][] m={{a[0], a[1]/2, a[3]/2},{a[1]/2, a[2], a[4]/2},{a[3]/2, a[4]/2, a[5]}};
	return m;
}

//adjugate matrix
real [][] adjmatrix(real [][] m){
	real [][] adj= {{m[1][1]*m[2][2] - m[1][2]*m[2][1], m[0][2]*m[2][1]- m[0][1]*m[2][2], m[0][1]*m[1][2]-m[0][2]*m[1][1]}, {m[1][2]*m[2][0] - m[1][0]*m[2][2], m[0][0]*m[2][2]- m[0][2]*m[2][0], m[0][2]*m[1][0]-m[0][0]*m[1][2]}, {m[1][0]*m[2][1] - m[1][1]*m[2][0], m[0][1]*m[2][0]- m[0][0]*m[2][1], m[0][0]*m[1][1]-m[0][1]*m[1][0]}};
	return adj;
}

void print(point o, real [][] mt){
	for (int i=0; i<=2; ++i){
		for (int j=0; j<=2; ++j) label(format("%f",mt[i][j]),(2*j+o.x,-i+o.y));
	}
}

//multiply matrix
real [][] multiply(real [][] a, real [][] b){
	real [][] tmp = new real[3][3];
	for (int i = 0; i <=2; ++i){
		for (int j = 0; j <=2; ++j){
			tmp[i][j] = 0; 
			for (int k = 0; k <=2; ++k) tmp[i][j] += a[i][k]*b[k][j]; 
		} 
	} 
	return tmp;
}

//matrix 3x3 to coefficients of the conic equation
real [] tocoefs(real [][] z){
	real [] a = {z[0][0],2*z[0][1],z[1][1],2*z[0][2],2*z[1][2],z[2][2]};
	return a;
}

//Common tangent two conics
line [] tangents(conic cm, conic cn){
	line [] tmp;
	real [][] m = tomatrix(cm), n = tomatrix(cn);
	real [] mc=tocoefs(adjmatrix(m)), nc=tocoefs(adjmatrix(n));
	bqe bm=bqe(mc[0],mc[1],mc[2],mc[3],mc[4],mc[5]);
	bqe bn=bqe(nc[0],nc[1],nc[2],nc[3],nc[4],nc[5]);
	point []p=intersectionpoints(conic(bm),conic(bn));
	
	for (int i=0; i<p.length; ++i) tmp.push(line(p[i].x,p[i].y,1));
	return tmp;
}
