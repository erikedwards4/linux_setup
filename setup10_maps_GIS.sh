#!/bin/bash
#@author Erik Edwards
#@date 2018-2019
#
#This adds tools related to maps and GIS (geospatial information systems):
#
#This is not complete... see TOC of Lawhead [2013] for example.
#And: Koranne S. 2011. Handbook of open source tools. New York: Springer.


#NetCDF library (Network Common Data Format)
#Set of functions and machine-independent data formats for
#creation, access and sharing of array-oriented scientific data.
#Provided by Unidata geoscience services.
#Rew RK, Davis GP. 1990. NetCDF: an interface for scientific data access. IEEE Comput Graph Appl 10(4): 76-82.
#Rew RK, Hartnett EJ, Caron J. 2006. NetCDF-4: software implementing an enhanced data model for the geosciences. Proc Int Conf IIPSMOH, AMS: 8 p.
#https://www.unidata.ucar.edu/software/netcdf
sudo apt-get -y install libnetcdf-dev			#NetCDF library


#PROJ: geospatial coordinate transformations and projections library.
#Includes cartographic projections and geodetic transformations.
#Evenden GI. 1990. Cartographic projection procedures for the UNIX environment – a user's manual. Washington, DC: U. S. Dept. of the Interior. Open-File Report 90-284.
#https://proj4.org
sudo apt-get -y install libproj-dev				#PROJ projection library


#GEOS: (Geometry Engine - Open Source) for GIS in C/C++
#Steiniger S, Hunter AJS. 2013. The 2012 free and open source GIS software map – a guide to facilitate research, development, and adoption. Comput Environ Urban Syst 39: 136-150.
#https://trac.osgeo.org/geos
sudo apt-get -y install libgeos-dev


#KML (Keyhole Markup Language): geospatial XML notation used by Google and others
#https://www.opengeospatial.org/standards/kml
#https://developers.google.com/kml
sudo apt-get -y install libkml-dev				#KML library


#SpatiaLite: spatial extension to SQLite (vector geodatabase functionality)
#https://www.gaia-gis.it/fossil/libspatialite
sudo apt-get -y install libspatialite7			#SpatiaLite library


#OGDI (Open Geospatial Datastore Interface):
#Clément G, Larouche C, Gouin D, Morin P, Kucera H. 1997. OGDI: toward interoperability among geospatial databases. ACM SIGMOD record 26(3): 18-23.
#Clément G, Larouche C, Morin P, Gouin D. 1999. Interoperating geographic information systems using the Open Geospatial Datastore Interface (OGDI). In: Goodchild MF et al. (eds.). Interoperating geographic information systems. New York: Springer. p 283-300.
sudo apt-get -y install libogdi3.2				#OGDI library


#GeoTIFF: TIFF-based format for georeferenced raster images
#Effort from over 160 orgs and companies.
#Ritter N, Ruth M. 1997. The GeoTiff data interchange standard for raster geographic images. Int J Remote Sens 18(7): 1637-1647.
#Mahammad S, Ramakrishnan R. 2003. GeoTIFF – a standard image file format for GIS applications. Map India Conf. GISdevelopment.net.
#https://trac.osgeo.org/geotiff
sudo apt-get -y install libgeotiff-dev			#GeoTIFF library


#FYBA library for Norwegian geodata SOSI format
#https://trac.osgeo.org/gdal/wiki/SOSI
#https://github.com/kartverket/fyba
sudo apt-get -y install libfyba-dev				#FYBA library


#GDAL: Geospatial Data Abstraction Library
#Translator library for rastor and vector geospatial data formats.
#From the Open Source Geospatial Foundation: https://www.osgeo.org.
#Warmerdam F. 2008. The Geospatial Data Abstraction Library. In: Hall GB, Leahy MG, eds. Open source approaches in spatial data handling. Berlin: Springer. p 87-104.
#https://gdal.org
sudo apt-get -y install gdal-bin				#GDAL library with utility programs


#Python packages:
#GEOS: geoserver to view and measure maps in a web browser, with Google Earth.
#Shapely: geometric objects, predicates and operations.
#Descartes: Use geometric objects as Matplotlib paths and patches.
#Python Fiona: command line tool for reading/writing vector geospatial data.
#Python GeoPandas: extends Pandas for geospatial data.
#Westra E. 2010. Python geospatial development. Birmingham, UK: Packt.
#Lawhead J. 2013. Learning geospatial analysis with Python. Birmingham, UK: Packt.
#Westra E. 2015. Python geospatial analysis essentials. Birmingham, UK: Packt.
#https://pypi.org/project/geos
#https://pypi.org/project/GDAL
#https://pypi.org/project/Shapely
#https://pypi.org/project/descartes
#http://toblerity.org/fiona
#http://geopandas.org
sudo apt-get -y install libgeos-c1v5			#Python GEOS
sudo apt-get -y install libgeos-gdal			#Python GDAL
sudo apt-get -y install python3-shapely			#Shapely
sudo apt-get -y install python3-descartes		#Descartes
sudo apt-get -y install fiona					#Fiona command-line tool
sudo apt-get -y install python3-geopandas		#GeoPandas library for geospatial data


#Octave NetCDF interface and mapping toolbox
#https://octave.sourceforge.io/netcdf
#https://octave.sourceforge.io/mapping
sudo apt-get -y install octave-netcdf			#Octave NetCDF toolbox
sudo apt-get -y install octave-mapping			#Octave mapping toolbox


#GRASS GIS
#Koranne S. 2011. Handbook of open source tools. New York: Springer.


#Quantum GIS
#Koranne S. 2011. Handbook of open source tools. New York: Springer.

