%%This script loads a standard NIFTI file and 
% it replaces the black background with a white one.
% It then saves the output to a new NIFTI file 
% (however not with the same header file as the original one)
%

% Copyright 2014 -  A. Gotsopoulos

addpath('nifti'); % Make sure that the nifti path is added. It is necessary in order to load files

base=load_nii('../nifti_templates_masks/mni152bet.nii'); % Load some NIFTI file. This one for example

%%base=load_nii('MNI152lin_T1_1mm.nii'); % Another example if needed

niiimg=double(base.img); % Convert the input NIFTI file to double (usually they are in uint8 format to save space)

niiimg=niiimg./max(niiimg(:)); % Normalize the nifti file to get values only up to 1 (We mainly assume that there are no negative values in the file)


% Use the magic wand tool with a seed from the black background. 
% The input arguments are the input infti file the coordinates (x,y,z) and the
% tolerance of the magic wand. Play around with those if they are not
% working
b=double(magicwand3d2(niiimg,1,1,1,0.2));

% This often make the edges to be too sharp. We smooth the mask to get smoother edges
temp2=smooth3(b,'gaussian',5,1);


% If you wish to visualize the result before saving uncomment the next two line
 %view_nii(make_nii((1-temp2).*niiimg+temp2));
nobits=4;
temp3=(1-temp2).*niiimg+temp2;
%temp3=temp3*(2^nobits);
%%
nobits=512;
%temp3=base.img;

temp3=(1-temp2).*niiimg+temp2;
temp3=temp3*(2^8);
niiout=make_nii(temp3);
niiout.hdr.dime.datatype=nobits;
niiout.hdr.dime.bitpix=nobits;

save_nii(niiout,'whitened_0.5mm.nii')
