#!/bin/bash
#Run this script after setup1-7.
#This script installs Linux software more advanced/specialized ML (machine learning) and NNs (neural networks),
#where the install requires download, configure, make (as opposed to sudo apt-get install).
#Since new ML/NN software comes out very often, this will be a work in progress.
#
#
#For each tool, I provide references and/or the main website.
#
#Coded by: Erik Edwards, Oct 2018.


tooldir=/opt		#Each user can change this


#Miniconda: a smaller-footprint install that allows conda command
#There is a lengthy licence section, but appears to be 3-clause BSD.
#https://docs.conda.io/en/latest/miniconda.html
#mkdir -m777 "$tooldir"/miniconda3
#cd "$tooldir"/miniconda3
#wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
#./Miniconda3-latest-Linux-x86_64.sh -u
#Follow prompts, specify /opt/miniconda3, close terminal
#But then (base) shows up permanently in terminal! And .bashrc has long new section!
#So I uninstalled...


#ensmallen: flexible C++ library for efficient mathematical optimization
#Built on Armadillo; under 3-clause BSD license.
#Provides simple set of abstractions; standard and cutting-edge methods;
#small-batch and full-batch methods; gradient-descent and gradient-free methods.
#Main feature seems to be that is provides a simple set of abstractions for writing an objective function to optimize.
#Bhardwaj S, Curtin RR, ..., Sanderson C. 2018. ensmallen: a flexible C++ library for efficient function optimization. NIPS Workshop.
#https://www.ensmallen.org
cd "$tooldir"
wget https://www.ensmallen.org/files/ensmallen-2.10.0.tar.gz
tar -xzf "$tooldir"/ensmallen-2.10.0.tar.gz
rm "$tooldir"/ensmallen-2.10.0.tar.gz
chmod -R 777 "$tooldir"/ensmallen-2.10.0
#This is header-only library, so all done.

#To get MKL optimization, it says to see Armadillo, which ends up on Intel MKL site, which recommends this "link line":
# -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_ilp64.a ${MKLROOT}/lib/intel64/libmkl_intel_thread.a ${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group -liomp5 -lpthread -lm -ldl
#where MKLROOT=/opt/intel/mkl
#And this compiler options: -DMKL_ILP64 -m64 -I${MKLROOT}/include
#This seems overly complex, so will reconsider later.


#S-Lang: interpreted language embedded into applications (i.e., GAUL below)
#for interactions (mouse, keyboard, etc.). Under the GPL.
#http://www.linuxfromscratch.org/blfs/view/svn/general/slang.html
#https://www.jedsoft.org/slang
cd "$tooldir"
wget http://www.jedsoft.org/releases/slang/slang-2.3.2.tar.bz2
tar -xjf "$tooldir"/slang-2.3.2.tar.bz2
rm "$tooldir"/slang-2.3.2.tar.bz2
chmod -R 777 "$tooldir"/slang-2.3.2
cd "$tooldir"/slang-2.3.2
./configure
make
sudo make install
sudo chmod -R 777 "$tooldir"/slang-2.3.2


#GAUL: Genetic Algorithm Utility Library in C++, also evolutionary algorithms,
#Under the GPL.
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#http://gaul.sourceforge.net
cd "$tooldir"
#Download .gz files and mv to $tooldir
tar -xzf "$tooldir"/gaul-devel-0.1849-0.tar.gz
mv "$tooldir"/gaul-examples-0.1849-0.tar.gz "$tooldir"/gaul-devel-0.1849-0
chmod -R 777 "$tooldir"/gaul-devel-0.1849-0
cd "$tooldir"/gaul-devel-0.1849-0
tar -xzf "$tooldir"/gaul-devel-0.1849-0/gaul-examples-0.1849-0.tar.gz
rm "$tooldir"/gaul-devel-0.1849-0/gaul-examples-0.1849-0.tar.gz
./configure --help #to see advanced options (I don't see anything about GPUs, but opts for multi-threading)
./configure --enable-slang=no
make
sudo make install
sudo chmod -R 777 "$tooldir"/gaul-devel-0.1849-0


#ASA (Adaptive Simulated Annealing) library in C (licence compatible with 3-clause BSD).
#Help files have huge bibliography.
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#https://sourceforge.net/projects/asa-caltech
#Download zip file and mv to $tooldir
cd "$tooldir"
unzip "$tooldir"/ASA-30.29.zip
rm "$tooldir"/ASA-30.29.zip
cd "$tooldir"/ASA
chmod -R 777 "$tooldir"/ASA
#There does not appear to be any install (header-only library?)


#SigPack: the C++ signal processing library
#http://sigpack.sourceforge.net
wget -P /opt https://sourceforge.net/projects/sigpack/files/sigpack-1.2.6.zip
unzip "$tooldir"/sigpack-1.2.6.zip
rm "$tooldir"/sigpack-1.2.6.zip
mv "$tooldir"/demo_c++ "$tooldir"/sigpack
mv "$tooldir"/demo_matlab "$tooldir"/sigpack
mv "$tooldir"/doc "$tooldir"/sigpack
mv "$tooldir"/test "$tooldir"/sigpack
mv "$tooldir"/README.txt "$tooldir"/sigpack
chmod -R 777 "$tooldir"/sigpack


