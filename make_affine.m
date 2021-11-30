function [affine_mat] = make_affine(theta,x_tr,y_tr)
    mat = [cosd(theta), sind(theta),0;
            -sind(theta),cosd(theta),0;
            x_tr,y_tr,1];
    affine_mat = affine2d(mat);
end