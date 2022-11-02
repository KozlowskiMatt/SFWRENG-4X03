function B = inverse(A)
    % Question 1
    % To find the inverse of a matrix A (nxn)
    % using LU with forward and backward sub
    
    [m,N] = size(A);
    [L,U,P] = lu(A);
    %LU = PA
    %Forward sub (%Ly = P)
    y = zeros(N,N);
    B = zeros(N,N);
    for i = 1:N
        for j = 1:N
            y(j,i) = P(j,i) - (L(j,1:j)*y(1:j,i));
        end
    end
    %backward sub (UB = Y)
    for k = 1:N
        B(N,k) = y(N,k)/U(N,N);
        for i = N-1:-1:1
            prev_sum = 0;
            for j = i+1:N
                prev_sum = prev_sum + (U(i,j)*B(j,k));
            end
            B(i,k) = (y(i,k)-prev_sum)/U(i,i);
        end
    end
end