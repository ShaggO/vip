function [F, F_x, F_y] = externalForces(I, sigma, method)

    hsize = ceil(6*sigma);
    switch method
        case 'gradient magnitude'
            I_x = imfilter(I,gaussFilter(hsize,sigma,'x'),'replicate','conv');
            I_y = imfilter(I,gaussFilter(hsize,sigma,'y'),'replicate','conv');
            I_xx = imfilter(I,gaussFilter(hsize,sigma,'xx'),'replicate','conv');
            I_xy = imfilter(I,gaussFilter(hsize,sigma,'xy'),'replicate','conv');
            I_yy = imfilter(I,gaussFilter(hsize,sigma,'yy'),'replicate','conv');
            F = -(I_x .^ 2 + I_y .^ 2);
            F_x = -2*(I_x .* I_xx + I_y .* I_xy);
            F_y = -2*(I_x .* I_xy + I_y .* I_yy);
        case 'log'
            I_xx = imfilter(I,gaussFilter(hsize,sigma,'xx'),'replicate','conv');
            I_yy = imfilter(I,gaussFilter(hsize,sigma,'yy'),'replicate','conv');
            I_xxx = imfilter(I,gaussFilter(hsize,sigma,'xxx'),'replicate','conv');
            I_xxy = imfilter(I,gaussFilter(hsize,sigma,'xxy'),'replicate','conv');
            I_xyy = imfilter(I,gaussFilter(hsize,sigma,'xyy'),'replicate','conv');
            I_yyy = imfilter(I,gaussFilter(hsize,sigma,'yyy'),'replicate','conv');
            F = -(I_xx + I_yy).^2;
            F_x = -2*(I_xx + I_yy).*(I_xxx + I_xyy);
            F_y = -2*(I_xx + I_yy).*(I_xxy + I_yyy);
    end

end
