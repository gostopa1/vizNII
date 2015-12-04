function MNIcoords=multicoords2MNI(matlevs, matdim,nii)

multi=abs([nii.hdr.hist.srow_x(1) nii.hdr.hist.srow_y(2) nii.hdr.hist.srow_z(3)]);


for i=1:length(matlevs)
    if length(matdim)>1
    dimstr=matdim(i);
    else
        dimstr=matdim;
    end
    switch dimstr
        case 'x'
            dim=1;
        case 'y'
            dim=2;
        case 'z'
            dim=3;
    end
    
    

%mat_coords-nii.hdr.hist.originator(1:3).*multi;
MNIcoords(i)=(matlevs(i)-nii.hdr.hist.originator(dim)).*multi(dim);
end

end