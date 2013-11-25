function mask = localExtremaMulti(I, nhood, extrema, threshold)
% Find local extrema in matrix/image
    if nargin < 4
        threshold = NaN;
    end

    %% Generate offsets based on nhood definition
    sz = size(nhood);
    if any(~mod(sz,2))
        error('Incapable neighbourhood size. Please define a centered neighbourhood.');
    end

    offsets = zeros(sum(sz(:)),length(sz));
    pm = (sz - 1)./2;
    ind = find(nhood(:));
    positions = ind2sub(sz,ind);

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
