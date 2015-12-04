function MNIcoords=coords2MNI(mat_coords,nii)

multi=abs([nii.hdr.hist.srow_x(1) nii.hdr.hist.srow_y(2) nii.hdr.hist.srow_z(3)]);

%mat_coords-nii.hdr.hist.originator(1:3).*multi;
MNIcoords=(mat_coords-nii.hdr.hist.originator(1:3)).*multi;

end