depgraph = function(v, d, GR = NULL, solver = "glpk", approximate = 1) {
		   	
	n_tot = nrow(v)

	n_dec = (n_tot*(n_tot-1))-sum(1:(n_tot-1))
	
	cvec = t(v)[lower.tri(v)]
		
	if (length(d)==1) {
		rows_d_sca = rep(1, n_dec)
		cols_d_sca = 1:n_dec	
		vals_d_sca = rep(1, n_dec)	
		row_count = max(rows_d_sca)
	}
	if (length(d)>1) {
		rows_d_vec = sort(rep(1:n_tot, n_tot-1))
		temp = matrix(0, nrow = n_tot, ncol = n_tot)
		temp[lower.tri(temp)] = 1:n_dec
		temp = temp+t(temp)
		diag(temp) = NA
		cols_d_vec = as.vector(t(temp))	
		cols_d_vec = cols_d_vec[!is.na(cols_d_vec)]
		vals_d_vec = rep(1, (n_tot-1)*n_tot)	
		row_count = max(rows_d_vec)
	}

	if (!is.null(GR)) {
		temp1 = GR[lower.tri(GR)]
		cols_GR = which(temp1==1)
		rows_GR = (row_count+1):(row_count+length(cols_GR)) 
		aux = rep(1, (n_tot-1)*n_tot)
		vals_GR = aux[cols_GR] 
		row_count = max(rows_GR)
	}
	
	if (length(d)==1 & is.null(GR)) {
		rows = c(rows_d_sca)
		cols = c(cols_d_sca)
		vals = c(vals_d_sca)
		aux = cbind(rows, cols, vals)[order(cols), ]
		cnstrn_mat = simple_triplet_matrix(i = aux[, 1], j = aux[, 2], v = aux[, 3])
		Amat = cnstrn_mat
	}
	if (length(d)>1 & is.null(GR)) {
		rows = c(rows_d_vec)
		cols = c(cols_d_vec)
		vals = c(vals_d_vec)
		aux = cbind(rows, cols, vals)[order(cols), ]
		cnstrn_mat = simple_triplet_matrix(i = aux[, 1], j = aux[, 2], v = aux[, 3])
		Amat = cnstrn_mat
	}
	if (length(d)==1 & !is.null(GR)) {
		rows = c(rows_d_sca, rows_GR)
		cols = c(cols_d_sca, cols_GR)
		vals = c(vals_d_sca, vals_GR)
		aux = cbind(rows, cols, vals)[order(cols), ]
		cnstrn_mat = simple_triplet_matrix(i = aux[, 1], j = aux[, 2], v = aux[, 3])
		Amat = cnstrn_mat
	}
	if (length(d)>1 & !is.null(GR)) {
		rows = c(rows_d_vec, rows_GR)
		cols = c(cols_d_vec, cols_GR)
		vals = c(vals_d_vec, vals_GR)
		aux = cbind(rows, cols, vals)[order(cols), ]
		cnstrn_mat = simple_triplet_matrix(i = aux[, 1], j = aux[, 2], v = aux[, 3])
		Amat = cnstrn_mat
	}
	
	if (is.null(GR)) {
		bvec = d
	}
	if (!is.null(GR)) {
		bvec = c(d, rep(1, length(rows_GR)))	
	}	
	
	ub = rep(1, n_dec)
	
	if (is.null(GR)) {
		sense = rep("L", length(d))
	}
	if (!is.null(GR)) {
		sense = c(rep("L", length(d)), rep("E", length(rows_GR)))	
	}
	
	if (approximate == 1) {
		var_type = rep("C", n_dec)
	}
	else if (approximate == 0) {
		var_type = rep("B", n_dec)
	}
	
	if (solver=="cplex") {
		if (requireNamespace('Rcplex', quietly=TRUE)) {

			ptm = proc.time()
			out = Rcplex::Rcplex(cvec, Amat, bvec, ub = ub, sense = sense, vtype = var_type, objsense = "max", control = list(trace = 0, round = 1))
			time = (proc.time()-ptm)[3]
		
			i_ind = rep(1:(n_tot-1), (n_tot-1):1)	
			aux = matrix(1:n_tot, nrow = n_tot, ncol = n_tot)
			j_ind = aux[lower.tri(aux)]

			if (approximate == 1) {
				group_1 = i_ind[out$xopt!=0]
				group_2 = j_ind[out$xopt!=0]
				approx_sol = out$xopt
			}
			else if (approximate == 0) {
				group_1 = i_ind[out$xopt==1]
				group_2 = j_ind[out$xopt==1]
			}
	
			obj_val = out$obj	
		}
	}
	else if (solver=="gurobi") {
		if (requireNamespace('gurobi', quietly=TRUE)) {

			model = list()
			model$obj = cvec
			model$A = Amat
			model$sense = rep(NA, length(sense))
			model$sense[sense=="E"] = '='
			model$sense[sense=="L"] = '<='
			model$sense[sense=="G"] = '>='
			model$rhs = bvec
			model$vtype = var_type
			model$ub = ub
			model$modelsense = "max"
			
t_max = 60*60*12
trace = 0
			t_lim = list(TimeLimit = t_max, OutputFlag = trace)
	
			ptm = proc.time()
			out = gurobi::gurobi(model, t_lim)
			time = (proc.time()-ptm)[3]
		
			i_ind = rep(1:(n_tot-1), (n_tot-1):1)	
			aux = matrix(1:n_tot, nrow = n_tot, ncol = n_tot)
			j_ind = aux[lower.tri(aux)]

			if (approximate == 1) {
				group_1 = i_ind[out$x!=0]
				group_2 = j_ind[out$x!=0]
				approx_sol = out$x
			}
			else if (approximate == 0) {
				group_1 = i_ind[out$x==1]
				group_2 = j_ind[out$x==1]
			}
		
			obj_val = out$objval
		}
	}
	if (solver=="glpk") {

    	dir = rep(NA, length(sense))
    	dir[sense=="E"] = '=='
    	dir[sense=="L"] = '<='
    	dir[sense=="G"] = '>='
   		bound = list(lower = list(ind=c(1:length(ub)), val=rep(0,length(ub))), upper = list(ind=c(1:length(ub)), val=ub))
    
   		ptm = proc.time()
    	out = Rglpk_solve_LP(cvec, Amat, dir, bvec, bounds = bound, types = var_type, max = TRUE)
    	time = (proc.time()-ptm)[3]

		i_ind = rep(1:(n_tot-1), (n_tot-1):1)	
		aux = matrix(1:n_tot, nrow = n_tot, ncol = n_tot)
		j_ind = aux[lower.tri(aux)]

		if (approximate == 1) {
			group_1 = i_ind[out$solution!=0]
			group_2 = j_ind[out$solution!=0]
			approx_sol = out$solution
		}
		else if (approximate == 0) {
			group_1 = i_ind[out$solution==1]
			group_2 = j_ind[out$solution==1]
		}
		    	
    	obj_val = out$optimum
	}	

	if (approximate == 1) {
		aux = matrix(0, nrow=n_tot, ncol=n_tot)
		aux[cbind(group_1, group_2)] = approx_sol[approx_sol!=0]
		A_max = aux+t(aux)
	}
	else if (approximate == 0) {
		max_groups = apply(cbind(group_1, group_2), 1, max)
		id_1 = group_1[max_groups<=n_tot]
		id_2 = group_2[max_groups<=n_tot]
		aux = matrix(0, nrow=n_tot, ncol=n_tot)
		aux[cbind(id_1, id_2)] = 1
		A_max = aux+t(aux)
	}
			
	return = list(A_max = A_max, obj_val = obj_val, time = time)
			   	
}