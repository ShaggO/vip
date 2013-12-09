function [test, accuracy] = retrieve(train, test, method)
    % Map each test BoW to the closest train BoW
    correct = 0;
    for i = 1:size(test,1)
        distances = zeros(size(train,1),1);
        for j = 1:size(train,1)
            if strcmp(method,'bhattacharyya')
                d = -sum(sqrt(test{i}.bow.*train{j}.bow));
            elseif strcmp(method,'kullback')
                kl1 = sum(test{i}.bow.*log(test{i}.bow ./ train{j}.bow));
                kl2 = sum(train{j}.bow.*log(train{j}.bow ./ test{i}.bow));
                d = 1/2 * (kl1 + kl2);
            elseif strcmp(method,'euclidean')
                d = sum((test{i}.bow - train{j}.bow).^2);
            end
            distances(j) = d;
        end

        % Find best match by minizing distance
        [~,best] = min(distances);
        test{i}.match = best;

        % Register if match was correct
        if train{best}.cat == test{i}.cat
            correct = correct+1;
        end
    end
    accuracy = correct / size(test,1);
end
