function [inliers,num_inliers] = test_F( F, x1, x2, matches )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

nmatches = size(matches); nmatches = nmatches(1);
num_inliers = 0;
inliers = [];
THRESHOLD = 0.0001;

for match = 1:nmatches
    % Naive question: X'FX < threhold is the condition for inliers (X' X)?
    
    x = x1(matches(match,1),:);
    xp = x2(matches(match,2),:);
    result = xp * F * x';
    
    if result < THRESHOLD
        num_inliers = num_inliers + 1;
        inliers(num_inliers) = match;
    end
end



end

