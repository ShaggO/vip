function filter = logFilter(sigma)
    % Compute derrivatives of the gaussian filter with respect to x^2 and y^2
    hsize = [ceil(6*sigma) ceil(6*sigma)];

    Lxx = gaussFilter(hsize, sigma, 'xx');
    Lyy = gaussFilter(hsize, sigma, 'yy');

    % Sum the two derrivatives to get the Laplacian of Gaussian filter
    filter = Lxx + Lyy;
end
