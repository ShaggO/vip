function path = getObject(path, cats, objs, i, j)
    path = [path cats{i} '/' objs{i}{j}];
end
