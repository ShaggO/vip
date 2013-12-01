function inds = harrisDetect(I, sigma, k, alpha, threshold, numOut)
% Perform harris detection on image I using defined properties
    if nargin < 6
        numOut = 0;
    end
    % Generate L_x and L_y by convolving I with gaussian derrivatives
    hsize = ceil(sigma*6);
    Lx = imfilter(I, gaussFilter(hsize, sigma,'x'));
    Ly = imfilter(I, gaussFilter(hsize, sigma,'y'));

    % Compute Lx^2, Ly^2 and Lxy
    Lxx = Lx.*Lx;
    Lyy = Ly.*Ly;
    Lxy = Lx.*Ly;

    % Convolve the above by G(x,y,k*sigma)
    Gk = gaussFilter(hsize*k, sigma*k);
    Axx = imfilter(Lxx, Gk);
    Ayy = imfilter(Lyy, Gk);
    Axy = imfilter(Lxy, Gk);

    % Compute the Harris corner measure
    R = Axx .* Ayy - (Axy.^2) - alpha * (Axx .* Ayy).^2;

    % Maxima
    inds = localExtrema(R,'8-connect','maxima', threshold, numOut);
end
