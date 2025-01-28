# Use the official NVIDIA CUDA base image; pick a specific tag for your needs.
#FROM nvidia/cuda:11.8.0-base-ubuntu22.04
FROM nvidia/cuda:12.6.3-cudnn-devel-ubuntu24.04
#FROM nvidia/cuda:12.8.0-cudnn-runtime-ubuntu22.04

# Optionally install other packages you need
#RUN apt-get update && \
#    apt-get install -y --no-install-recommends \
#        git \
#        vim python3 pip \ && \
#    rm -rf /var/lib/apt/lists/*


#git clone https://github.com/exo-explore/exo.git

# Set the default command to run nvidia-smi
#CMD ["nvidia-smi"]

#TODO VENV needed?

# Install system packages needed for git, Python, pip, venv
#RUN apt-get update && apt-get install -y --no-install-recommends \
# Enable extra repos and install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    git nano htop wget \
    python3 \
    python3-pip \
    python3-venv

#For CPU support: 
#RUN apt-get install -y --no-install-recommends \
#    clang \
#    python3-llvmlite

RUN apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \ 
    && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /exo

# Clone exo into /exo
RUN git clone https://github.com/exo-explore/exo.git /exo

# Create a virtual environment (named .venv) and install exo in editable mode
# Note: we also upgrade pip here inside the venv, which can help avoid issues
RUN python3 -m venv .venv && \
    . .venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -e . && \ 
#    pip install llvmlite

#llvmlite is for cpu inferencing, but really unstable and feels single core...  not needed for GPU

# Put the venv's bin on PATH so "exo" is available by default
ENV PATH="/exo/.venv/bin:${PATH}"

# Set the default command to run "exo"
CMD ["exo"]
