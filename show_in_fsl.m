%% This script loads a bunch of nifti files and opens them in fslview using the command tools for fslview
% Loading all the images every time manually in fsl is laborious so this
% script saves time in that sense

base= './nifti_templates_masks/mni152bet.nii'
cmd=['fslview ' base];
    
method='outgr'

prefix='./example_niftis/';
for emoi=1:5
switch emoi
    case 1
        color='Green';
    case 2
        color='Red'
    case 3
        color='Yellow'
    case 4
        color='Pink'
    case 5
        color='Blue'
end

file=[prefix method num2str(emoi) '_hires.nii'];


cmd=[cmd ' ' file ' -l ' color ' -b 10,11 ']
end
cmd=[cmd ' &']
system(cmd);