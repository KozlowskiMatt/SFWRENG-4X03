function main_newton()

syms x1 x2 x3 x4
tol = 1e-6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   part A

eq1 = x1 + x2*(x2*(5-x2)-2)-13;
eq2 = x1 + x2*(x2*(1+x2)-14)-29;
parta_start = [15 -2];

options=optimset('Display','iter'); 
[newton_xa, newton_counta] = newtons_method([eq1; eq2], [x1, x2], parta_start, tol);
parta_funcs = @(x)[x(1) + x(2)*(x(2)*(5-x(2))-2)-13; 
            x(1) + x(2)*(x(2)*(1+x(2))-14)-29];
[xparta,fvalparta,exit,outputa] = fsolve(parta_funcs, parta_start,options);


fprintf('Part A -- fsolve: Number of Iterations = %d\t x-values = %.8f %.8f \n',outputa.iterations, xparta(1),xparta(2));
fprintf('Part A -- Newtons: Number of Iterations = %d\t x-values = %.8f %.8f \n',newton_counta, newton_xa(1),newton_xa(2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     part B

eq3 = x1^2 + x2^2 + x3^2 - 5;   
eq4 = x1 + x2 - 1;
eq5 = x1 + x3 - 3;
partb_start = [(1+sqrt(3))/2, (1-sqrt(3))/2, sqrt(3)];

[newton_xb, newton_countb] = newtons_method([eq3; eq4; eq5], [x1, x2, x3], partb_start, tol)
partb_funcs = @(x)[x(1)^2 + x(2)^2 + x(3)^2 - 5; 
                        x(1) + x(2) - 1;
                        x(1) + x(3) - 3];
[xpartb,fvalpartb,exit,outputb] = fsolve(partb_funcs, partb_start);

fprintf('Part B: fsolve: Number of Iterations = %d\t x-values = %.8f %.8f %.8f\n', outputb.iterations,xpartb(1),xpartb(2),xpartb(3));
fprintf('Part B: Newtons: Number of Iterations = %d\t x-values = %.8f %.8f %.8f\n',newton_countb, newton_xb(1),newton_xb(2),newton_xb(3));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     partC

eq6 = x1 + 10*x2;
eq7 = sqrt(5)*(x3 - x4);
eq8 = (x2 - x3)^2;
eq9 = sqrt(10)*(x1 - x4)^2;
partc_start = [1, 2, 1, 1];
[newton_xc, newton_countc] = newtons_method([eq6; eq7; eq8; eq9], [x1, x2, x3, x4], partc_start, tol);
partc_funcs = @(x)[x(1) + 10*x(2); 
                       sqrt(5)*(x(3) - x(4));
                       (x(2) - x(3))^2;
                       sqrt(10)*(x(1) - x(4))^2];
[xpartc,fvalpartc,exit,outputc] = fsolve(partc_funcs, partc_start);

fprintf('Part C -- fsolve: Number of Iterations = %d\t x-values = %.8f %.8f %.8f %.8f\n',outputc.iterations, xpartc(1),xpartc(2),xpartc(3), xpartc(4));
fprintf('Part C -- Newtons: Number of Iterations = %d\t x-values = %.8f %.8f %.8f %.8f\n',newton_countc, newton_xc(1),newton_xc(2),newton_xc(3),newton_xc(4));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% part D

eq10 = x1;
eq11 = 10*x1/(x1+0.1)+2*(x2)^2;
partd_start = [1.8, 0];
[newton_xd, newton_countd] = newtons_method([eq10;eq11], [x1, x2], partd_start, tol)
 partd_funcs = @(x)[x(1); 
                       10*x(1)/(x(1)+0.1)+2*(x(2))^2;];
[xpartd,fvalpartd,exit,outputd] = fsolve(partd_funcs, partd_start);

fprintf('Part D -- fsolve: Number of Iterations = %d\t x-values = %.8f %.8f %.8f \n', outputd.iterations, xpartd(1),xpartd(2));
fprintf('\nPart D -- Newtons: Number of Iterations = %d\t x-values = %.8f %.8f %.8f \n', newton_countc,newton_xd(1),newton_xd(2));
    

end



function [x_vals, count] = newtons_method(eq, var, start_x, tol)
    curr_x = start_x;
    jacob = jacobian(eq, var);
    accuracy = double(norm(subs(eq, var, curr_x)));
    count = -1;
    while(accuracy > tol)
        j_vals = double(subs(jacob, var, curr_x));
        f_vals = double(subs(eq, var, curr_x));
        accuracy = norm(f_vals);
        step = -(j_vals\f_vals);
        next_x = curr_x + step';
        curr_x = next_x;
        count = count + 1;
    end
    x_vals = curr_x;
end