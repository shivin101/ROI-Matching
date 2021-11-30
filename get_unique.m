function uqe = get_unique(a,b)
    uqe=0;
    for i=1:size(a,2)
        if(length(unique([a(i),b(i)]))>1)
            if(a(i)==0 || b(i)==0)
                uqe=uqe+1;
            else
                uqe=uqe+2;
            end
        else
            uqe=uqe+1;
            
        end   
    end
end