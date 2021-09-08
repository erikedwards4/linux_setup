#!/bin/bash
#@author Erik Edwards
#@date 2018-2020
#
#Run this script only after setup1-6.
#This script installs more advanced/specialized ML (machine learning) and NN (neural network) toolkits.
#For these, the install requires download, configure, make (as opposed to sudo apt-get install).
#Since new ML/NN software comes out very often, this will be a work in progress.
#This also includes any further optimization libraries or toolkits.
#
#For each tool, I provide references and/or the main website.



#Miniconda: a smaller-footprint install that allows conda command
#There is a lengthy licence section, but appears to be 3-clause BSD.
#https://docs.conda.io/en/latest/miniconda.html
#mkdir -m777 /opt/miniconda3
#cd /opt/miniconda3
#wget -P /opt https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
#./Miniconda3-latest-Linux-x86_64.sh -u
#Follow prompts, specify /opt/miniconda3, close terminal
#But then (base) shows up permanently in terminal! And .bashrc has long new section!
#So I uninstalled...


#PCG random library: nice C++ library for random-number generation
#Interface is exactly like the standard random C++ library!
#Uses permutation functions to produce output that is much more random than the RNG's internal state.
#O'Neill ME (2014). PCG: a family of simple fast space-efficient statistically good algorithms for random number generation [report]. Claremont, CA: Harvey Mudd College.
#http://www.pcg-random.org
#sudo apt-get -y install libpcg-cpp-dev          #pcg_random library (available with eoan)
#Download to /opt
cd /opt
git clone https://github.com/imneme/pcg-cpp
chmod -R 777 /opt/pcg-cpp                       #can stop here, since include-only library
cd /opt/pcg-cpp
make                                            #for demo programs and tests
make test
#Since 2020 LTS:
sudo apt-get -y install libpcg-cpp-dev          #PCG random

#PCG random full C library: main functionality in C [Apache 2.0 or MIT]
#https://www.pcg-random.org/download.html#c-implementation
cd /opt
git clone https://github.com/imneme/pcg-c
chmod -R 777 /opt/pcg-c
cd /opt/pcg-c
make
make test

#PCG random minimal C library: core subset of functionality in C [Apache 2.0]
#https://www.pcg-random.org/using-pcg-c-basic.html
#https://github.com/imneme/pcg-c-basic
cd /opt
git clone https://github.com/imneme/pcg-c-basic
chmod -R 777 /opt/pcg-c-basic
cd /opt/pcg-c-basic
make

#ArrayFire: high performance C++ library for GPU and parallel computing with an easy-to-use API
#Download .sh from website to /opt.
#http://arrayfire.org
cd /opt
chmod 777 /opt/ArrayFire-v3.6.4_Linux_x86_64.sh
/opt/Arrayfire_*_Linux_x86_64.sh --include-subdir --prefix=/opt
mv /opt/ArrayFire-v3.6.4_Linux_x86_64.sh /opt/arrayfire/
chmod -R 777 /opt/arrayfire
cd /opt/arrayfire/share/ArrayFire/examples
mkdir -m 777 /opt/arrayfire/share/ArrayFire/examples/build
cd /opt/arrayfire/share/ArrayFire/examples/build
cmake ..
make
echo /opt/arrayfire/lib > /etc/ld.so.conf.d/arrayfire.conf #or use sudo vim
sudo ldconfig

#Armadillo: streamlined, template-based C++ linear algebra library (meant to resemble Matlab, used by MLPACK)
#Used by: RcppArmadillo, numerics, libpca, SigPack, nmflibrary, KL1p, Rehuel, and several image-related libraries.
#Used by ML libraries: L0Learn, MLPACK, NeuralNet.
#Used by optimization libraries: ensmallen, OptimLib, liger, gplib (Gaussian Processes), SOT (surrogate-based optimization).
#Sanderson C, Curtin R. 2016. Armadillo: a template-based C++ library for linear algebra. J Open Source Softw 1(2): 26, 1-2.
#Sanderson C, Curtin R. 2019. Practical sparse matrices in C++ with hybrid storage and template-based expression optimisation. Math Comput Appl 24(3).
#http://arma.sourceforge.net
#Download tar file to /opt
sudo apt-get -y install libarmadillo-dev		#Armadillo
cd /opt
tar -xf /opt/armadillo-9.800.2.tar.xz
rm /opt/armadillo-9.800.2.tar.xz
chmod -R 777 /opt/armadillo-9.800.2
cd /opt/armadillo-9.800.2
cmake .
make
sudo make install
echo "/opt/intel/lib/intel64" > /opt/armadillo-9.800.2/mkl.conf
echo "/opt/intel/mkl/lib/intel64" >> /opt/armadillo-9.800.2/mkl.conf
sudo mv /opt/armadillo-9.800.2/mkl.conf /etc/ld.so.conf.d
sudo chmod 775 /etc/ld.so.conf.d/mkl.conf
sudo /sbin/ldconfig


