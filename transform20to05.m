%% This script transforms 2mm or 4mm isotropic images to 0.5mm images for visualization


filename='test_4mm_radius_2.nii';
filename_hires='test_4mm_radius_2_hires.nii';
curdir=pwd;

ref=[curdir '/' 'mni152bet.nii'];
transmat=[curdir '/transformation_matrices/' '2mmto05mm.mat'];

system(['flirt -in ' filename ' -applyxfm -init ' transmat ' -out ' filename_hires  ' -paddingsize 0.0 -interp trilinear -ref ' ref])
system(['gzip -d ' filename_hires '.gz' ])

%%
dir  MNI152_T1_2mm_brain.nii


niitemp=load_nii(filename);
niibase=load_nii('MNI152_T1_2mm_brain.nii');

niitemp.hdr=niibase.hdr;

niitemp.img=niitemp.img*10000;

save_nii(niitemp,'test2mm2.nii')