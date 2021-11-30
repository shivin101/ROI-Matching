clc;
close all;
% clear all;
load('./KA.mat')
%Create sparse matrix with M(i(k),j(j))=v(k)
M12 = sparse(M180106VS180126(:,1), M180106VS180126(:,2), ones(size(M180106VS180126,1),1));
M13 = sparse(M180106VS180214(:,1), M180106VS180214(:,2), ones(size(M180106VS180214,1),1));
M14 = sparse(M180106VS180306(:,1), M180106VS180306(:,2), ones(size(M180106VS180306,1),1));
M23 = sparse(M180126VA180214(:,1), M180126VA180214(:,2), ones(size(M180126VA180214,1),1));
M24 = sparse(M180126VS180306(:,1), M180126VS180306(:,2), ones(size(M180126VS180306,1),1));
M34 = sparse(M180214VS180306(:,1), M180214VS180306(:,2), ones(size(M180214VS180306,1),1));

%%
match1 = zeros(size(M12,1),4);
match1(:,1) = 1:size(M12,1);

[r,c] = find(M12);
match1(r,2) = c;

[r,c] = find(M13);
match1(r,3) = c;

[r,c] = find(M14);
match1(r,4) = c;

%%
match2 = zeros(size(M12',1),4);
match2(:,2) = 1:size(M12',1);

[r,c] = find(M12');
match2(r,1) = c;

[r,c] = find(M23);
match2(r,3) = c;

[r,c] = find(M24);
match2(r,4) = c;
%%
match3 = zeros(size(M13',1),4);
match3(:,3) = 1:size(M13',1);

[r,c] = find(M13');
match3(r,1) = c;

[r,c] = find(M23');
match3(r,2) = c;

[r,c] = find(M34);
match3(r,4) = c;
%%
match4 = zeros(size(M14',1),4);
match4(:,4) = 1:size(M14',1);

[r,c] = find(M14');
match4(r,1) = c;

[r,c] = find(M24');
match4(r,2) = c;

[r,c] = find(M34');
match4(r,3) = c;

%%
match_all = [match1 ;match2 ;match3;match4];
match_all_u = unique(match_all,'rows');

match_all_u(sum(match_all_u>0,2) == 1,:) = [];

%% 
% TODO - 
% there are still multiple rows per ROIs
% these need to be 
% 1) merged if there is a missing match
% 2) if there is a consistency issue we need to keep the different assignement
% paths and display them to user to correct. 
% for example running code above will give this inconsistency in 
% rows 344-345 of the match_all_u matrix:
% 202,0, 88,61
% 202,0,136,61
% or in rows 147-149
% 0,149,112,51
% 0,149,112,91
% 0,149,123,91
pptable = match_all_u;
for i=1:size(match_all_u,2)
    pptable = process_table(sortrows(pptable,i));
end
pptable = unique(sortrows(pptable,1),'rows');









