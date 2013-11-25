function corners = harrisDetect(I, sigma, k, alpha, threshold)
    hsize = ceil(sigma*6);
    Lx = imfilter(I, gaussFilter(hsize, sigma,'x'));
    Ly = imfilter(I, gaussFilter(hsize, sigma,'y'));

    Lxx = Lx.*Lx;
    Lyy = Ly.*Ly;
    Lxy = Lx.*Ly;

    Gk = gaussFilter(hsize*k, sigma*k);
    Axx = imfilter(Lxx, Gk);
    Ayy = imfilter(Lyy, Gk);
    Axy = imfilter(Lxy, Gk);

    R = Axx .* Ayy - (Axy.^2) - alpha * Axx .* Ayy;

    % Maxima
    corners = localExtrema(R,'8-connect','maxima', threshold);
end
