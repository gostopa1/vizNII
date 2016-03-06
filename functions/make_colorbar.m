function clrbar=make_colorbar(col1,col2)
for coli=1:length(col1)
coll(:,coli)=linspace(col2(coli),col1(coli),1000);
end

for i=1:100
    clrbar(:,i,:)=coll;
end

end