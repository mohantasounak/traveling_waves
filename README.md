# Traveling_waves
Example code and functions to calculate traveling waves for neural time series.

This script (tested on Matlab 2018a) uses the Fieldtrip toolbox (Oostenveld et al. 2011), CircStat toolbox (Berens 2009). Analysis pipline adapted from Halgren et al. 2017.

# Installation
Step 1: Download Fieldtrip from https://www.fieldtriptoolbox.org/download/

Step 2: Download CircStat toolbox from https://fr.mathworks.com/matlabcentral/fileexchange/10676-circular-statistics-toolbox-directional-statistics

Step 3: Load example_code.m in Matlab editor. This is an example script on how to calculate traveling wave across electrodes and can be used as a template. Traveling waves are calculated with respect to the ventro-posterior most electrode's phase.

Step 4: Change Fieldtrip file path in example_code.m
```
addpath /my fieldtrip software location here/fieldtrip folder name
```
Step 5: Change scripts file path in example_code.m
```
path(path,genpath('my traveling wave scripts here/my scripts folder name'));
```
Step 6: Change CircStat file path in example_code.m
```
path(path,genpath('my CircStat folder path/CircStat folder name'));
```
Step 7: Run example_code.m
# Data description
Electrocorticigraphy (ECoG) dataset with 62 grid electrodes (data.label). Registered to Human Connectome Project atlas (data.label2).
