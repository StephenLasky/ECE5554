function T = normalize( x, y )
% Returns T normalization matrix for points x,y
% source: https://piazza.com/class/j6vqe2ljo9y4lc?cid=67
% s = size(x); s = s(1);

T = [1/std(x), 0, 0;
      0, 1/std(y), 0;
      0, 0, 1];

% T = [ 1/(std(x)^2), 0, -mean(x);
%       0, 1/(std(y)^2), -mean(y);
%       0, 0, 1];





end

