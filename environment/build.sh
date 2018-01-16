#!/bin/bash
set -ex
IMAGE="yandexdataschool/mlhep2017"

version=0.4
if [ -n "$1" ] ; then
  version=$1
fi
if docker images|grep $IMAGE|grep "\s$version\s" ; then
  echo "Version $version already exists"
  exit 1
fi
docker build -t $IMAGE:latest -f Dockerfile.ubuntu .
docker tag $IMAGE:latest $IMAGE:$version

#docker push $IMAGE:$version
#docker push $IMAGE:latest
