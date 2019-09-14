#!/bin/bash
#Run this script upon launching a new Linux Ubuntu instance.
#This script installs basic Linux utilities and common dependencies for other software.
#
#This includes package managers, compression utilities, bc, vim, doxygen, etc.
#The universe of C coding (upon which so much else depends) is installed:
#GNU C/C++ libraries, GSL, make, valgrind, FFTW, Eigen3, BLAS, ATLAS, Boost, Armadillo, Google Performance Tools, etc. 
#Other basic programming and scripting languages: C/C++, Perl, Python, Ruby, Java, JavaScript.
#Major Internet and version control utilities are installed: SSH, cURL, wget, git, subversion, bazel, etc.
#It also installs the very widely-used: SQLite, JSON, FreeType, TeX, etc.
#
#All packages in this script can be obtained by apt-get install (see https://packages.ubuntu.com).
#
#Unwanted packages can be commented out. But few extraneous packages are included here; these show up in later dependencies.
#To later remove an unwanted package, use: sudo apt remove <pkgname>
#
#For each tool, I provide references and the main website.
#The references should help the user appreciate: ML and NLP work rests on decades of computer science research and effort.
#As the expression says, we stand on the shoulders of giants...
#For further information on any tool, search Google, Wikipedia, or the Free Software Directory (https://directory.fsf.org).
#
#Coded by: Erik Edwards, Oct 2018.


#Basic Linux dependencies
#sudo apt update									#updates package lists for upgrades
#sudo apt -y upgrade								#uses the updated package list to update packages on the system (takes a long time the first time)
#sudo apt -y dist-upgrade						#same as upgrade, but also handles changing dependencies (probably does nothing here, but just in case)
#sudo apt-get -y install build-essential			#refers to many packages needed for building software in general
#sudo apt-get -y install pkg-config				#manages library compile and link flags
#sudo apt-get -y install dpkg					#Debian package management system (Debian is early Linux OS) (should already be there, but just in case)
#sudo apt -y autoremove							#automatically removes packages that are no longer required


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


#X11 windows system (or simply "X")
#Long-developed (since1 1980s) windows system for UNIX/LINUX.
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


#HDF5 (Hierarchical Data Format, v.5): file formats to store/organize large amounts of data
#Folk MJ, McGrath RE, Yeager NJ. 1999. HDF: an update and future directions. IGARSS. IEEE: 273-275.
#Poinot M. 2010. Five good reasons to use the hierarchical data format. Computing in science & engineering 12(5): 84-90.
#Folk MJ, Heber G, Koziol Q, Pourmal E, Robinson D. 2011. An overview of the HDF5 technology suite and its applications. EDBT/ICDT Workshop AD. ACM: 36-47.
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#Collette A. 2013. Python and HDF5. Sebastopol, CA: O'Reilly.
#https://www.hdfgroup.org
sudo apt-get -y install libhdf5-dev				#HDF5 library
sudo apt-get -y install libhdf5-serial-dev		#HDF5 serial library
sudo apt-get -y install hdf5-tools				#HDF5 command-line tools


#Tcl (Tool command language) and Tk (Tcl toolkit).
#This also installs lots of dependencies related to X windowing.
#Ousterhout JK. 1994. Tcl and the Tk toolkit. Reading, MA: Addison-Wesley.
#https://www.tcl.tk
sudo apt-get -y install tk						#Toolkit for Tcl and X11 windowing (also installs tcl)


#XML (Extensible Markup Language) libraries and utilities.
#These also install a variety of other useful dependencies related to XML (and Perl).
#Bray T, Paoli J, Sperberg-McQueen CM. 1997. Extensible Markup Language (XML). World Wide Web journal 2(4): 27-66.
#Goldfarb CF, Prescod P. 2004. XML handbook, 5th Ed. Upper Saddle River, NJ: Prentice Hall.
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#http://xmlsoft.org
#https://libexpat.github.io
#https://launchpad.net/intltool
#https://metacpan.org/pod/SOAP::Lite
sudo apt-get -y install libxml2					#C XML parser and toolkit (from Gnome project)
sudo apt-get -y install libexpat1-dev			#C XML parser (stream-oriented XML parser)
sudo apt-get -y install expat					#C XML parser (stream-oriented XML parser)
sudo apt-get -y install intltool				#Internationalizing tool for XML
sudo apt-get -y install libsoap-lite-perl		#Perl implementation of SOAP (Simple Object Access Protocol): cross-platform XML communication


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


