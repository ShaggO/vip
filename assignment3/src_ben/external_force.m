function [F, F_x, F_y] = external_force(I, sigma, method)

switch method
    case 'gradient magnitude'
        hsize = ceil(6*sigma);
        I_x = imfilter(I,gauss(hsize,sigma,'x'),'replicate','conv');
        I_y = imfilter(I,gauss(hsize,sigma,'y'),'replicate','conv');
        I_xx = imfilter(I,gauss(hsize,sigma,'xx'),'replicate','conv');
        I_xy = imfilter(I,gauss(hsize,sigma,'xy'),'replicate','conv');
        I_yy = imfilter(I,gauss(hsize,sigma,'yy'),'replicate','conv');
        F = -(I_x .^ 2 + I_y .^ 2);
        F_x = -2*(I_x .* I_xx + I_y .* I_xy);
        F_y = -2*(I_x .* I_xy + I_y .* I_yy);
    case 'log'
        hsize = ceil(6*sigma);
        I_xx = imfilter(I,gauss(hsize,sigma,'xx'),'replicate','conv');
        I_yy = imfilter(I,gauss(hsize,sigma,'yy'),'replicate','conv');
        I_xxx = imfilter(I,gauss(hsize,sigma,'xxx'),'replicate','conv');
        I_xxy = imfilter(I,gauss(hsize,sigma,'xxy'),'replicate','conv');
        I_xyy = imfilter(I,gauss(hsize,sigma,'xyy'),'replicate','conv');
        I_yyy = imfilter(I,gauss(hsize,sigma,'yyy'),'replicate','conv');
        F = -(I_xx + I_yy).^2;
        F_x = -2*(I_xx + I_yy).*(I_xxx + I_xyy);
        F_y = -2*(I_xx + I_yy).*(I_xxy + I_yyy);
end

end

