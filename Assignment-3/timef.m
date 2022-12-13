function t = timef(f,A,B)

    switch (f)
        case 1 % AddR
            tic; 
            C = AddR(A, B);  
            t = toc;
            if t > 2 % at least two seconds
                return;
            end
            rep = ceil(2/t);
            [t rep];
            tic;
            for i=1:rep
                C = AddR(A,C);
            end
            t = toc/rep;

        case 2 %% AddC
            tic; 
            C = AddC(A, B);  
            t = toc;
            if t > 2 % at least two seconds
                return;
            end
            rep = ceil(2/t);
            [t rep];
            tic;
            for i=1:rep
                C = AddC(A,C);
            end
            t = toc/rep;

        otherwise
            return
    end
end

