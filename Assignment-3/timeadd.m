clear; close all;
n = [50:50:550];
j=1;
fprintf('\tn\t   time for AddR\t   time for AddC\n')
for i = n
    A = rand(i,i);
    B = rand(i,i);
    time_AddR(j) = timef(1,A,B);
    time_AddC(j) = timef(2,A,B);

    [c_row,k_row] = findcoeff(i,time_AddR(j));
    [c,k_col] = findcoeff(i,time_AddC(j));
    fprintf('\t%d\t\t  %.2e\t\t\t   %.2e\n',i, time_AddR(j), time_AddC(j));
    j = j+1;
end

plot(n,time_AddR,'or', n, time_AddC, '*b');
hold on;
[c_row,k_row] = findcoeff(n,time_AddR);
h1=fplot( @(x) c_row*x.^k_row, [n(1),n(end)], 'r');
hold on;
[c_col,k_col] = findcoeff(n,time_AddC);
h2=fplot( @(x) c_col*x.^k_col, [n(1),n(end)], 'b');
hold on;
s1 = sprintf("AddR       %.1e*n^{%.3f}", c_row, k_row);
s2 = sprintf("AddC         %.1e*n^{%.3f}", c_col, k_col);

fprintf("c_row = %.2e\nk_row = %.2e\nc_col = %.2e\nk_col = %.2e\n",c_row,k_row,c_col,k_col);

legend([h1,h2], s1, s2, 'Location', 'NorthWest', 'FontSize', 12);
set(gca, 'FontSize', 12);
xlabel('n'); ylabel('CPU time')

function [a,b] = findcoeff(n, time)
l = length(n);
B = [ones(l,1) log(n)'];
coeff = B\log(time)';

a = exp(coeff(1));
b = coeff(2);
end
