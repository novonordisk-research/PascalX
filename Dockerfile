FROM ubuntu:22.04

# Copy over PascalX
COPY . /PascalX

# Install dependencies
RUN mkdir -p /PascalX/build/lib
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && \
    apt-get install -y \
    python3.11 \
    python3.11-dev \
    python3-setuptools \
    python3-pip \
    python3-numpy \
    g++ \
    make \
    libboost-all-dev \
    wget \
    unzip \
    python3-pybind11 \
    python3-matplotlib \
    python3-pandas && \
    rm -rf /var/lib/apt/lists/*
RUN ln -sf /usr/bin/python3.11 /usr/local/bin/python3
RUN echo "/PascalX/build/lib" > /etc/ld.so.conf.d/pascalx.conf

# Build
RUN cd /PascalX && make all && ldconfig && make test
RUN cd /PascalX/python/ && python3 setup.py install

# Install jupyter
RUN python3 -m pip install jupyter
