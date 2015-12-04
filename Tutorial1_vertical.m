
addpath(genpath('functions')) % Add the paths to use the NIFTI tools and VIZNII scripts

mask=load_nii('./templates_masks/whitened_0.5mm.nii'); % Load the background image
base=load_nii('./templates_masks/mni152bet.nii'); % Load the image to use as reference for the MNI coords


%% This a struct for the images. The first one is the background

str(1).img=double(mask.img); % str.img is the NIFTI image
str(1).trans=1.3; % This is the transparency of the image. It basically takes values from 0-1 but values larger than 1 make it brighter
str(1).col=[1 1 1]; % This is the coloud
str(1).thr=0;

%% Load all the .nii files
for emoi=1:5
    
    nii(emoi)=load_nii(['./example_niftis/cat' num2str(emoi) '_hires.nii']);
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

no_ver_pics=1;
no_hor_pics=3;
noplots=3;
picsize=1/(noplots+1);
horpad=0.01;
verpad=0.01
ind=0
figure(2)
clf
scale=0.8;


x1=140;
y1=140;
z1=140;


subplot('Position',[0+horpad ind*picsize picsize picsize ])
viznii(str,'z',z1,0,0,scale);
ind=ind+1

subplot('Position',[0+horpad ind*picsize picsize picsize ])
viznii(str,'y',y1,0,0,scale);
ind=ind+1

subplot('Position',[0+horpad ind*picsize picsize picsize ])
viznii(str,'x',x1,0,0,scale);





print(['test'],'-r100','-dpng')


%%
