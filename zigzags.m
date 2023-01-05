% on génère un tableau de taille NxN dont les éléments sont les indices
% de parcours de following the zig zag scan pattern
% N: taille de la matrice
function zz_tab = zigzags(N)
    % Creating a NULL matriz
    zz_tab = zeros(N);
    
    % Generating the first column
    for n = 2:N+1
        zz_tab(n-1, 1) = 1/2*(-1)^n*(n+(-1)^n*((n-2)*n+2)-2);
    end
    
    % Generating the rows recursively
    for i = 1:N
        for j = 2:N
            if ((mod(i, 2) == 0 && mod(j, 2) == 0) || (mod(i, 2) == 1 && mod(j, 2) == 1))
                zz_tab(i, j) = zz_tab(i, j-1) + (2*i-1);
            else 
                zz_tab(i, j) = zz_tab(i, j-1) + (j-1)*2;
            end
        end
    end
    
    % Correcting the elements bellow the secondary diagonal
    zz_tab = fliplr(zz_tab);
    
    for i = 2:N
        for j = 1:N-1
            if i>j
                zz_tab(i, j) = zz_tab(i, j) - (i-j)^2;
            end
        end
    end
    
    % Final zig zag matrix
    zz_tab = fliplr(zz_tab);
    %final table
end