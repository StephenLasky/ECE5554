function display_epipolar_lines( r1,r2,c1,c2,matches,F,inliers,im1,im2 )
% Display epipolar lines
matches = matches(inliers, :);
% Randomly pick some match pairs
% select = [50, 60, 70, 80, 90, 130];
select = randperm(size(matches,1),8);      % need 8 distinct points
% select = [5, 8, 12, 15, 18, 21, 25, 116];
matches = matches(select, :);
N = size(matches, 1);
X1 = [c1(matches(:, 1)), r1(matches(:, 1)), ones(N, 1)];
X2 = [c2(matches(:, 2)), r2(matches(:, 2)), ones(N, 1)];

l1 = (F'*X2')';
l2 = (F*X1')';

% This can tell you the average distance from each point to their corresponding epipolar line
dist1 = mean(abs(sum(X1.*l1, 2) ./ sqrt(l1(:,1).^2+l1(:,2).^2)));
dist2 = mean(abs(sum(X2.*l2, 2) ./ sqrt(l2(:,1).^2+l2(:,2).^2)));

x1l = X1(:, 1) - 20;
x2l = X2(:, 1) - 20;
x1r = X1(:, 1) + 20;
x2r = X2(:, 1) + 20;

y1l = (-l1(:, 3) - l1(:, 1) .* x1l) ./ l1(:, 2);
y2l = (-l2(:, 3) - l2(:, 1) .* x2l) ./ l2(:, 2);
y1r = (-l1(:, 3) - l1(:, 1) .* x1r) ./ l1(:, 2);
y2r = (-l2(:, 3) - l2(:, 1) .* x2r) ./ l2(:, 2);

subplot(1, 2, 1);
imshow(im1);
hold on
for i = 1:length(x1l)
    plot(X1(i, 1), X1(i, 2), 'bo');
    plot([x1l(i), x1r(i)], [y1l(i), y1r(i)], 'r');
end

subplot(1, 2, 2);
imshow(im2);
hold on
for i = 1:length(x2l)
    plot(X2(i, 1), X2(i, 2), 'bo');
    plot([x2l(i), x2r(i)], [y2l(i), y2r(i)], 'r');
end
end

