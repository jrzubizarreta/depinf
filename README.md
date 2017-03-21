# depinf


### to do: 

1. edit DESCRIPTION: linear unbiased estimators
2. edit citation
3. vignette
4. installation workflow via `install_github`
  * see devtools package: https://www.rdocumentation.org/packages/devtools/versions/1.12.0
  * install_github: https://www.rdocumentation.org/packages/devtools/versions/1.12.0/topics/install\_github


For an exact solution, we strongly recommend running designmatch either with CPLEX or Gurobi.  

### installing gurobi: 

Between these two solvers, the R interface of Gurobi is considerably easier to install.  Here we provide general instructions for manually installing Gurobi and its R interface in Mac and Windows machines.

1. Create a free academic license
	Follow the instructions in: http://www.gurobi.com/documentation/6.0/quickstart_windows/creating_a_new_academic_li.html

2. Install the software
	2.1. In http://www.gurobi.com/index, go to Downloads > Gurobi Software
	2.2. Choose your operating system and press download

3. Retrieve and set up your Gurobi license
	2.1. Follow the instructions in: http://www.gurobi.com/documentation/6.0/quickstart_windows/retrieving_and_setting_up_.html
	2.2. Then follow the instructions in: http://www.gurobi.com/documentation/6.0/quickstart_windows/retrieving_a_free_academic.html

4. Test your license
	Follow the instructions in: http://www.gurobi.com/documentation/6.0/quickstart_windows/testing_your_license.html

5. Install the R interface of Gurobi	
	Follow the instructions in: http://www.gurobi.com/documentation/6.0/quickstart_windows/r_installing_the_r_package.html
	* In Windows, in R run the command install.packages("PATH\\gurobi_6.0-5.zip", repos=NULL) where path leads to the file gurobi_6.0-5.zip (for example PATH=C:\\gurobi605\\win64\\R; note that the path may be different in your computer)
	* In MAC, in R run the command install.packages('PATH/gurobi_6.0-5.tgz', repos=NULL) where path leads to the file gurobi_6.0-5.tgz (for example PATH=/Library/gurobi605/mac64/R; note that the path may be different in your computer)
		
6. Test the installation 
	Load the library and run the examples therein
	* A possible error that you may get is the following: "Error: package ‘slam’ required by ‘gurobi’ could not be found". If that case, install.packages('slam') and try again.
	You should be all set!
