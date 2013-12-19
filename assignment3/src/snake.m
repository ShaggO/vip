function p = snake(I, p, alpha, beta, gamma, tau, sigma)
% Perform snake iterations and output final snake points

    % Compute system matrix components
    A = tau * beta;
    B = -tau * (alpha + 4 * beta);
    C = 1 + tau * (2 * alpha + 6 * beta);

    % Initialize system matrix
    M = toeplitz([C, B, A, zeros(1,size(p,1)-5), A, B]);
    Minv = inv(M);

    % Compute derrived images
    hsize = 6*sigma;
    Ix  = imfilter(I, gaussFilter(hsize, sigma,  'x'),'conv', 'replicate');
    Ixx = imfilter(I, gaussFilter(hsize, sigma, 'xx'),'conv', 'replicate');
    Iy  = imfilter(I, gaussFilter(hsize, sigma,  'y'),'conv', 'replicate');
    Iyy = imfilter(I, gaussFilter(hsize, sigma, 'yy'),'conv', 'replicate');
    Ixy = imfilter(I, gaussFilter(hsize, sigma, 'xy'),'conv',  'replicate');

    Fx = -2 * (Ix .* Ixx + Iy .* Ixy);
    Fy = -2 * (Ix .* Ixy + Iy .* Iyy);

    oldP = p;
    v = p-oldP;

    % Draw initial figure
    fi = figure();
    imshow(I, []);
    hold on;
    plotL = plot([p(:,1);p(1,1)],[p(:,2);p(1,2)],'r-');
    plotV = quiver(p(:,1),p(:,2),v(:,1),v(:,2));
    drawnow;

    % Iterate util stop
    for i = 1:5000
        % Interpolate current points
        Fp(:,1) = interp2(Fx,p(:,1),p(:,2),'linear',0);
        Fp(:,2) = interp2(Fy,p(:,1),p(:,2),'linear',0);

        % Compute new points
        oldP = p;
        p = Minv * (p - gamma * Fp);

        v = p-oldP;

        % Update plot
        delete(plotL)
        delete(plotV)
        plotL = plot([p(:,1);p(1,1)],[p(:,2);p(1,2)],'r-');
        plotV = quiver(p(:,1),p(:,2),v(:,1),v(:,2));
        drawnow;

        % Stop loop early if no change is detected
        diffP = max(sqrt(sum(v.^2,2)));
        if max(diffP) < 2.1e-2
            break;
        end
    end
end
