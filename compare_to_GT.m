clear
load('data.mat')
len = size(align,2);

full_match = zeros(size(align,1),size(GT,1));
mismatch   = zeros(size(align,1),size(GT,1)); 
missing_match =  zeros(size(align,1),size(GT,1));
full_missing_match =  zeros(size(align,1),size(GT,1));
extra_match = zeros(size(align,1),size(GT,1));

for i = 1:size(align,1)
    match = align(i,:);
    
    for j = 1:size(GT,1)
        gt = GT(j,:);
        inds = gt == match;
        
        if sum(gt>0) == len   % gt has all align
            
            if sum(inds) > 0
                if sum(inds) == len
                    full_match(i,j) = 1;
                else
                    if any(match(~inds)>0)
                        mismatch(i,j) = 1;
                    elseif any(match(~inds)==0)
                        missing_match(i,j) = 1;
                    end
                end
            end
        else % gt has missing align 

            if all(gt(inds)==0) % only match on the zeros (so no match)
                continue
            end
            gt_inds = gt~=0;
            match_inds = match~=0 ;
            inds = inds & (gt_inds | match_inds);
            
            if all(inds == gt_inds & inds == match_inds) % all non-zero elements match
                full_missing_match(i,j) = 1;
                continue
            end
            
            if any(match(~inds) ~= 0 & gt(~inds) ~=0)
                mismatch(i,j) = 1;
            elseif any(match(~inds) == 0 & gt(~inds) ~=0)
                missing_match(i,j) = 1;
            end
            
           if all(match(~inds) ~= 0 & gt(~inds) ==0)
               extra_match(i,j) = 1;
           end
        end
    end
    
end

combined = full_match + extra_match + missing_match + mismatch + full_missing_match;
disp(sum(sum(full_match)));
disp(sum(sum(missing_match)));
disp(sum(sum(mismatch)));
disp(sum(sum(extra_match)));
disp(sum(sum(full_missing_match)));
%%
k1 = 1;
k2 = 1;
k3 = 1;
k4 = 1;
k5 = 1;
k6 = 1;

full_match_record = [];
full_missing_match_record = [];
missing_match_record = [];
mismatch_record = [];
extra_match_record = [];
no_match_record = [];

for i = 1:size(align,1)
    ind = find(full_match(i,:));
    if ~isempty(ind)
        full_match_record(k1,:) = [GT(ind,:) nan align(i,:)];
        k1 = k1+1;
    end
    ind = find(full_missing_match(i,:));
    if ~isempty(ind)
        full_missing_match_record(k2,:) = [GT(ind,:) nan align(i,:)];
        k2 =k2+1;
    end
    
    ind = find(missing_match(i,:));
    if ~isempty(ind)
        for t = 1:length(ind)
        missing_match_record(k3,:) = [GT(ind(t),:) nan align(i,:)];
        k3 =k3+1;
        end
    end
    
    ind = find(mismatch(i,:));
    if ~isempty(ind)
        for t = 1:length(ind)
        mismatch_record(k4,:) = [GT(ind(t),:) nan align(i,:)];
        k4 =k4+1;
        end
    end
    
    ind = find(extra_match(i,:));
    if ~isempty(ind)
        for t = 1:length(ind)
        extra_match_record(k5,:) = [GT(ind(t),:) nan align(i,:)];
        k5 =k5+1;
        end
    end
    
    if sum(combined(i,:)) == 0
        no_match_record(k6,:) = align(i,:);
        k6 = k6+1;
    end
    
end
    
no_match_GT_record =[];
k7 = 1;
for j = 1:size(GT,1)
    if sum(combined(:,j)) == 0
        no_match_GT_record(k7,:) = GT(j,:);
        k7 = k7+1;
    end
end
%%
any(sum(full_match)>1)
any(sum(full_match,2)>1)

sum(sum(combined)>0)
find(sum(combined)>1)
sum(sum(combined,2)>0)
find(sum(combined,2)>1)