function [matrix, modulation] = readOfdmDataIn(filepath)
    matrix =[];
    modulation = '';
    fid = fopen(filepath);
    tline = fgetl(fid);
    while ischar(tline)
        [newchar, result] = str2num(tline);
        if result == 1
            matrix = [matrix ; newchar];
        else
            modulation = tline;
        end
        tline = fgetl(fid);
    end
    fclose(fid);
end

