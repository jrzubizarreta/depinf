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
If you use this package, please cite the article by Aronow, Crawford, Zubizarreta below.  If you use the dataset contained in this package, please cite the articles by Niccolai et al. and Iguchi et al. 
~~~
  citation(package="depinf")

  Peter M. Aronow, Forrest W. Crawford and Jos'e R. Zubizarreta (2017). “Confidence intervals for
  linear unbiased estimators under constrained dependence.” _arXiv:1602.00359_. <URL:
  https://arxiv.org/abs/1602.00359>.

  Linda M. Niccolai, O. V. Toussova, S. V. Verevochkin, R. Barbour, R. Heimer and A. P. Kozlov
  (2010). “High HIV prevalence, suboptimal HIV testing, and low knowledge of HIV-positive
  serostatus among injection drug users in St. Petersburg, Russia.” _AIDS and Behavior_, *14*, pp.
  932-941.

  M. Y. Iguchi, A. J. Ober, S. H. Berry, T. Fain, D. D. Heckathorn, P. M. Gorbach, R. Heimer, A.
  Kozlov, L. J. Oullet, S. Shoptaw and W. A. Zule (2009). “Simultaneous recruitment of drug users
  and men who have sex with men in the United States and Russia using respondent-driven sampling:
  sampling methods and implications.” _Journal of Urban Health_, *86*, pp. 5-31.
  
~~~

Replication materials for the regression analysis of the risk factors associated with HIV status reported in Aronow, Crawford and Zubizarreta (n.d.) are in the vignette.

## Solver Details

The software is compatible with solvers implemented in external R packages GLPK ("glpk", free), Gurobi ("gurobi", recommended), and CPLEX ("cplex"). By default, the package uses `glpk` which requires no additional setup or license. For installation of Gurobi, including the necessary associated R package (with free academic license), visit [Gurobi](http://www.gurobi.com). 
