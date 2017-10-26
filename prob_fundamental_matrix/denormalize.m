function F = denormalize( F, T, Tp )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% F = Tp'*F*T;    % original

F = T'*F*Tp;
% F = Tp * F * T;
% F = T * F * Tp';


end