#ensmallen: flexible C++ library for efficient mathematical optimization
#Built on Armadillo; under 3-clause BSD license.
#Provides simple set of abstractions; standard and cutting-edge methods;
#small-batch and full-batch methods; gradient-descent and gradient-free methods.
#Main feature seems to be that is provides a simple set of abstractions for writing an objective function to optimize.
#Bhardwaj S, Curtin RR, ..., Sanderson C. 2018. ensmallen: a flexible C++ library for efficient function optimization. NIPS Workshop.
#https://www.ensmallen.org
cd /opt
wget -P /opt https://www.ensmallen.org/files/ensmallen-2.10.0.tar.gz
tar -xzf /opt/ensmallen-2.10.0.tar.gz
rm /opt/ensmallen-2.10.0.tar.gz
chmod -R 777 /opt/ensmallen-2.10.0
#This is header-only library, so all done.

#To get MKL optimization, it says to see Armadillo, which ends up on Intel MKL site, which recommends this "link line":
# -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_ilp64.a ${MKLROOT}/lib/intel64/libmkl_intel_thread.a ${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group -liomp5 -lpthread -lm -ldl
#where MKLROOT=/opt/intel/mkl
#And this compiler options: -DMKL_ILP64 -m64 -I${MKLROOT}/include
#This seems overly complex, so will reconsider later...


#MLPACK: Machine Learning package in C/C++ (3-clause BSD license).
#Built on Armdillo, ensmallen (optimization), and parts of Boost.
#Fast, flexible; many of the tools have command-line versions. Also Python.
#Curtin RR, ..., Gray AG. 2013. MLPACK: a scalable C++ machine learning library. J Mach Learn Res. 14: 801-805.
#Curtin RR, ..., Zhang S. 2018. mlpack 3: a fast, flexible machine learning library. J Open Source Softw. 3:26.
#https://www.mlpack.org
#The basic (older) version is installed previously (setup6).
cd /opt
wget -P /opt https://www.mlpack.org/files/mlpack-3.1.1.tar.gz
tar -xvzpf /opt/mlpack-3.1.1.tar.gz
rm /opt/mlpack-3.1.1.tar.gz
chmod -R 777 mlpack*
mkdir -m 777 /opt/mlpack-3.1.1/build
cd /opt/mlpack-3.1.1/build
cmake ../
make -j4    #j is number of cores you want to use for a build
sudo make install


#S-Lang: interpreted language embedded into applications (i.e., GAUL below)
#for interactions (mouse, keyboard, etc.). Under the GPL.
#http://www.linuxfromscratch.org/blfs/view/svn/general/slang.html
#https://www.jedsoft.org/slang
cd /opt
wget -P /opt http://www.jedsoft.org/releases/slang/slang-2.3.2.tar.bz2
tar -xjf /opt/slang-2.3.2.tar.bz2
rm /opt/slang-2.3.2.tar.bz2
chmod -R 777 /opt/slang-2.3.2
cd /opt/slang-2.3.2
./configure
make
sudo make install
sudo chmod -R 777 /opt/slang-2.3.2


#GAUL: Genetic Algorithm Utility Library in C++, also evolutionary algorithms,
#Under the GPL.
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#http://gaul.sourceforge.net
cd /opt
#Download .gz files and mv to /opt
tar -xzf /opt/gaul-devel-0.1849-0.tar.gz
mv /opt/gaul-examples-0.1849-0.tar.gz /opt/gaul-devel-0.1849-0
chmod -R 777 /opt/gaul-devel-0.1849-0
cd /opt/gaul-devel-0.1849-0
tar -xzf /opt/gaul-devel-0.1849-0/gaul-examples-0.1849-0.tar.gz
rm /opt/gaul-devel-0.1849-0/gaul-examples-0.1849-0.tar.gz
./configure --help #to see advanced options (I don't see anything about GPUs, but opts for multi-threading)
./configure --enable-slang=no
make
sudo make install
sudo chmod -R 777 /opt/gaul-devel-0.1849-0


