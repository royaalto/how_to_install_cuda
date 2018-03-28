#!/bin/bash
##first install nvidia_diver
##uninstall all the nvidia_diver

#sudo apt-get remove --purge nvidia*
#sudo reboot
#cd Downloas/

##download the proper nvidia_diver from the website
#sudo chmod a+x nvidia_diver
#echo -e "blacklist nouveau\nblacklist lbm-nouveau\noptions nouveau modeset=0\nalias nouveau off\nalias lbm-nouveau off\n" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
#echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf
#sudo update-initramfs  -u

##update linux kernel
#sudo apt-get install linux-image-extra-virtual
#apt-get install linux-headers-$(uname -r)
#sudo service lightdm stop
# sudo ./nvidia_diver -no-x-check -no-nouveau-check -no-opengl-files
#sudo service lightdm start

##verify the driver
#nvidia-smi

#second install cuda-8.0 cudnn6.0
#fix bugs
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --no-install-recommends libboost-all-dev
sudo apt-get install libopenblas-dev liblapack-dev libatlas-base-dev
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev
sudo apt-get install git cmake build-essential
sudo apt-get install freeglut3 freegult3-dev
mkdir -p /usr/lib64
echo "/usr/local/cuda/lib64" > cuda.conf
cp cuda.conf /etc/ld.so.conf.d
ldconfig
sudo echo -e "export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:\$LD_LIBRARY_PATH
export PATH=/usr/local/cuda-8.0/bin:\$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH" >> ~/.bashrc
cd ~
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run﻿ ﻿
﻿sudo sh cuda_8.0.61_375.26_linux.run --override --no-opengl-lib
#Do you accept the previously read EULA? (accept/decline/quit): accept
# Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 375.26? ((y)es/(n)o/(q)uit): n
# Install the CUDA 8.0 Toolkit? ((y)es/(n)o/(q)uit): y
# Enter Toolkit Location [ default is /usr/local/cuda-8.0 ]:
# Do you want to install a symbolic link at /usr/local/cuda? ((y)es/(n)o/(q)uit): y
# Install the CUDA 8.0 Samples? ((y)es/(n)o/(q)uit): y
# Enter CUDA Samples Location [ default is /home/user ]: /usr/local/cuda-8.0

#install cudnn 6.0
CUDNN_TAR_FILE="cudnn-8.0-linux-x64-v6.0.tgz"
wget http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/${CUDNN_TAR_FILE}
tar -xzvf ${CUDNN_TAR_FILE}
sudo cp -P cuda/include/cudnn.h /usr/local/cuda-8.0/include
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda-8.0/lib64/
cd /usr/local/cuda/lib64/
sudo rm -rf libcudnn.so libcudnn.so.5
sudo ln -s libcudnn.so.6.0.21 libcudnn.so.6 #生成软衔接
sudo ln -s libcudnn.so.5 libcudnn.so #生成软链接
sudo chmod a+r /usr/local/cuda-8.0/lib64/libcudnn*
