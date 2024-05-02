#!/bin/bash
#SBATCH --job-name=topnet
#SBATCH --time=00:10:00
#SBATCH --mem=5g

while getopts r:t:m: flag
do
  case "${flag}" in
    t) topnet_src=${OPTARG};;
    r) run_dir=${OPTARG};;
    m) env_module=${OPTARG};;
  esac
done

echo "run_dir: $run_dir"
echo "topnet_src: $topnet_src"
echo "input_dir: $input_dir"
echo "env_module: $env_module"

cd $run_dir
module load Python

python $topnet_src/scripts/plot_tseries.py -n output/tseries*.nc -v mod_streamq -o mod_streamq.png >& plot_tseries-out.txt

# get the checksum
checksum=$(cat plot_tseries-out.txt | perl -ne 'if(/checksum\:\s*([^\s]*)/){print $1;}')
ref_checksum="1249613.54610252"

# compare checksum
python -c "diff = abs(${checksum} - ${ref_checksum});if diff > 1.e10:print('FAIL')"
