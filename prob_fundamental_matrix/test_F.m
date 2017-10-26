function [inliers,num_inliers] = test_F( F, x1, x2, matches )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

nmatches = size(matches); nmatches = nmatches(1);
num_inliers = 0;
inliers = [];
THRESHOLD = 0.01;

for match = 1:nmatches
    % Naive question: X'FX < threhold is the condition for inliers (X' X)?
    
    x = x1(matches(match,1),:);
    xp = x2(matches(match,2),:);
%     result = xp * F * x';
    
    L = F * xp';
    d = abs(L(1)*x(1)+L(2)*x(2)+L(3)) / sqrt(x(1)^2+x(2)^2);
    result = d;
    
    
    
    
    if result < THRESHOLD
        num_inliers = num_inliers + 1;
        inliers(num_inliers) = match;
    end
end



end

