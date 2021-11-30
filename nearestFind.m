function [matchNN,matchDist,vis] = nearestFind(iarea,dist,vis,idx,matchNN,matchDist,thresh)
    overlap = iarea(idx,:);
    euclid = dist(idx,:);
%     overlap(idx)=0;
%     euclid(idx)=9999;
    
    overlap = overlap;
    euclid = -euclid/100;
    
    
    distVal = euclid+overlap;
    distVal(distVal<thresh)=-99999;
    
    [B,I] = sort(distVal,'descend');
    [matchNN,matchDist,vis] = matchNeighbor(B,I,matchNN,matchDist,vis,idx);
    
end