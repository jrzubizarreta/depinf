# depinf: "Confidence intervals for linear unbiased estimators under constrained dependence" 

This package implements the methods for constructing confidence intervals for linear unbiased estimators given constraints on units’ dependency graph described in Aronow, Crawford and Zubizarreta (n.d.). The primary function, depvar, produces conservative variance estimates for generic linear unbiased estimators 

To install the package, run:

~~~
  install.packages("devtools")
  library("devtools")
  install_github("jrzubizarreta/depinf")
~~~
To get started, run:
~~~
  load("depinf")
  vignette("replication", package="depinf")
~~~
The citation is: 
~~~
  citation(package="depinf")

  Peter M. Aronow, Forrest W. Crawford and Jos'e R. Zubizarreta (2017).
  "Confidence intervals for linear unbiased estimators under constrained
  dependence." _arXiv:1602.00359_. <URL: https://arxiv.org/abs/1602.00359>.

  A BibTeX entry for LaTeX users is

  @Article{,
    title = {Confidence intervals for linear unbiased estimators under constrained dependence},
    author = {{Peter M. Aronow} and {Forrest W. Crawford} and {Jos'e R. Zubizarreta}},
    year = {2017},
    journal = {arXiv:1602.00359},
    url = {https://arxiv.org/abs/1602.00359},
  }
  
~~~

Replication materials for the regression analysis of the risk factors associated with HIV status reported in Aronow, Crawford and Zubizarreta (n.d.) are in the vignette.

## Solver Details

The software is compatible with solvers implemented in external R packages GLPK ("glpk", free), Gurobi ("gurobi", recommended), and CPLEX ("cplex"). By default, the package uses `glpk` which requires no additional setup or license. For installation of Gurobi, including the necessary associated R package (with free academic license), visit [Gurobi](http://www.gurobi.com). 
