clc, clear all, close all

sigma = 2;
patchsize = 15;
threshold_init = 0.0003;
threshold_keep = threshold_init/100;
convergence_iters = 5;
frames = 2000;
scale = 1;
arrowscale = 10;
saved_frames = [1 10 100 213];

sigma = sigma * scale;
patchsize = round(patchsize * scale);
threshold_init = threshold_init * scale;

figure
set(gcf,'units','normalized','outerposition',[0 0 1 1])

I = dudekface(0,scale);
% I = spinning_circles(0);
for frame = 1:frames
    %% Load frame
    J = I;
    I = dudekface(frame,scale);
%     I = spinning_circles(frame);
    
    %% Get features
    [Gxx, Gxy, Gyy, L1, L2] = harris_matrix(I, sigma, patchsize);
    [Ex, Ey] = gradient_residue(I, J, sigma, patchsize);
    L = min(abs(L1),abs(L2));
    if frame == 1
        X = get_features(L, patchsize, threshold_init);
    else
        X = X((X(:,1) >= 1) & (X(:,1) <= size(L,1)) & ...
            (X(:,2) >= 1) & (X(:,2) <= size(L,2)),:);
        Xi = round(X(:,1));
        Xj = round(X(:,2));
        X = X(L(sub2ind(size(L),Xi,Xj)) > threshold_keep,:);
    end
    
    %% Get displacement
    d = zeros(size(X,1),2);
    keep = boolean(ones(size(X,1),1));
    for n = 1:size(X,1)
        for k = 1:convergence_iters
            i = X(n,1) + d(n,1);
            j = X(n,2) + d(n,2);
            if i >= 1 && i <= size(L,1) && j >= 1 && j <= size(L,2)
                gxx = interp2(Gxx,j,i,'bilinear');
                gxy = interp2(Gxy,j,i,'bilinear');
                gyy = interp2(Gyy,j,i,'bilinear');
                ex = interp2(Ex,j,i,'bilinear');
                ey = interp2(Ey,j,i,'bilinear');
                %         gxx = Gxx(i,j);
                %         gxy = Gxy(i,j);
                %         gyy = Gyy(i,j);
                %         ex = Ex(i,j);
                %         ey = Ey(i,j);
                d(n,:) = flip((pinv([gxx gxy; gxy gyy])*[ex; ey])');
            else
                keep(n) = 0;
                break
            end
        end
    end
    X = X(keep,:);
    d = d(keep,:);
    
    %% Draw image
    imshow(I,[])
    title(['Frame ' num2str(frame)])
    hold on
    for n = 1:size(X,1)
        i = X(n,1);
        j = X(n,2);
        plot([j j+patchsize j+patchsize j j],...
            [i i i+patchsize i+patchsize i],'r-')
        plot(j+patchsize/2+arrowscale*[0 d(n,2)],...
            i+patchsize/2+arrowscale*[0 d(n,1)],'b-')
        %         quiver(j+patchsize/2,i+patchsize/2,d(n,2),d(n,1),1)
    end
    drawnow
    hold off
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
    %% Save image
    if ismember(frame, saved_frames)
        
        saveas(gcf,['tracker_dudekface_' num2str(frame) '.pdf'])
    end
    
    %% Add displacement
    X = X + d;
end

% figure, imshow(ex,[])
% figure, imshow(ey,[])