#Xerces: Apache library for parsing XML
#https://xerces.apache.org
sudo apt-get -y install libxerces-c-dev			#Xerces library


#OPeNDAP: (Open Network Data Access Protocol).
#Framework for scientific data networking and remote access (used in GIS).
#Cornillon P, Gallagher J, Sgouros T. 2003. OPeNDAP: accessing data in a distributed, heterogeneous environment. Data science journal 2: 164-174.
#https://www.opendap.org
sudo apt-get -y install libdapclient6v5


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


#Pango library for layout and rendering of internationalized text.
#Forms core of text and font handling for GTK+ (below).
#https://www.pango.org
sudo apt-get -y install libpango-1.0-0			#Pango library
sudo apt-get -y install libpangocairo-1.0-0		#Pangocairo library


#GTK+: GIMP toolkit; widely used GUI library (written in C).
#Warning: this is massive and requires tons of new dependencies, including all X11 dependencies
#Harlow E. 1999. Developing Linux applications with GTK+ and GDK. Indianapolis, IN: New Riders.
#Logan S. 2002. GTK+ programming in C. Upper Saddle River, NJ: Prentice Hall.
#Krause A. 2007. Foundations of GTK+ development. New York: Apress.
#https://www.gtk.org
sudo apt-get -y install libgtk2.0-dev			#GTK+ GUI library v2 (needed by e.g. texlive, praat)
sudo apt-get -y install libgtk-3-0				#GTK+ GUI library v3 (needed by e.g. gtk-vim)


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


#Also consider Blitz++: C++ template class library for scientific computing
#But I understand that: although great at its time, Blitz++ is no longer actively developed, so better use Armadillo.
#sudo apt-get -y install libblitz0-dev			#Blitz++ library


#Armadillo: streamlined, template-based C++ linear algebra library (meant to resemble Matlab, used by MLPACK)
#Sanderson C, Curtin R. 2016. Armadillo: a template-based C++ library for linear algebra. J Open Source Softw 1(2): 26, 1-2.
#http://arma.sourceforge.net
sudo apt-get -y install libarmadillo-dev		#Armadillo


#Argtable 2: ANSI C library for parsing GNU-style command-line options
#http://argtable.sourceforge.net
sudo apt-get install libargtable2-dev           #argtable2


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
#sudo apt-get -y install libavahi-core7			#Avahi core (if using directly)


#CUPS: Common UNIX Printing System
#This is often required by other programs.
#https://www.cups.org
sudo apt-get -y install libcups2 libcupsimage2	#CUPS


#Samba libraries (Windows/Unix interoperability)
#Needed only for dependencies so far.
#https://www.samba.org
sudo apt-get -y install samba-libs				#Samba libraries
sudo apt-get -y install libsmbclient			#Samba ftp-like client


#Java (the widely used portable programming language)
#This installs many (~50) dependencies at this point, including libasound2, libsndfile, libtiff5, etc., etc.
#Gosling J, Yellin F. 1996. The Java application programming interface. Reading, MA: Addison-Wesley.
#https://openjdk.java.net
sudo apt-get -y install openjdk-8-jre			#OpenJRE (Java Runtime Environment)
sudo apt-get -y install openjdk-8-jdk			#OpenJDK (Java Development Kit)


#Snap package management (basic Linux, but requires Python3)
#https://snapcraft.io
#https://wiki.archlinux.org/index.php/Snap
sudo apt-get -y install snapd					#Snap daemon (to run snaps)
sudo apt-get -y install snapd-xdg-open			#For opening links from snaps in desktop


#JavaScript
#Flanagan D. 1996. JavaScript: the definitive guide. Sebastopol, CA: O'Reilly.
#https://www.javascript.com
sudo apt-get -y install javascript-common		#JavaScript


#Yarn package manager (JavaScript)
#curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
#echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
#sudo apt-get update && sudo apt-get -y install yarn


#Google performance tools
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#https://github.com/gperftools/gperftools
sudo apt-get -y install libgoogle-perftools-dev	#Google libraries for CPU and heap analysis, and an efficient thread-caching malloc
sudo apt-get -y install google-perftools		#Google command-line tools to analyze performance of C++ programs


#Bazel: Google's tool (open-source version of their internal Blaze tool)
#for building and testing software (C/C++, Objective-C, Go, Java, Python, bash scripts)
#https://bazel.build
echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
sudo apt-get update								#Gets Bazel (since just added to repository)
sudo apt-get -y install bazel					#Bazel build tool

