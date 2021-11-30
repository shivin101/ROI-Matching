function [ret_vol] = transform_2d(vol_in,tform)
    outputView = imref2d(size(vol_in(:,:,1)));
    ret_vol = [];
    for i =1:size(vol_in,3)
        img = vol_in(:,:,i);
        Ir = imwarp(img,tform,'OutputView',outputView);
        ret_vol = cat(3,ret_vol,Ir);
    end
    
end