function new_table = process_table(table)
    start = 1;
    end_idx = size(table,1);
    count = 1;
    while start<end_idx
        row1 = table(start,:);
        row2 = table(start+1,:);
        
        %Number of unique entries in the table
        uqe = get_unique(row1,row2);
        if uqe<=size(row1,2)   
            new_row = merge_row(table(start,:),table(start+1,:));
            new_table(count,:)=new_row;
            count=count+1;
            start=start+2;
        else
            new_row = table(start,:);
            new_table(count,:)=new_row;
            count=count+1;
            start=start+1;
            
        end
    end
    
    %Add the final row of the table;
    new_table(count,:)=table(end_idx,:);
    
    %Recursive call
    if size(new_table,1)<size(table,1);
        new_table = process_table(new_table);
    end
end