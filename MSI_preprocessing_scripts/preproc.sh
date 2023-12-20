#!/bin/bash -l
#SBATCH --job-name=ImageGen
#SBATCH --time=4:00:00
#SBATCH --mem-per-cpu=32G
#SBATCH --output=logs/preproc_%A_%a.out
#SBATCH --error=logs/preproc_%A_%a.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=USER@umn.edu
#SBATCH -A feczk001

pwd; hostname; date
echo jobid=${SLURM_JOB_ID}; echo nodelist=${SLURM_JOB_NODELIST}

module load python3/3.8.3_anaconda2020.07_mamba
module load fsl
module load ants/2.3.3

SUBJECT=$1
SESSION=$2
input_file=$3
output_file=$4
data_dir=$5
code_dir=$6
img_mod=$7

sub_temp_dir=${data_dir}/temp/${SUBJECT}_${SESSION}
if [ ! -d "${sub_temp_dir}" ]; then
	mkdir "${sub_temp_dir}"
fi

${code_dir}/setup_input_image.sh ${input_file} ${SUBJECT} ${SESSION} ${data_dir}/temp/${SUBJECT}_${SESSION} /${data_dir}/output/${SUBJECT}_${SESSION} ${img_mod}


echo COMPLETE

