addpath('nifti')

mask=load_nii('whitened_2mm.nii');


%mask=load_nii('MNI152lin_T1_1mm.nii');


x=3
f1='../make_results_for_movies/results_nii/importance_maps_avgtps_thresholded_0.05_positive/emo1_2mm.nii';
nii1=load_nii(f1)
%nii1=load_nii('emo1.nii');
%nii1.img=nii1.img(:,:,:,1);
tpi=1;
% 
% view_nii(nii1)

str(1).img=double(mask.img);
str(1).trans=1;
str(1).col=[1 1 1];
str(1).thr=0;

str(2).img=nii1.img(:,:,:,tpi);
str(2).trans=0.8;
str(2).col=[0 1 0];
str(2).thr=[0.0001 0.0005]; % set min max
%str(2).thr=[0.01 0.05]; % set min max
% 
% 
% f1='../make_results_for_movies/results_nii/importance_maps_avgtps_thresholded_0.05_positive/emo2_2mm.nii';
% nii1=load_nii(f1)
% str(3).img=nii1.img(:,:,:,tpi);
% str(3).trans=0.8;
% str(3).col=[1 0 0];
% str(3).thr=[0.0002 0.0005]; % set min max
% 
% f1='../make_results_for_movies/results_nii/importance_maps_avgtps_thresholded_0.05_positive/emo3_2mm.nii';
% nii1=load_nii(f1)
% str(4).img=nii1.img(:,:,:,tpi);
% str(4).trans=0.9;
% str(4).col=[1 1 0];
% str(4).thr=[0.0002 0.0005]; % set min max
% 
% f1='../make_results_for_movies/results_nii/importance_maps_avgtps_thresholded_0.05_positive/emo4_2mm.nii';
% nii1=load_nii(f1)
% str(5).img=nii1.img(:,:,:,tpi);
% str(5).trans=0.7;
% str(5).col=[0.5 0.5 0.5];
% str(5).thr=[0.0002 0.0005]; % set min max
% 
% f1='../make_results_for_movies/results_nii/importance_maps_avgtps_thresholded_0.05_positive/emo5_2mm.nii';
% nii1=load_nii(f1)
% str(6).img=nii1.img(:,:,:,tpi);
% str(6).trans=0.7;
% str(6).col=[0 0 1];
% str(6).thr=[0.0001 0.0005]; % set min max


% figure
% viznii(str,'z',40)

% 
% 
% %%
% 
figure(1)
subplot(3,1,1)
viznii(str,'x',50);
subplot(3,1,2)
viznii(str,'y',54);
subplot(3,1,3)
viznii(str,'z',45);
% %%
% ind=1;
% for zi=25:5:65
%     subplot(1,10,ind)
%     zi
%  viznii(str,'z',zi)   
%  ind=ind+1;
% end
%     
% %viznii(str,'z',40)