function pairMat = createPairMat(roiDict,Roi)
   pairMat = cell(size(Roi,2),size(Roi,2));
   for i =1:size(Roi,2)
       for j=i+1:size(Roi,2)
            P = zeros(size(Roi{i},2),size(Roi{j},2));
            matching = roiDict{i,j};
            for k=1:size(matching,1)
                if matching(k)>0
                    P(k,matching(k))=1;
                end
            end
            pairMat{i,j}=P;
       end
   end
end