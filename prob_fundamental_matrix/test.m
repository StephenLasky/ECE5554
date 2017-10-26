function F = HW3_FundamentalMatrix
close all;

im1 = im2double(imread('chapel00.png'));
im2 = im2double(imread('chapel01.png'));
load 'matches.mat';


% get t to normalize x1 and x2
T = normalize(c1, r1);
Tp = normalize(c2, r2);

% combine points into 2 nice matrices
x1 = horzcat(c1, r1);
x2 = horzcat(c2, r2);
x1(:,3) = 1;
x2(:,3) = 1;

% normalize our new matrices
s = size(r1); s = s(1);
for i = 1:s
    v = x1(i,:);
    v = v * T;
    x1(i,:) = v;
    
    v = x2(i,:);
    v = v * T;
    x2(i,:) = v;
end

% ransac goes here
[F,inliers] = compute_best_F(x1,x2,100,matches)

% denormalize F
F = denormalize(F,T,Tp);



