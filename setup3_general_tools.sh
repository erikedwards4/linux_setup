#!/bin/bash
#@author Erik Edwards
#@date 2018-2019
#
#This script installs further general utilities and software,
#but now considering some specialized and less universally-used tools.
#
#This includes GTK2 (GUI support) and associated programs.
#Important document/text tools: Texlive (LaTeX), Markdown, Pandoc and other document/mark-up converters.
#I use JabRef for open-source bibliography management (but skip if you don't).
#The major scripting language are included here: Python3, R, Octave, Lua, Scala.
#I include shellcheck for bash scripting.
#I also include Node.js, since I plan to use JavaScript.
#Oracle Java is installed (requires brief interaction).
#Parallel processing support is installed: GNU parallel, hypre, and PETSc.
#For AWS users, s3cmd is installed (requires brief interaction and keys/passwords).
#
#To later remove an unwanted package, use: sudo apt remove <pkgname>
#
#For each tool, I provide references and the main website.
#The references should help the user appreciate: ML and NLP work rests on decades of computer science research and effort.
#As the expression says, we stand on the shoulders of giants...
#For further information on any tool, search Google, Wikipedia, or the Free Software Directory (https://directory.fsf.org).
#


#Basic Linux dependencies
#sudo apt update									#updates package lists for upgrades
#sudo apt -y dist-upgrade						#same as upgrade, but also handles changing dependencies
#sudo apt -y autoremove							#automatically removes packages that are no longer required


#Lua scripting language (small footprint C code, so doesn't take much space)
#Ierusalimschy R, de Figueiredo LH, Filho WC. 1996. Lua – an extensible extension language. Softw Pract Exp 26(6):635-652.
#Ierusalimschy R. 2016. Programming in Lua, 4th Ed. Rio de Janeiro, Brazil: lua.org.
#https://www.lua.org
sudo apt-get -y install lua5.3					#Lua


#vim-gtk: Vi IMproved with GTK2 GUI.
#Launched with gvim.
#https://www.vim.org
sudo apt-get -y install vim-gtk					#Vim-GTK


#gedit: official text editor of the GNOME desktop environment, simple, light-weight
#https://wiki.gnome.org/Apps/Gedit
#sudo apt-get -y install gedit					#gedit (GNOME text editor)


#PostgreSQL: heavier SQL database, open-source, one of the original SQL databases (1980s origins)
#Stonebraker MR, Rowe LA, Hirohama M. 1990. The implementation of POSTGRES. IEEE Trans Knowl Data Eng 2(1): 125-142.
#https://www.postgresql.org
sudo apt-get -y install postgresql-client		#Postgre 10+ SQL database, client side


#MySQL: heavier SQL database, open-source, most widely used, now owned by Oracle
#Axmark D, Widenius M. 1999. MySQL introduction. Linux journal 67es: Article 5.
#DuBois P. 2013. MySQL, 5th Ed. Upper Saddle River, NJ: Addison-Wesley.
#https://www.mysql.com
sudo apt-get -y install libmysqlclient20		#MySQL client library
#sudo apt-get -y install mysql-client			#MySQL 5+, client side
#sudo apt-get -y install mysql-server			#MySQL 5+, server side


#MongoDB: object- or document-oriented database (uses JSON)
#Chodorow K, Dirolf M. 2010. MongoDB: the definitive guide. Sebastopol, CA: O'Reilly.
#Banker K, Bakkum P, Verch S, Garrett D, Hawkins T. 2016. MongoDB in action, 2nd Ed. Shelter Island, NY: Manning.
#https://www.mongodb.com
#sudo apt-get -y install mongodb				#MongoDB database


#Markdown: minimal mark-up language, and text-to-HTML converter
sudo apt-get -y install markdown				#markdown text-to-html conversion tool


#GhostScript: interpreter for the PostScript (PS) language and for PDF-X11 support
#Includes usual ghostscript library and the libx11-6 and the libxt6 libraries.
sudo apt-get -y install ghostscript				#ghostscript
sudo apt-get -y install ghostscript-x			#adds PDF-X11 libraries


