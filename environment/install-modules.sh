#!/bin/bash
set -ex

ENV_FILE="environment.yaml"
ENV_NAME="root"

if ! conda env list|grep  $ENV_NAME ; then
    echo "Creating conda venv $ENV_NAME"
    conda env create -q --file $ENV_FILE -n $ENV_NAME
    conda clean -tipsy
else
    conda env update -f $ENV_FILE -n $ENV_NAME
fi
conda env list
#cat >> ~/.profile << EOT  
#source activate $ENV_NAME
#EOT

#source activate $ENV_NAME

# XGBoost
git clone --recursive https://github.com/dmlc/xgboost
cd xgboost
git checkout 14fba01b5ac42506741e702d3fde68344a82f9f0
make -j
cd python-package; python setup.py install
cd ../../
rm -rf xgboost

# LightGBM
git clone --recursive https://github.com/Microsoft/LightGBM
cd LightGBM
git checkout d12e5e4c74b2a0b23ddc49df41ce4deaf02612d2
mkdir build && cd build && cmake -DUSE_MPI=ON ..
make -j
cd ../python-package/ && python setup.py install
cd ../../
rm -rf LightGBM

echo "Python version:"
which python
python --version

