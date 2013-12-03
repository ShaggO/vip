function displayAllPoints(I, p, fLegends, pColor, save)
% Display interest points on image
    if nargin < 5
        save = false;
    end
    fi = figure();
    imshow(I);
    hold on;
    % Loop through each set of interest points
    for i = 1:size(p,2)
        nplot = plot(p{i}(:,2),p{i}(:,1),pColor{i});
        if i == 1
            % Create legend if first set of points
            lgnd = legend(fLegends{i});
        else
            % Append interest point legend to current legends
            [~,~,outHandle,OUTM] = legend;
            legend([outHandle;nplot],OUTM{:},fLegends{i});
    end

    % Save figure if wanted
    if save
        if size(I,1)/size(I,2) == 0.75
            set(fi, 'PaperPosition', [-0.45 -0.41 6 4.5]);
            set(fi, 'PaperSize', [5.12 3.85]);
        elseif size(I,1)/size(I,2) == 1
            set(fi, 'PaperPosition', [-0.5 -0.6 6 6]);
            set(fi, 'PaperSize', [5 5]);
        end
        saveas(fi, save,'pdf');
    end
end
