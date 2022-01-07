function column = textToColumnParser(text)
    rows = split(text,";");
    rowsSize = size(rows);
    column = [];
    for i=1:rowsSize(1)
        column = [column; str2num(string(rows(i)))];
    end
end
