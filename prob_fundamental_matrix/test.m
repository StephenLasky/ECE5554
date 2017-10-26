function F = HW3_FundamentalMatrix
close all;

im1 = im2double(imread('chapel00.png'));
im2 = im2double(imread('chapel01.png'));
load 'matches.mat';

% P1 = [c1, r1]';
% P2 = [c2, r2]';
% plotmatches(im1,im2,P1,P2,matches(1:8,:)','interactive',2);

% try swapping c1, r1
% temp = c1; c1 = r1; r1 = temp;
% temp = c2; c2 = r2; r2 = temp;

% get t to normalize x1 and x2
T = normalize(c1, r1);
Tp = normalize(c2, r2);

% combine points into 2 nice matrices
x1 = horzcat(c1, r1);
x2 = horzcat(c2, r2);
x1(:,3) = 1;
x2(:,3) = 1;

% normalize our new matrices
% s = size(r1); s = s(1);
% for i = 1:s
%     x1(i,:) = T * (x1(i,:))';
%     x2(i,:) = Tp * (x2(i,:))';
% end
x1 = (T * x1')';
x2 = (Tp * x2')';

MEAN = mean(x1)
SD = std(x1)
MEAN = mean(x2)
SD = std(x2)
% mean(x2)
% std(x2)

% ransac goes here
[F,inliers] = compute_best_F(x1,x2,1000,matches)
[inliers, num_inliers] = test_F(F,x1,x2,matches);

% denormalize F
F = denormalize(F,T,Tp);
F = F';

% display epipolar lines

display_epipolar_lines( r1,r2,c1,c2,matches,F,inliers,im1,im2 );

% matches = matches(50:100,:);
% matches = matches(116,:);   % match # 116 is good
% plotmatches(im1,im2,[c1 r1]', [c2 r2]', matches');