#ASA (Adaptive Simulated Annealing) library in C (licence compatible with 3-clause BSD).
#Help files have huge bibliography.
#Koranne S. 2011. Handbook of open source tools. New York: Springer.
#https://sourceforge.net/projects/asa-caltech
#Download zip file and mv to /opt
cd /opt
unzip /opt/ASA-30.29.zip
rm /opt/ASA-30.29.zip
cd /opt/ASA
chmod -R 777 /opt/ASA
#There does not appear to be any install, so header-only library


#SigPack: the C++ signal processing library
#Has usual spectrogram and such, but noteworthy for Kalman filters and adaptive filters.
#http://sigpack.sourceforge.net
wget -P /opt https://sourceforge.net/projects/sigpack/files/sigpack-1.2.6.zip
unzip /opt/sigpack-1.2.6.zip
rm /opt/sigpack-1.2.6.zip
mv /opt/demo_c++ /opt/sigpack
mv /opt/demo_matlab /opt/sigpack
mv /opt/doc /opt/sigpack
mv /opt/test /opt/sigpack
mv /opt/README.txt /opt/sigpack
chmod -R 777 /opt/sigpack


#libLBFGS: C++ library of Limited-memory Broyden-Fletcher-Goldfarb-Shanno (L-BFGS)
#method for unconstrained minimization when only F(x) and G(x) are computable.
#Also implements orthant-wise quasi-Newton (OWL-QN) method [Andrew and Gao 2007].
#The Ubuntu install is already done, but in case more is needed.
#This is dependency for several toolboxes below.
#Used by CRFsuite, Classias, lbfgs (R lib), mlegp (R lib for GPs), imaging2.
#Nocedal J. 1980. Updating quasi-Newton matrices with limited storage. Math Comput. 35(151): 773-82.
#Liu DC, Nocedal J. 1989. On the limited memory BFGS method for large scale optimization. Math Program B. 45(3): 503-28.
#Dennis JE, Schnabel RB. 1983. Numerical methods for unconstrained optimization and nonlinear equations. Prentice-Hall.
#Andrew G, Gao J. 2007. Scalable training of L1-regularized log-linear models. Proc ICML: 33-40.
#http://www.chokkan.org/software/liblbfgs/
cd /opt
wget -P /opt https://github.com/downloads/chokkan/liblbfgs/liblbfgs-1.10.tar.gz
tar -xzf /opt/liblbfgs-1.10.tar.gz
rm /opt/liblbfgs-1.10.tar.gz
chmod -R 777 /opt/liblbfgs-1.10
cd /opt/liblbfgs-1.10
./configure
make
make check
sudo make install
chmod -R 777 /opt/liblbfgs-1.10
sudo ln -s /opt/liblbfgs-1.10/.libs/liblbfgs-1.10.so /usr/lib/liblbfgs-1.10.so
sudo ln -s /opt/liblbfgs-1.10/.libs/liblbfgs.so /usr/lib/liblbfgs.so


#Classias: ML algorithms for classification in C++ 
#Simple headers, good command-line tools, modified (2-clause) BSD license.
#L1/L2 logistic regression, SVM, averaged perceptron.
#Binary, multi-class, and candidate classification. The later is really important, check it out!
#From maker of widely-used L-BFGS lib.
#http://www.chokkan.org/software/classias
cd /opt
wget -P /opt http://www.chokkan.org/software/dist/classias-1.1.tar.gz
tar -xzf /opt/classias-1.1.tar.gz
rm /opt/classias-1.1.tar.gz
chmod -R 777 /opt/classias-1.1
cd /opt/classias-1.1
./configure
sed -i 's|int ret = lbfgs_solve|int ret = this->lbfgs_solve|g' /opt/classias-1.1/include/classias/train/lbfgs.h
make
sudo make install
sudo chmod -R 777 /opt/classias-1.1


