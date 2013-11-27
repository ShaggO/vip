function inds = blobDetect(I, type)

    if strcmp(type,'log')
        % Define constants
        k = 6;
        sigma = 0.88*k;
        hsize = ceil(6*sigma);
        threshold = 0.008;

        %% Log filter:
        H = fspecial('log', hsize, sigma);

        % Convole with LoG filter using replication for boundaries
        filtered = imfilter(I,H,'conv','replicate');

    elseif strcmp(type,'dog')
        % Define constants
        threshold = 0.15;
        sigma = 0.88*4;
        k = 2;

        % Create DoG filter
        dog = dogFilter(sigma,k);

        % Convolve with DoG filter using replication for boundaries
        filtered = imfilter(I,dog,'conv','replicate');

    end

    % Find local extrema satisfying threshold
    blobs = localExtrema(filtered, '8-connect','both', threshold);
    [rows, cols] = find(blobs);
    inds = [rows, cols];
end
