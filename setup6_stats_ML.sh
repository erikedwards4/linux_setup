#!/bin/bash
#Run this script after setup1-2.
#This script installs Linux utilities for statistics and basic ML (machine learning).
#This includes some NN (neural network) software from general ML packages,
#but various specialized/advanced ML and NN tools are treated later (setup7).
#
#Most packages in this script can be obtained by apt-get install (see https://packages.ubuntu.com).
#
#Unwanted packages can be commented out.
#
#For each tool, I provide references and/or the main website.
#
#Coded by: Erik Edwards, Oct 2018.


tooldir=/opt					                #Each user can change this
mkdir -m 777 $tooldir
cd $tooldir


#Update
#sudo apt update									#updates package lists for upgrades
#sudo apt -y upgrade								#uses the updated package list to update packages on the system (takes a long time the first time)
#sudo apt -y dist-upgrade						#same as upgrade, but also handles changing dependencies (probably does nothing here, but just in case)
#sudo apt -y autoremove							#automatically removes packages that are no longer required


#NumExpr: Python 3 numerical expression library (MIT license).
#Evaluates equations as strings, using Intel MLK for up to 4x performance gain over NumPy.
#(May need to separately install/configure for MLK support.)
#This would make an excellent command-line tool!
#https://github.com/pydata/numexpr
#https://numexpr.readthedocs.io/en/latest/user_guide.html
sudo apt-get -y install python-numexpr          #Python 2 NumEpr library (probably already installed)
sudo apt-get -y install python3-numexpr         #Python 3 NumEpr library (probably already installed)


#GMP: GNU multi-precision library
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#https://gmplib.org
sudo apt-get -y install libgmp-dev			#GMP


#MPFR: GNU multi-precision float rounding
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#https://www.mpfr.org
sudo apt-get -y install libmpfr-dev			#MPFR


#GPLK: GNU Linear programming Kit
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#https://www.gnu.org/software/glpk/glpk.html
sudo apt-get -y install libglpk-dev			#GLPK


#NTL: C number theory library used below (LGPL license)
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#Shoup V. 2018. NTL vs FLINT. Report. New York: NYU Courant Institute. 10 p.
#https://www.shoup.net/ntl
sudo apt-get -y install libntl-dev			#NTL


#FLINT: Fast Library for Number Theory. C library (LGPL license), used below
#Hart WB. 2010. Fast Library for Number Theory: an introduction. Proc ICMS, LNCS 6327. Springer: 88-91.
#http://www.flintlib.org
sudo apt-get -y install libflint-dev		#FLINT


#OpenLibm: standalone, portable (platform-independent) C math library
#Started as need to have high-quality libm for Julia (MIT license and 2-clause BSD license).
#https://github.com/JuliaMath/openlibm
#https://openlibm.org
sudo apt-get -y install libopenlibm-dev        #OpenLibm


#OpenSpecFun: library of special functions (MIT license)
#Bessel, Airy, error functions, Fadeeva, etc.; part of Julia math project
#https://github.com/JuliaMath/openspecfun
sudo apt-get -y install libopenspecfun-dev      #OpenSpecFun


#CDD library: C-library for finding vertices of convex polytopes
#https://www.inf.ethz.ch/personal/fukudak/cdd_home
sudo apt-get -y install libcdd-dev			#CDD library


#Singular: algebra system for polynomial computations (GPL license)
#Greuel G-M, Pfister G, Schönemann H. 1997. SINGULAR-1.0: a computer algebra system for singularity theory, algebraic geometry and commutative algebra. ACM SIGSAM Bull. 31(3): 48-50.
#Lossen C. 2003. Singular: a computer algebra system. Comput Sci Eng. 5(4): 45-55.
#Greuel G-M, Pfister G. 2008. A Singular introduction to commutative algebra, 2nd Ed. Berlin: Springer.
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#https://www.singular.uni-kl.de
sudo apt-get -y install singular			#Singular


#lib L-BFGS: a library of Limited-memory Broyden-Fletcher-Goldfarb-Shanno (L-BFGS) method.
#C port of original FORTRAN code (MIT license), for unconstrained minimization (where gradient is computable).
#Also implements orthant-wise quasi-Newton (OWL-QN) method [Andrew and Gao 2007].
#Used by CRFsuite, Classias, lbfgs (R lib), mlegp (R lib for GPs), imaging2.
#Nocedal J. 1980. Updating quasi-Newton matrices with limited storage. Math Comput. 35(151): 773-82.
#Liu DC, Nocedal J. 1989. On the limited memory BFGS method for large scale optimization. Math Program B. 45(3): 503-28.
#Dennis JE, Schnabel RB. 1983. Numerical methods for unconstrained optimization and nonlinear equations. Prentice-Hall.
#Andrew G, Gao J. 2007. Scalable training of L1-regularized log-linear models. Proc ICML: 33-40.
#http://www.chokkan.org/software/liblbfgs
sudo apt-get -y install liblbfgs-dev        #L-BFGS library


