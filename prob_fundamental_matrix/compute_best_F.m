function [F, inliers] = compute_best_F( x1,x2,ntrials,matches)

% F_mtxs = zeros(ntrials,3,3,'double');
% inliers = zeros(ntrials);

best_F = zeros(3,3,'double');
best_inlier = 0;

for trial_num = 1:ntrials
    % choose 8 random points
    s = size(matches); s = s(1);
    u = zeros(8,3,'double');
    v = zeros(8,3,'double');
    rpts = randperm(s,8);      % need 8 distinct points
    for i = 1:8
        rpt = rpts(i);
        pt1 = matches(rpt,1);
        pt2 = matches(rpt,2);

        u(i,:) = x1(pt1,:);
        v(i,:) = x2(pt2,:);
    end

    % 8 point here
    F = eight_point(u,v);

%     % denormalize F
%     F = denormalize(F,T,Tp);

    % get number of inliers
    [inliers,num_inliers] = test_F(F, x1, x2, matches);
%     disp(num_inliers);
    if num_inliers > best_inlier
        best_inlier = num_inliers;
        best_F = F;
    end
end

F = best_F;
inliers = best_inlier;

end

