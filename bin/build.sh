#! /usr/bin/bash

while getopts t:f:m:d: flag
do
  case "${flag}" in
    f) fort=${OPTARG};;
    m) env_module=${OPTARG};;
    d) build_dir=${OPTARG};;
    t) topnet_src=${OPTARG};;
  esac
done

echo "fort: $fort"
echo "env_module: $env_module"
echo "build_dir: $build_dir"
echo "topnet_src: $topnet_src"

cd $build_dir
module load CMake
module load "$env_module"
FC=$fort cmake $topnet_src
make clean
make

