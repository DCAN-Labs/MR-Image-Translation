### When generating synthetic images from a trained models:

#### Put models in directory:
```
./models/
```

#### With names:
```
G_A2B_model.hdf5
G_B2A_model.hdf5
```

#### Create directories for generated images:
All images must be of size (156, 182, 156).
```
./generate_images/synthetic_images/A
./generate_images/synthetic_images/B
```

#### Comment row 242:
```
#self.train(…
```

#### Uncomment row 243:
```
self.load_model_and_generate_synthetic_images()
```

#### Put input data in:

* CycleGAN/data/MR_crop/testA
* CycleGAN/data/MR_crop/testA

#### Then run:
Run from the *CycleGAN* folder.
```
python CycleGAN_3D.py
```
