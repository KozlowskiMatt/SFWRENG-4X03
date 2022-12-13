function [r,iter] = bisection( f, a, b,  tol )
fa = f (a);
fb = f (b);
if sign(fa) == sign(fb) 
    fprintf('f has the same sign at a = %e b = %e, f(a) = %e, f(b) = %e\n', ...
        a, b, fa, fb);
        r = NaN;
   return
end
error = b - a;
nmax = ceil(log((b-a)/(2*tol))/log(2));
for n = 0 : nmax 
    error = error/2;
    c = a + error;
    fc = f (c);
    if error < tol
        r = c;
        iter=n;
        break;
    end
    if sign(fa) ~= sign(fc) 
        b = c;
        fb = fc;
    else
        a = c; fa = fc;
    end     
end 
