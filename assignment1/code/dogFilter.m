function filter = dogFilter(sigma,k)
    % Compute common support size
    hsize = ceil(sigma*k*6) * [1 1];

    % Find midpoint
    mid = (hsize - 1) ./ 2;

    % Create mesh around midpoint
    [x y] = meshgrid(-mid(1):mid(1),-mid(2):mid(2));

    % Sample from Difference of Gaussians (DoG) distribution
    filter = ...
        (exp(-(x.^2+y.^2)/(2*k^2*sigma^2)) - ...
        k^2*exp(-(x.^2+y.^2)/(2*sigma^2)))/(2*pi*k^2*sigma^2);
end
