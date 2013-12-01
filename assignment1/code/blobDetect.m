function inds = blobDetect(I, type, sigma, threshold, k, numOut)
% Detect blobs in image using either the LoG or DoG method
    if nargin < 5
        k = 1;
    end
    if nargin < 6
        numOut = 0;
    end

    if strcmp(type,'log')
        % Create Log filter
        H = logFilter(sigma);

        % Convole with LoG filter using replication for boundaries
        filtered = imfilter(I,H,'conv','replicate');

    elseif strcmp(type,'dog')
        % Create DoG filter
        dog = dogFilter(sigma,k);

        % Convolve with DoG filter using replication for boundaries
        filtered = imfilter(I,dog,'conv','replicate');
    end

    % Find local extrema satisfying threshold
    inds = localExtrema(filtered, '8-connect','both', threshold, numOut);
end
