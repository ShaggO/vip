function p = snake(I, p, alpha, beta, gamma, tau, sigma, method, sCriteria, img, ith)
% Perform snake iterations and output final snake points
    if nargin < 9
        sCriteria = 2.1e-2
    end
    if nargin < 10
        img = '';
    end
    if nargin < 11
        ith = false;
    end

    % Compute system matrix components
    M = systemMatrix(size(p,1), alpha, beta, tau);
    Minv = inv(M);

    % Compute derrived images
    [F, Fx, Fy] = externalForces(I, sigma, method);

    % Save intermediate images
    fi1 = figure();
    imshow(I,[]);
    title('Grayscale image');

    fi2 = figure();
    imshow(F, []);
    title('Force image');

    fi3 = figure();
    imshow(Fx, []);
    title('x derivative of force image');

    fi4 = figure();
    imshow(Fy, []);
    title('y derivative of force image');


    % Initial velocities (for displaying changes)
    oldP = p;
    v = p-oldP;

    % Draw initial figure
    fi5 = figure();
    imshow(I, []);
    hold on;
    plotL = plot([p(:,1);p(1,1)],[p(:,2);p(1,2)],'r-');
    plotV = quiver(p(:,1),p(:,2),v(:,1),v(:,2));
    title('Iteration 0');
    axis('equal');

    fi = [fi1, fi2, fi3, fi4, fi5];
    if size(I,1) == size(I,2)
        % Box image
        set(fi, 'paperposition', [-0.2 -0.2 5 5]);
        set(fi, 'papersize', [4.6 4.8]);
    else
        % Coin image
        set(fi, 'PaperPosition', [-0.8 -1.1 5 4.5])
        set(fi, 'PaperSize', [3.45 3]);
    end

    drawnow;

    if ~strcmp(img,'')
        saveas(fi1,[img '_gray'],'pdf');
        saveas(fi2,[img '_forces'],'pdf');
        saveas(fi3,[img '_xforces'],'pdf');
        saveas(fi4,[img '_yforces'],'pdf');
        saveas(gcf,[img '_0' ],'pdf');
    end

    % Iterate util stop
    for i = 1:30000
        title(['Iteration ' num2str(i)]);
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
        if ~strcmp(img,'') && mod(i,ith) == 0
            saveas(gcf,[img '_' num2str(i) ],'pdf');
        end

        % Stop loop early if no change is detected
        diffP = max(sqrt(sum(v.^2,2)));
        if max(diffP) < sCriteria
            break;
        end
    end
    if ~strcmp(img,'')
        saveas(gcf,[img '_' num2str(i) ],'pdf');
    end
end
