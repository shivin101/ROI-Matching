function [tp,fp,tn,fn,accuracy] = getStats(gt,score)
    accuracy = gt==score;
    accuracy = sum(accuracy)/length(accuracy);
    tp=0;
    fp=0;
    tn=0;
    fn=0;
    for i =1:size(score,1);
        if(score(i)>=1)
            if(score(i)==gt(i))
                tp=tp+1;
            else
                fp=fp+1;
            end
        else
           if(score(i)==gt(i))
                tn=tn+1;
           else
                fn=fn+1;
           end
           
        end
    end
end