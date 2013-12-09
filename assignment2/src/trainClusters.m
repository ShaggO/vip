function [C, I] = trainClusters(data, k, fromFile)
    if nargin < 3
        fromFile = '';
    end

    if ~strcmp(fromFile,'') && exist(fromFile,'file')
        load(fromFile);
        return;
    end

    [C, I] = vl_ikmeans(data', k);
    I = I';

    if ~strcmp(fromFile,'')
        save(fromFile);
    end
end
