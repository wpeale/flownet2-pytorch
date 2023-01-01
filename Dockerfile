FROM nvidia/cuda:12.0.0-devel-ubuntu20.04
MAINTAINER hirakawat
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# basic packages
RUN apt-get -y update && apt-get -y upgrade && \
        apt-get install -y sudo cmake g++ gfortran \
        libhdf5-dev pkg-config build-essential \
        wget curl git htop tmux vim ffmpeg rsync openssh-server \
        python3 python3-dev libpython3-dev && \
        apt-get -y autoremove && apt-get -y clean && apt-get -y autoclean && \
        rm -rf /var/lib/apt/lists/*


# cuda path
ENV CUDA_ROOT /usr/local/cuda
ENV PATH $PATH:$CUDA_ROOT/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$CUDA_ROOT/lib64:$CUDA_ROOT/lib:/usr/local/nvidia/lib64:/usr/local/nvidia/lib
ENV LIBRARY_PATH /usr/local/nvidia/lib64:/usr/local/nvidia/lib:/usr/local/cuda/lib64/stubs:/usr/local/cuda/lib64:/usr/local/cuda/lib$LIBRARY_PATH


# python3 modules
RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && \
        pip3 install --upgrade --no-cache-dir wheel six setuptools cython numpy scipy \
                matplotlib seaborn scikit-learn scikit-image pillow requests \
                jupyterlab networkx h5py pandas plotly protobuf tqdm tensorboardX colorama setproctitle && \
        pip3 install torch
