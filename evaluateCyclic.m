function [correct,wrong,accuracy]=evaluateCyclic(P1,P2)
    correct = 0;
    wrong = 0;
    for i =1:size(P1,1)
        if(sum(P1(i,:)-P2(i,:))==0)
            correct=correct+1;
        else
%             disp(i);
%             disp(sum(P1(i,:)));
%             disp(sum(P2(i,:)));
            if (sum(P1(i,:))>0 && sum(P2(i,:))>0)
                wrong=wrong+1;
            end
        end
    end
    accuracy = correct/(correct+wrong);
end