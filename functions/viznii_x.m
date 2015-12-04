function viznii(str,dim,sliceno,varargin)
%%  VIZNII(str,dim,sliceno) is a visualization tool for fMRI files. 
% It is handy to generate layouts of neuroscientific results.
% str has to be a struct or struct list with the following fields:
%   - str(i).img  :the 3-D matrix of the NIFTI file is provided
%   - str(i).trans :transparency of the layer
%   - str(i).col : the color of the layer in RGB format 
%   - str(i).thr : thr sets the threshold, If only one number is set then
%                   alla the values below this threshold are set to zero.
%                   If a second value is also set [min_th max_th] then all
%                   the values abov the max_th are set to max_th. This
%                   serves visualization purposes.
%
%   dim refers to the dimensions that shall be viewed. It can be 'x', 'y'
%   or 'z'.
%   
%   sliceno corresponds to the slice number that should be viewed in the
%   dimension defined in the dim variable.
%
%   Additional arguments: 
%   - MNI, transforms the figure label to MNI
%     corresponding coordinates. This requires the MNI152_T1_2mm.nii file and
%     that the NIFTI toolbox is on path (for the load_nii function).
%     Default is 1.
%
%   - showlabel is a boolean defining whether a label (in the y axis) about
%   the slice number should be . Default is 1.
%                   
% 
if nargin<4
    showMNI=1;
    showlabel=1;
    solid_color=0;
elseif nargin<5
    showlabel=1;
    showMNI=varargin{1};
    solid_color=0;
elseif nargin<6
    showlabel=varargin{2};
    showMNI=varargin{1};
    solid_color=0;
    else
    showlabel=varargin{2};
    showMNI=varargin{1};
    solid_color=varargin{3};
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
        else
            
            pow=0.1;
            
            %%new=((1-tempimg(ind)).^pow).*((1-str(i).trans)*p(i).pic(ind))+(((tempimg(ind)).^pow).*(str(i).col(coli)*(str(i).trans*tempimg(ind))));
            if solid_color==0
            new=(1-str(i).trans)*p(i).pic(ind)+str(i).col(coli)*(str(i).trans*tempimg(ind));
            else
                new=(1-str(i).trans)*p(i).pic(ind)+str(i).col(coli)*(str(i).trans*(double(tempimg(ind)>0)));
            end
        end
        
        p(i).pic(ind)=new;
        
        
        
        
        pic(:,:,coli)=p(i).pic;
    end
end

temp=imrotate(pic,90);
%temp=imresize(temp,10);
%temp=imresize(temp,1);
temp(temp>1)=1;
temp(temp<0)=0;


%% This is to make it always square adjusted to the biggest dimension
s=size(str(1).img);
ztemp=ones(size(temp));
stemp=size(temp);
padamount=(max(s)-stemp(1:2))/2;

% imagesc(padarray(ztemp,padamount));
% imagesc(temp2)
% imagesc(padarray(temp,padamount)+(1-padarray(ztemp,padamount)))

temp=padarray(temp,padamount)+(1-padarray(ztemp,padamount));
display(['Image size: ' num2str(size(temp))])
%%

imagesc(temp)
axis image

if showlabel==1
    if showMNI==1
        %nii=load_nii('MNI152_T1_2mm.nii');
        %nii=load_nii('MNI152_T1_2mm.nii');
        nii=load_nii('mni152bet.nii');
        sliceno
        MNIco=coords2MNI([sliceno sliceno sliceno],nii)
        matcos=MNI2coords([sliceno sliceno sliceno],nii)
        
        switch dim
            case 'x'
                ylabel([upper(dim) ' = ' num2str(MNIco(1)) '        '])
            case 'y'
                ylabel([upper(dim) ' = ' num2str(MNIco(2)) '        '])
            case 'z'
                ylabel([upper(dim) ' = ' num2str(MNIco(3)) '        '])
        end
    else
        ylabel(['    ' upper(dim) ' = ' num2str(sliceno) '        '])
        
    end
end
%ylabel('test','rot',270)
set(get(gca,'YLabel'),'Rotation',0);
%set(gca, 'xtick', [], 'ytick', []) ;
box off

%set(gca,'xcolor','w','ycolor','w','xtick',[],'ytick',[])


%set(gca,'visible','off'); %hides all axes, ticks and labels it will also hide the title. A little trick to bring back the title is
axis off;
set(findall(gca, 'type', 'text'), 'visible', 'on');
%axis off



%%
end