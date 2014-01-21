function I = spinning_circles(n)

p1 = [100 100]+25*[sin(n*pi/100) cos(n*pi/100)];
p2 = [100 100]-25*[sin(n*pi/100) cos(n*pi/100)];

% I((X-p1(1)).^2 + (Y-p1(2)).^2 < 6^2) = 0.99;
% I((X-p2(1)).^2 + (Y-p2(2)).^2 < 10^2) = 0.99;
G1 = gauss(200,2,'');
G2 = gauss(200,1,'');
% I = 500*G1(round(p1(1)) + (-50:50),round(p1(2)) + (-50:50)) + ...
%     200*G2(round(p2(1)) + (-50:50),round(p2(2)) + (-50:50));
[X1,Y1] = meshgrid(p1(1) + (-50:50),p1(2) + (-50:50));
[X2,Y2] = meshgrid(p2(1) + (-50:50),p2(2) + (-50:50));
I = interp2(G1,X1,Y1)/max(G1(:)) + ...
    interp2(G2,X2,Y2)/max(G2(:));

end