#LaTeX (Lamport TeX): famous document preparation system
#Lamport L. 1986. LaTeX: a document preparation system. Reading, MA: Addison-Wesley.
#Grätzer GA. 1993. Math into TeX: a simple introduction to AMS-LaTeX. Boston: Birkhäuser.
#https://www.latex-project.org
#Specifically, the TeXLive free distribution of TeX, LaTeX, and BibTeX.
#This is one of the oldest (starting in 1996 with Rahtz, Goossens, and others)
#and most common TeX distributions; and it is default for Ubuntu and other Linux distros.
#Goossens M, Rahtz SPQ, Mittelbach F. 1997. The LaTex graphics companion: illustrating documents with TeX and PostScript. Reading, MA: Addison-Wesley.
#https://www.tug.org/texlive
sudo apt-get -y install texlive					#TeX Live distribution of LaTeX
sudo apt-get -y install texlive-bibtex-extra	#TeX Live BibTeX additional styles


#bibtexconv: BibTeX Converter (to XML, text).
#Can also be use to verify ISBNs, ISSNs, and URLs.
#http://manpages.ubuntu.com/manpages/bionic/man1/bibtexconv.1.html
#https://www.uni-due.de/~be0001/bibtexconv
sudo apt-get -y install bibtexconv				#BibTeX converter


#bibtex2html: filters BibTeX files and converts to HTML
#https://www.lri.fr/~filliatr/bibtex2html
sudo apt-get -y install bibtex2html				#bibtex2html converter


#latex2html: converts LaTeX documents to HTML format


#Pandoc (requires texlive): free document converter ("pan-document")
#Converts between Markdown, HTML, LaTeX, etc.
sudo apt-get -y install pandoc					#pan-document converter


#pdfgrep: works like grep, but straight from .pdf file
#(Actually, this works better: pdftotext file.pdf | grep).
#https://pdfgrep.org
sudo apt-get -y install pdfgrep					#pdfgrep


#Also consider libhtml-wikiconverter-perl (HTML to Wiki markup converter)
#sudo apt-get -y install libhtml-wikiconverter-perl


#Also consider Web Scraping Toolkit
#sudo apt-get -y install libweb-scraper-perl	#Web Scraping Toolkit


#Also consider GNU libiconv (converts text to/from Unicode)
#cd $tooldir
#wget https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz
#tar -xvf libiconv-1.15.tar.gz
#rm *.gz
#chmod -R 777 $tooldir/libiconv-1.15
#cd $tooldir/libiconv-1.15
#./configure
#make
#sudo make install
#chmod -R 777 $tooldir/libiconv-1.15


#Shell script checker/lint tool. Highly recommended if you write bash scripts.
#https://www.shellcheck.net/
sudo apt-get -y install shellcheck				#shell script checker


#Python 2
#van Rossum G. 1993. An introduction to Python for UNIX/C programmers. Dutch UNIX Users Group: 1-8.
#Pérez F, Granger BE. 2007. IPython: a system for interactive scientific computing. Comput Sci Eng 9(3): 21-29.
#van der Walt S, Colbert SC, Varoquaux G. 2011. The NumPy array: a structure for efficient numerical computation. Comput Sci Eng 13(2):22-30.
#Behnel S, Bradshaw R, Citro C, Dalcin L, Seljebotn DS, Smith KW. 2011. Cython: the best of both worlds. Comput Sci Eng 13(2): 31-39.
#Oliphant TE. 2015. A guide to NumPy, 2nd Ed. Austin, TX: Continuum Press.
#van Rossum G. 2016. Python tutorial: release 3.5.1. Wilmington, DE: Python Software Foundation.
#McKinney W. 2018. Python for data analysis: data wrangling with Pandas, NumPy, and IPython, 2nd Ed. Sebastapool, CA: O'Reilly.
#https://www.python.org
#https://ipython.org
#http://www.numpy.org
#https://pandas.pydata.org
#https://www.scipy.org
sudo apt-get -y install python-dev				#Python 3
sudo apt-get -y install python-pip				#Python 3 package installer
sudo apt-get -y install python-setuptools		#Python 3 distutils enhancements
sudo apt-get -y install python-wheel			#Python 3 built-package format
sudo apt-get -y install python-numpy			#Python 3 NumPy array library
sudo apt-get -y install python-pandas			#Python 3 Pandas library for data structures
sudo apt-get -y install python-scipy			#Python 3 SciPy library
sudo apt-get -y install cython					#Cython C extensions for Python 2
sudo apt-get -y install ipython			    	#Python enhanced interactive shell


