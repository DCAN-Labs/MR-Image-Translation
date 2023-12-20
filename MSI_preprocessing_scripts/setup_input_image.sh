#!/bin/bash

FSLDIR=/common/software/install/migrated/fsl/6.0.4

input=$1
subject=$2
session=$3
WD=$4
output=$5
img_mod=$6

mkdir -p ${WD}

std=$WD/`basename $input | sed 's|.nii.gz|_std.nii.gz|'`
acpc=$WD/`basename $input | sed 's|.nii.gz|_acpc.nii.gz|'`
omat=`echo $acpc | sed 's|.nii.gz|.mat|'`
denoised=`echo $acpc | sed 's|.nii.gz|Denoise.nii.gz|'`
dc=`echo $denoised | sed 's|.nii.gz|N4dc.nii.gz|'`

fslreorient2std ${input} ${std}

/home/faird/shared/projects/3D_MRI_GAN/tio_unet/dcan-infant-pipeline/PreFreeSurfer/scripts/ACPCAlignment_with_crop.sh --workindir=${WD} --in=${std} --ref=/home/faird/shared/projects/3D_MRI_GAN/tio_unet/dcan-infant-pipeline/global/templates/INFANT_MNI_T1_1mm.nii.gz --out=$acpc --omat=$omat --brainsize=120

DenoiseImage -d 3 -n Rician --input-image ${acpc} --output ${denoised}

N4BiasFieldCorrection -d 3 --input-image ${denoised} --shrink-factor 2 --output [${dc},${WD}/N4BiasField_${img_mod}.nii.gz]

mkdir -p ${output}
cp ${dc} ${output}/${subject}_${session}_${img_mod}.nii.gz



