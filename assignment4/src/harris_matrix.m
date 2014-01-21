function [Gxx, Gxy, Gyy, L1, L2] = harris_matrix(I, sigma, patchsize)

hsize = ceil(6*sigma);

Ix = imfilter(I,gauss(hsize,sigma,'x'),'replicate','conv');
Iy = imfilter(I,gauss(hsize,sigma,'y'),'replicate','conv');
Axx = Ix .^ 2;
Axy = Ix .* Iy;
Ayy = Iy .^ 2;

size_E = size(I)+[1-patchsize, 1-patchsize];
Gxx = zeros(size_E);
Gxy = zeros(size_E);
Gyy = zeros(size_E);
w = gauss(patchsize,sigma,'');

for i = 1:patchsize
    for j = 1:patchsize
        Gxx = Gxx + w(i,j)*Axx((1:end-patchsize+1)+i-1,(1:end-patchsize+1)+j-1);
        Gxy = Gxy + w(i,j)*Axy((1:end-patchsize+1)+i-1,(1:end-patchsize+1)+j-1);
        Gyy = Gyy + w(i,j)*Ayy((1:end-patchsize+1)+i-1,(1:end-patchsize+1)+j-1);
    end
end

% for i = 1:size_E(1)
%     for j = 1:size_E(2)
%         e = eig([Gxx(i,j) Gxy(i,j); Gxy(i,j) Gyy(i,j)]);
%         E1(i,j) = e(1);
%         E2(i,j) = e(2);
%     end
% end
D = sqrt(Gxx.^2 + 4*Gxy.^2 - 2*Gxx.*Gyy + Gyy.^2);
L1 = (Gxx + Gyy - D)/2;
L2 = (Gxx + Gyy + D)/2;

end