y = [1 1 1 1 2 2 2 2 1 1 3 3 4 5];
% prob_y = arrayfun(@(x)length(find(y==x)), unique(y)) / length(y)
prob_y = arrayfun(@(x)length(find(y==x)), y) / length(y)



y = [1.3 1 1 1 2 2 2 2 1 1 3 3 4 5];

[g,~,gl] = grp2idx(y);
count = accumarray(g,1);
p = count(g) ./ numel(g)
