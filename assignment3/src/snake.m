function p = snake(I, p, alpha, beta, gamma, tau, sigma, method)
% Perform snake iterations and output final snake points

    % Compute system matrix components
    M = systemMatrix(size(p,1), alpha, beta, tau);
    Minv = inv(M);

    % Compute derrived images
    [F, Fx, Fy] = externalForces(I, sigma, method);

    % Initial velocities (for displaying changes)
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
    for i = 1:30000
        title(['Interation ' num2str(i)]);
        % Interpolate current points
        Fp(:,1) = interp2(Fx,p(:,1),p(:,2),'linear',0);
        Fp(:,2) = interp2(Fy,p(:,1),p(:,2),'linear',0);

        % Compute new points
        oldP = p;
        p = Minv * (p - gamma * Fp);

        % Position changes
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
