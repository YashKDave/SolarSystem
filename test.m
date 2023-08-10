function theta = getRotation(X)
% Orbit coordinates 
    x = X(:,4);
    y = X(:,N + 4);
    z = X(:,2*N + 4);
    
    theta = -atan2d(mean(z), mean(y));
end

% theta = 156.4187
% R = rotx(theta);
% rotated_points = R * [x'; y'; z'];
% 
% % Extract rotated coordinates
% x_rotated = rotated_points(1, :);
% y_rotated = rotated_points(2, :);
% z_rotated = rotated_points(3, :);
% 
% % Plot the original and rotated ellipses
% f = figure(1);
% clf(f)
% view(3)
% hold on
% plot3(x, y, z, 'b.');  % Original ellipse
% plot3(x_rotated, y_rotated, z_rotated, 'r.');  % Rotated ellipse
% grid on;
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Original and Rotated Ellipses');
% legend('Original', 'Rotated');
% 
% pause(0.05);

