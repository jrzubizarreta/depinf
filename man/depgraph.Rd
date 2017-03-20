\name{depgraph}

\alias{depgraph}

\title{Maximum Variance Adjacency Matrix}

\description{
	Function for finding the adjacency matrix that maximizes the variance of a mean estimate given general constraints on the degree of dependence of the observations.
}

\usage{
	depgraph(v, d, GR = NULL, solver = "glpk", approximate = 1)
}

\arguments{
	\item{v}{a matrix with the estimated (sample) covariance matrix.}

	\item{d}{a vector with the observed degree; if \code{length(d)=1} then \code{d} is the total number of non-zero (off-diagonal) elements of the adjancency matrix A (for solving a more relaxed version of the problem); if \code{length(d)=nrow(v)} then \code{d} is the total number of non-zero (off-diagonal) elements of each row of A.}

	\item{GR}{a matrix with the known dependencies.  The default is \code{GR = NULL}.}
	
	\item{solver}{a string with the optimization solver to be used.  The options are: \code{cplex}, \code{glpk} and \code{gurobi}.  The default solver is \code{glpk} but \code{cplex} or \code{gurobi} are much faster.  Note that \code{cplex} and \code{gurobi} require a license, which is free for people affiliated to universities, but not otherwise.  Between \code{cplex} and \code{gurobi}, the \code{gurobi} interface for R is much easier to install.}
	
	\item{approximate}{a scalar that determines whether an exact solution is to be found by solving the original integer programming problem (\code{approximate = 0}), or whether an approximate solution is to be obtained by solving the relaxed problem via linear programming (\code{approximate = 1}).  Of course, obtaining the approximate solution is faster but will result in more conservative variance estimates.  The default is \code{approximate = 1}.}
}

\value{
	A list with the following objects:
		
	\item{A_max}{adjacency matrix that maximizes the variance;}
	
	\item{obj_val}{objective value of the graph optimization problem at the optimum;}
	
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

################################# 
# General case
#################################

# Solve (5) in the paper
# Sample covariance matrix
my = mean(y)
v = outer(y-my, y-my)
# No known dependencies (so in (5) in the paper A_R (the matrix of known dependencies) is the n times n matrix of 0's)
A_max_gral_no_dep = depgraph(v, d, NULL, "glpk", 1)$A_max
# Some known dependencies
A_max_gral_some_dep = depgraph(v, d, GR, "glpk", 1)$A_max

################################# 
# Homoskedastic case
#################################

# Solve (8) in the paper
# No known dependencies (so in (8) in the paper A_R (the matrix of known dependencies) is the n times n matrix of 0's)
v = matrix(1, nrow=n, ncol=n)
A_max_homo_no_dep = depgraph(v, d, NULL, "glpk", 0)$A_max
# Some known dependencies
A_max_homo_some_dep = depgraph(v, d, GR, "glpk", 0)$A_max
	
}

\keyword{X}
\keyword{Y}
\keyword{Z}