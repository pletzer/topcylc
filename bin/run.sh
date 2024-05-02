#!/bin/bash -e
#SBATCH --job-name=topnet
#SBATCH --time=00:10:00
#SBATCH --mem=5g

while getopts r:i:m:d: flag
do
  case "${flag}" in
    r) run_dir=${OPTARG};;
    i) input_dir=${OPTARG};;
    m) env_module=${OPTARG};;
    d) build_dir=${OPTARG};;
  esac
done

echo "run_dir: $run_dir"
echo "input_dir: $input_dir"
echo "env_module: $env_module"
echo "build_dir: $build_dir"

cd $run_dir
module load "$env_module"
cp $input_dir/io_paths.nml .
cp $input_dir/test.nml .

$build_dir/source/topnet test.nml >& topnet-out.txt
