function result = bow(categories, clusterIdx, clusters, path, catPaths, objects)
    objectNum = length(unique(categories,'rows'));
    result = cell(objectNum,1);
    current = [-1,-1];
    idx = 0;
    % Create histogram while looping through descriptors
    for i = 1:size(categories,1)
        if ~all(current == categories(i,:))
            if idx > 0
                result{idx}.bow = result{idx}.bow / sum(result{idx}.bow);
            end
            current = categories(i,:);
            idx = idx+1;
            result{idx}.bow = zeros(1,clusters);
            result{idx}.cat = categories(i,1);
            result{idx}.obj = categories(i,2);
            result{idx}.imgPath = getObject(path, catPaths, objects, categories(i,1), categories(i,2));
        end
        result{idx}.bow(clusterIdx(i)) = result{idx}.bow(clusterIdx(i))+1;
    end
end
