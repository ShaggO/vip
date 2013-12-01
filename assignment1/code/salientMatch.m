function ind = salientMatch(I1, I2, p1, p2, threshold, patchSize)
% Match salient points in two images to eachother
    if nargin < 5
        threshold = -1;
    end
    if nargin < 6
        patchSize = [11 11];
    end
    illustrate = false;
    % Select way to map images (i1 to i2 or wise versa)
    if size(p1,1) <= size(p2,1)
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
    ind = [];
    if illustrate
        figure();
        imshow([fromI, toI]);
        hold on;
    end
    patchType = 'square';
    % Match each salient point in "from" with all salient points in "to"
    for i = 1:size(from,1)
        current = [NaN, Inf; NaN, Inf];
        if illustrate
            plot(from(i,2),from(i,1),'.b');
        end

        % Get patch in "from"
        p1Patch = getPatch(fromI,from(i,:),patchType,patchSize);
        for j = 1:size(to,1)
            % Get patch in "to"
            p2Patch = getPatch(toI,to(j,:),patchType,patchSize);

            % Compute ncc value of the two patches
            value = ncc(p1Patch,p2Patch);

            % Update best and 2nd best ncc values if the current is larger than
            % any of the current ones
            if value < current(1,2)
                current(2,:) = current(1,:);
                current(1,:) = [j value];
            elseif value < current(2,2)
                current(2,:) = [j value];
            end
        end

        if threshold >= 0
            % If threshold method should be used then compare the best and 2nd best
            % matches to see if the match should be saved or not
            if current(1,2)/current(2,2) < threshold && ~isnan(current(1,1))
                ind(end+1,:) = [i, current(1,1)];
                if illustrate
                    plot(size(fromI,2) + to(current(1,1),2), to(current(1,1),1),'.r');
                    plot([from(i,2),size(fromI,2)+to(current(1,1),2)],[from(i,1),to(current(1,1),1)],'-y');
                end
            end
        elseif ~isnan(current(1,1))
            % Register match if no threshold
            ind(end+1,:) = [i, current(1,1)];
            if illustrate
                plot(size(fromI,2) + to(current(1,1),2), to(current(1,1),1),'.r');
                plot([from(i,2), size(fromI,2)+to(current(1,1),2)],[from(i,1) to(current(1,1),1)],'-y');
        end
        if illustrate
            drawnow;
            pause(0.05);
        end
    end
    if size(p1,1) > size(p2,1)
        % Switch output vector locations if needed to ensure that the caller has
        % appropriate result (p1 indices, p2 indices)
        disp('Switch');
        ind = [ind(:,2) ind(:,1)];
    end
end
