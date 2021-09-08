#!/bin/bash
#@author Erik Edwards
#@date 2018-2020
#
#Run this script upon launching a new Linux Ubuntu instance.
#Stage 1 installs basic Linux utilities and common dependencies for other software.
#Stage 2 installs some ML (machine learning) and ASR (automatic speech recognition) tools available by apt-get.
#Stage 3 gives instructions for ML and ASR tools requiring manual install (Stage 3, but run manually).
#
#Stage 1:
#This includes package managers, compression utilities, bc, vim, doxygen, etc.
#The universe of C coding (upon which so much else depends) is installed:
#GNU C/C++ libraries, GSL, make, valgrind, FFTW, Eigen3, BLAS, ATLAS, Boost, Armadillo, Google Performance Tools, etc. 
#Other basic programming and scripting languages: C/C++, Perl, Python, Ruby, Java, JavaScript.
#Major Internet and version control utilities are installed: SSH, cURL, wget, git, subversion, bazel, etc.
#It also installs the very widely-used: SQLite, JSON, FreeType, TeX, etc.
#Unwanted packages can be commented out. But few extraneous packages are included here; these show up in later dependencies.
#To later remove an unwanted package, use: sudo apt remove <pkgname>
#
#For each tool, I provide references and the main website.
#The references should help the user appreciate: ML and NLP work rests on decades of computer science research and effort.
#As the expression says, we stand on the shoulders of giants...
#


#Perhaps update basic Linux dependencies first (manually):
#sudo apt update									#updates package lists for upgrades
#sudo apt -y upgrade								#uses the updated package list to update packages on the system (takes a long time the first time)
#sudo apt -y dist-upgrade						#same as upgrade, but also handles changing dependencies (probably does nothing here, but just in case)
#sudo apt-get -y install build-essential			#refers to many packages needed for building software in general
#sudo apt-get -y install pkg-config				#manages library compile and link flags
#sudo apt-get -y install dpkg					#Debian package management system (Debian is early Linux OS) (should already be there, but just in case)
#sudo apt -y autoremove							#automatically removes packages that are no longer required


