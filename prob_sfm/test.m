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

A = [1 2 3]



D = zeros(2*m,n,'single');
D = [track_x track_y]';

disp('Program finished.');

% step 3: factorize D
% [U,S,V] = svd(A)

% [U, W, V] = svd(D);