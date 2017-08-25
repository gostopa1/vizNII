function clrbr=make_int_colorbar(col1,col2,thr)
clrbr=(ceil(eps+((thr(2) - thr(1)+1)*make_colorbar(col1,col2)-1))/(thr(2) - thr(1)));
end
