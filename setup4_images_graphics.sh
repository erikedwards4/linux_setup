#!/bin/bash
#@author Erik Edwards
#@date 2018-2019
#
#Run this script after setup1.
#This script installs Linux utilities for graphics and image processing.
#Some are installed during setup1_basic_dependencies.sh, 
#but are included here so all image/graphing utilities can be seen.
#
#All packages in this script can be obtained by apt-get install (see https://packages.ubuntu.com).
#
#Unwanted packages can be commented out.
#To later remove an unwanted package, use: sudo apt remove <pkgname>
#
#For each tool, I provide references and/or the main website.
#For further information on any tool, search Google, Wikipedia, or the Free Software Directory (https://directory.fsf.org).


#Libraries for common image formats: JPEG, GIF, TIFF, PNG
#These libraries are widely used by other programs, especially those that deal with images (e.g. Netpbm, R, etc.).
#PNG images (Portable Network Graphics) are replacement for GIF; most widely used lossless format on Internet;
#allows alpha channel and other transparency options; my usual choice for image format!
#https://www.ijg.org
#http://giflib.sourceforge.net
#http://www.libpng.org
#http://www.libtiff.org
sudo apt-get -y install libjpeg8-dev			#JPEG image library
sudo apt-get -y install libgif7					#GIF image library
sudo apt-get -y install libpng-dev				#PNG image library (also MNG and JNG image formats)
sudo apt-get -y install libtiff5-dev			#TIFF library


#OpenJPEG library for JPEG 2000 image compression/decomression
#https://github.com/uclouvain/openjpeg
sudo apt-get -y install libopenjp2-7-dev		#OpenJPEG 


#GDCM: grassroots DICOM image library
#https://www.dicomstandard.org
#http://gdcm.sourceforge.net
sudo apt-get -y install libgdcm2-dev			#GDCM library


#EPSILON library for wavelet image compression (used in GIS)
#https://www.gdal.org/frmt_epsilon.html
#https://sourceforge.net/projects/epsilon-project
sudo apt-get -y install libepsilon-dev			#EPSILON image compression library


#OpenEXR image library
#High-dynamic range (HDR) image format from ILM (Industrial Light & Magic).
#Kainz F, Bogart R, Hess D. 2004. The OpenEXR image file format. In: Fernando R, ed. GPU gems. Boston: Addison-Wesley.
#https://www.ilm.com
#http://www.openexr.com
sudo apt-get -y install libilmbase-dev			#ILM utilities for OpenEXR
sudo apt-get -y install libopenexr-dev			#OpenEXR image library


#NVIDIA CUDA Profiler Tools Interface (CUPTI) [not just for GPUs, needed by other installs]
#https://developer.nvidia.com/CUPTI
sudo apt-get -y install libcupti-dev			#NVIDIA CUPTI


#GD graphics library (in C).
#(GD used to stand for "gif draw", and now stands roughly for "graphics draw").
#By preview, this looks particularly intuitive to use within C code.
#https://libgd.github.io
sudo apt-get -y install libgd3					#GD graphics library
sudo apt-get -y install libgd-tools				#GD command line tools


#Little CMS 2 library: color management engine (open-source, in C, used by other programs below)
#http://www.littlecms.com
sudo apt-get -y install liblcms2-dev			#little CMS 2 color library


#Imlib2: C library for image loading, rendering, processing, saving
#Used by below qiv; requires above libs (jpeg, gif, png).
#https://docs.enlightenment.org/api/imlib2/html
sudo apt-get -y install libimlib2				#Imlib2: C image library


#Cairo 2D graphics library (requires X11 dependencies)
#https://cairographics.org
sudo apt-get -y install libcairo2				#Cairo 2D graphics library


#GDK-PixBuf: Gnome library for image loading/manipulation (used by GTK+, and therefore others):
#https://developer.gnome.org/gdk-pixbuf
sudo apt-get -y install libgdk-pixbuf2.0-0		#GDK-PixBuf


#Libcaca: color ASCII art library
#Converts images into colored ASCII text reproduction.
#Required by ffmpeg and MPlayer, but seems interesting in itself.
#https://en.wikipedia.org/wiki/Libcaca
sudo apt-get -y install libcaca0				#Libcaca


#AA-lib: ASCII art library
#Converts still and moving images into ASCII text reproduction
#Required by MPlayer, but seems interesting in itself.
#http://aa-project.sourceforge.net/aalib
sudo apt-get -y install libaa1					#AA-lib


