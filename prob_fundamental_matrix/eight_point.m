function [ F ] = eight_point( u,v )

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


end

