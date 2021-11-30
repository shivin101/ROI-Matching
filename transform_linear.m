function [ret_ind] = transform_linear(ind_arr,vol_sz,tform)
    values = ind_arr(:,2:end);
    indices = ind_arr(:,1);
    ret_ind = {};
    for idx = 1:size(indices)
        linear_indices = indices{idx};
        [x,y,z]=ind2sub(vol_sz,linear_indices);
        [x,y]=transformPointsForward(tform,x,y);
        x(x>vol_sz(1))=vol_sz(1);
        y(y>vol_sz(2))=vol_sz(2);
        x(x<1)=1;
        y(y<1)=1;
        ind = sub2ind(vol_sz,x,y,z);
        ret_ind{idx}=ind;
    end
    ret_ind = horzcat(ret_ind',values);
end