function T = normalize( x, y )
% Returns T normalization matrix for points x,y
% source: https://piazza.com/class/j6vqe2ljo9y4lc?cid=67
% s = size(x); s = s(1);

% T = [1/std(x), 0, 0;
%       0, 1/std(y), 0;
%       0, 0, 1];
  
% Jing's solution ...
% sig_x = 1/(std(x)^2);
% sig_y = 1/(std(y)^2);
% mu_x = mean(x);
% mu_y = mean(y);
% 
% T = [sig_x, 0, 0;
%       0, sig_y, 0;
%       0, 0, 1];
% T = T * [-mu_x,0,0; 0,-mu_y,0; 0,0,1];
% Jing's solution above ^^^

% % 1 Piazza solution
% scaleF = mean(std(x) + std(y));
% T = [1/scaleF 0 0; 0 1/scaleF 0; 0 0 1];

% T = [ 1/(std(x)^2), 0, -mean(x);
%       0, 1/(std(y)^2), -mean(y);
%       0, 0, 1];

% Tscale = diag([ 1/std(x), 1/std(y), 1]);
% Ttranslation = [1 0 -mean(x); 0 1 -mean(y); 0 0 1];
% T = Tscale * Ttranslation;
% T = Tscale;

Tscale = diag([ 1/std(x), 1/std(y), 1]);
Ttranslation = [1 0 -mean(x); 0 1 -mean(y); 0 0 1];
T = Tscale * Ttranslation;



end