#Python 3
#van Rossum G. 1993. An introduction to Python for UNIX/C programmers. Dutch UNIX Users Group: 1-8.
#Pérez F, Granger BE. 2007. IPython: a system for interactive scientific computing. Comput Sci Eng 9(3): 21-29.
#van der Walt S, Colbert SC, Varoquaux G. 2011. The NumPy array: a structure for efficient numerical computation. Comput Sci Eng 13(2):22-30.
#Behnel S, Bradshaw R, Citro C, Dalcin L, Seljebotn DS, Smith KW. 2011. Cython: the best of both worlds. Comput Sci Eng 13(2): 31-39.
#Oliphant TE. 2015. A guide to NumPy, 2nd Ed. Austin, TX: Continuum Press.
#van Rossum G. 2016. Python tutorial: release 3.5.1. Wilmington, DE: Python Software Foundation.
#McKinney W. 2018. Python for data analysis: data wrangling with Pandas, NumPy, and IPython, 2nd Ed. Sebastapool, CA: O'Reilly.
#https://www.python.org
#https://ipython.org
#http://www.numpy.org
#https://pandas.pydata.org
#https://www.scipy.org
sudo apt-get -y install python3-dev				#Python 3
sudo apt-get -y install python3-pip				#Python 3 package installer
sudo apt-get -y install python3-setuptools		#Python 3 distutils enhancements
sudo apt-get -y install python-wheel			#Python 3 built-package format
sudo apt-get -y install python3-numpy			#Python 3 NumPy array library
sudo apt-get -y install python3-pandas			#Python 3 Pandas library for data structures
sudo apt-get -y install python3-scipy			#Python 3 SciPy library
sudo apt-get -y install cython3					#Cython C extensions for Python 3
sudo apt-get -y install ipython3				#Python 3 enhanced interactive shell
sudo apt-get -y install python3-six				#Python 2,3 compatibility library
#sudo apt-get -y install ipython3-notebook		#Python 3 interactive HTML notebook (this didn't work)


#Python3 agate: data analysis library optimized for human readability
#Used below by e.g. python3-csvkit
#https://agate.readthedocs.io
#sudo apt-get -y install python3-agate			#Python3 agate
#sudo apt-get -y install python3-agatedbf python3-agateexcel python3-agatesql


#csvtool: toolkit for csv (comma-separated values) files
#csvtool is older and available for older versions of Ubuntu, whereas csvkit is requires newer Ubuntu version.
#https://colin.maudry.com/csvtool-manual-page
sudo apt-get -y install csvtool


#csvkit: toolkit for csv (comma-separated values) files
#This gives command-line tools: in2csv, csvcut, csvgrep, csvstat, csvjson, csvsql, sql2csv
#Janssens JHM. 2014. Data science at the command line. Sebastopol, CA: O'Reilly.
#https://csvkit.readthedocs.io/en/1.0.3
sudo apt-get -y install python3-csvkit			#csvkit for Python3


#FreeXL: library for direct reading of Microsoft Excel spreadsheets
sudo apt-get -y install libfreexl-dev			#FreeXL


#unoconv (Universal Office Converter): command-line utility to convert btwn any formats supported by LibreOffice
#https://github.com/dagwieers/unoconv
#https://linux.die.net/man/1/unoconv
#https://docs.moodle.org/36/en/Universal_Office_Converter_(unoconv)
sudo apt-get -y install unoconv					#unoconv


#Gnumeric: free spreadsheet program, also does conversions
#http://www.gnumeric.org
#sudo apt-get -y install gnumeric				#Gnumeric


#SuiteSparse: widely used (Google, MathWorks, NSF, Nvidia, Intel, etc.).
#library of sparse matrix algorithms (GraphBLAS, UMFPACK, CHOLMOD, SPQR, KLU, etc.).
#This is required by the GLPK and other installs below.
#http://faculty.cse.tamu.edu/davis/suitesparse.html
sudo apt-get -y install libsuitesparse-dev		#SuiteSparse


#GLPK: GNU linear programming kit in C
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#https://www.gnu.org/software/glpk
sudo apt-get -y install libglpk-dev				#GLPK


#Also consider: COIN-OR (Computational Infrastructure for Operations Research)
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#https://www.coin-or.org


#GNU Octave (free Matlab emulator)
#Eaton JW. 1997. GNU Octave: a high-level interactive language for numerical computations, 3rd Ed. Boston: Free Software Foundation.
#Eaton JW, Bateman D, Hauberg S. 2017. GNU Octave 4.2 reference manual. Surrey, UK: Samurai Media.
#https://www.gnu.org/software/octave
#https://octave.sourceforge.io
sudo apt-get -y install octave					#GNU Octave
sudo apt-get -y install octave-general			#extra general functions for Octave
sudo apt-get -y install octave-gsl				#GNU scientific library (GSL) bindings for Octave
sudo apt-get -y install octave-statistics		#Statistics package for Octave


