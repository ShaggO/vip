function [D, Didx] = getDescriptors(path, categories, objects, indices, fromFile)
    if nargin < 5
        fromFile = '';
    end

    if ~strcmp(fromFile,'') && exist(fromFile, 'file')
        load(fromFile);
        return;
    end

    D = [];
    Didx = [];

    for i = 1:size(indices,1)
        I = imread(getObject(path, categories, objects, indices(i,1), indices(i,2)));

        if size(I,3) > 1
            I = rgb2gray(I);
        end
        I = single(I);

        [~, d] = vl_sift(I);

        D = [D; d'];
        Didx = [Didx; ones(size(d,2),1) * [indices(i,:)]];
    end

    if ~strcmp(fromFile,'')
        save(fromFile);
    end
end
