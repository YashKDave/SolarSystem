function [acc] = getAcceleration( position, mass, G)
% Function calculates acceleration N bodies exert on one another
% Returns NxN matrix of accelerations

% Splits position matrix into X, Y, and Z components
x = position(1,:);
y = position(2,:);
z = position(3,:);

% X,Y, and Z distances between bodies
dx = x' - x;
dy = y' - y;
dz = z' - z;

% Absolute value of distances beween bodies
r3 = sqrt(dx.^2 + dy.^2 + dz.^2);
% Invert for division purposes and remove infinities
r3 = 1./r3.^3;
r3(r3 == Inf) = 0;

ax = -G * (dx .* r3) * mass;
ay = -G * (dy .* r3) * mass;
az = -G * (dz .* r3) * mass;

acc = [ax ay az];
%norm(acc(2,:))
end