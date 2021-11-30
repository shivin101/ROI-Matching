clear all;
close all;
root = 'D:\Ryoma\RH365\shallower\';
save_root  = 'C:\Users\shivi\OneDrive\Documents\Courses\CSE293\Ryoma_New\';
name = 'Asaf';
save_dir = [save_root,name];
mkdir(save_dir);
subdirs = dir(root);
subdirs = subdirs(3:end);
for i=1:size(subdirs)
    curr_dir = subdirs(i);
    roi_file = dir([curr_dir.folder,'\',curr_dir.name,'\regops_','*.mat']);
    image_file = dir([curr_dir.folder,'\',curr_dir.name,'\','*align_warped.tif']);
    load([roi_file.folder,'\',roi_file.name]);
    img_name =[image_file.folder,'\',image_file.name];
    tiff_info = imfinfo(img_name); % return tiff structure, one element per image
    %         tiff_stack = imread(img_name, 1) ; % read in first image
    tiff_stack = bigread2(img_name, 1);
    tiff_stack(tiff_stack>8700)=0;
    %         concatenate each successive tiff to tiff_stack
    %         for ii = 2 : size(tiff_info, 1)
    %             temp_tiff = bigread2(img_name, ii);
    %             tiff_stack = cat(3 , tiff_stack, temp_tiff);
    %         end

    size_vol = 50; % The size of the volume that is averaged to downsize the 
                    % image for computation
    avg_stack = [];
    for k=1 : size_vol : size(tiff_info,1)-size_vol
        temp_avg = mean(tiff_stack(:,:,k:k+size_vol),3);
        avg_stack = cat(3,avg_stack,temp_avg);
    end

    size_vol = 50; % The size of the volume that is averaged to downsize the 
                    % image for computation
    max_stack = [];
    for k=1 : size_vol : size(tiff_info,1)-size_vol
        temp_max = max(tiff_stack(:,:,k:k+size_vol),[],3);
        max_stack = cat(3,max_stack,temp_max);
    end
    fig = figure;
    imshow(uint8(max(max_stack,[],3)/10));
    hold on;
    ROI={};
    idxList=[];
    count=1;
    for j=1:size(stat,2)
        if iscell(j)==1
            
            curr_roi = stat{j};
            x = double(curr_roi.xpix);
            y = double(curr_roi.ypix);
            K = boundary(x',y',1);
            x1 = x(K);
            y1 = y(K);
            plot(x1,y1,... %'MarkerIndices',1:5:length(y1),...
            'LineWidth',1);
            idx=[count,j];
            idxList = cat(1,idxList,idx);
%             plot(x,y);
            ROI{count}= cat(1,x,y)';
            count = count+1;
        end
        
    end
    saveas(fig,[save_dir,'\ROI_img',num2str(i),'.jpg']);
    save(join([save_dir,'\modified_stack',num2str(i),'.mat']),'avg_stack','max_stack','ROI','idxList');
    hold off;
    close all;
    
end