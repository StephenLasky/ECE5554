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

for i=1:m
    track_x(:,i) = track_x(:,i) - nanmean(track_x(:,i));
    track_y(:,i) = track_y(:,i) - nanmean(track_y(:,i));
end

% step 2: construct 2m x n measurment matrix D
% sub-step, remove keypoints that become untracked at some point (NaN
% values)
to_remove = []; % list of keypoint IDs that need to be removed
ntr = 0;
for kp = 1:n
    for imn = 1:m
        if isnan(track_x(kp,imn)) || isnan(track_y(kp,imn))
            ntr = ntr + 1;
            to_remove(ntr) = kp;
            break;
        end
    end
end

% create the new tracked x and tracked y matrices
% n = n-ntr;
% new_track_x = zeros(n,m,'single');
% new_track_y = zeros(n,m,'single');
% 
% tri = 1;
% i = 1;
% for kp = 1:n+ntr
%     if tri <= ntr && kp == to_remove(tri)
%         tri = tri + 1;
%     else
%         new_track_x(i,:) = track_x(kp,:);
%         new_track_y(i,:) = track_y(kp,:);
%     end
%     
% end

% fill new tracked x and track y matrices with new values
% track_x = new_track_x;
% track_y = new_track_y;

valid = ~any(isnan(track_x), 2) & ~any(isnan(track_y), 2); 

D = zeros(2*m,n,'single');
track_x = track_x(valid, :);
track_y = track_y(valid, :);
D = [track_x track_y]';


% step 3: factorize D
[U, W, V] = svd(D);
V = V';
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
    a = A(i,1); b = A(i,2); c = A(i,3);
    d = A(i+m,1); e = A(i+m,2); f = A(i+m,3);
    newr = reshape([ a b c ]'*[ d e f ], [1,9]);
    A_squigly(3*i-2,:) = newr;
    A_squigly(3*i-1,:) = newr;
    A_squigly(3*i,  :) = newr;
end

% create matrix b
b = ones(3*m, 1, 'single');
for i = 1:m
    b(3*i,1) = 0;
end

size(A_squigly)
size(b)
L = reshape(A_squigly\b,[3,3]);


% C = zeros(3,3,'single'); C(1,1) = 1; C(2,2) = 1; C(3,3) = 1;    % arbitrary invertible C
% A_squigly = A_squigly * C;
% X_squigly = C^(-1) * X_squigly;
% 
% D_s = A_squigly * X_squigly;


disp('Program finished.');