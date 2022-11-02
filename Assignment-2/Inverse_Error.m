clear all;
n = 700;
m = 4;
for i=1:m
    A = rand(n,n);
    tic;
    B=inverse(A);
    time(i) = toc;
    Ainv = inv(A);
    error(i) = norm(B-Ainv,inf)/norm(Ainv,inf);
    N(i) = n;
    n = 2*n;
    if (i==1)
        fprintf("n = %4d  time = % .1e                   error = %.2e\n",N(i),time(i),error(i));
    else
        fprintf("n = %4d  time = % .1e   ratio=%5.1f     error = %.2e\n",N(i),time(i),time(i)/time(i-1),error(i));
    end
end