[ $# -ge 1 ] && stage=$1 || stage=0
[[ "$stage" == [0-3] ]] || error $LINENO "stage must be in {0,1,2,3} \n"


#Stage 1: Basic dependencies
if [[ "$stage" == [01] ]]
then

    #make: classic utility to compile code with dependencies
    #Feldman SI. 1979. Make – a program for maintaining computer programs. Software: practice & experience 9(4): 255-265.
    #Loukides MK, Oram A. 1997. Programming with GNU software. Sebastopol, CA: O'Reilly.
    #https://www.gnu.org/software/make
    sudo apt-get -y install make					#famous utility for managing dependencies for compilations

    #Valgrind: debugging tool for C, tests memory and thread usage errors
    #Nethercote N, Seward J. 2003. Valgrind: a program supervision framework. Electronic notes in theoretical computer science 89(2): 44-66.
    #http://valgrind.org
    sudo apt-get -y install valgrind				#Valgrind

    #m4 (macro processing language): used by autoconf, etc., etc.
    #Kernighan BW, Ritchie DM. 1977. The M4 macro processor. Manual. 6 p. Murray Hill, NJ: Bell Labs.
    #Turner KJ. 1994. Exploiting the m4 macro language. Report CSM-126. 20 p. Stirling, Scotland: Univ.  of Sterling.
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://www.gnu.org/software/m4
    sudo apt-get -y install m4						#m4 macro processing language

    #Berkeley database (libdb): widely used C code for databases
    #Originated in 1980s, modern version ~1991, and eventually acquired by Oracle.
    #This is a dependency for many basic programs below.
    #Olson MA, Bostic K, Seltzer MI. 1999. Berkeley DB. Proc USENIX Tech Conf. USENIX Assoc.: 183-191.
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://www.oracle.com/database/berkeley-db
    sudo apt-get -y install libdb-dev				#Berkeley database libraries

    #Compression utilities
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://zlib.net
    #https://www.7-zip.org
    #https://tukaani.org/xz
    #http://www.bzip.org
    #https://github.com/google/snappy
    sudo apt-get -y install zlib1g-dev				#most used compression library
    sudo apt-get -y install zip unzip				#zip/unzip (probably already installed)
    sudo apt-get -y install xz-utils				#XZ-format compression utility
    sudo apt-get -y install liblzma-dev				#XZ-format compression library
    sudo apt-get -y install p7zip					#7zr archiver
    sudo apt-get -y install libbz2-dev				#block-sorting file compressor library
    sudo apt-get -y install bzip2					#block-sorting file compressr utility
    sudo apt-get -y install libsnappy-dev			#fast compression/decompression library from Google (optimized for speed, not compression ratio)
    sudo apt-get -y install libminizip-dev			#minizip library

    #libgmp: GNU Multiple Precision (GMP) library
    #Very frequently used as dependency for math programs.
    #https://gmplib.org
    sudo apt-get -y install libgmp-dev		    	#GMP library

    #binutils: GNU binary tools
    #Common dependency, but also gives command-line tools: ar, nm, gprof, addr2line, etc.
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://www.gnu.org/software/binutils
    sudo apt-get -y install binutils				#GNU binutils

    #Perl (Practical Extraction and Report Language):
    #The is the famous first scripting language of Larry Wall, still widely used, and required for many dependencies
    #It is probably already installed and updated, but just to be certain.
    #Wall L, Schwartz RL. 1991. Programming Perl. Sebastopol, CA: O'Reilly.
    #https://www.perl.org
    sudo apt-get -y install perl					#Perl scripting language

    #Debian programs (required by other programs later)
    #Debian was one of the earliest Linux distributions and a precursor to Ubuntu.
    #It is also one of the oldest major free, open-source software (FOSS) projects.
    #Murdock I. 1994. Overview of the Debian GNU/Linux system. Linux journal 6es: Article 15.
    #Zacchiroli S. 2011. Debian: 18 years of free software, do-ocracy, and democracy. Talk presented at Workshop OSDOC. ACM: 87.
    #https://packages.debian.org/sid/debianutils
    #https://manpages.debian.org/jessie/debhelper
    #https://manpages.debian.org/jessie/debconf
    sudo apt-get -y install debianutils				#Debian miscellaneous utilities
    sudo apt-get -y install debhelper				#helper programs for Debian/rules
    sudo apt-get -y install debconf					#Debian configuration management

    #YACC (Yet Another Compiler Compiler) and flex (fast lex)
    #Johnson SC. 1975. Yacc: Yet another compiler-compiler. Report PS1:15. 1-33. Murray Hill, NJ: Bell Labs.
    #Mason T, Brown D. 1990. lex & yacc. Sebastopol, CA: O'Reilly.
    #Donnelly C, Stallman RM. 1992. Bison 1.20: the YACC-compatible parser generator. Manual. Boston: Free Software Foundation.
    #Bennett JP. 1996. Introduction to compiling techniques: a first course using ANSI C, LEX, and YACC. New York: McGraw-Hill.
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://invisible-island.net/byacc
    #https://www.gnu.org/software/bison
    #https://www.gnu.org/software/flex
    sudo apt-get -y install byacc					#Berkeley YACC parser generator
    sudo apt-get -y install bison					#YACC-compatible parser generator
    sudo apt-get -y install flex					#fast lexical analyzer generator

    #Autotools: autoconf (automatic configure script builder), automake and libtool
    #Calcote J. 2010. Autotools: a practitioner's guide to GNU Autoconf, Automake, and Libtool. San Francisco: No Starch Press.
    #https://www.gnu.org/software/autoconf
    #https://www.gnu.org/software/automake
    #https://www.gnu.org/software/libtool
    sudo apt-get -y install autotools-dev			#used by the automake, libtool and other packages (has config files)
    sudo apt-get -y install autoconf				#automatic configure script builder
    sudo apt-get -y install autoconf-archive		#archive of autoconf macros
    sudo apt-get -y install automake				#tool for generating make files compliant to GNU Standards
    sudo apt-get -y install libtool					#generic library support script

    #Yasm (yet another software model-checker) library
    #Modular assembler library (deals with code at the assembly level)
    #Gurfinkel A, Wei O, Chechik M. 2006. Yasm: a software model-checker for verification and refutation. LNCS 4144: 170-174.
    #https://yasm.tortall.net
    sudo apt-get -y install yasm					#Yasm

    #CheckInstall installation tracker
    #Can be used instead of 'make install' to just check.
    #http://asic-linux.com.mx/~izto/checkinstall
    sudo apt-get -y install checkinstall			#CheckInstall

    #OpenSSL: open-source tookit for SSL (Secure Socket Layer) and cryptography in C.
    #Used by many other programs, and gives the openssl command-line tool.
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://www.openssl.org
    sudo apt-get -y install openssl					#OpenSSL

    #Apache portable runtime library
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://apr.apache.org
    sudo apt-get -y install libapr1					#Apache runtime library

    #SQLite 3 (lightweight SQL database)
    #Owens M. 2003. Embedding an SQL database with SQLite. Linux journal 110: 2.
    #Allen G, Owens M. 2010. The definitive guide to SQLite, 2nd Ed. New York: APress.
    #https://www.sqlite.org
    sudo apt-get -y install sqlite3					#SQLite 3

    #SSH (Secure SHell)
    #Carasik AH. 1999. Unix Secure Shell. New York: McGraw-Hill.
    #Barrett DJ, Silverman RE, Byrnes RG. 2005. SSH, the secure shell: the definitive guide, 2nd Ed. Sebastopol, CA: O'Reilly.
    #https://www.ssh.com/ssh
    sudo apt-get -y install ssh						#SSH: this installs both client and server dependencies

    #cmake: cross-platform make
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://cmake.org
    sudo apt-get -y install cmake					#cmake

    #SCons (Software Construction tool)
    #Improved, cross-platform substitute for the classic make utility
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    sudo apt-get -y install scons					#SCons make tool

    #Sub-version: version control system (common in 2000s before git)
    #This gives the svn command, but mainly required for installing certain software still using subversion.
    #Collins-Sussman B, Fitzpatrick BW, Pilato CM. 2004. Version control with Subversion. Sebastopol, CA: O'Reilly.
    #https://subversion.apache.org
    sudo apt-get -y install subversion				#sub-version control system

    #Mercurial: version control system (not common, but required in occasional installs)
    #O'Sullivan B. 2009. Mercurial: the definitive guide. Sebastopol, CA: O'Reilly.
    #https://www.mercurial-scm.org
    sudo apt-get -y install mercurial				#Mercurial

    #Basic/often-used C/C++ libraries and utilities:
    #Johnson SC. 1978. Lint, a C program checker. Report. Murray Hill, NJ: Bell Labs.
    #Johnson MK. 1994. Introduction to the GNU C library. Linux journal 2es: Article 5.
    #Loukides MK, Oram A. 1997. Programming with GNU software. Sebastopol, CA: O'Reilly.
    #Gough BJ. 2005. An introduction to GCC for the GNU compilers gcc and g++. Bristol, UK: Network Theory Ltd.
    #Novillo D. 2006. OpenMP and automatic parallelization in GCC. In: Proc GCC Developers' Summit: 135-144.
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://gcc.gnu.org
    #https://www.gnu.org/software/gdb
    #https://www.gnu.org/software/libc
    #https://gcc.gnu.org/onlinedocs/libstdc++
    #https://gcc.gnu.org/onlinedocs/libgomp
    #https://www.splint.org
    sudo apt-get -y install cpp						#GNU preprocessor for C
    sudo apt-get -y install gcc						#GNU C compiler
    sudo apt-get -y install libgcc1					#GNU GCC support library
    sudo apt-get -y install g++						#GNU C++ compiler
    sudo apt-get -y install gdb						#GNU debugger for C, C++
    sudo apt-get -y install libglib2.0-dev			#GNU GLib C library
    sudo apt-get -y install libglib2.0-cil			#GNU GLib C library CLI binding
    sudo apt-get -y install libstdc++6				#GNU standard C++ library v3
    sudo apt-get -y install libgomp1				#GCC OpenMP (GOMP) support library
    sudo apt-get -y install splint					#improved C lint checker

    #popt: parse options C library
    #This is for C programming, can include popt.h, for better command-line argument parsing
    sudo apt-get - install libpopt0					#popt cmdline parsing library

    #FORTRAN: Classic language for scientific computing, still used in simulations and numerical libraries (LAPACK, etc.)
    #Backus JW, Beeber RJ, et al. 1957. The FORTRAN automatic coding system. In: Proc Western Joint Computer Conference. ACM: 188-198.
    #Press WH, Teukolsky SA, Vetterling WT, Flannery BP. 1986. Numerical recipes: the art of scientific computing. Cambridge, UK: Cambridge University Press.
    #https://gcc.gnu.org/fortran
    sudo apt-get -y install gfortran				#GNU Fortran compiler

    #SWIG (Simplified Wrapper and Interface Generator): converts annotated C/C++ headers
    #to wrapper (glue) code for Perl, Python, Octave, R, etc., etc.
    #Beazley DM. 1996. SWIG: an easy to use tool for integrating scripting languages with C and C++. USENIX Annual Tcl/Tk Workshop, vol. 4, ACM.
    #Beazley DM. 2003. Automated scientific software scripting with SWIG. Future generation computer systems 19(5): 599-509.
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #http://www.swig.org
    sudo apt-get -y install swig

    #Libraries for common image formats: JPEG, GIF, TIFF, PNG
    #These libraries are widely used by other programs, especially those that deal with images (e.g. Netpbm, R, etc.).
    #PNG images (Portable Network Graphics) are replacement for GIF; most widely used lossless format on Internet;
    #allows alpha channel and other transparency options; my usual choice for image format!
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://www.ijg.org
    #http://giflib.sourceforge.net
    #http://www.libpng.org
    #http://www.libtiff.org
    sudo apt-get -y install libjpeg8-dev			#JPEG image library
    sudo apt-get -y install libgif7					#GIF image library
    sudo apt-get -y install libpng-dev				#PNG image library (also MNG and JNG image formats)
    sudo apt-get -y install libtiff-dev				#TIFF library
    sudo apt-get -y install libtiff5-dev			#TIFF library

    #X11 windows system (or simply "X")
    #Long-developed (since1 1980s) windows system for UNIX/LINUX.
    #This is dependency for many other installs (OpenGL, etc.)
    #Scheifler RW, Gettys J. 1986. The X window system. ACM Trans Graph 5(2): 79-109.
    #Jones O. 1989. Introduction to the X Window System. Englewood Cliffs, NJ: Prentice Hall.
    #Scheifler RW, Gettys J, Mento A, Converse D. 1996. X Window System: core library and standards; X version 11, releases 6 and 6.1. Boston: Digital Press.
    #https://www.x.org/wiki
    sudo apt-get -y install libx11-6				#X11 Windows system, client-side library
    sudo apt-get -y install xclip					#command-line interface to X selections (like ctrl-c)
    sudo apt-get -y install xfonts-utils			#X font utilities
    sudo apt-get -y install xfonts-75dpi			#75dpi xfonts

    #Cairo 2D graphics library (requires X11 dependencies)
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://cairographics.org
    sudo apt-get -y install libcairo2				#Cairo 2D graphics library

    #ICU (International Components for Unicode)
    #Standard for ~100k international characters.
    #Gillam R. 2003. Unicode demystified: a practical programmer's guide to the encoding standard. Boston: Addison-Wesley.
    #http://site.icu-project.org
    sudo apt-get -y install libicu-dev				#ICU library

    #Wget (WWW get): retrieve files from the Web
    #Niksic H, Scrivano G, Ruhsen T. 2016. GNU Wget 1.18. Manual. Free Software Foundation: https://www.gnu.org/software/wget/manual/.
    #https://www.gnu.org/software/wget
    sudo apt-get -y install wget					#wget

    #cURL (client URL): library and command-line tool for client-side URL transfer
    #Must be considered one of the most successful command-line tools of all time (used billions of times per week I think).
    #Stenberg D. 2001. The art of scripting HTTP requests using curl, version 0.6. Stockholm, Sweden: https://curl.haxx.se/.
    #Stenberg D. 2018. curl://. The complete guide to all there is to know about the curl project. Stockholm, Sweden: https://curl.haxx.se/.
    sudo apt-get -y install libcurl4-gnutls-dev		#cURL (GnuTLS flavour)

    #Common Linux command-line tools
    #Cherry LL, Morris RH. 1978. BC – an arbitrary precision desk-calculator language. Murray Hill, NJ: Bell Labs.
    #Oualline S. 2001. Vi IMproved, Vim. Indianapolis, IN: New Riders.
    #Robbins A, Hannah E, Lamb L. 2008. Learning the vi and Vim editors. Sebastopol, CA: O'Reilly.
    #https://www.gnu.org/software/bc
    #https://www.vim.org
    sudo apt-get -y install bc						#basic calculator (original Unix tool, still widely used)
    sudo apt-get -y install vim						#Vi IMproved (improved vi text editor)

    #Z shell: shell with extra features compared to bash
    #This is large (14 MB), but is required in other package installs.
    #http://www.zsh.org/
    sudo apt-get -y install zsh						#Z shell

    #JSON (JavaScript Object Notation) files
    #Crockford D. 2006. The application/json media type for JavaScript Object Notation (JSON). Memo, RFC 4627: The Internet Society.
    #Bray T. 2017. The JavaScript Object Notation (JSON) data interchange format. Memo, RFC 8259: Internet Engineering Task Force (IETF).
    #Marrs T. 2017. JSON at work: practical data integration for the web. Sebastopol, CA: O'Reilly.
    #https://www.json.org
    sudo apt-get -y install libjansson-dev			#C library for encoding, decoding and manipulating JSON data
    sudo apt-get -y install jshon					#command-line tool to parse, read and create JSON
    sudo apt-get -y install jq						#lightweight and flexible command-line JSON processor (like sed for JSON data)

    #Git: most common revision control system (i.e. as used by GitHub)
    #Swicegood T. 2008. Pragmatic version control using Git. Raleigh, NC: Pragmatic.
    #Loeliger J, McCullough M. 2012. Version control with Git, 2nd Ed. Sebastopol, CA: O'Reilly.
    #https://git-scm.com
    sudo apt-get -y install git						#git

    #Linear algebra libraries (heavily used by other software)
    #Dongarra JJ, Du Croz J, Hammarling S, Duff IS. 1990. A set of level 3 basic linear algebra subprograms. ACM Trans Math Softw 16(1): 1-17.
    #Whaley RC, Dongarra JJ. 1998. Automatically tuned linear algebra software. IEEE/ACM Conf Supercomputing.
    #Anderson E, Bai Z, et al. 1999. LAPACK users' guide, 3rd Ed. Philadelphia: SIAM.
    #Blackford LS, Demmel JW, et al. 2002. An updated set of basic linear algebra subprograms (BLAS). ACM Trans Math Softw 28(2): 135-151.
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #Zhang X, Wang Q, Saar W. 2016. OpenBLAS: an optimized BLAS library. http://www.openblas.net.
    #http://www.netlib.org/lapack
    sudo apt-get -y install libblas-dev				#BLAS (Basic Linear Algebra Subroutines) (also installs libblas3)
    sudo apt-get -y install libopenblas-dev			#open BLAS
    sudo apt-get -y install liblapack-dev			#LAPACK: linear algebra package
    sudo apt-get -y install liblapacke-dev          #LAPACK: (this version required for ArrayFire)
    sudo apt-get -y install libatlas-base-dev		#ATLAS (Automatically Tuned Linear Algebra Software)

    #GNU scientific library (GSL): widely used numerical/scientific libraries in C
    #This also installs libgsl23 and libgslcblas0
    #Galassi M, Davies J, et al. 2009. GNU scientific library reference manual, 3rd Ed. Bristol, UK: Network Theory Ltd.
    #https://www.gnu.org/software/gsl
    sudo apt-get -y install libgsl-dev				#GNU GSL

    #Eigen3: lightweight, high-level C++ template library for linear algebra (under excellent MPL2 license for FOSS)
    #Guennebaud G, Jacob B. 2010. Eigen v3. http://eigen.tuxfamily.org.
    sudo apt-get -y install libeigen3-dev			#eigen3 library
    #sudo apt-get -y install libeigen3-doc			#eigen3 documentation

    #FFTW3: "fastest FFT in the West" library, v3
    #Widely-used (Octave, Python, etc.) library for fast Fourier transform (FFT)
    #Frigo M, Johnson SG. 2005. The design and implementation of FFTW3. Proc IEEE 93(2): 216-231.
    #http://www.fftw.org
    sudo apt-get -y install fftw3-dev				#FFTW3 FFT library

    #Boost C++ libraries
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://www.boost.org
    sudo apt-get -y install libboost-all-dev		#Boost C++ libraries

    #NVIDIA CUDA Profiler Tools Interface (CUPTI) [not just for GPUs, needed by other installs]
    #https://developer.nvidia.com/CUPTI
    sudo apt-get -y install libcupti-dev			#NVIDIA CUPTI
    #sudo apt-get -y install nvidia-cuda-toolkit        #NVIDIA CUDA toolkit
    #sudo apt-get -y install nvidia-opencl-dev          #openCL library for NVIDIA

    #Also consider Blitz++: C++ template class library for scientific computing
    #But I understand that: although great at its time, Blitz++ is no longer actively developed, so better use Armadillo.
    #sudo apt-get -y install libblitz0-dev			#Blitz++ library

    #Armadillo: streamlined, template-based C++ linear algebra library (meant to resemble Matlab, used by MLPACK)
    #Sanderson C, Curtin R. 2016. Armadillo: a template-based C++ library for linear algebra. J Open Source Softw 1(2): 26, 1-2.
    #Sanderson C, Curtin R. 2019. Practical sparse matrices in C++ with hybrid storage and template-based expression optimisation. Math Comput Appl 24(3).
    #http://arma.sourceforge.net
    sudo apt-get -y install libarmadillo-dev		#Armadillo

    #Argtable 2: ANSI C library for parsing GNU-style command-line options
    #http://argtable.sourceforge.net
    sudo apt-get -y install libargtable2-dev           #argtable2

    #Ruby scripting language.
    #Required by other installs (e.g., TeXLive).
    sudo apt-get -y install ruby					#Ruby

    #UFT-8 with C++: portable C++ library for Unicode strings
    #http://utfcpp.sourceforge.net
    sudo apt-get -y install libutfcpp-dev           #UTF-8 with C++

    #FreeType 2 font engine in C (small, efficient, widely used as dependency)
    #https://www.freetype.org
    sudo apt-get -y install libfreetype6			#FreeType font library

    #TeX: famous typesetting system by Knuth
    #Knuth DE. 1984. The TeXbook. Reading, MA: Addison-Wesley.
    #http://tug.org
    sudo apt-get -y install tex-common				#common infrastructure for TeX
    sudo apt-get -y install texinfo					#documentation system for TeX

    #OpenCL: Open Computing Language, a C-like language for executing on heterogeneous platforms.
    #This is used extensively by other software (ArrayFire, etc.)
    #https://www.khronos.org/opencl
    sudo apt-get -y install opencl-headers             #OpenCL headers (C and C++)
    sudo apt-get -y install python3-pyopencl           #Python3 module to access OpenCL

    #Clang: compiler front-end for C family languages (C/C++, Objective C/C++, OpenMP, OpenCL, CUDA)
    #This is way down here, because it requires Python and JSON.
    #Lattner C. 2008. LLVM and Clang: next generation compiler technology. Talk given at BSD Conference: llvm.org.
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://clang.llvm.org
    sudo apt-get -y install clang					#Clang

    #Doxygen: documentation system for C/C++, Java, Python, etc.
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #http://www.doxygen.org/
    sudo apt-get -y install doxygen					#documentation generation

    #Avahi: zero-configuration networking library
    #Often required by other programs.
    #https://www.avahi.org
    sudo apt-get -y install libavahi-client3		#Avahi client (also instals Avahi common)

    #CUPS: Common UNIX Printing System
    #This is often required by other programs.
    #https://www.cups.org
    sudo apt-get -y install libcups2 libcupsimage2	#CUPS

    #Python 3
    #van Rossum G. 1993. An introduction to Python for UNIX/C programmers. Dutch UNIX Users Group: 1-8.
    #Behnel S, Bradshaw R, Citro C, Dalcin L, Seljebotn DS, Smith KW. 2011. Cython: the best of both worlds. Comput Sci Eng 13(2): 31-39.
    #Oliphant TE. 2015. A guide to NumPy, 2nd Ed. Austin, TX: Continuum Press.
    #van Rossum G. 2016. Python tutorial: release 3.5.1. Wilmington, DE: Python Software Foundation.
    #McKinney W. 2018. Python for data analysis: data wrangling with Pandas, NumPy, and IPython, 2nd Ed. Sebastapool, CA: O'Reilly.
    #https://www.python.org
    #http://www.numpy.org
    #https://pandas.pydata.org
    #https://www.scipy.org
    sudo apt-get -y install python3-dev				#Python 3
    #sudo apt-get -y install python3-pip				#Python 3 package installer
    sudo apt-get -y install python3-setuptools		#Python 3 distutils enhancements
    sudo apt-get -y install python-wheel			#Python 3 built-package format
    sudo apt-get -y install python3-numpy			#Python 3 NumPy array library
    sudo apt-get -y install python3-pandas			#Python 3 Pandas library for data structures
    sudo apt-get -y install python3-scipy			#Python 3 SciPy library
    sudo apt-get -y install python3-six				#Python 2,3 compatibility library
    sudo apt-get -y install cython3					#Cython C extensions for Python 3

    #Snap package management (basic Linux, but requires Python3)
    #https://snapcraft.io
    #https://wiki.archlinux.org/index.php/Snap
    sudo apt-get -y install snapd					#Snap daemon (to run snaps)
    sudo apt-get -y install snapd-xdg-open			#For opening links from snaps in desktop

    #JavaScript
    #Flanagan D. 1996. JavaScript: the definitive guide. Sebastopol, CA: O'Reilly.
    #https://www.javascript.com
    sudo apt-get -y install javascript-common		#JavaScript

    #Google performance tools
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://github.com/gperftools/gperftools
    sudo apt-get -y install libgoogle-perftools-dev	#Google libraries for CPU and heap analysis, and an efficient thread-caching malloc
    sudo apt-get -y install google-perftools		#Google command-line tools to analyze performance of C++ programs

    #glags: Google command-line flags library in C++
    #https://gflags.github.io/gflags/
    sudo apt-get -y install libgflags-dev libgflags2v5  #gflags

    #glog: Google logging library in C++
    #https://github.com/google/glog
    sudo apt-get -y install libgoogle-glog-dev libgoogle-glog0v5

    #Lua scripting language (small footprint C code, so doesn't take much space)
    #Ierusalimschy R, de Figueiredo LH, Filho WC. 1996. Lua – an extensible extension language. Softw Pract Exp 26(6):635-652.
    #Ierusalimschy R. 2016. Programming in Lua, 4th Ed. Rio de Janeiro, Brazil: lua.org.
    #https://www.lua.org
    sudo apt-get -y install lua5.3					#Lua

    #txt2man: converts ASCII text to manpage format (used by other programs)
    #https://github.com/mvertes/txt2man
    sudo apt-get -y install txt2man                 #txt2man

    #PostgreSQL: heavier SQL database, open-source, one of the original SQL databases (1980s origins)
    #Stonebraker MR, Rowe LA, Hirohama M. 1990. The implementation of POSTGRES. IEEE Trans Knowl Data Eng 2(1): 125-142.
    #https://www.postgresql.org
    sudo apt-get -y install postgresql-client		#Postgre 10+ SQL database, client side

    #Markdown: minimal mark-up language, and text-to-HTML converter
    sudo apt-get -y install markdown				#markdown text-to-html conversion tool

    #bibutils: converts to/from .bib files and .xml, etc.
    #https://sourceforge.net/p/bibutils/home/Bibutils
    #http://bibutils.refbase.org
    sudo apt-get -y install bibutils                #bibutils

    #bibtexconv: BibTeX Converter (to XML, text).
    #Can also be use to verify ISBNs, ISSNs, and URLs.
    #http://manpages.ubuntu.com/manpages/bionic/man1/bibtexconv.1.html
    #https://www.uni-due.de/~be0001/bibtexconv
    sudo apt-get -y install bibtexconv				#BibTeX converter

    #bibtex2html: filters BibTeX files and converts to HTML
    #https://www.lri.fr/~filliatr/bibtex2html
    sudo apt-get -y install bibtex2html				#bibtex2html converter

    #Pandoc (requires texlive): free document converter ("pan-document")
    #Converts between Markdown, HTML, LaTeX, etc.
    sudo apt-get -y install pandoc					#pan-document converter

    #Shell script checker/lint tool. Highly recommended if you write bash scripts.
    #https://www.shellcheck.net/
    sudo apt-get -y install shellcheck				#shell script checker

    #csvtool: toolkit for csv (comma-separated values) files
    #csvtool is older and available for older versions of Ubuntu, whereas csvkit is requires newer Ubuntu version.
    #https://colin.maudry.com/csvtool-manual-page
    sudo apt-get -y install csvtool

    #SuiteSparse: widely used (Google, MathWorks, NSF, Nvidia, Intel, etc.).
    #library of sparse matrix algorithms (GraphBLAS, UMFPACK, CHOLMOD, SPQR, KLU, etc.).
    #This is required by the GLPK and other installs below.
    #http://faculty.cse.tamu.edu/davis/suitesparse.html
    sudo apt-get -y install libsuitesparse-dev		#SuiteSparse

    #GLPK: GNU linear programming kit in C
    #Koranne S. 2011. Handbook of open source tools. New York: Springer.
    #https://www.gnu.org/software/glpk
    sudo apt-get -y install libglpk-dev				#GLPK

    #GNU Parallel: shell tool for executing jobs in parallel: https://www.gnu.org/software/parallel
    #Tange O. 2011. GNU parallel: the command-line power tool. USENIX magazine 36(1): 42-47.
    #https://www.gnu.org/software/parallel
    sudo apt-get -y install parallel				#GNU parallel

    #TBB (Threading Building Blocks)
    #Widely-used library to easily write parallel (multicore) C++ programs.
    #Reinders J. 2007. Intel threading building blocks: outfitting C++ for multi-core processor parallelism. Sebastopol, CA: O'Reilly.
    #https://www.threadingbuildingblocks.org
    sudo apt-get -y install libtbb-dev				#TBB library

    #htop: like top to monitor system
    #https://hisham.hm/htop/
    sudo apt-get -y install htopW

    #libsamplerate: sample rate converter (SRC) for audio (used below)
    #http://www.mega-nerd.com/SRC
    sudo apt-get -y install libsamplerate0				#libsamplerate

    #ALSA (Advanced Linux Sound Architecture) library: provides audio and MIDI functionality to Linux.
    #Audio interfaces, sound drivers, support for Open Sound System (OSS).
    #Used by most audio and video programs if running on Linux.
    #Phillips D. 2000. Linux music & sound. San Francisco: No Starch Press.
    #Tranter J. 2004. Introduction to sound programming with ALSA. Linux J: 6735.
    #Newmarch J. 2017. Linux sound programming. New York: Apress.
    #https://www.alsa-project.org
    sudo apt-get -y install libasound2-dev				#ALSA Linux sound library

    #Ogg library.
    #Ogg is a multimedia container format (for video).
    #https://xiph.org/ogg
    sudo apt-get -y install libogg-dev					#Ogg library

    #Vorbis general audio compression codec (non-proprietary)
    #https://xiph.org/vorbis
    sudo apt-get -y install libvorbis-dev				#Vorbis library

    #FLAC (Free Lossless Audio Codec) C library.
    #FLAC is an audio format similar to mp3, but lossless.
    #FLAC is said to be the fastest and most widely supported lossless audio codec, and the only non-proprietary one.
    #This yields the flac command.
    #https://xiph.org/flac
    sudo apt-get -y install libflac-dev					#FLAC audio library
    sudo apt-get -y install flac						#flac command-line tool

    #OpenCORE audio codecs AMR-NB and AMR-WB (required by e.g. sox)
    #https://sourceforge.net/projects/opencore-amr
    sudo apt-get -y install libopencore-amrnb0			#OpenCORE AMR-NB codec
    sudo apt-get -y install libopencore-amrwb0			#OpenCORE AMR-WB codec

    #Opus Interactive Audio Codec: open, versatile audio codec
    #Valin J-M, Vos K, Terriberry TB. 2012. Definition of the Opus audio codec. IETF, RFC6716: 326 p.
    #Valin J-M, Maxwell G, Terriberry TB, Vos K. 2016. High-quality, low-delay music coding in the Opus codec. arXiv 1602.04845: 10 p.
    #http://www.opus-codec.org
    sudo apt-get -y install libopus-dev					#Opus codec
    #sudo apt-get -y install opus-tools					#Opus command-line tools

    #Speex: free codec for speech (used by below and Kaldi) (BSD licence)
    #Valin J-M. 2007. The Speex codex manual: version 1.2 beta 3. xiph.org.
    #https://www.speex.org
    sudo apt-get -y install libspeex-dev				#Speex codec

    #WavPack: hybrid lossless audio compression (used by e.g. sox)
    #http://www.wavpack.com
    sudo apt-get -y install wavpack						#WavPack

    #libsndfile: C library for reading/writing audio files.
    #Not likely to be directly useful, given SoX and FFmpeg, but likely dependency.
    #http://www.mega-nerd.com/libsndfile
    sudo apt-get -y install libsndfile1-dev				#libsndfile audio read/write library

    #libaudiofile: SGI's audiofile library
    #This is only needed for GNU sound library (for conversions, use SoX and FFmpeg)
    #https://audiofile.68k.org
    sudo apt-get -y install libaudiofile-dev			#SGI's audiofile library

    #GSM lossy speech compressor (used by ccAudio2, sox, etc.)
    #http://www.quut.com/gsm
    sudo apt-get -y install libgsm1						#GSM speech compressor

    #GNU ccAudio2: GNU C++ library for manipulating audio data.
    #https://www.gnu.org/software/ccaudio
    sudo apt-get -y install libccaudio2-2				#GNU ccAudio2

    #SoX: "Sound Exchange" library for audio processing, conversion and effects.
    #Long developed (since 1991); the "Swiss army knife of sound processing"
    #http://sox.sourceforge.net
    sudo apt-get -y install sox							#SoX audio library

    #FFmpeg: audio/video conversion, processing, streaming and playing
    #Stands for "Fast-forward MPEG", but is very general/useful program for wide range of audio and video.
    #Installs quite a few more audio and video related dependencies.
    #https://www.ffmpeg.org
    sudo apt-get -y install ffmpeg						#FFmpeg audio/video library

    #Praat: heavily-used audio/speech GUI and scripting software.
    #Boersma P, van Heuven V. 2002. Praat, a system for doing phonetics by computer. Glot international 5(9/10): 341-345.
    #http://www.fon.hum.uva.nl/praat
    sudo apt-get -y install praat						#Praat

fi


#Stage 2: ML and ASR
if [[ "$stage" == [02] ]]
then

    #Intel MKL (Intel Math Kernel Library) (required by Kaldi)
    #https://software.intel.com/en-us/mkl
    #wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
    #sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
    #sudo wget https://apt.repos.intel.com/setup/intelproducts.list -O /etc/apt/sources.list.d/intelproducts.list
    #sudo apt-get update
    #sudo apt-get upgrade
    #sudo apt-get -y install intel-mkl-2019.4-070
    #sudo apt-get -y install intel-ipp-2019.4-070
    #sudo apt-get -y install intel-tbb-2019.6-070
    #sudo apt-get -y install intel-daal-2019.4-070
    #sudo apt-get -y install intel-mpi-2019.4-070
    sudo apt-get -y install intelpython2
    sudo apt-get -y install intelpython3

    #OpenCV: Open-source Computer Vision library.
    #Very widely used (>47k users, >14 million downloads) library of optimized C/C++ code.
    #It can be used by openSMILE.
    #Requires OpenCL and a variety of other dependencies (https://www.learnopencv.com/install-opencv3-on-ubuntu).
    #https://opencv.org
    sudo apt-get -y install libopencv*				#OpenCV

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

    #ArrayFire: high performance C++ library for GPU and parallel computing with an easy-to-use API.
    #Has backends for CPU, OpenCL and NVIDIA/CUDA.
    #Extensive functions (whole libraries) built on top, e.g. Forge for data visualization, etc.
    #The following is for basic install; see setup7 for the custom install into /opt.
    #http://arrayfire.org
    sudo apt-get -y install libarrayfire-dev         #ArrayFire
    sudo apt-get -y install libarrayfire-cpu3        #ArrayFire CPU backend
    sudo apt-get -y install libarrayfire-unified3    #ArrayFire unified backend
    #sudo apt-get -y install python3-arrayfire        #Python3 bindings

    #CDD library: C-library for finding vertices of convex polytopes
    #https://www.inf.ethz.ch/personal/fukudak/cdd_home
    sudo apt-get -y install libcdd-dev			#CDD library

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

    #Caffe: deep learning framework in C++ (2-clause BSD licence).
    #Has API with function list; excellent speed; background is computer vision.
    #Tutorials for ImageNet, CIFAR-10, and image classification using low-level C++ API.
    #Jia Y, Darrell T. 2014. Caffe: Convolutional architecture for fast feature embedding. arXiv. 1408.5093.
    #http://caffe.berkeleyvision.org
    sudo apt-get -y install cafe-cuda			#Caffe
    sudo apt-get -y install cafe-tools-cuda		#Caffe tools

    #OpenMPI: widely-used (e.g. flashlight, etc.) message-passing interface library
    sudo apt-get -y install openmpi-bin openmpi-common libopenmpi-dev  #OpenMPI

    #Torch C++ (used by e.g. PyTorch)
    sudo apt-get -y install libtorch3-dev       #Torch
fi


#Stage 3: manual installs into /opt
if [[ "$stage" == [03] ]]
then
    #Cereal serialization C++ library
    #https://uscilab.github.io/cereal
    cd /opt
    git clone https://github.com/USCiLab/cereal
    chmod -R 777 /opt/cereal

    #PyTorch C++ API
    #This is for the CPU-only version (try GPU version later).
    #https://pytorch.org/cppdocs/
    cd /opt
    wget -P /opt https://download.pytorch.org/libtorch/nightly/cpu/libtorch-shared-with-deps-latest.zip
    unzip -d /opt/libtorch libtorch-shared-with-deps-latest.zip
    rm /opt/libtorch-shared-with-deps-latest.zip
    chmod -R 777 /opt/libtorch

    #Flashlight: C++ library from Facebook for general ML
    #https://github.com/facebookresearch/flashlight
    #https://fl.readthedocs.io/en/latest
    cd /opt
    git clone https://github.com/facebookresearch/flashlight.git
    export MKLROOT=/opt/intel/mkl
    cd /opt/flashlight
    mkdir -p build
    cd /opt/flashlight/build
    # Create flashgood dir and use following command 
    cmake CMAKE_INSTALL_PREFIX=/opt/flashgood .. -DCMAKE_BUILD_TYPE=Release -DFLASHLIGHT_BACKEND=CUDA
    make -j4
    make install
    make test

    #OpenFST
    cd /opt
    wget http://www.openfst.org/twiki/pub/FST/FstDownload/openfst-1.7.6.tar.gz
    tar -xvf /opt/openfst-1.7.6.tar.gz
    rm /opt/openfst-1.7.6.tar.gz
    chmod -R 777 /opt/openfst-1.7.6
    mv /opt/openfst-1.7.6 /opt/openfst
    cd /opt/openfst
    #./configure --enable-static --enable-shared --enable-far --enable-pdt --enable-mpdt --enable-python
    sed -i 's| -std=c++11| -std=c++14|' ./configure  #required for enable-ngram-fsts
    ./configure --enable-static --enable-shared --enable-far --enable-pdt --enable-mpdt --enable-python --enable-ngram-fsts #needed for OpenGRM
    make
    sudo make install
    chmod -R 777 /opt/openfst

    #OpenGRM
    cd /opt
    wget http://www.opengrm.org/twiki/pub/GRM/NGramDownload/ngram-1.3.9.tar.gz
    tar -xvf /opt/ngram-1.3.9.tar.gz
    rm /opt/ngram-1.3.9.tar.gz
    mv /opt/ngram-1.3.9 /opt/ngram
    cd /opt/ngram
    ./configure
    make
    sudo make install
    chmod -R 777 /opt/ngram

    #OpenGrm Pynini
    cd /opt
    wget http://www.opengrm.org/twiki/pub/GRM/PyniniDownload/pynini-2.1.0.tar.gz
    tar -xvf /opt/pynini-2.1.0.tar.gz
    rm /opt/pynini-2.1.0.tar.gz
    chmod -R 777 /opt/pynini-2.1.0
    mv /opt/pynini-2.1.0 /opt/pynini
    cd /opt/pynini
    sudo python setup.py install
    python setup.py test

    #KenLM
    cd /opt
    wget https://kheafield.com/code/kenlm.tar.gz
    tar -xzf /opt/kenlm.tar.gz
    rm /opt/kenlm.tar.gz
    chmod -R 777 /opt/kenlm
    cd /opt/kenlm
    mkdir -m 777 /opt/kenlm/build
    cd /opt/kenlm/build
    cmake .. -DCMAKE_BUILD_TYPE=Release -DKENLM_MAX_ORDER=20 -DCMAKE_POSITION_INDEPENDENT_CODE=ON
    make -j2
    chmod -R 777 /opt/kenlm

    #MIT LM
    cd /opt
    git clone https://github.com/mitlm/mitlm
    chmod -R 777 /opt/mitlm
    cd /opt/mitlm
    ./autogen.sh
    make
    sudo make install
    chmod -R 777 /opt/mitlm

    #word2vec: the classic C-code implementation by Mikolov (Apache 2.0 license).
    #Mikolov T et al. (2013a,b,c).
    #https://code.google.com/p/word2vec/
    #https://github.com/tmikolov/word2vec
    cd /opt
    git clone https://github.com/tmikolov/word2vec
    chmod -R 777 /opt/word2vec
    cd /opt/word2vec
    make
    chmod -R 777 /opt/word2vec

    #CRFSuite: fast C++ implementation of Conditional Random Fields (CRFs)
    #Linear-chain (1st-order Markov) CRFs.
    #Excellent training methods, simple command-line use, performance evaluation.
    #From maker of widely-used L-BFGS lib
    #http://www.chokkan.org/software/crfsuite
    wget https://github.com/downloads/chokkan/crfsuite/crfsuite-0.12.tar.gz
    tar -xzf /opt/crfsuite-0.12.tar.gz
    rm /opt/crfsuite-0.12.tar.gz
    chmod -R 777 crfsuite-0.12
    mv /opt/crfsuite-0.12 /opt/crfsuite
    cd /opt/crfsuite
    ./configure
    make
    sudo make install
    sudo ln -s /usr/local/lib/libcrfsuite-0.12.so /usr/lib/libcrfsuite-0.12.so
    sudo ln -s /usr/local/lib/libcqdb-0.12.so /usr/lib/libcqdb-0.12.so
    sudo ln -s /usr/local/bin/crfsuite /usr/bin/crfsuite-stdin

    #Speex (needed by Kaldi, even though already sudo apt-get -y installed)
    #Valin J-M. 2007. The Speex codex manual: version 1.2 beta 3. xiph.org.
    #https://www.speex.org
    cd /opt
    wget http://downloads.xiph.org/releases/speex/speex-1.2rc1.tar.gz
    tar -xzf /opt/speex-1.2rc1.tar.gz
    rm /opt/speex-1.2rc1.tar.gz
    chmod -R 777 /opt/speex-1.2rc1
    mv /opt/speex-1.2rc1 /opt/speex
    cd /opt/speex
    ./configure --prefix=/opt/speex/build
    make
    sudo make install
    sudo chmod -R 777 /opt/speex

    #Kaldi: Part I
    #Can add to your .bashrc script:
    #nvidia-smi -c 3
    #nvidia-smi -c 1
    #kaldir=/opt/kaldi
    cd /opt
    git clone https://github.com/kaldi-asr/kaldi.git kaldi --origin upstream
    chmod -R 777 /opt/kaldi
    cd /opt/kaldi/tools
    ln -s /opt/speex/build speex
    /opt/kaldi/tools/extras/check_dependencies.sh
    #This should end with 'OK'

    #IRSTLM (GNU LGPL licence)
    #Basic install fails (with err msg compatible with: requires older version of gcc).
    #So, after download Kaldi (but not install), do:
    cd /opt
    git clone https://github.com/irstlm-team/irstlm
    chmod -R 777 /opt/irstlm
    cd /opt/irstlm
    sed -i 's|AM_CONFIG_HEADER|AC_CONFIG_HEADERS|' configure.ac
    patch -p1 < /opt/kaldi/tools/extras/irstlm.patch
    ./regenerate-makefiles.sh || ./regenerate-makefiles.sh
    ./configure --prefix '/opt/irstlm'
    make
    sudo make install
    chmod -R 777 /opt/irstlm
    [ -f /opt/kaldi/tools/extras/env.sh ] || echo -n > /opt/kaldi/tools/extras/env.sh
    echo "export IRSTLM=$tooldir/irstlm" >> /opt/kaldi/tools/extras/env.sh
    echo "export PATH=\${PATH}:\${IRSTLM}/bin" >> /opt/kaldi/tools/extras/env.sh
    chmod 777 /opt/kaldi/tools/extras/env.sh

    #SRILM
    #First fill out form at: http://www.speech.sri.com/projects/srilm/download.html
    #mkdir -m 777 /opt/srilm
    #mv ~/Downloads/srilm-1.7.2.tar.gz /opt/srilm
    cd /opt/srilm
    tar -xzf /opt/srilm/srilm-1.7.2.tar.gz
    sed -i 's|# SRILM = .*|SRILM = /opt/srilm|' /opt/srilm/Makefile
    mtype=$(/opt/srilm/sbin/machine-type)
    echo "HAVE_LIBLBFGS=1" >> /opt/srilm/common/Makefile.machine."$mtype"
    grep 'ADDITIONAL_INCLUDES' /opt/srilm/common/Makefile.machine."$mtype" |
    sed 's|$| -I$(SRILM)/../liblbfgs-1.10/include|' >> /opt/srilm/common/Makefile.machine."$mtype"
    grep 'ADDITIONAL_LDFLAGS' /opt/srilm/common/Makefile.machine.$mtype |
    sed 's|$| -L$(SRILM)/../liblbfgs-1.10/lib/ -Wl,-rpath -Wl,$(SRILM)/../liblbfgs-1.10/lib/|' \
    >> /opt/srilm/common/Makefile.machine."$mtype"
    make
    echo "export SRILM=$tooldir/srilm" >> /opt/kaldi/tools/extras/env.sh
    dirs="\${PATH}"
    for dir in $(find bin -type d)
    do dirs="$dirs:\${SRILM}/$dir"
    done
    echo "export PATH=$dirs" >> /opt/kaldi/tools/extras/env.sh

    #Kaldi: Part II
    cd /opt/kaldi/tools
    make -j 8
    cd /opt/kaldi/src
    sudo apt-get -y install gcc-6 g++-6
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 100
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 100
    ./configure --shared --static --static-math --mathlib=MKL --mkl-root="/opt/intel/mkl" --use-cuda --cudatk-dir="/usr/local/cuda" --speex-root="/opt/speex/build"
    make -j clean depend 
    make -j 8
    sudo chmod -R 777 /opt/kaldi
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 100

    #Kaldi: Part III
    #I found later that I have to add links to OpenFST libraries
    ln -s /usr/local/lib/libfst.so.19 /opt/kaldi/tools/openfst-1.6.7/lib
    ln -s /usr/local/lib/libfstscript.so.19 /opt/kaldi/tools/openfst-1.6.7/lib
    ln -s /usr/local/lib/libfstfar.so.19 /opt/kaldi/tools/openfst-1.6.7/lib
    ln -s /usr/local/lib/libfstfarscript.so.19 /opt/kaldi/tools/openfst-1.6.7/lib
fi

