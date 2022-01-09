function text = arrayToString(array)
    text="";
    columnsLength = size(array);
    for i=1:columnsLength(1)
        text=strcat(text, num2str(array(i)));
        if i~=(columnsLength(1))
            text=strcat(text, ";");
        end
    end
end
