function blobs = blobDetect(I, type)
    hsize = [10 10];

    if strcmp(type,'log')
        k = 6;
        sigma = 0.88*k;
        hsize = ceil(6*sigma);
        threshold = 0.004;

        %% Log filter:
        H = fspecial('log', hsize, sigma);
        filtered = imfilter(I,H,'conv','replicate');

    elseif strcmp(type,'dog')
        threshold = 0.06;
        sigma = 0.88*4;
        k = 2;
        hsize = ceil(6*sigma);

        dog1 = fspecial('gaussian', hsize, sigma);

        hsize = ceil(6*sigma);
        dog2 = fspecial('gaussian', hsize, k*sigma);

        im1 = imfilter(I,dog1,'conv','replicate');
        im2 = imfilter(I,dog2,'conv','replicate');

        filtered = im1 - im2;
    end

    % Find local extrema satisfying threshold
    blobs = localExtrema(filtered, '8-connect','both', threshold);
end
