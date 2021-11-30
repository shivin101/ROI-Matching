path = 'C:\Users\shivi\OneDrive\Documents\Courses\CSE293\AR098_MatchingPairs';
files = dir(path);
dataGT = cell(8,8);
for i=1:8
    for j=(i+1):8
        id1 = max(0,2*(i-1)-1);
        id2 = max(0,2*(j-1)-1);
        GTfile = [path,'\','Day',num2str(id1),'_',num2str(id2)];
        load(GTfile);
        dataGT{i,j}=roiMatchData.allSessionMapping;
    end
end
save('dataGT.mat','dataGT');