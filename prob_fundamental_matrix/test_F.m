function inliers = test_F( F, x1, x2, matches )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

nmatches = size(matches); nmatches = nmatches(1);
inliers = 0;
THRESHOLD = 1.0;

for match = 1:nmatches
    % Naive question: X'FX < threhold is the condition for inliers (X' X)?
    
    x = x1(matches(match,1),:);
    xp = x2(matches(match,2),:);
    result = xp * F * x';
    
    if result < THRESHOLD
        inliers = inliers + 1;
    end
end



end

