function patch = getPatch(I, position, type, dimensions)
    if strcmp(type,'square')
        % Calculate central distance to edges of patch
        pm = (dimensions-1)/2;

        % Offset patch if at edge
        position = ((position-pm) < [1 1]).* ([1 1] + pm) + ...
                   ((position+pm) > size(I)).* (size(I) - pm) +...
                   ((position-pm) >= [1 1] & (position+pm) <= size(I)).*position;

        % Extract patch
        patch = I(position(1)-pm(1):position(1)+pm(1),...
                   position(2)-pm(2):position(2)+pm(2));
    end
end
