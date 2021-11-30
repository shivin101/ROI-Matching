function ret_row = merge_row(a,b)
    ret_row =[];
    for i =1:size(a,2)
        if a(i)==b(i)
            ret_row(i)=a(i);
        else
            if a(i)==0
                ret_row(i)=b(i);
            else
                ret_row(i)=a(i)
            end
        end
    end
end