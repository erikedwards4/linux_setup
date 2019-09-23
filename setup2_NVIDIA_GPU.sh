#!/bin/bash
#@author Erik Edwards
#@date 2019
#
#This lists commands that I figured out for setting up NVIDIA GPU.


#nvidia-smi should already be installed. Try:
nvidia-smi -L		#lists GPUs installed

#Install nvidia toolkit
sudo apt-get install nvidia-cuda-toolkit

#This gives, for example, the nvcc command (a cc compiler for nvidia):
nvcc --help

#To check the nvidia-cuda-toolkit version:
nvcc -V

#Install openCL library for nvidia (should already be installed)
sudo apt-get install nvidia-opencl-dev

#When running something, can check with:
nvidia-smi -lms 500

#But that scrolls through (one printout every 500 ms)
#The following makes is like top for GPUs:
watch nvidia-smi


#Also consider
#nvtop                      #only for Disco (not Bionic)
#nvidia-system-monitor      #separate, GUI application


#UPGRADE:

#First must force upgrade of held-back driver updates
sudo apt-get --with-new-pkgs upgrade
sudo apt autoremove
#Restart: sudo reboot

#Remove nvidia-cuda-toolkit
sudo apt remove nvidia-cuda-toolkit
sudo apt autoremove
sudo apt purge nvidia-cuda-tookit

#Some dependencies
sudo apt-get install freeglut3 freeglut3-dev libxi-dev libxmu-dev
sudo apt autoremove

#Upgrade nvidia-cuda-toolkit to latest (here 10.1.2):
#These lines come from developer.nvidia.com (have to login, choose OS, etc.)
cd /opt/cuda
wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
sudo sh cuda_10.1.243_418.87.00_linux.run
#Then make cuda.sh file (run only after restart):
sudo vim /etc/profile.d/cuda.sh
#with 2 lines:
#export PATH=$PATH:/usr/local/cuda/bin
#export CUDADIR=/usr/local/cuda


#There are a number of math libraries
#Most of these may already come with nvidia-cuda-toolkit:
#cuBLAS, CUDA Math library, cuSPARSE, cuRAND, cuSOLVER, AmgX.

#And a number of signal, image and video libraries
#cuFFT, NVIDIA Performance Primitives, NVIDIA Codec SDK

#And a few parallel algorithm libraries
#NCCL (for multiple GPUs and nodes), nvGRAPH (for graph analytics),
#Thrust (for general parallel algorithms and data structures).

#And a few deep learning libraries
#But these are not included with nvidia-cuda-toolkit:
#cuDNN, TensorRT, DeepStream SDK (for video inference)


#Install cuDNN (required for tensorflow-gpu)
#From developer.nvidia.com, downloaded: runtime, dev, and doc .deb files -> /opt/cuda
cd /opt/cuda
sudo dpkg -i libcudnn7_7.6.3.30-1+cuda10.1_amd64.deb
sudo dpkg -i libcudnn7-dev_7.6.3.30-1+cuda10.1_amd64.deb
sudo dpkg -i libcudnn7-doc_7.6.3.30-1+cuda10.1_amd64.deb


#Note that the following are "partner libraries":
#FFmpeg, OpenCV, ArrayFire, Magma, RogueWave, Gunrock, Sundog, etc.


#I now re-install openBLAS (BSD licence) to get most recent version:
cd /opt
git clone https://github.com/xianyi/OpenBLAS.git
chmod -R 777 /opt/OpenBLAS
cd /opt/OpenBLAS
make PREFIX=/opt/OpenBLAS/install USE_THREAD=0 -C OpenBLAS all install


