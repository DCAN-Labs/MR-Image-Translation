from os import listdir
from os.path import isfile, join

import nibabel as nib

input_folder='<folder containing preprocessed images that need to be cropped>'
output_folder='<output folder for cropped images>'

def crop_images(image_dir, output_dir):
    x_max = 171
    x_min = 15

    y_max = 213
    y_min = 25

    z_max= 156
    z_min=0

    image_files = sorted([f for f in listdir(image_dir) if isfile(join(image_dir, f))])
    for f in image_files:
        input_file = join(image_dir, f)
        img = nib.load(input_file)
        cropped_img = img.slicer[x_min:x_max, y_min:y_max, z_min:z_max, ...]
        print(cropped_img.shape)
        output_file = join(output_dir, f)
        nib.save(cropped_img, output_file)

if __name__ == '__main__':
    crop_images(input_folder, output_folder)