#SVMlight: SVM in C, with fast optimization algorithm,
#and efficient leave-one-out estimates of error rate, precision, recall.
#For regression and classification; can train SVMs with cost models and example-dependent costs
#Handles 1000s of SVs and 100000s of training examples.
#(Suggested by Classias website) (but no particular licence)
#Joachims T [1999], Making large-scale SVM learning practical. In Schulkopf et al., eds. Cambridge: MIT Press.
#http://svmlight.joachims.org


#SVMperf: SVM for multivariate performance measures
#(Suggested by Classias website) (but no particular licence)
#http://www.cs.cornell.edu/people/tj/svm_light/svm_perf.html


#RNNLIB: recurrent NN library for sequence learning problems in C++
#https://sourceforge.net/p/rnnl/wiki/Home
#Download .tar.gz file to /opt
cd /opt
tar -xzf /opt/rnnlib.tar.gz
rm /opt/rnnlib.tar.gz
mv /opt/rnnlib_source_forge_version /opt/rnnlib
chmod -R 777 /opt/rnnlib
cd /opt/rnnlib
./configure
make
make check
sudo make install
chmod -R 777 /opt/rnnlib
#This install doesn't work, so use an improved github version:
cd /opt
git clone https://github.com/jpuigcerver/rnnlib
chmod -R 777 /opt/rnnlib
cd /opt/rnnlib
make
#This install also fails for the same reaons...


#CURRENNT: RNN ML library using NVIDIA GPUs and C++/CUDA to accelerate.
#Also allows very large data sets that don't fit in RAM.
#Focus is on uni- and bi-LSTMs, but also other DNNs.
#Under GPL
#https://sourceforge.net/projects/currennt
#Download .zip file from sourceforge and put in /opt
cd /opt
unzip -d /opt/currennt /opt/currennt-0.2-rc1.zip
rm /opt/currennt-0.2-rc1.zip
chmod -R 777 /opt/currennt
cd /opt/currennt
mkdir build && cd build
cmake ..
make
#Get Error 2. Anyway, under GPL, so not worth fixing...


#LSTMNeuroEvolver: Under GPLv2
#Download .zip file from sourceforge and put in /opt
cd /opt
unzip -d /opt/neuroevolver /opt/neuroevolver_src.zip
rm /opt/neuroevolver_src.zip
chmod -R 777 /opt/neuroevolver
cd /opt/neuroevolver
#In Java!!


#Haste: LSTM in C++ from lmnt.com
#https://github.com/lmnt-com/haste
#Wan L, et al. 2013. Regularization of neural networks using DropConnect. ICML.
#Krueger D, et al. 2017. Zoneout: regularizing RNNs by randomly preserving hidden activations. arXiv. 1606.01305: 1-.
cd /opt
git clone https://github.com/lmnt-com/haste
chmod -R 777 /opt/haste
cd /opt/haste
#...must first install TensorFlow, and have all CUDA aspects working...



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


#Sage Math (GUI, not command-line usage)


#hmmlearn: simple Python library for unsupervised HMM models [BSD license].
#Seems clear and easy-to-use (like sklearn), at least for HMM-GMM example.
#For supervised learning of HMMs, they suggest seqlearn.
#https://hmmlearn.readthedocs.io/en/latest
#https://github.com/hmmlearn/hmmlearn
python -m pip install --user --upgrade hmmlearn


#pomegranate: "Fast, flexible and easy to use probabilistic modelling in Python" [MIT license]
#Seems like excellent work (BLAS/GPU acceleration, Cython), attempts to be sklearn-like. 
#Mixture models, HMMs, Markov chains, Bayes classifiers, Bayesian networks, etc.
#Schreiber J. (2018). pomegranate: fast and flexible probabilistic modelling in Python. J Mach Learn Res. 18(1): 5992-7.
#https://pomegranate.readthedocs.io/en/latest
#https://github.com/jmschrei/pomegranate
python -m pip install --user pomegranate


#Flashlight: C++ library from Facebook for general ML
#https://github.com/facebookresearch/flashlight
#https://fl.readthedocs.io/en/latest
sudo apt-get install openmpi-bin openmpi-common libopenmpi-dev
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


#PyTorch C++ API
#This is for the CPU-only version (try GPU version later).
#https://pytorch.org/cppdocs/
sudo apt-get -y install libtorch3-dev       #Torch
cd /opt
wget -P /opt https://download.pytorch.org/libtorch/nightly/cpu/libtorch-shared-with-deps-latest.zip
unzip -d /opt/libtorch libtorch-shared-with-deps-latest.zip
rm /opt/libtorch-shared-with-deps-latest.zip
chmod -R 777 /opt/libtorch


