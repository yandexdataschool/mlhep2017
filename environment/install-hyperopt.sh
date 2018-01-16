#!/bin/bash
set -ex

cd /tmp
git clone https://github.com/hyperopt/hyperopt.git
cd hyperopt && git pull origin pull/288/head
pip install --upgrade .
cd /tmp; rm -rf hyperopt

