#! /bin/bash
# 
# This lists commands that I figured out for setting up NVIDIA GPU.


# nvidia-smi should already be installed. Try:
nvidia-smi -L		# lists GPUs installed

# Install nvidia toolkit
sudo apt-get install nvidia-cuda-toolkit

# This gives, for example, the nvcc command (a cc compiler for nvidia):
nvcc --help

# To check the nvidia-cuda-toolkit version:
nvcc -V

# Install openCL library for nvidia (should already be installed)
sudo apt-get install nvidia-opencl-dev

# When running something, can check with:
nvidia-smi -lms 500

# But that scrolls through (one printout every 500 ms)
# The following makes is like top for GPUs:
watch nvidia-smi

# Install NCCL 2 (NVIDIA Collective Communications Toolkit)
# For multi-GPU and multi-node, but dependency for e.g. flashlight
# This gives header file nccl.h (probably used by flashlight)
# https://developer.nvidia.com/nccl
# Download local installer for Ubuntu 18, manually with email account.
# Move .deb file to /opt
# Follow: https://docs.nvidia.com/deeplearning/sdk/nccl-install-guide/index.html
cd /opt
sudo dpkg -i nccl-repo-ubuntu1804-2.5.6-ga-cuda10.1_1-1_amd64.deb
# (Have to install key when prompted)
sudo apt update
sudo apt install libnccl2 libnccl-dev

# Also consider
# nvtop                      # only for Disco (not Bionic)
# nvidia-system-monitor      # separate, GUI application


# UPGRADE:

# First must force upgrade of held-back driver updates
sudo apt-get --with-new-pkgs upgrade
sudo apt autoremove
# Restart: sudo reboot

# Remove nvidia-cuda-toolkit
sudo apt remove nvidia-cuda-toolkit
sudo apt autoremove
sudo apt purge nvidia-cuda-tookit

# Some dependencies
sudo apt-get install freeglut3 freeglut3-dev libxi-dev libxmu-dev
sudo apt autoremove

# Disable Nouveau
sudo touch /etc/modprobe.d/blacklist-nouveau.conf
sudo chmod 775 /etc/modprobe.d/blacklist-nouveau.conf
sudo vim /etc/modprobe.d/blacklist-nouveau.conf
# Put:
# blacklist nouveau
# options nouveau modeset=0
sudo update-initramfs -u


# Upgrade nvidia-cuda-toolkit to latest (here 10.1.2):
# These lines come from developer.nvidia.com (have to login, choose OS, etc.)
cd /opt/cuda
wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
sudo sh cuda_10.1.243_418.87.00_linux.run
# Then make cuda.sh file (run only after restart):
sudo vim /etc/profile.d/cuda.sh
# with 2 lines:
# export PATH=$PATH:/usr/local/cuda/bin
# export CUDADIR=/usr/local/cuda


# There are a number of math libraries
# Most of these may already come with nvidia-cuda-toolkit:
# cuBLAS, CUDA Math library, cuSPARSE, cuRAND, cuSOLVER, AmgX.

# And a number of signal, image and video libraries
# cuFFT, NVIDIA Performance Primitives, NVIDIA Codec SDK

# And a few parallel algorithm libraries
# NCCL (for multiple GPUs and nodes), nvGRAPH (for graph analytics),
# Thrust (for general parallel algorithms and data structures).

# And a few deep learning libraries
# But these are not included with nvidia-cuda-toolkit:
# cuDNN, TensorRT, DeepStream SDK (for video inference)

# Note that the following are "partner libraries":
# FFmpeg, OpenCV, ArrayFire, Magma, RogueWave, Gunrock, Sundog, etc.


# Install cuTensor (linear algebra library)
# https://developer.nvidia.com/cutensor
# Download .tar.gz file to /opt/cuda
cd /opt/cuda
tar -xvf /opt/cuda/libcutensor-linux-x86_64-1.0.1.tar.gz -C /opt/cuda
chmod -R 777 /opt/cuda/libcutensor
rm /opt/cuda/libcutensor-linux-x86_64-1.0.1.tar.gz