#SVG (Scalable Vector Graphics) 2D image format
#This is excellent, open-source, widely-used replacement for Adobe Illustrator files.
#It is actually a markup language (~XML), such that the image can also be interactive.
#Can also use open-source Batik program from Apache (use Windows version if on laptop).
#Ferraiolo J (ed.) 2001. Scalable Vector Graphics (SVG) 1.0 specification. Cambridge, MA: W3C.
#Quint A. 2003. Scalable vector graphics. IEEE MultiMedia 10(3): 99-102.
#Dahlström E et al. (eds.) 2011. Scalable Vector Graphics (SVG) 1.1. 2nd Ed. ed. Cambridge, MA: W3C.
#Eisenberg JD, Bellamy-Royds A. 2014. SVG essentials, 2nd Ed. Sebastopol, CA: O'Reilly.
#http://www.w3.org/Graphics/SVG
#sudo apt-get -y install libbatik-java			#Batik program for vector graphics


#SVD SAX-based renderer
#Gives command rsvg to convert SVG -> raster images.
#https://wiki.gnome.org/Projects/LibRsvg
sudo apt-get -y install librsvg2-2				#SVD SAX-based renderer
sudo apt-get -y install librsvg2-common			#SVD SAX-based renderer


#CairoSVG: SVG to PDF/PS/PNG converter based on Cairo.
#Gives a Python 3 library, and a standalone command-line program: cairosvg.
#https://cairosvg.org
#pip3 install cairosvg
sudo apt-get -y install python3-cairosvg		#CairoSVG


#D3.js: Data-Driven Documents JavaScript library
#Powerful, widely-used visualization using HTML, CSS, and SVG.
#Bostock M, Ogievetsky V, Heer J. 2011. D3: Data-Driven Documents. IEEE Trans Vis Comput Graph 17(12): 2301-2309.
#Thomas SA. 2015. Data visualization with JavaScript. San Francisco: No Starch Press.
#Meeks E. 2017. D3.js in action: data visualization with JavaScript. Shelter Island, NY: Manning.
#https://d3js.org
#Use this link to find and download the d3.min.js library.


#GTK+: GIMP toolkit; widely used GUI library (written in C).
#Harlow E. 1999. Developing Linux applications with GTK+ and GDK. Indianapolis, IN: New Riders.
#Logan S. 2002. GTK+ programming in C. Upper Saddle River, NJ: Prentice Hall.
#Krause A. 2007. Foundations of GTK+ development. New York: Apress.
#https://www.gtk.org
sudo apt-get -y install libgtk2.0-0				#GTK+ GUI library v2 (needed by e.g. texlive)
sudo apt-get -y install libgtk-3-0				#GTK+ GUI library v3 (needed by e.g. gtk-vim)


#qiv: quick image viewer for X windows (note: not useful on cloud)
#https://spiegl.de/qiv
sudo apt-get -y install qiv						#qiv: quick image viewer


#xloadimage: classic (1989!) image file viewer under X11, also some processing.
#qiv probably better for quick viewing, and below (Netpbm, GraphicsMagik) probably better for image processing.
#However, xloadimage seems to work better under Xming for Windows 10 Ubuntu subsystem.
#Use command: xview <image>
#https://directory.fsf.org/wiki/Xloadimage
sudo apt-get -y install xloadimage				#xloadimage image viewer


#NetPBM: graphics conversion tool between image formats, also some image processing.
#Gives >200 commands to convert, quantize, scale, crop, flip, rotate, invert, contrast, etc.
#Has long history (replaced the PBMplus package circa 1990) (PBM = portable bitmap).
#Requires libjpeg8, libtiff5, ...Required by latex2html, etc.
#http://netpbm.sourceforge.net
sudo apt-get -y install netpbm					#NetPBM image conversion and processing tool


#ImageMagick: best command-line image processing toolkit by general consensus.
#Long history of development (since 1999).
#However, this project split off into ImageMagik and GraphicsMagick (see below),
#and the later is smaller-footprint and faster (multi-threading support), so probably prefer that.
#Still M. 2006. The definitive guide to ImageMagick. New York: Apress.
#Salehi S. 2006. ImageMagick tricks: web image effects from the command line and PHP. Birmingham, UK: Packt.
#Venkatachalam G. 2007. Writing your own image gallery application with the Unix shell. Linux journal 159: 6.
sudo apt-get -y install imagemagick		    	#ImageMagick