#lib L-BFGS-B: library for large-scale bound-constrained (l<=x<=u) optimization (3-clause BSD license)
#Byrd RH, Lu P, Nocedal J. 1995. A limited memory algorithm for bound constrained optimization. SIAM J Sci Stat Comput. 16(5): 1190-1208.
#Zhu C, Byrd RH, Nocedal J. 1997. L-BFGS-B, FORTRAN routines for large scale bound constrained optimization. ACM Trans Math Softw. 23(4): 550-60.
#http://users.iems.northwestern.edu/~nocedal/lbfgsb.html
sudo apt-get -y install liblbfgsb-dev       #L-BFGS-B library


#NLopt: open-source nonlinear optimization library in C
#Under LGPL license, but "looser licenses for some portions".
#Used by Shogun, and by some C/C++, Matlab/Octave, Python, R, etc.
#Doesn't have a command-line tool, but looks easy to include in C/C++.
#Has evolutionary algorithms (with citations)!
#http://ab-initio.mit.edu/nlopt
#https://nlopt.readthedocs.io/en/latest
sudo apt-get -y install libnlopt-dev		#NLopt library


#GAlib: Genetic Algorithms library in C++
#Partly under GPL, partly under its own license stated on web page.
#Wall M. 1996. GAlib: a C++ library of genetic algorithm components. Cambridge, MA, MIT: 101 p.
#http://lancet.mit.edu/ga
sudo apt-get -y install libga-dev		#GAlib


#VIGRA: C++ Vision with Genetic Algorithms library (MIT license).
#Flexible; based on STL so easy to adapt to other applications; Python library available.
#Lots of general image processing, filters, etc. Tensor processing.
#Some ML (random forest classifier with feature ranking/selection; PCA and pLSA); some optimization.
#http://ukoethe.github.io/vigra
sudo apt-get -y install libvigraimpex-dev       #VIGRA


#PSPP: portable, high-performance statistical analysis tools
#The acronym does not stand for anything; it is a free alternative to SPSS.
#From the GNU project (GPL license).
#GUI and command-line use.
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#http://savannah.gnu.org/projects/pspp
#https://www.gnu.org/software/pspp
sudo apt-get -y install pspp				#PSPP


#MCL: Markov Cluster algorithm for graphs, in C (GPL license).
#van Dongen S. 2000. Graph clustering by flow simulation. Doctoral Thesis. Utrecht, Netherlands: Univ. of Utrecht.
#van Dongen S. 2008. Graph clustering via a discrete uncoupling process. SIAM J Matrix Anal Appl. 30(1): 121-141.
#http://micans.org/mcl
sudo apt-get -y install mcl					#MCL


#LIBLINEAR: C/C++ library for linear regression, logistic regression, LDA, etc. (3-clause BSD license).
#Fan R-E, ..., Lin C-J. 2008. LIBLINEAR: a library for large linear classification. J Mach Learn Res. 9: 1871-1874.
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#https://www.csie.ntu.edu.tw/~cjlin/liblinear
sudo apt-get -y install liblinear-dev 		#LIBLINEAR
sudo apt-get -y install liblinear-tools 	#Standalone tools for LIBLINEAR


#LIBSVM: C/C++ library for support vector machines (3-clause BSD license).
#Very widely used (e.g., Scikit-learn, R, etc.).
#Chang C-C, Lin C-J. 2011. LIBSVM: a library for support vector machines. ACM Trans Intell Syst Technol. 2(3): article 27, 1-27.
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#https://www.csie.ntu.edu.tw/~cjlin/libsvm
sudo apt-get -y install libsvm-dev			#LIBSVM
sudo apt-get -y install libsvm-tools		#Standalone tools for LIBSVM


#WEKA 3 (Waikato Environment for Knowledge Analysis, v. 3): data mining and ML software in Java.
#This was an important early toolbox (~2000) that is still widely used. Uses the .arff format.
#Under GNU GPL license.
#Hall M, ..., Witten IH. 2009. The WEKA data mining software: an update. ACM SIGKDD Explor Newslett. 11(1): 10-18.
#Witten IH, Frank E, Hall MA, Pal CJ. 2016. Data mining: practical machine learning tools and techniques, 4th Ed. San Francisco, CA: Morgan Kaufmann.
#https://www.cs.waikato.ac.nz/ml/weka
sudo apt-get -y install weka				#WEKA


#MLPACK: Machine Learning package in C/C++ (3-clause BSD license).
#Built on Armdillo, ensmallen (optimization), and parts of Boost.
#Fast, flexible; many of the tools have command-line versions. Also Python.
#Curtin RR, ..., Gray AG. 2013. MLPACK: a scalable C++ machine learning library. J Mach Learn Res. 14: 801-805.
#Curtin RR, ..., Zhang S. 2018. mlpack 3: a fast, flexible machine learning library. J Open Source Softw. 3:26.
#https://www.mlpack.org
sudo apt-get -y install libmlpack-dev		#MLPACK


