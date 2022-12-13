function y = main_simpson(a,b)
    global  xpoints;
    
    func = @(x) sin(1./x)
    actual = integral(func,a,b)
    comp_error = 1;
    n_comp=0;
    tol = 1e-04;
    
    xpoints = [a,b];
    [adaptive_integral,n_adap,funs] = ad_simpson(func, a, b, tol, 0, 1000, 0 );
    
    if mod(n_adap,2) == 1 %%ensure it is even and take conservative approach
        n_adap = n_adap+1;
    end

    adap_error = vpa(abs(actual - adaptive_integral));
    
    while (comp_error > tol)
        n_comp = n_comp+2;
        comp_integral = func(a);
        delta_x = (b-a)/n_comp;
        for i=1:(n_comp-1)
            x = a +i*delta_x;
            if (mod(i,2) == 1)
                comp_integral = comp_integral + 4*func(x);
            else
                comp_integral = comp_integral + 2*func(x);
            end
        end
        comp_integral = comp_integral + func(b);
        comp_integral = (delta_x/3)*comp_integral;
        %calculate error again
        comp_error = vpa(abs(actual - comp_integral));
    end
    
    
    fprintf("composite n = %d\t error = %e\t adaptive n = %d\t error = %e\n",n_comp,comp_error,n_adap,adap_error)
    
    plot(xpoints, func(xpoints), 'r*')
    hold on
    fplot(func, [a,b],'b')
    z = zeros(length(xpoints),1);
    plot(xpoints, z, 'xr')
    title('Adaptive simpson on sin(1/x)')
end
