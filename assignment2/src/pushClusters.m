function Ci = pushClusters(data, clusters, fromFile)
    if nargin < 3
        fromFile = '';
    end

    if ~strcmp(fromFile, '') && exist(fromFile,'file')
        load(fromFile);
        return;
    end

    Ci = vl_ikmeanspush(data', clusters);

    if ~strcmp(fromFile, '')
        save(fromFile);
    end
end