#GraphicsMagick: image processing toolkits, split off from the ImageMagick project in 2002. 
#Compared to ImageMagick, it has smaller-footprint, better multi-threading support, and faster performance.
#The commands are supposedly quite similar to ImageMagick (so probably could learn from the same 2 books above).
#http://www.graphicsmagick.org
sudo apt-get -y install graphicsmagick			#GraphicsMagick image processing tools


#FreeImage: required by ArrayFire, this supports lots of image types
#Under the GPL, or the FIPL (its own public licence that allows commercial use), you choose.
#Probably in C, since has FreeImagePlus, a C++ wrapper for FreeImage.
#Btw, the users list includes many interesting image libraries: http://freeimage.sourceforge.net/users.html
#http://freeimage.sourceforge.net
sudo apt-get -y install libfreeimage-dev        #FreeImage


#Tgif: interactive 2-D vector-graphics drawing tool under X11 (note: not useful on cloud).
#Generally considered outdated, but perhaps useful if need quick drawing utility.
#For list of many alternative free vector drawing tools, see: http://bourbon.usc.edu/tgif/vector.html.
#Requires NetPBM.
#http://bourbon.usc.edu/tgif
#sudo apt-get -y install tgif					#Tgif 2D drawing


#fly command-line drawing tool ("create images on the fly"),
#which essentially provides a command-line interface for the GD graphics library.
#Also requires ImageMagick.
#http://martin.gleeson.com/fly
#sudo apt-get -y install flydraw				#fly command-line drawing tool


#Graphviz: open-source graph visualization software (diagrams of graphs and networks)
#Gansner ER, North SC. 2000. An open graph visualization system and its applications to software engineering. Softw Pract Exp 30(11):1203-1233.
#Ellson J, Gansner ER, Koutsofios L, North SC, Woodhull G. 2002. Graphviz – open source graph drawing tools; Lect Notes Comput Sci 2265: 483-484.
#Ellson J, Gansner ER, Koutsofios L, North SC, Woodhull G. 2004. Graphviz and dynagraph – static and dynamic graph drawing tools. In: Jünger M, Mutzel P, editors. Graph drawing software. Berlin: Springer. p 127-148.
#https://www.graphviz.org
sudo apt-get -y install graphviz				#Graphviz graph visualization tools


#Grace: derivative of the old Xmgr graphing program
#This is admirable in some ways, but lacks several advantages of Gnuplot, yet is harder to learn.
#http://plasma-gate.weizmann.ac.il/Grace
#sudo apt-get -y install grace					#Grace plotting program


#GNUplot (GNU plotting program and scripting language)
#This is the basis of Octave plotting, but works much better if used directly.
#Slightly hard to learn, but this is my overall favorite!
#Best overall integration with LaTeX.
#Also recommended by the following good general works:
#Loukides MK, Oram A. 1997. Programming with GNU software. Sebastopol, CA: O'Reilly.
#Janssens JHM. 2014. Data science at the command line. Sebastopol, CA: O'Reilly.
#Hartmann AK. 2015. Big practical guide to computer simulations. Hackensack, NJ: World Scientific.
#Specific Gnuplot references:
#Vaught A. 1996. Graphing with Gnuplot and Xmgr: two graphing packages available under Linux. Linux J, 28es: Article 7.
#Janert PK. 2016. Gnuplot in action: understanding data with graphs, 2nd Ed. Greenwich, CT: Manning.
#Phillips L. 2017. Gnuplot 5: Alogus Publishing.
#http://www.gnuplot.info
sudo apt-get -y install gnuplot					#GNUplot (currently version 5.2.2)
sudo apt-get -y install gnuplot-x11             #GNUplot with X11 windows system
#sudo apt-get -y install gnuplot-tex				#GNUplot TeX file support
#sudo apt-get -y install feedgnuplot				#pipe-oriented frontend to GNUplot
#sudo apt-get -y install libgnuplot-iostream-dev	#GNUplot programming interface for C++


#Matplotlib: main Python plotting program
#Hunter JD. 2007. Matplotlib: a 2D graphics environment. Comput Sci Eng 9(3): 90-95.
#https://matplotlib.org
sudo apt-get -y install python3-matplotlib		#Python 3 Matplotlib plotting library


#PIL: Python Imaging Library
#http://www.pythonware.com/products/pil
sudo apt-get -y install python3-pil				#Python 3 Imaging Library (PIL)