#R statistical computing language
#Ihaka R, Gentleman R. 1996. R: a language for data analysis and graphics. J Comput Graph Stat 5(3):299-314.
#Chambers JM. 2008. Software for data analysis: programming with R. New York: Springer.
#https://www.r-project.org
#https://cran.r-project.org
#First, add the following line to the /etc/apt/sources.list file: deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/
#sudo echo "deb http://cloud.r-project.org/bin/linux/ubuntu xenial/" | sudo tee -
#sudo rm -
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
#sudo apt-get -y update
sudo apt-get -y install r-base					#R
#sudo apt -y autoremove


#R stand-alone math library for C/C++
#This can be used within C/C++ programs by include <RMath.h>
#Includes general functions, distributions, and random number generators
#https://www.stat.berkeley.edu/classes/s243/rmath.html
sudo apt-get -y install r-mathlib				#RMath library


#Other R packages: these have to be done inside an R session using install.packages(""):
#BiocManager, cli, date, devtools, dplyr, dtw, grid, littler, mvtnorm, plyr, pracma, readxl, rio, Rcpp, RcppEigen, RcppGSL, reshape2, RSQLite, shiny, shinyBS, zoo
#https://cran.r-project.org


#Scala programming language (requires Java)
#This also installs the Scala standard library.
#Odersky M, Spoon L, Venners B. 2016. Programming in Scala, 3rd Ed. Mountain View, CA: Artima.
#https://www.scala-lang.org
sudo apt-get -y install scala					#Scala


#Yarn package manager (JavaScript)
#curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
#echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
#sudo apt-get update && sudo apt-get -y install yarn


#jQuery for JavaScript
#Bibeault B, Katz Y. 2008. jQuery in action. Greenwich, CT: Manning.
#Chaffer J, Swedberg K. 2013. Learning jQuery. Birmingham, UK: Packt.
#https://jquery.com
sudo apt-get -y install libjs-jquery			#jQuery


#Node.js for JavaScript
#Tilkov S, Vinoski S. 2010. Node. js: using JavaScript to build high-performance network programs. IEEE Internet Comput 14(6): 80-83.
#Young AR, Meck B, Cantelon M, Oxley T, Harter M, Holowaychuk TJ, Rajlich N. 2017. Node.js in action, 2nd Ed. Shelter Island, NY: Manning.
#https://nodejs.org
sudo apt-get -y install nodejs					#Node.js
sudo apt-get -y install npm						#Node.js package manager


#MathJax: MathML and LaTeX for JavaScript.
#Cervone D. 2012. MathJax: a platform for mathematics on the Web. Not Am Math Soc 59(2): 312-316.
#https://www.mathjax.org
sudo apt-get -y install libjs-mathjax			#MathJax


#GNU Parallel: shell tool for executing jobs in parallel: https://www.gnu.org/software/parallel
#Tange O. 2011. GNU parallel: the command-line power tool. USENIX magazine 36(1): 42-47.
#https://www.gnu.org/software/parallel
sudo apt-get -y install parallel				#GNU parallel


#TBB (Threading Building Blocks)
#Widely-used library to easily write parallel (multicore) C++ programs.
#Reinders J. 2007. Intel threading building blocks: outfitting C++ for multi-core processor parallelism. Sebastopol, CA: O'Reilly.
#https://www.threadingbuildingblocks.org
sudo apt-get -y install libtbb-dev				#TBB library


#hypre (High Performance Preconditioners): scalable/parallel solutions of linear systems
#Includes BLOPEX method for eigenvalue problems.
#Meant for high-performance, parallel implementations using Message Passing Interface (MPI).
#Developed by Lawrence Livermore National Laboratory.
#Falgout RD, Yang UM. 2002. hypre: a library of high performance preconditioners. In: Proc ICCS. Springer: 632-641.
#Falgout RD, Jones JE, Yang UM. 2006. The design and implementation of hypre, a library of parallel high performance preconditioners. Lect Notes Comput Sci Eng 51: 267-294.
#Falgout RD, Jones JE, Yang UM. 2006. Conceptual interfaces in hypre. Future Gener Comput Syst 22(1-2): 239-251.
#http://www.llnl.gov/casc/hypre
sudo apt-get -y install libhypre-dev			#hypre library


