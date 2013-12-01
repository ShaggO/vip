function displayAllPoints(I, p, fLegends, pColor, save)
    if nargin < 5
        save = false;
    end
    fi = figure();
    imshow(I);
    hold on;
    for i = 1:size(p,2)
        nplot = plot(p{i}(:,2),p{i}(:,1),pColor{i});
        if i == 1
            lgnd = legend(fLegends{i});
        else
            [~,~,outHandle,OUTM] = legend;
            legend([outHandle;nplot],OUTM{:},fLegends{i});
    end

    if save
        set(fi, 'PaperPosition', [-0.45 -0.41 6 4.5]);
        set(fi, 'PaperSize', [5.12 3.85]);
        saveas(fi, save,'pdf');
    end
end