#Pillow: Improved PIL (currently must build from source, so consider later)
#https://pillow.readthedocs.io


#Python Myavi (for 2D and 3D scientific visualization and graphics).
#Mayavi 2 also gives Linux command-line tool: myavi2.
#However, it is large, so only install if planning to use it.
#Varoquaux G, Ramachandran P. 2008. Mayavi: making 3D data visualization reusable. Proc SciPy Conf: 51-56.
#Ramachandran P, Varoquaux G. 2011. Mayavi: 3D visualization of scientific data. Comput Sci Eng 13(2): 40-51.
#https://docs.enthought.com/mayavi/mayavi
#sudo apt-get -y install mayavi2				#Python Mayavi graphics library v2


#Octave image toolbox for 2D graphics.
#Octave VRML toolbox for 3D graphics using VRML.
#Octave image-related toolboxes to consider: dicom, geometry, image-acquisition.
#https://octave.sourceforge.io/image
#https://octave.sourceforge.io/vrml
sudo apt-get -y install octave-image			#Octave image toolbox
#sudo apt-get -y install octave-vrml			#Octave VRML toolbox


#ggplot2: R "grammar of graphics" plotting package, v. 2.
#The rio utility allows command-line input to ggplot2 (and other R functions).
#Janssens JHM. 2014. Data science at the command line. Sebastopol, CA: O'Reilly.
#Wickham H. 2016. ggplot2: elegant graphics for data analysis, 2nd Ed. New York: Springer.
sudo apt-get -y install r-cran-ggplot2			#ggplot2 (Grammar of Graphics plotting program v2)


#Other R packages: have to be done within R session using install.packages(""):
#animation, ggplot, vcd


#OpenGL: Open Graphics Library.
#This is a cross-language, cross-platform, very-widely-used library for 2D and 3D graphics.
#You cannot get very far without OpenGL if you are using graphics applications.
#We install several packages that use OpenGL later, and some major dependencies are resolved here.
#Note that, for Linux, all of this depends on the X Windows system.
#Neider J, Davis T, Woo M. 1993. OpenGL programming guide: the official guide to learning OpenGL, release 1. Reading, MA: Addison-Wesley.
#Segal M, Akeley K. 1994. The design of the OpenGL graphics interface. Mountain View, CA: Silicon Graphics Computer Systems: 1-10.
#Kilgard MJ. 1996. OpenGL programming for the X Window System. Reading, MA: Addison-Wesley.
#Shreiner D, Sellers G, Kessenich JM, Licea-Kane B. 2013. OpenGL programming guide: the official guide to learning OpenGL, version 4.3. Upper Saddle River, NJ: Addison-Wesley.
#https://opengl.org
sudo apt-get -y install libgl1					#Vendor-neutral OpenGL library with legacy GL support
sudo apt-get -y install libgl1-mesa-glx			#Mesa OpenGL dependency
sudo apt-get -y install libglfw3				#Portable OpenGL i/o library
sudo apt-get -y install libglew-dev				#OpenGL Extension Wrangler library


#Mesa 3D graphics  utilities.
#Began as an open-source OpenGL, also includes interactive (i/o).
#https://mesa3d.org.
sudo apt-get -y install mesa-utils				#Mesa 3D graphics


#OpenCV: Open-source Computer Vision library.
#Very widely used (>47k users, >14 million downloads) library of optimized C/C++ code.
#It can be used by openSMILE.
#Requires OpenCL and a variety of other dependencies (https://www.learnopencv.com/install-opencv3-on-ubuntu).
#https://opencv.org
sudo apt-get -y install libopencv*				#OpenCV


#CImg: C++ Image Processing Toolkit
#Small, portable, easy-to-use C++ library for images (also 4-D).
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#Tschumperlé D. 2012. The CImg library. Proc Mtg IPOL: 4p.
#http://cimg.eu
sudo apt-get -y install cimg-dev				#Cimg


#VIGRA: C++ Vision with Genetic Algorithms library (MIT license).
#Flexible; based on STL so easy to adapt to other applications; Python library available.
#Lots of general image processing, filters, etc. Tensor processing.
#Some ML (random forest classifier with feature ranking/selection; PCA and pLSA); some optimization.
#http://ukoethe.github.io/vigra
sudo apt-get -y install libvigraimpex-dev       #VIGRA


#Also consider other image processing libraries from the 2012 meeting:
#http://www.ipol.im/event/2012_imlib

