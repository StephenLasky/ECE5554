function F = HW3_FundamentalMatrix
close all;

im1 = im2double(imread('chapel00.png'));
im2 = im2double(imread('chapel01.png'));
load 'matches.mat';

[F, inliers] = ransacF(c1(matches(:, 1)), r1(matches(:, 1)), c2(matches(:, 2)), r2(matches(:, 2)), im1, im2);

% display F

% plot outliers

% display epipolar lines


function [bestF, best] = ransacF(x1, y1, x2, y2, im1, im2)

% Find normalization matrix
T1 = normalize(x1, y1);
T2 = normalize(x2, y2);

% Transform point set 1 and 2

% RANSAC based 8-point algorithm


function inliers = getInliers(pt1, pt2, F, thresh)
% Function: implement the criteria checking inliers. 


function T = normalize(x, y)
% Function: find the transformation to make it zero mean and the variance as sqrt(2)


  
function F = computeF(x1, y1, x2, y2)
% Function: compute fundamental matrix from corresponding points