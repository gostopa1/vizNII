function [indx,indy,indz]=slices_of_max_info(img)
%% SLICES_OF_MAX_INFO(img)
% This function finds the slices (for each plane) with the maxmimum
% information (higher sum across voxels)
% It outputs the slice coordinates in matrix format.


[~,indx]=max(squeeze(sum(sum(img,2),3)));
[~,indy]=max(squeeze(sum(sum(img,1),3)));
[~,indz]=max(squeeze(sum(sum(img,1),2)));

end