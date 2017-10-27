% im1 = im2double(imread('chapel00.png'));
% im2 = im2double(imread('chapel01.png'));
% load 'matches.mat';
% 
% % get t to normalize x1 and x2
% T = normalize(c1, r1);
% Tp = normalize(c2, r2);
% 
% % combine points into 2 nice matrices
% x1 = horzcat(c1, r1);
% x2 = horzcat(c2, r2);
% x1(:,3) = 1;
% x2(:,3) = 1;
% 
% % normalize our new matrices
% x1 = (T * x1')';
% x2 = (Tp * x2')';
% 
% gmp = [116,200,202,204,123,124,54,191]; % GOOD MATCH POINTS
% % plotmatches(im1,im2,[c1 r1]',[c2 r2]',matches(gmp,:)');
% 
% x1 = x1(gmp,:);
% x2 = x2(gmp,:);
% F = eight_point(x1,x2);
% 
% 
% F = denormalize(F,T,Tp);
% F = F';
% 
% inliers = gmp;
% display_epipolar_lines( r1,r2,c1,c2,matches,F,inliers,im1,im2 );
% 
% 
% 
% 
A = [2,3,4]
B = [1,2,3,4,5]

B(~A)

% 
