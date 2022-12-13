function main_rk4()
    syms f(x) g(x);
    mu = 0.012277471;
    muhat = 1 - mu;
  
    eq1 = f + 2*diff(g) - muhat*((f + mu)/((f+mu)^2 + g^2)^(3/2)) - mu*((f - muhat)/((f - muhat).^2 + g.^2).^(3/2)) == diff(f,2);   % setup equation given
    eq2 = g - 2*diff(f) - muhat*(g/(((f + mu).^2 + g.^2).^(3/2))) - mu*(g/(((f - muhat).^2 + g.^2).^(3/2))) == diff(g, 2);
    f0 = 0.994;
    fdiff0 = 0;
    g0 = 0;
    gdiff0 = -2.001585106379082522420537862224;
    
    yinitial = [f0, fdiff0, g0, gdiff0];     
    [teq1] = odeToVectorField([eq1, eq2])   ;     % convert to first ode
    func = matlabFunction(teq1, 'vars', {'t', 'Y'})    

    points_100 = rungeee(func, yinitial, [0 17.1], 100);     
    f_100 = points_100(:, 1)';
    g_100 = points_100(:, 3)';

    figure;
    plot( g_100,f_100, 'k');
    xlabel("equation 2");
    ylabel("equation 1");
    title("stepsize = 100");

    points_1000 = rungeee(func, yinitial, [0 17.1], 1000);
    f_1000 = points_1000(:, 1)';
    g_1000 = points_1000(:, 3)';
    figure;
    plot(g_1000, f_1000, 'm');
    xlabel("equation 2");
    ylabel("equation 1");
    title("stepsize = 1000");

    points_10000 = rungeee(func, yinitial, [0 17.1], 10000);
    f_10000 = points_10000(:, 1)';
    g_10000 = points_10000(:, 3)';
    figure;
    plot(g_10000, f_10000, 'r');
    xlabel("equation 2");
    ylabel("equation 1");
    title("stepsize = 10,000");

    points_20000 = rungeee(func, yinitial, [0 17.1], 20000);
    f_20000 = points_20000(:, 1)';
    g_20000 = points_20000(:, 3)';
    figure;
    plot(g_20000, f_20000, 'b');
    xlabel("equation 2");
    ylabel("equation 1");
    title("stepsize = 20, 000");
    
end

function y_vals = rungeee(func, yinitial, bounds, n)
    h = (bounds(1) + bounds(2))/n;
    t_vals = bounds(1):h:bounds(2);
    y_vals(1,:) = yinitial;
    for i = 1: length(t_vals)-1
        Y1 = y_vals(i,:);
        Y2 = y_vals(i,:) + h/2*func(t_vals(i), Y1)';
        Y3 = y_vals(i,:) + h/2*func(t_vals(i)/2, Y2)';
        Y4 = y_vals(i,:) + h*func(t_vals(i)/2, Y3)';
        y_vals(i+1,:) = y_vals(i,:) + h/6*(func(t_vals(i), Y1)' + 2*func(t_vals(i)+h/2, Y2)' + 2*func(t_vals(i)+h/2, Y3)' + func(t_vals(i+1), Y4)');
    end
end