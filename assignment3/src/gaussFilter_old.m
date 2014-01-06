function filter = gaussFilter(hsize, sigma, derrive)
%% Create a discretized derrived gaussian filter of defined size
    if nargin < 3
        derrive = false;
    end
    if length(hsize) == 1
        hsize = hsize * [1 1];
    end
    % Compute midpoints of filter
    mid = (hsize - 1) ./ 2;

    % Generate grid centered at mid just found
    [x y] = meshgrid(-mid(1):mid(1),-mid(2):mid(2));

    % If derrivative is required.
    if derrive
        if strcmp(derrive,'x')
            % With respect to x
            filter = -(x.*exp(-(x.^2 + y.^2)/(2*sigma^2)))/(2*pi*sigma^4);
        elseif strcmp(derrive,'y')
            % With respect to y
            filter = -(y.*exp(-(x.^2 + y.^2)/(2*sigma^2)))/(2*pi*sigma^4);
        elseif strcmp(derrive,'xx')
            % Twice differentiated with respect to x
            filter = -(exp(-(x.^2 + y.^2)./(2.*sigma.^2)).*(sigma^2 - x.^2))/(2*pi*sigma^6);
        elseif strcmp(derrive, 'yy')
            % Twice differentiated with respect to y
            filter = -(exp(-(x.^2 + y.^2)./(2*sigma^2)).*(sigma^2 - y.^2))/(2*pi*sigma^6);
        elseif strcmp(derrive,'xy') || strcmp(derrive,'yx')
            % Derrived with respect to x and y
            filter = (x.*y.*exp(-(x.^2 + y.^2)/(2*sigma^2)))/(2*pi*sigma^6);
        else
            error(['Derrivation with respect to ' derrive ' not supported']);
        end
    else
        % Standard Gaussian filter
        filter = 1 / (2*pi*sigma^2) * exp(-(x.^2+y.^2)/(2*sigma^2));
    end
end
