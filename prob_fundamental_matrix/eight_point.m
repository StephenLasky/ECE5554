function [ F ] = eight_point( u,v )

% set up matrix A for the 8 point algorithm
A = zeros(8,9,'double');
for i = 1:8
    x1 = u(i,1);
    x2 = v(i,1);
    y1 = u(i,2);
    y2 = v(i,2);
    
    % MY ORIGINAL CODE
%     A(i,1) = v(i,1) * u(i,1);   % x'*x
%     A(i,2) = v(i,1) * u(i,2);   % x'*y
%     A(i,3) = v(i,1);            % x'
%     A(i,4) = v(i,2) * u(i,1);   % y'*x
%     A(i,5) = v(i,2) * u(i,2);   % y'*y
%     A(i,6) = v(i,2);            % y'
%     A(i,7) = u(i,1);            % x
%     A(i,8) = u(i,2);            % y
%     A(i,9) = 1;                 % 1

    A(i,1) = x2*x1;
    A(i,2) = x2*y1;
    A(i,3) = x2;
    A(i,4) = y2*x1;
    A(i,5) = y2*y1;
    A(i,6) = y1;
    A(i,7) = x1;
    A(i,8) = y1;
    A(i,9) = 1;                 % 1

    
% PIAZZA CODE
% a = [x1(i)*x2(i) x1(i)*y2(i) x1(i) y1(i)*x2(i) y1(i)*y2(i) y1(i) x2(i) y2(i) 1];
%     A(i,1) = x1*x2;
%     A(i,2) = x1*y2;
%     A(i,3) = x1;
%     A(i,4) = y1*x2;
%     A(i,5) = y1*y2;
%     A(i,6) = y1;
%     A(i,7) = x2;
%     A(i,8) = y2;
%     A(i,9) = 1;                 % 1
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

