function matrix = textToMatrixParser(text)
    rows = split(text,";");
    matrix = [];
    for i=1:rows.length
        rowElems = split(rows(i), ",");
        nums=[];
        for j=1:rowElems.length
            nums = [nums, str2num(rowElems(j))];
        end
        matrix = [matrix;nums];
    end
end
