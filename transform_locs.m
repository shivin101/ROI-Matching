function [vol_out] = transform_locs(vol_in,vol_sz,tform)
    x= vol_in(:,1);
    y= vol_in(:,2);
    z= vol_in(:,3);
    [x,y]=transformPointsForward(tform,x,y);
    
    vol_out = horzcat(x,y,z);
end