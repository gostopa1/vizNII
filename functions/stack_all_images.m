%% This script stacks a number of images (vertically)


prefix='./';

newimg=[];

res=dir([prefix 'test' '*.png']);

for resi=1:length(res)

img(resi).a=imread([prefix res(resi).name]);
end

simg=size(img(1).a);


top_trim=round(simg(1)*0.6)+1;
bottom_trim=round(simg(1)*0.05);





for i=1:length(img)

   newimg=cat(1,newimg,img(i).a(top_trim:(end-bottom_trim),:,:));
end







image(newimg)
axis image

%imwrite(imresize(newimg,0.4),'./all.png','png');