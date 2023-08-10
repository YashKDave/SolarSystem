function [dX] = propagate(t, X, mass, G)
    % Function is called with ODE45 to propagate N-Body Simulation
    % X contains pos/vel values  as [X, Y, Z, dx, dy, dz]
    
    N = length(X)/6;
    x = X(1:N);
    y = X(N + 1:2*N);
    z = X(2*N + 1:3*N);

    pos = [x, y, z]';
    acc = getAcceleration(pos, mass, G);

    for i = 1:3*N
        dX(i) = X(3*N + i);
    end

    for i = 1:N
        dX(3*N + i) = acc(i,1);
        dX(4*N + i) = acc(i,2);
        dX(5*N + i) = acc(i,3);
    end

    dX = dX';
    
end