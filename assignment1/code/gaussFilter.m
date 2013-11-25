function filter = gaussFilter(hsize, sigma, derrive)
%% Create a discretized derrived gaussian filter of defined size
    if nargin < 3
        derrive = false;
    end
    if length(hsize) == 1
        hsize = hsize * [1 1];
    end
    mid = (hsize - 1) ./ 2;

    [x y] = meshgrid(-mid:mid,-mid:mid);

    if derrive
        if strcmp(derrive,'x')
            filter = -(x.*exp(-(x.^2 + y.^2)/(2*sigma^2)))/(2*pi*sigma^4);
        elseif strcmp(derrive,'y')
            filter = -(y.*exp(-(x.^2 + y.^2)/(2*sigma^2)))/(2*pi*sigma^4);
        elseif strcmp(derrive,'xx')
            filter = -(exp(-(x.^2 + y.^2)./(2.*sigma.^2)).*(sigma^2 - x.^2))/(2*pi*sigma^6);
        elseif strcmp(derrive, 'yy')
            filter = -(exp(-(x.^2 + y.^2)./(2*sigma^2)).*(sigma^2 - y.^2))/(2*pi*sigma^6);
        elseif strcmp(derrive,'xy') || strcmp(derrive,'yx')
            filter = (x.*y.*exp(-(x.^2 + y.^2)/(2*sigma^2)))/(2*pi*sigma^6);
        else
            error(['Derrivation with respect to ' derrive ' not supported']);
        end
    else
        filter = 1 / (2*pi*sigma^2) * exp(-(x.^2+y.^2)/(2*sigma^2));
    end
end
