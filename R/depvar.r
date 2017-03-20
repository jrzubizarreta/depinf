depvar = function(y, theta, d, GR = NULL, case = "heteroskedastic", solver = "glpk", approximate = 1) {

	.errorhandle(y, theta, d, GR, case, solver, approximate)

	x = as.vector(y*theta)
		
	# Estimator V_1 in the paper
	V1 = function(A, x) {
		mx = mean(x)
		n = nrow(A)
		V1_hat = as.numeric( var(x)/n + (t(x-mx) %*% A %*% (x-mx))/(n^2) )
		return(V1_hat) 
	}

	# Estimator V_2 in the paper
	V2 = function(A, x) {
		mx = mean(x)
		n = nrow(A)
		V2_hat = as.numeric( var(x)/n * (1 + sum(A)/n) )
		return(V2_hat) 
	}
		
	# Estimator V_2' in the paper
	V2p = function(d, x) {
		mx = mean(x)
		n = length(d)
		V2_hat = as.numeric( var(x)/n * (1 + sum(pmin(d, n-1))/n) )
		return(V2_hat) 
	}
	
	if (case=="heteroskedastic") {
		mx = mean(x)
		v = outer(x-mx, x-mx)
		out = depgraph(v, d, GR, solver, approximate)
		A_max = out$A_max
		obj_val = out$obj_val
		time = out$time
	}
	else if (case=="homoskedastic") {
		n = length(x)
		v = matrix(1, nrow=n, ncol=n)
		out = depgraph(v, d, GR, solver, approximate)
		A_max = out$A_max
		obj_val = out$obj_val
		time = out$time
	}	
		
	if (case=="heteroskedastic") {
		V_hat = V1(A_max, x)
	}
	else if (case=="homoskedastic") {
		V_hat = V2(A_max, x)
	}
	else if (case=="homoskedastic, worst") {
		V_hat = V2p(d, x) 
	}
	
	return(list(V_hat = V_hat, A_max = A_max, obj_val = obj_val, time = time))
		
}