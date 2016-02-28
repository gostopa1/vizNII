function temp=viznii_image(str,dim,sliceno,varargin)
%%  VIZNII_image(str,dim,sliceno) is identical to the viznii function except that its output is an image array  n x n x 3 (RGB)
% It works faster and more efficiently that viznii without that high
% memory requirements

if nargin<4
    showMNI=1;
    showlabel=1;
    scale=1;
elseif nargin<5
    showlabel=1;
    showMNI=varargin{1};
    scale=1;
elseif nargin<6
    showlabel=varargin{2};
    showMNI=varargin{1};
    scale=1;
else
    showlabel=varargin{2};
    showMNI=varargin{1};
    scale=varargin{3};

end


%showMNI

x=sliceno;
if dim=='x'
    pic=repmat(zeros(size(squeeze(str(1).img(sliceno,:,:)))),[1 1 3]);
elseif dim=='y'
    pic=repmat(zeros(size(squeeze(str(1).img(:,sliceno,:)))),[1 1 3]);
elseif dim=='z'
    pic=repmat(zeros(size(squeeze(str(1).img(:,:,sliceno)))),[1 1 3]);
end

for i=1:length(str)
    if length(str(i).thr)>1
        str(i).img(str(i).img>=str(i).thr(2))=str(i).thr(2);
        
    end
    
    str(i).img(str(i).img<str(i).thr(1))=0;
    str(i).img=double(str(i).img)/double(max(str(i).img(:)));
    
end

%%
for i=1:length(str)
    if dim=='x'
        tempimg=squeeze(str(i).img(sliceno,:,:));
    elseif dim=='y'
        tempimg=squeeze(str(i).img(:,sliceno,:));
    elseif dim=='z'
        tempimg=squeeze(str(i).img(:,:,sliceno));
    end
    ind=find(tempimg>0);
    
    for coli=1:3
        
        p(i).pic=pic(:,:,coli);
        
        if i<2
            new=(1-str(i).trans)*p(i).pic(ind)+str(i).col(coli)*(str(i).trans*tempimg(ind));
            new(new>1)=1;
        else
            
           
            new=(1-str(i).trans)*p(i).pic(ind)+str(i).col(coli)*(str(i).trans*tempimg(ind));
            
        end
        %new=new/max(new(:));
        
        p(i).pic(ind)=new;
        
        
        
        
        pic(:,:,coli)=p(i).pic;
    end
end


s=size(str(1).img);
spic=size(pic)
padamount=(max(s)-spic(1:2))/2
padamount=round(padamount)+1
s=round(size(str(1).img)*scale);

zpic=ones(size(pic));
pic=pic/(max(pic(:)));
temp=padarray(pic,padamount)+(1-padarray(zpic,padamount));
%temp=imrotate(temp,90,'crop');
temp=imrotate(temp,90);
temp=imresize(temp,scale);

temp(temp>1)=1;
temp(temp<0)=0;

%% This is to make it always square adjusted to the biggest dimension
% 
% ztemp=ones(size(temp));
% stemp=size(temp);
% padamount=(max(s)-stemp(1:2))/2;
% padamount=round(padamount)+1;
% % imagesc(padarray(ztemp,padamount));
% % imagesc(temp2)
% % imagesc(padarray(temp,padamount)+(1-padarray(ztemp,padamount)))
% 
% temp=padarray(temp,padamount)+(1-padarray(ztemp,padamount));
display(['Image size: ' num2str(size(temp))])
%%

% imagesc(temp)
% axis image


%%
end