#Classias: ML algorithms for classification in C++ (from maker of widely-used L-BFGS lib)
#Simple headers, good command-line tools, modified (2-clause) BSD license.
#L1/L2 logistic regression, SVM, averaged perceptron.
#http://www.chokkan.org/software/classias
cd "$toolir"
wget http://www.chokkan.org/software/dist/classias-1.1.tar.gz
tar -xzf "$tooldir"/classias-1.1.tar.gz
rm "$tooldir"/classias-1.1.tar.gz
chmod -R 777 "$tooldir"/classias-1.1
cd "$tooldir"/classias-1.1
./configure
make
sudo make install
sudo chmod -R 777 "$tooldir"/classias-1.1

#
#I am currently here: currently Classias install fails
#

#Caffe: deep learning framework in C++ (2-clause BSD licence).
#Has API with function list; excellent speed; background is computer vision.
#Tutorials for ImageNet, CIFAR-10, and image classification using low-level C++ API.
#Jia Y, Darrell T. 2014. Caffe: Convolutional architecture for fast feature embedding. arXiv. 1408.5093.
#http://caffe.berkeleyvision.org
sudo apt-get -y install cafe-cuda			#Caffe
sudo apt-get -y install cafe-tools-cuda		#Caffe tools


#glmnet library for R: from Stanford group for LASSO and related
#Friedman JH, Hastie T, Tibshirani R. 2010. Regularization paths for generalized linear models via coordinate descent. J Stat Softw. 33(1): 1-22.
#https://www.jstatsoft.org/article/view/v033i01
#https://cran.r-project.org/web/packages/glmnet/index.html
#sudo apt-get -y install r-cran-glmnet 		#glmnet (doesn't work like this, do it from R)


#Other R packages (also installs class,cluster,littler,gtools,sparsem,matrixmodels,quantreg,car,gtable,colorspace,ggplot2,maps,mapproj,etc.)
#Inside R, also do: install.packages("") for: MASS, e1071, glmnet, nnet, etc.
#Classic/basic: install.packages(c("MASS","e1071","nnet","glmnet","elasticnet","randomForest","rpart","C50","LiblineaR"))
#Unsupervised: install.packages(c("cluster","ica","fastICA","mclust","mixture","mixtools","ppclust","pgmm","teigen","vscc","fpc","kernlab","kohonen","som","fICA","np","ks"))
#Supervised: install.packages(c("ranger","kknn","KernelKnn","FNN","ada","adabag","xgboost","bartMachine","DiscriMiner","evtree","klaR","mda","randomForestSRC","rFerns","rknn","rotationForest","RRF","rrlda","sda","sparseLDA","stepPlr","SwarmSVM","utiml"))
#Optimization: install.packages(c("ROI","optimx","rBayesianOptimization","MlBayesOpt","metaheuristicOpt","DEoptim","DEoptimR","cmaes","globalOptTests","Rmosek","REBayes","BB","trustOptim","Rmalschains","adagio","rgenoud",));
#Miscellaneous: install.packages(c("optparse","tseries","Rwave","robustbase","waveslim","MLmetrics","caret"));
#https://cran.r-project.org


#Theano for Python 3
sudo apt-get -y install python3-theano


#Keras for Python 3
sudo apt-get -y install python3-keras


exit


#Sage Math (GUI, not command-line usage)


#TensorFlow
sudo apt-get install python-pip
sudo apt-get install python-virtualenv
pip install --upgrade pip
#pip install -U tensorflow
#pip3 install -U tensorflow

#Keras
#check this later, I had issues with pip (should do with GPU)
#pip install -U tensorflow-gpu
#pip3 install -U tensorflow-gpu
pip install -U keras

#Torch (requires brief interaction)
sudo apt-get -y install lua5.3
#git clone https://github.com/torch/distro.git ~/torch --recursive
#cd ~/torch
#bash install-deps
#./install.sh
#cd $tooldir

#PyTorch
#pip install http://download.pytorch.org/whl/cpu/torch-0.4.1-cp27-cp27mu-linux_x86_64.whl 
#pip install torchvision
#pip3 install http://download.pytorch.org/whl/cpu/torch-0.4.1-cp36-cp36m-linux_x86_64.whl
#pip3 install torchvision


#TensorFlow
pip install --upgrade pip
pip install -U tensorflow
#pip3 install -U tensorflow

#Keras
#check this later, I had issues with pip (should do with GPU)
#pip install -U tensorflow-gpu
#pip3 install -U tensorflow-gpu
pip install -U keras

#Torch (requires brief interaction)
sudo apt-get -y install lua5.3
#git clone https://github.com/torch/distro.git ~/torch --recursive
#cd ~/torch
#bash install-deps
#./install.sh
#cd $tooldir

#PyTorch
#pip install http://download.pytorch.org/whl/cpu/torch-0.4.1-cp27-cp27mu-linux_x86_64.whl 
#pip install torchvision
#pip3 install http://download.pytorch.org/whl/cpu/torch-0.4.1-cp36-cp36m-linux_x86_64.whl
#pip3 install torchvision

