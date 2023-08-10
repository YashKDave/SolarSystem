% Yash Dave
% August 3rd 2023
% n-body Solar System Simulation

clear all;clc;close all;

tic;
% Parameters
N       = 5;                % Bodies in System
t       = 0.0;              % Simulation Start Time
tEnd    = 2*365*24*60*60;           % Simulation End time
dt      = 10000;              % Time Step
G       = 6.67259e-20;      % Gravitational Constant - [Km^3/s^2*kg]


% Inital Conditions
SolarSystem = ["Sun", "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"];

mass = [198910.0,   % Sun
        0.330,      % Mercury
        4.87,       % Venus
        5.97,       % Earth
        0.642,      % Mars
        1898,       % Jupiter
        568,        % Saturn
        86.8,       % Uranus
        102,        % Neptune
        0.0130      % Pluto
        ] * 10e24;  % Scale masses to kg

% mass = [198910.0,   % Sun
%        5.97,       % Earth
%        ] * 10e24;  % Scale masses to kg
    
   
%Initialize positions and velocities of the planets relative to the Sun
for i = 1:N
    [position(:,i), velocity(:,i)] = planetEphemeris(juliandate(2023,8,3), convertStringsToChars(SolarSystem(1)), convertStringsToChars(SolarSystem(i)));
end

% [position(:,1), velocity(:,1)] = planetEphemeris(juliandate(2023,8,3), convertStringsToChars(SolarSystem(1)), convertStringsToChars(SolarSystem(1)));
% [position(:,2), velocity(:,2)] = planetEphemeris(juliandate(2023,8,3), convertStringsToChars(SolarSystem(1)), convertStringsToChars(SolarSystem(4)));

%acc = getAcceleration(position, mass, G);

tspan = [0:dt:tEnd];
inits = [position', velocity'];
options = odeset('reltol',1e-13,'abstol',1e-14); % tolerance for ode solver


[t,X] = ode45(@(t,y) propagate(t, y, mass(1:N), G),tspan,inits,options);


theta = getRotation(X, N);

R = rotx(theta);

x0 = X(:,1);
y0 = X(:,N + 1);
z0 = X(:,2*N + 1);

rotated_sun = R * [x0'; y0'; z0'];

x0 = rotated_sun(1, :);
y0 = rotated_sun(2, :);
z0 = rotated_sun(3, :);

% x0 = 0;
% y0 = 0;
% z0 = 0;

view(90,0)
% xlim([-3e8 3e8])
% ylim([-3e8 3e8])

xlabel('X');ylabel('Y');zlabel('Z');
hold on
grid on

for ii = 1:N
    x = X(:,ii);
    y = X(:,N + ii);
    z = X(:,2*N + ii);

    
    rotated_points = R * [x'; y'; z'];

    % Extract rotated coordinates
    x_rotated = rotated_points(1, :);
    y_rotated = rotated_points(2, :);
    z_rotated = rotated_points(3, :);
    
    plot3(x_rotated - x0, y_rotated - y0, z_rotated - z0, 'DisplayName', SolarSystem(ii))

   %plot3(X(:,ii) - x0, X(:,N + ii) - y0, X(:,2*N + ii) - z0)
end
legend()
toc

% planet = 8;
% for jj = 1:length(X(:,planet))
%     x_test = X(:,planet);
%     y_test = X(:,N + planet);
%     z_test = X(:,2*N + planet);
% 
%     rotated_test = R * [x_test'; y_test'; z_test'];
% 
%     x_test = rotated_test(1, :);
%     y_test = rotated_test(2, :);
%     z_test = rotated_test(3, :);
% 
%    x(jj) = (((x_test(jj) - x0(jj))^2 + (y_test(jj) - y0(jj))^2 +  (z_test(jj) - z0(jj))^2)^0.5);
% end
% rp = abs(min(x))
% ra = abs(max(x))
% syms a e
% a = vpa(solve(2*a == rp + ra))
% e = vpa(solve(ra == a*(1+e), e))
% std(x)
% 
% % view(3)
% % xlabel('X');ylabel('Y');zlabel('Z');
% % hold on
% % grid on
% 
% 
% plot3(x_test - x0,y_test - y0,z_test - z0)


