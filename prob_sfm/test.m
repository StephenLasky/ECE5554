folder = 'images/';
nums = 0:50;
im = cell(numel(nums),1);
t = 0;
for k = nums,
t = t+1;
    im{t} = imread(fullfile(folder, ['hotel.seq' num2str(k) '.png']));
    im{t} = im2single(im{t});
end

load './tracks.mat';

m = size(im,1);         % M = NUMBER OF IMAGES
n = size(track_x,1);    % N = NUMBER OF KEYPOINTS

% step 1: for each image i, center the image coordinates
track_x_orig = track_x;     % remember original
track_y_orig = track_y;     % remember original

valid = ~any(isnan(track_x), 2) & ~any(isnan(track_y), 2); % remove NaNs
track_x = track_x(valid, :);
track_y = track_y(valid, :);

for i=1:m
    track_x(:,i) = track_x(:,i) - mean(track_x(:,i));
    track_y(:,i) = track_y(:,i) - mean(track_y(:,i));
end

% step 2: construct 2m x n measurment matrix D
% D = [track_x'; track_y'];
D = [track_x'; track_y'];
size(D)

% step 3: factorize D
[U, W, V] = svd(D);
% V = V';
U3 = U(:,1:3);
V3 = V(:,1:3);
W3 = W(1:3,1:3);

% step 4: create motion (affine) and shape (3D) matrices:
A = U3 * sqrt(W3);
S = sqrt(W3) * V3';

% compute A_squigly?
A_squigly = zeros(3*m,9,'single');
% just do for 1 now
for i = 1:m
    x = A(i,:);
    y = A(i+m,:);
%     x = A(2*i-1,:);
%     y = A(2*i,:);
    
    % equation 1 
    a = x(1); b = x(2); c = x(3);
    d = x(1); e = x(2); f = x(3);
    newr = reshape([a b c]'*[d e f], [1,9]);
    A_squigly(3*i-2,:) = newr;
    
    % equation 2
    a = y(1); b = y(2); c = y(3);
    d = y(1); e = y(2); f = y(3);
    newr = reshape([a b c]'*[d e f], [1,9]);
    A_squigly(3*i-1,:) = newr;
    
    % equation 3
    a = x(1); b = x(2); c = x(3);
    d = y(1); e = y(2); f = y(3);
    newr = reshape([a b c]'*[d e f], [1,9]);
    A_squigly(3*i,:) = newr;
    
end

% create matrix b
b = ones(3*m, 1, 'single');
for i = 1:m
    b(3*i,1) = 0;
end

% solve for L
size(A_squigly);
size(b);
L = reshape(A_squigly\b,[3,3])

C = chol(L,'lower');

% step 5: update A and S
A = A*C;
S = inv(C)*S;


% step 6: plot?
plotSfM(A,S);



% C = zeros(3,3,'single'); C(1,1) = 1; C(2,2) = 1; C(3,3) = 1;    % arbitrary invertible C
% A_squigly = A_squigly * C;
% X_squigly = C^(-1) * X_squigly;
% 
% D_s = A_squigly * X_squigly;


disp('Program finished.');