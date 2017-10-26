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

% set up matrix A for the 8 point algorithm
A = zeros(8,9,'double');
for i = 1:8
    A(i,1) = v(i,1) * u(i,1);   % x'*x
    A(i,2) = v(i,1) * u(i,2);   % x'*y
    A(i,3) = v(i,1);            % x'
    A(i,4) = v(i,2) * u(i,1);   % y'*x
    A(i,5) = v(i,2) * u(i,2);   % y'*y
    A(i,6) = v(i,2);            % y'
    A(i,7) = u(i,1);            % x
    A(i,8) = u(i,2);            % y
    A(i,9) = 1;                 % 1
end

% solve using slides STEP 1.b
[U,S,V] = svd(A);
f = V(:, end);
F = reshape(f, [3 3])';
% 
% % solve using slides STEP 2
[U, S, V] = svd(F);
S(3,3) = 0;
F = U*S*V';

% denormalize F
F = denormalize(F,T,Tp);

% get number of inliers
inliers = test_F(F, x1, x2, matches);




