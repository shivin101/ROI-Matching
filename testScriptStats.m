for i=2:size(roiDict,1)
    for j =i+1:size(roiDict,1)
        align = roiDict{i,j};
        GT = dataGT{i,j};
        getMatchScore(align,GT)
    end
end