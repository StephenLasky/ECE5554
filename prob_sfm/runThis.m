function F = HW3_SfM
close all;

folder = 'images/';
im = readImages(folder, 0:50);

load './tracks.mat';


figure(2), imagesc(im{1}), hold off, axis image, colormap gray
hold on, plot(track_x', track_y', 'r')
figure(3), imagesc(im{end}), hold off, axis image, colormap gray
hold on, plot(track_x', track_y', 'r')
%pause;

valid = ~any(isnan(track_x), 2) & ~any(isnan(track_y), 2); 

[R, S] = affineSFM(track_x(valid, :), track_y(valid, :));

plotSFM(R, S);



function [R, S] = affineSFM(x, y)
% Function: Affine structure from motion algorithm

% Normalize x, y to zero mean

% Create measurement matrix
D = [xn' ; yn'];

% Decompose and enforce rank 3

% Apply orthographic constraints


function im = readImages(folder, nums)
im = cell(numel(nums),1);
t = 0;
for k = nums,
    t = t+1;
    im{t} = imread(fullfile(folder, ['hotel.seq' num2str(k) '.png']));
    im{t} = im2single(im{t});
end
