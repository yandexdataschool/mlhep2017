#!/bin/sh

apt-get update
apt-get install -y \
        gfortran \
        liblapack-dev \
        zlib1g-dev \
        libjpeg-dev \
        libboost-all-dev \
        libsdl2-dev \
        swig \
        clang \
        unzip \
        libibnetdisc-dev \
        build-essential \
        git \
        cmake \
        wget \
        curl
#       libblas-dev \
#apt-get install -y python-dev python-pip python-nose g++ libblas-dev git cmake gfortran liblapack-dev zlib1g-dev libjpeg-dev xvfb libav-tools xorg-dev python-opengl libboost-all-dev libsdl2-dev swig clang unzip htop python-setuptools libibnetdisc-dev