#LIBOCAS: library implementing OCAS solver, for linear SVM classifiers on large-scale data,
#OCAS (Optimized Cutting Plane Algorithm) does seem like excellent (fast!) solution for Big data.
#Also includes COFFIN for translation-invariant image classifiers (super fast for large data)
#From Franc and Sonnenburg (see Shogun next). Under GPL license.
#Franc V, Sonnenburg S. 2008. Optimized cutting plane algorithm for Support Vector Machines. Proc ICML. ACM: 320-327.
#Franc V, Sonnenburg S. 2009. Optimized cutting plane algorithm for large-scale risk minimization. J Mach Learn Res. 10: 2157-2192.
#Sonnenburg S, Franc V. 2010. COFFIN: a computational framework for linear SVMs. Proc ICML. IMLS: 999-1006.
#http://cmp.felk.cvut.cz/~xfrancv/ocas/html
sudo apt-get -y install libocas-dev			#LIBOCAS
sudo apt-get -y install libocas-tools		#Standalone tools implementing OCAS


#Shogun: large-scale ML toolbox in C++.
#GPLv3 license, but "working towards BSD compatibility".
#Started by Soeren Sonnenburg and Gunnar Rätsch, hence "ShoGun" (from Germany, not Japan).
#Doesn't give command-line tools that I know of.
#Sonnenburg S, Rätsch G, ..., Franc V. 2010. The SHOGUN machine learning toolbox. J Mach Learn Res. 11: 1799-1802.
#http://www.shogun-toolbox.org
sudo apt-get -y install libshogun-dev		#Shogun


#Shark: Machine learning library in C++ (LGPL license); built on Boost.
#Won the Gold Prize for Open Source Software World Challenge in 2011.
#Has LDA, SVMs, NNs, RNNs, decision trees and random forests, clustering, PCA, etc.
#Has various linear, nonlinear and evolutionary optimization, etc.
#I think it is particularly strong for restricted Boltzmann machines.
#Igel C, Heidrich-Meisner V, Glasmachers T. 2008. Shark. J Mach Learn Res. 9: 993-996.
#http://image.diku.dk/shark
sudo apt-get -y install libshark-dev		#Shark


#Dlib: C++ libraries for ML and computer vision (Boost Software license).
#Seems to have excellent documentation, testing of code, etc.
#Used by Lawrence NL, MIT IE toolkit, Mobile Mind, OpenFace, etc.
#Includes image processing, graph tools, Bayesian nets, SVMs, MLPs, deep learning, RBF networks, etc.
#Looks particularly good for various classification methods (SVMs, etc.), particulary multiclass methods.
#King DE. 2009. Dlib-ml: a machine learning toolkit. J Mach Learn Res. 10: 1755-1758.
#http://dlib.net
sudo apt-get -y install libdlib-dev			#Dlib


#Vowpal Wabbit (VW): fast, scalable, "the essence of speed in machine learning, able to learn from terafeature dataset..."
#Started at Yahoo! Research, now at MSR. Has command-line tool. Under 3-clause BSD license.
#http://hunch.net/~vw
sudo apt-get -y install libvw-dev           #VW
sudo apt-get -y install vowpal-wabbit       #Vowpal Wabbit


#ELKI (Environment for deveLoping KDD-applications supported by Index-structures)
#Compiled under Python; under GPL license.
#Emphasis on unsupervised methods, cluster analysis, outlier detection.
#High-performance and scalability, by using data index structures (eg R*-tree).
#sudo apt-get -y install elki-dev           #ELKI


#herisvm: a collection of simple tools for evaluation of classification algorithms (MIT license).
#Gives command-line tools: heri-eval, heri-stat, heri-split (just splits for CV).
#Has N-fold CV where train/test are run in parallel (heri-eval)
#Calculates precision, recall, F1, with per-class and other options (heri-stat).
#https://github.com/cheusov/herisvm
sudo apt-get -y install herisvm             #herisvm


#FANN: Fast Artificial Neural Network library in C (LGPL license).
#Easy-to-use (create, train, run with just 3 function calls); fast.
#Has evolving topology training that dynamically builds/trains the ANN.
#Documentation for creating unsupervised SOM and GNG (Growing Neural Gas) networks.
#Nissen S. 2003. Implementation of a Fast Artificial Neural Network library (FANN). Report. Copenhagen, Denmark: DIKU, Univ. Copenhagen: 92 p.
#Nissen S. 2005. Neural networks made simple. Software 2.0 2: 14-19.
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#http://leenissen.dk/fann/wp
sudo apt-get -y install libfann-dev			#FANN


#Zinnia: online hand-writting recognition system with ML; in C/C++/Perl/Ruby/Python (BSD license).
#Uses SVM; gets pen strokes as sequence of coordinates and outputs n-best characters sorted by SVM confidence.
#http://taku910.github.io/zinnia/
#sudo apt-get -y install libzinnia0v5       #Zinnia library

