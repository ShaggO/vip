function mask = localExtrema(I, nhood, extrema, threshold)
% Find local extrema in matrix/image
    if nargin < 4
        threshold = NaN;
    end
    if strcmp(nhood,'8-connect')
        % 8 neighbourhood connectivity
        offsets = [-1 -1; -1 0; -1 1; ...
                    0 -1;        0 1; ...
                    1 -1;  1 0;  1 1];
    elseif strcmp(nhood,'4-connect')
        % 4 neighbourhood connectivity
        offsets = [       -1 0;       ...
                    0 -1;        0 1; ...
                           1 0;     ];
    end

    width  = size(I,2);
    height = size(I,1);

    % Pad image with NaNs
    Ipad = ones(height+2,width+2) * (-Inf);
    Ipad(2:end-1,2:end-1) = I;


    %% Initialize and generate neighbourhood tensor
    In = zeros(height, width, size(offsets,1));
    for i = 1:size(offsets,1)
        o = offsets(i,:);
        In(:,:,i) = Ipad((2+o(1)):(end-1+o(1)),(2+o(2)):(end-1+o(2)));
    end

    mask = zeros(size(I));

    %% Find extrema in neighbourhoods
    if strcmp(extrema,'maxima') || strcmp(extrema,'both')
        % Get highest neighbour
        Inmax = max(In,[],3);

        mask = mask | (I > Inmax);
    end

    if strcmp(extrema,'minima') || strcmp(extrema,'both')
        % Change NaN to inf for finding minima
        In(In == -Inf) = Inf;

        % Get lowest neighbour
        Inmin = min(In,[],3);

        mask = mask | (I < Inmin);
    end

    % Filter by threshold if defined
    if ~isnan(threshold)
        mask = abs(mask .* I) > threshold;
    end
end
