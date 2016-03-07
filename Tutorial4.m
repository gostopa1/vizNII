
addpath(genpath('functions')) % Add the paths to use the NIFTI tools and VIZNII scripts

mask=load_nii('./templates_masks/whitened_0.5mm.nii'); % Load the background image
base=load_nii('./templates_masks/mni152bet.nii'); % Load the image to use as reference for the MNI coords

%% This a struct for the images. The first one is the background

str(1).img=double(mask.img); % str.img is the NIFTI image
str(1).trans=1.3; % This is the transparency of the image. It basically takes values from 0-1 but values larger than 1 make it brighter
str(1).col=[1 1 1]; % This is the colour
str(1).thr=0;

%% Load all the .nii files
thr=8;

%% Load the two first niftis and find their ovelap
nii(1)=load_nii(['./example_niftis/cat' num2str(1) '_hires.nii']);
nii(2)=load_nii(['./example_niftis/cat' num2str(2) '_hires.nii']);



%% Define a set of colours for the images
%Starting color
col1=[1 0 0 ; 0 0 1 ; 1 0.8 0];

%Final color
col2=[0.8 0.8 0; 1 1 1 ; 1 0.8 0];

%% Make the rest of the struct for the image

tofindbestslices=zeros(size(nii(1).img));
for i=1:length(nii)
    str(i+1).img=nii(i).img;
    
    str(i+1).trans=1; % set the transparency
    str(i+1).col=col(i,:); % set the colour
    
    str(i+1).col2=col2(i,:); % set the colour
    str(i+1).thr=[thr 60]; % set min max threshold
    
    clrbr=make_colorbar(str(i+1).col,str(i+1).col2);
    imwrite(clrbr,['Colorbar_' num2str(i+1) '_thr'  num2str(str(i+1).thr) '.png'])
    display(['The filename of the colorbar image is :' ' Colorbar_' num2str(i+1) '_thr'  num2str(str(i+1).thr) '.png'])
    
    tofindbestslices=tofindbestslices+(nii(i).img>thr);
end
%%

scale=1; % Scaling parameter. Low scale speeds up the process but worsens the resolution

[x1,y1,z1]=slices_of_max_info(tofindbestslices);
x1=(floor([x1]/2)*2+1);
y1=(floor([y1]/2)*2+1);
z1=(floor([z1]/2)*2+1);

imx=viznii_image(str,'z',z1,0,0,scale);
imy=viznii_image(str,'y',y1,0,0,scale);
imz=viznii_image(str,'x',x1,0,0,scale);

simg=size(imx);
llim=0.1;rlim=.9; % To trim a bit between the image to reduce the white space

xinds=1:simg(1);
yinds=round(llim*simg(2)):round(rlim*simg(2));

allimgs=[imx(xinds,yinds,:) imy(xinds,yinds,:) imz(xinds,:,:)];


%%
prefix='results/';
mkdir(prefix)
filename=[prefix 'Tutorial4_result' num2str(thr) ]

imwrite(allimgs,[filename '.png'])

fileID = fopen([filename '.txt'],'w');

matcords=num2str([x1 y1 z1]);
fprintf(fileID,'%s\n','Matrix Coordinates');
fprintf(fileID,'%s\n',matcords);

fprintf(fileID,'%s\n','MNI coordinates');
mnicords=num2str(coords2MNI([x1 y1 z1],base));
fprintf(fileID,'%s\n',mnicords);

fclose(fileID);

imshow(allimgs)