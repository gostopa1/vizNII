function img3=overlap_niis(nii1,nii2,thr)
%% OVERLAP_NIIS(nii1,nii2,thr)
% this function gets two nifti structs and find the overlapping regions given a
% threshold.
nii1.img(nii1.img<thr)=0;
nii1.img(nii1.img>=thr)=1;


nii2.img(nii2.img<thr)=0;
nii2.img(nii2.img>=thr)=1;


img3=(nii1.img+nii2.img)>1;


end