#PyTorch for Python
python -m pip install torch torchvision
#later I did this to get newer version
python -m pip install --user --upgrade torch torchvision


#torch audio
#Mostly for input/output, other than a simple pitch detector and repeat of sox functionality.
#https://pytorch.org/audio
#https://github.com/pytorch/audio
python -m pip install --user torchaudio -f https://download.pytorch.org/whl/torch_stable.html


#fastai for Python 3
#python -m pip install --user fastai


#Weights and Biases (wandb) for tracking and visualizing training in a web browser
python -m pip install --user --upgrade wandb


#TensorFlow2
#Requires pip version >19.
python -m pip install tensorflow
#I then installed /opt/nvidia/TensorRT-7.0.0.11
#Then I installed /opt/nvidia/TensorRT-6.0.1.8
python -m pip install --user --upgrade tensorflow
#Still cannot find libnvinfer.so.6, so won't use TensorRT


#Tensor2Tensor (T2T) from Google Brain
#Library of deep learning models and datasets designed to make deep learning more accessible
#Now in maintenance mode, can still use, but superceded by Trax.
python -m pip install --user --upgrade tensor2tensor && t2t-trainer



#Keras
python -m pip install --user --upgrade keras



#Chainer
#Major advantage seems to be:
#"Forward computation can include any control flow statements of Python without lacking the ability of backpropagation."
#Examples for RNN LM, word2vec and seq2seq models.
#However, these look like lots of code to achieve the result! And end result is a .py script to be run by Chainer.
#https://chainer.org
#There is a tar method, or git clone method, but they recommend pip
python -m pip install --user --upgrade chainer



#PaddlePaddle: PArallel Distributed Deep LEarning.
#ML framework from industrial practice: "industrial platform with advanced technologies and
#rich features that cover core deep learning frameworks, basic model libraries, end-to-end development kits, ..."
#"the only independent R&D deep learning platform in China" (Apache 2.0 license)
#Appears to be only for Python.
#Does appear to have many examples and maintained pre-trained models (that win), e.g. GANs for CV.
#However, NLP examples are limited to sentiment analysis, label semantic roles, and MT.
#https://github.com/PaddlePaddle/Paddle
#python -m pip install --user paddlepaddle-gpu==1.7.1.post107 -i https://mirror.baidu.com/pypi/simple
python -m pip install --user --upgrade paddlepaddle
python -m pip install --user --upgrade paddlepaddle-gpu
#This roles SciPy back to 1.3.1 from 1.4.1.



#MXNet: from Apache
#"A truly open source deep learning framework suited for flexible research prototyping and production"
#Nice ecosystems for CV, NLP and time-series analysis.
#There is a whole interactive textbook where each section is an executable Jupyter notebooks:
#Zhang A, ..., Smola AJ. (2020). Dive into deep learning, Release 0.7.1. https://d2l.ai
#https://mxnet.apache.org
#Do this later when ready to consider installing more Apache tools...


#faiss: "library for efficient similarity search and clustering of dense vectors", from FAIR [MIT license]
#https://github.com/facebookresearch/faiss


#Optuna: library for hyperparameter optimization [MIT license]
#Looks really good. Advanced, professional grade. Has proper reference, docs, tutorial, etc.
#Has "integration modules" for: XGBoost, LightGBM, Chainer, Keras, TF, tf.keras, MXNet, PyTorch, FastAI, AllenNLP.
#Main drawback seems to be that the objective function must be defined as a Python function,
#even for the command-line tool "optuna study optimize ...", where one gives the .py function as an input.
#The tutorial is entirely in Python.
#Akiba T, Sano S, Yanase T, Ohta T, Koyama M. 2019. Optuna: a next-generation hyperparameter optimization framework. arXiv. 1907.10902.
#https://optuna.org
#https://github.com/optuna/optuna
python -m pip install --user --upgrade optuna


#IDIAP:
#WARCA: a simple and fast algorithm for metric learning.
#C++ code (GPL3 license) for linear metric learning and non-linear metric learning via kernels.
#This seems really easy to install and use (has command-line tools for train and predict).
#https://github.com/idiap/warca

