# Start from Ubuntu
FROM ubuntu:24.04

# Copy over PascalX
COPY . /PascalX

# Install dependencies
RUN mkdir -p /PascalX/build/lib
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt-get install -y python3.11 python3-dev python3-setuptools python3-pip python3-numpy g++ make libboost-all-dev wget unzip
RUN echo "/PascalX/build/lib" > /etc/ld.so.conf.d/pascalx.conf

# Build
RUN cd /PascalX && make all && ldconfig && make test
RUN apt-get update && apt-get install -y python3-pybind11
RUN apt-get update && apt-get install -y python3-matplotlib
RUN apt-get update && apt-get install -y python3-pandas
RUN cd /PascalX/python/ && python3 setup.py install

# Install jupyter
RUN pip3 install jupyter

