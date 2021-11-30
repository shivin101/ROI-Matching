function[] = getMatchScore(align,GT)
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
end