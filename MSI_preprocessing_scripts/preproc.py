import os
import glob

code_dir='<full path to location of MR-Image-Translation/MSI_preprocessing_scripts>'
base_dir='<working directory>'
orig_dir=f'{base_dir}/orig' #put your real anatomicals to perform preprocessing on in this folder
temp_dir=f'{base_dir}/temp'
output_dir=f'{base_dir}/output'
anat_modality='T1w' #update with either T1w or T2w

# Create temp and output directories if they don't already exist
if not os.path.exists(temp_dir):
    os.mkdir(temp_dir)

if not os.path.exists(output_dir):
    os.mkdir(output_dir)

os.chdir(orig_dir)
anats=glob.glob('sub-*.nii.gz')
anats.sort()

for i in anats:
    sub=i.split('_')[0]
    ses=i.split('_')[1]
    subses=sub+'_'+ses

    outfile=f'{output_dir}/{subses}/{subses}_{anat_modality}.nii.gz'

    if not os.path.exists(outfile):
        cmd=f'sbatch {code_dir}/preproc.sh {sub} {ses} {orig_dir}/{i} {outfile} {base_dir} {code_dir} {anat_modality}'
        os.system(cmd)