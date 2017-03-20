\name{depvar}

\alias{depvar}

\title{Variance Estimates for Means with Constrained Dependent Observations}

\description{
	Function for variance estimates of a mean given general constraints on the degree of dependence of the observations.
}

\usage{
	depvar(y, theta, d, GR = NULL, case = "heteroskedastic", solver = "glpk", approximate = 1)
}

\arguments{
	\item{y}{a vector with the outcome variable.}
	
	\item{theta}{a vector with the coefficients or weights.}

	\item{d}{a vector with the observed degree; if \code{length(d)=1} then \code{d} is the total number of non-zero (off-diagonal) elements of the adjancency matrix A (for solving a more relaxed version of the problem); if \code{length(d)=nrow(v)} then \code{d} is the total number of non-zero (off-diagonal) elements of each row of A.}

	\item{GR}{a matrix with the known dependencies.  The default is \code{GR = NULL}.}
	
	\item{case}{a string with the variance estimate to be calculated.  If \code{case = heteroskedastic}, then (1) in section 3.1 of Aronow et al. (2016) is calculated.  If \code{case = homoskedastic} and \code{GR} is not \code{NULL}, then (7) in section 3.2 of the same paper is calculated.  Finally, if \code{case = homoskedastic} and \code{GR} is \code{NULL}, (9) is calculated.}
	
	\item{solver}{a string with the optimization solver to be used.  The options are: \code{cplex}, \code{glpk} and \code{gurobi}.  The default solver is \code{glpk} but \code{cplex} or \code{gurobi} are much faster.  Note that \code{cplex} and \code{gurobi} require a license, which is free for people affiliated to universities, but not otherwise.  Between \code{cplex} and \code{gurobi}, the \code{gurobi} interface for R is much easier to install.}
	
	\item{approximate}{a scalar that determines whether an exact solution is to be found by solving the original integer programming problem (\code{approximate = 0}), or whether an approximate solution is to be obtained by solving the relaxed problem via linear programming (\code{approximate = 1}).  Of course, obtaining the approximate solution is faster but will result in more conservative variance estimates.  The default is \code{approximate = 1}.}
}

\value{
	A list with the following objects:
	
	\item{V_hat}{the variance estimate;}
	
	\item{A_max}{adjacency matrix that maximizes the variance;}
	
	\item{obj_val}{the objective value of the graph optimization problem at the optimum;}
	
	\item{time}{time elapsed to find the optimal solution.}
}

\references{
	Aronow, P. M., Crawford, F. W., and Zubizarreta, J. R., (2017), "Confidence intervals for linear unbiased estimators under constrained dependence," \emph{submitted}, X, X-X.
}

\author{
	Peter M. Aronow <peter.aronow@yale.edu>, Forrest W. Crawford <forrest.crawford@yale.edu>, Jose R. Zubizarreta <zubizarreta@columbia.edu>.
}

\examples{

################################# 
# Data
#################################

# Example with 100 nodes
data(example)

# Total number of observations
n = nrow(dat)

# Observed data 
# Observed dependencies (observed (known) a_ij's; this is A_R in (5) in the paper)
GR = GR
# Observed degrees
d = dat$degree
# Observed outcomes
y = dat$hiv
# Coefficients or weights
theta = rep(1, length(y))

################################# 
# Heteroskedastic case, solve (5) in the paper
#################################

# No known dependencies (so in (5) in the paper A_R (the matrix of known dependencies) is the n times n matrix of 0's)
depvar(y, theta, d, NULL, case = "heteroskedastic", solver = "glpk", approximate = 1)$V_hat

# Some known dependencies
depvar(y, theta, d, GR, case = "heteroskedastic", solver = "glpk", approximate = 1)$V_hat

################################# 
# Homoskedastic case, solve (8) in the paper
#################################

# Some known dependencies
depvar(y, theta, d, GR, case = "homoskedastic", solver = "glpk", approximate = 1)$V_hat

# Compare to the more conservative variance estimate from (9) in the paper
depvar(y, theta, d, NULL, case = "homoskedastic")$V_hat
var(y * theta)/n * (1 + sum(pmin(d, n-1))/n) 
	
}

\keyword{X}
\keyword{Y}
\keyword{Z}