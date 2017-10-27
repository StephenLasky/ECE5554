function [inliers,num_inliers,outliers,num_outliers] = test_F( F, x1, x2, matches )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

nmatches = size(matches); nmatches = nmatches(1);
num_inliers = 0;
num_outliers = 0;
inliers = [];
outliers = [];
THRESHOLD = 0.1;

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
    else
        num_outliers = num_outliers + 1;
        outliers(num_outliers) = match;
    end
end



end