#PETSc: Portable, Extensible Toolkit for Scientific computation
#This is the major parallel toolkit for scientific computation (PDEs, linear algebra, etc.), developed since 1991 by Argonne National Lab.
#Requires gfortran, FFTW3, Python, hypre, and OpenMPI (Open-source higher-performance message passing library).
#I suggest that it is too intense for now; only install if doing serious parallel/concurrent processing. It relies on hypre, so probably try that first anyway.
#Balay S, Gropp WD, McInnes LC, Smith BF. 1997. Efficient management of parallelism in object oriented numerical software libraries. In: Arge E, et al. eds. Modern software tools for scientific computing. Boston: Birkhäuser. p 163-202.
#Balay S, Abhyankar S, et al. 2018. PETSc Web page. http://www.mcs.anl.gov/petsc. Chicago: Argonne National Laboratory.
#Balay S, Abhyankar S, et al. 2018. PETSc users manual. Argonne: Argonne National Laboratory. Report nr ANL-95/11 Rev 3.10. 272 p. p.
#https://www.mcs.anl.gov/petsc
#sudo apt-get -y install petsc-dev				#PETSc scientific computation toolkit


#Also consider libnet-openssh-parallel-perl to run SSH jobs in parallel:
#sudo apt-get -y install libnet-openssh-parallel-perl


#Also consider node-parallel-transform (JavaScript) to run transforms in parallel:
#sudo apt-get -y install node-parallel-transform


#Also consider octave-parallel for parallel execution of Octave in computer clusters
#sudo apt-get -y install octave-parallel


#Also consider python3-parallel (pyparallel)
#sudo apt-get -y install python3-parallel


#LibreOffice: free office tools
#Should be installed, but confirms dependencies for below.
#https://www.libreoffice.org
sudo apt-get -y install libreoffice-common		#LibreOffice common files


#Oracle Java (this requires brief interaction)
#Note that the latest official version of Oracle JDK is Java 8
#https://docs.oracle.com/javase/8/docs
#sudo add-apt-repository ppa:webupd8team/java	#add installer to repository
#sudo apt-get update							#re-update repository
#sudo apt-get -y install oracle-java8-installer	#install Oracle Java


#Oracle Java 11 (above Java 8 appears no longer available, but neither does this)
#sudo add-apt-repository ppa:linuxuprising/java  #add installer to repository
#sudo apt-get update								#re-update repository
#sudo apt-get -y install oracle-java11-installer	#install Oracle Java


#JabRef: Java bibliography reference manager, focused on BibTeX format, open-source.
#Excellent features/functionality (best bibliography program in my opinion).
#Installs a long list of Java dependencies (only drawback, but good to have dependencies for other Java apps).
#http://www.jabref.org
sudo apt-get -y install jabref 					#JabRef


#s3cmd: command-line utility for AWS (this requires brief interaction)
#https://s3tools.org/s3cmd
sudo apt-get -y install s3cmd
s3cmd --configure
#Enter AccessKey and SecretKey
#Then generally just choose 'y' and hit Enter.


#Google Cloud SDK: gcloud, gsutil, and bq command-line tools.
#First install Windows Cloud SDK


#Intel MKL (Intel Math Kernel Library) (required by Kaldi)
#https://software.intel.com/en-us/mkl
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo wget https://apt.repos.intel.com/setup/intelproducts.list -O /etc/apt/sources.list.d/intelproducts.list
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install intel-mkl-2019.4-070
sudo apt-get -y install intel-ipp-2019.4-070
sudo apt-get -y install intel-tbb-2019.6-070
sudo apt-get -y install intel-daal-2019.4-070
sudo apt-get -y install intel-mpi-2019.4-070
sudo apt-get -y install intelpython2
sudo apt-get -y install intelpython3


#Some dependencies for Docker (probably already installed, but will upgrade)
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

exit

#Docker: most widely-used container application, written in Go
#Anderson C. 2015. Docker. IEEE Softw. 32(3): 102-103.
#Boettiger C. 2015. An introduction to Docker for reproducible research. ACM SIGOPS Oper Syst Rev. 49(1): 71-79.
#Matthias K, Kane SP. 2015. Docker: up & running. Sebastopol, CA: O'Reilly.
#https://www.docker.com
#https://docs.docker.com
sudo apt-get remove docker docker-engine docker.io containerd runc	#remove old versions if any
sudo apt-get update
#First install the Docker repository:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#Now install Docker CE (Community Edition):
sudo apt-get update
sudo apt-get -y install docker-ce
#Test install  with example image:
sudo docker run hello-world
#This doesn't work on WSL... (requires Docker for Windows to be installed, etc.)
sudo snap install docker		#installs docker-machine, etc.
