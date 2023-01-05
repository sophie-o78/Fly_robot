%exo1
function res= DCT(N,f)
%  
for k=0:N
    cumul=0;
    res=zeros(N);
    for n= 0:N-1
        cumul= cumul+ f *cos( pi*k*(2*n+1)/(2*N));
        if k==0
            c=1/sqrt(2);
        else
            c=1;
        end
    end
    res(k)=2*c*cumul/N;
end
end

