function ind = salientMatch(I1, I2, p1, p2)
    if size(p1,1) < size(p2,1)
        from = p1;
        fromI = I1;
        to = p2;
        toI = I2;
    else
        from = p2;
        fromI = I2;
        to = p1;
        toI = I1;
    end
    ind = zeros(size(p1,1),2);
    patchType = 'square';
    patchSize = [201 201];
    % Match each salient point in p1 with all salient points in p2
    acc = 0;
    for i = 1:size(from,1)
        current = [NaN, Inf];
        p1Patch = getPatch(fromI,from(i,:),patchType,patchSize);
        for j = 1:size(to,1)
            p2Patch = getPatch(toI,to(j,:),patchType,patchSize);
            value = ncc(p1Patch,p2Patch);
            if value <= current(2)
                current = [j value];
            end
        end
        ind(i,:) = [i, current(1)];
        acc = acc + current(2);
    end
    meanncc = acc / size(from,1)
    if size(p1,1) > size(p2,1)
        disp('Switch');
        ind = [ind(:,2) ind(:,1)];
    end
end
