FROM python:3.11-slim

# Copy over PascalX
COPY . /PascalX

# Install dependencies
RUN mkdir -p /PascalX/build/lib
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

# Install Python packages
RUN pip install numpy setuptools pybind11 matplotlib pandas
RUN echo "/PascalX/build/lib" > /etc/ld.so.conf.d/pascalx.conf

# Build
RUN cd /PascalX && make all && ldconfig && make test
RUN cd /PascalX/python/ && python setup.py install

# Install jupyter
RUN python -m pip install jupyter
