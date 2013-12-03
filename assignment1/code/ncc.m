function value = ncc(F1, F2)
%% Compute normalized cross correlation
    % Compute means
    F1mean = mean(F1(:));
    F2mean = mean(F2(:));

    % Compute standard deviation
    F1sigma = std(F1(:), true);
    F2sigma = std(F2(:), true);

    % Compute normalized cross correlation
    value = 1-1/numel(F1)*sum(sum((F1 - F1mean).*(F2 - F2mean)/(F1sigma * F2sigma)));
end
