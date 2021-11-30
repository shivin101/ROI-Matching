function value=refDict(idx,dict)
    for i=1:size(idx)
        if(idx(i)~=0)
            value(i)=dict(idx(i))-1;
        else
            value(i)=0;
        end
    end 
end