# depinf: "Confidence intervals for linear unbiased estimators under constrained dependence" 

This package implements the methods for constructing confidence intervals for linear unbiased estimators given constraints on units’ dependency graph described in Aronow, Crawford and Zubizarreta (n.d.). The primary function, depvar, produces conservative variance estimates for generic linear unbiased estimators 

To install the package, run:
'install.packages("devtools")
library("devtools")
install_github("jrzubizarreta/depinf")'

Replication materials for the regression analysis of the risk factors associated with HIV status reported in Aronow, Crawford and Zubizarreta (n.d.) are in the vignette: VIGNETTE

## Solver Details

Software is compatible with GLPK ("glpk", free), Gurobi ("gurobi", recommended), and CPLEX ("cplex"). By default, the package uses glpk which requires no additional setup or license. For installation of Gurobi, including the necessary associated R package (with free academic license), visit http://www.gurobi.com/index with instructions here: http://www.gurobi.com/documentation/6.0/quickstart_windows/creating_a_new_academic_li.html 
