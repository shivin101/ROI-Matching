roiGTMat = cell(lenId,lenId);
for i = 1:lenId
        for j = i+1:lenId 
           idx = find(roiGT{i,j}(:,2));
           roiGTMat{i,j}=sparse(roiGT{i,j}(idx,1), roiGT{i,j}(idx,2), ones(size(idx,1),1)); 
           roiGTMat{j,i}=roiGTMat{i,j}';
        end
end

for i = 2:lenId
        for j = i+1:lenId 
          roiGTMat{i,j}=roiGTMat{i,1}*roiGTMat{1,j};
        end
end

for i = 1:lenId
    roiGTMat{i,i}=sparse(eye(size(Roi{i},2)));
end

matchGT ={};
match_allGT = [];
for i=1:lenId-1
    match1GT = zeros(size(roiGTMat{i,1},1),4);
    match1GT(:,i) = 1:size(roiGTMat{i,1},1);
    for j=1:lenId
        if j~=i
            [r,c] = find(roiGTMat{i,j});
            match1GT(r,j) = c;
            
        end
        
    end
    matchGT{i,j} = match1GT;
    match_allGT = vertcat(match_allGT,match1GT);
end
% score = roiDict{i,j}
% [tp,fp,tn,fn,accuracy] = getStats(gt,score);
% precision = tp/(tp+fp);
% recall = tp/(tp+fn);
match_all_uGT = unique(match_allGT,'rows');

match_all_uGT(sum(match_all_uGT>0,2) == 1,:) = [];

pptableGT = match_all_uGT;
for i=1:size(match_all_uGT,2)
    pptableGT = process_table(sortrows(pptableGT,i));
end
pptableGT = unique(sortrows(pptableGT,1),'rows');