# Install cuDNN (old first try using deb)
# From developer.nvidia.com, downloaded: runtime, dev, and doc .deb files -> /opt/cuda
# cd /opt/cuda
# sudo dpkg -i libcudnn7_7.6.3.30-1+cuda10.1_amd64.deb
# sudo dpkg -i libcudnn7-dev_7.6.3.30-1+cuda10.1_amd64.deb
# sudo dpkg -i libcudnn7-doc_7.6.3.30-1+cuda10.1_amd64.deb

# Install cuDNN (using tar download)
# https://developer.nvidia.com/rdp
# Download .tgz file to /opt/cuda
cd /opt/cuda
tar -xvf /opt/cuda/cudnn-10.2-linux-x64-v7.6.5.32.tgz -C /opt/cuda
chmod -R 777 /opt/cuda/cuda
rm /opt/cuda/cudnn-10.2-linux-x64-v7.6.5.32.tgz

# From https://developer.nvidia.com/
# Selected my system and OS type to get this download link:
wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run -P /opt
sudo sh /opt/cuda_10.2.89_440.33.01_linux.run
# But this gives message:
# "Existing package manager installation of the driver found.
#  It is strongly recommended that you remove this before continuing."
# So I aborted...


# I now re-install openBLAS (BSD licence) to get most recent version:
# The USE_THREAD=0 forces the single-threaded version (so apparently NVIDIA libraries require this?)
# I think that the default Ubuntu install is also single-threaded.
cd /opt
git clone https://github.com/xianyi/OpenBLAS.git
chmod -R 777 /opt/OpenBLAS
cd /opt/OpenBLAS
make PREFIX=/opt/OpenBLAS/install USE_THREAD=0 -C OpenBLAS all install

# However, I think this is a better make for other purposes is:
# DYNAMIC_ARCH does some sort of dynamic architecture build (adaptive to CPU type).
# USE_OPENMP uses OpenMP for multi-threading (remember to disable if the larger application does multi-threading to avoid conflict)
make DYNAMIC_ARCH=1 USE_OPENMP=1 PREFIX=/opt/OpenBLAS/install -C OpenBLAS all install

# So, may have to use make clean; and then redo the make, depending on larger application.


# Install dir for other NVIDIA tools
[ -d /opt/nvidia ] || mkdir -m 777 /opt/nvidia
cd /opt/nvidia


# Install TensorRT-6
# https://developer.nvidia.com/tensorrt
tar -xzf TensorRT-6.0.1.8.Ubuntu-18.04.x86_64-gnu.cuda-10.2.cudnn7.6.tar.gz -C /opt/nvidia
cd /opt/nvidia/TensorRT-6.0.1.8
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/nvidia/TensorRT-6.0.1.8/lib
cd /opt/nvidia/TensorRT-6.0.1.8/python
python -m pip install tensorrt-6.0.1.8-cp36-none-linux_x86_64.whl
cd /opt/nvidia/TensorRT-6.0.1.8/uff
python -m pip install uff-0.6.5-py2.py3-none-any.whl
# Check: which convert-to-uff
cd /opt/nvidia/TensorRT-6.0.1.8/graphsurgeon
python -m pip install graphsurgeon-0.4.1-py2.py3-none-any.whl


# Install TensorRT-7
# https://developer.nvidia.com/tensorrt
tar -xzf TensorRT-7.0.0.11.Ubuntu-18.04.x86_64-gnu.cuda-10.2.cudnn7.6.tar.gz -C /opt/nvidia
cd /opt/nvidia/TensorRT-7.0.0.11
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/nvidia/TensorRT-7.0.0.11/lib
cd /opt/nvidia/TensorRT-7.0.0.11/python
python -m pip install tensorrt-7.0.0.11-cp36-none-linux_x86_64.whl
cd /opt/nvidia/TensorRT-7.0.0.11/uff
python -m pip install uff-0.6.5-py2.py3-none-any.whl
# Check: which convert-to-uff
cd /opt/nvidia/TensorRT-7.0.0.11/graphsurgeon
python -m pip install graphsurgeon-0.4.1-py2.py3-none-any.whl


# Get repositories
sudo add-apt-repository ppa:graphics-drivers/ppa
# Hit Enter to confirm


# Install NVIDIA apex library
cd /opt/nvidia
git clone https://github.com/NVIDIA/apex
chmod -R 777 /opt/nvidia/apex
cd /opt/nvidia/apex

