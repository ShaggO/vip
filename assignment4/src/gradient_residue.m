function [ex, ey] = gradient_residue(I, J, sigma, patchsize)

hsize = ceil(6*sigma);

Ix = imfilter(I,gauss(hsize,sigma,'x'),'replicate','conv');
Iy = imfilter(I,gauss(hsize,sigma,'y'),'replicate','conv');
Ax = (J-I) .* Ix;
Ay = (J-I) .* Iy;

size_e = size(I)+[1-patchsize, 1-patchsize];
ex = zeros(size_e);
ey = zeros(size_e);
w = gauss(patchsize,sigma,'');

for i = 1:patchsize
    for j = 1:patchsize
        ex = ex + w(i,j)*Ax((1:end-patchsize+1)+i-1,(1:end-patchsize+1)+j-1);
        ey = ey + w(i,j)*Ay((1:end-patchsize+1)+i-1,(1:end-patchsize+1)+j-1);
    end
end

end