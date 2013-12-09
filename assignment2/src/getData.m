function [cats, objects, trains, tests] = getData(path, train, test)
    cats = sort(strsplit(ls(path)));
    cats = cats(2:end);
    trains = zeros(size(cats,2)*train,2);
    tests = zeros(size(cats,2)*test,2);
    objects    = cell(1,size(cats,2));
    for i = 1:size(cats,2)
        objects{i} = sort(strsplit(ls([path cats{i}])))';
        objects{i} = objects{i}(2:end);
        trains((i-1)*train+1:i*train,:) = [ones(train,1)*i, (1:train)'];
        tests((i-1)*test+1:i*test,:) = [ones(test,1)*i, (train+1:test+train)'];
    end
end
