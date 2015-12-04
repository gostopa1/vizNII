
addpath(genpath('functions')) % Add the paths to use the NIFTI tools and VIZNII scripts

mask=load_nii('./nifti_templates_masks/whitened_05mm.nii'); % Load the background image
base=load_nii('./nifti_templates_masks/mni152bet.nii'); % Load the image to use as reference for the MNI coords


%% This a struct for the images. The first one is the background

str(1).img=double(mask.img); % str.img is the NIFTI image
str(1).trans=1.3; % This is the transparency of the image. It basically takes values from 0-1 but values larger than 1 make it brighter
str(1).col=[1 1 1]; % This is the coloud
str(1).thr=0;

%% Load all the .nii files
for emoi=1:5
    
    nii(emoi)=load_nii(['./example_niftis/outgr' num2str(emoi) '_hires.nii']);
end

%% Define a set of colours for the image
col=[0 1 0; 1 0 0 ; 1 1 0; 1 0 1; 0 0 1];
 %% Make the rest of the struct for the image
 thr=10;
for i=1:length(nii)
    str(i+1).img=nii(i).img;
    
    str(i+1).trans=0.8; % set the transparency
    str(i+1).col=col(i,:); % set the colour
    str(i+1).thr=[thr thr]; % set min max threshold
end

%%


xlevels=[111 151 181 ]; % the axial slices to show
xlevels=[111 151 181 191 201]; % whatever number of slices works fine


no_ver_pics=1;
no_hor_pics=3;
noplots=(length(xlevels)+1)
picsize=1/(noplots+1);
horpad=0.3;
verpad=0.1
ind=0
figure(2)
clf
scale=0.8;
for xli=1:length(xlevels)
    %subplot('Position',[horpad ind*picsize picsize picsize ])
    %subplot(noplots,1,xli)
    subplot('Position',[ind*picsize 0+verpad picsize picsize ])
    ind=ind+1
    viznii(str,'z',xlevels(xli),0,0,scale);
end

subplot('Position',[ind*picsize 0+verpad picsize picsize ])

viznii_levels(str,xlevels,140,0,0,scale);

multimni=multicoords2MNI(xlevels,'z',base)


print(['test'],'-r100','-dpng')


%%
