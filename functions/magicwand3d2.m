function b=magiwand3d2(img,xpos,ypos,zpos,tol)

b=false(size(img));
s=size(img);
for xi=1:s(1)
    tmp1=repmat(squeeze(img(xi,:,:)),[1 1 3]);
    b(xi,:,:)=squeeze(b(xi,:,:))+magicwand(tmp1,ypos,zpos,tol);
end
   
for yi=1:s(2)
    tmp1=repmat(squeeze(img(:,yi,:)),[1 1 3]);
    b(:,yi,:)=squeeze(b(:,yi,:))+magicwand(tmp1,xpos,zpos,tol);
end

for zi=1:s(3)
    tmp1=repmat(squeeze(img(:,:,zi)),[1 1 3]);
    b(:,:,zi)=squeeze(b(:,:,zi))+magicwand(tmp1,xpos,ypos,tol);
end

end