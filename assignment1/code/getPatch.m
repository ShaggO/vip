function patch = getPatch(I, position, type, dimensions, method)
    if nargin < 5
        method = 'zeropad';
    end

    if strcmp(type,'square')
        if size(dimensions,2) < size(dimensions,1)
            dimensions = dimensions';
        end
        % Calculate central distance to edges of patch
        pm = (dimensions-1)/2;

        if strcmp(method,'bound')
            % Bound/constrain patch to be within image
            % Offset patch if at edge
            position = ((position-pm) < [1 1]).* ([1 1] + pm) + ...
                       ((position+pm) > size(I)).* (size(I) - pm) +...
                       ((position-pm) >= [1 1] & (position+pm) <= size(I)).*position;
           % Extract patch
            patch = I(position(1)-pm(1):position(1)+pm(1),...
                       position(2)-pm(2):position(2)+pm(2));
        elseif strcmp(method,'zeropad')
            % Zeropad patch when outside image
            patch = zeros(dimensions);
            maskFrom = position-pm > [1 1];
            maskTo = position+pm <= size(I);

            % Calculate offsets (inside image)
            offFrom = maskFrom .* -pm + ~maskFrom .* (1-position);
            offTo = maskTo.* pm + ~maskTo .* (size(I)-position);

            % Copy patch from image into the corresponding part of the patch
            patch(pm(1)+(offFrom(1):offTo(1))+1,pm(2)+(offFrom(2):offTo(2))+1) = ...
                I(position(1)+offFrom(1):position(1)+offTo(1),...
                  position(2)+offFrom(2):position(2)+offTo(2));
        end
    end
end
