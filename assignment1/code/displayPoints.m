function displayPoints(I, p, fTitle, pColor, save)
    if nargin < 5
        save = false;
    end
    fi = figure();
    imshow(I);
    hold on;
    title(fTitle);
    plot(p(:,2),p(:,1),pColor);

    if save
        set(fi, 'PaperPosition', [-0.2 -0.25 6 5.5]);
        set(fi, 'PaperSize', [5.4 5.2]);
        saveas(fi, save,'pdf');
    end
end
