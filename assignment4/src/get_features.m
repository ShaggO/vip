function X = get_features(E, patchsize, threshold)
% get maximal non-overlapping features above a threshold

if nargin == 0
    E = magic(5)
    patchsize = 2;
    threshold = 20;
end

[E_sort, Idx] = sort(E(:),'descend');
Idx = Idx(E_sort > threshold);
E_sort = E_sort(E_sort > threshold);
Overlap = zeros(size(E));

X = zeros(0,2);
for n = 1:numel(E_sort)
    [i,j] = ind2sub(size(E),Idx(n));
    if ~Overlap(i,j)
        X = [X; i j];
        
        i_min = max(i-(patchsize-1),1);
        i_max = min(i+(patchsize-1),size(E,1));
        j_min = max(j-(patchsize-1),1);
        j_max = min(j+(patchsize-1),size(E,2));
        Overlap(i_min:i_max,j_min:j_max) = 1;
    end
end

end

