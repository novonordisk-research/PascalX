FROM python:3.11-slim

# Install dependencies
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && \
    apt-get install -y \
        python3-dev \
        g++ \
        make \
        libboost-all-dev \
        wget \
        unzip \
    && rm -rf /var/lib/apt/lists/*
RUN pip install setuptools pybind11 matplotlib pandas
RUN mkdir -p /PascalX/build/lib && \
    echo "/PascalX/build/lib" > /etc/ld.so.conf.d/pascalx.conf

# Build
COPY . /PascalX
RUN cd /PascalX && make all && ldconfig && make test
RUN cd /PascalX/python/ && python setup.py install

# Install jupyter
RUN python -m pip install jupyter
