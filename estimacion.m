function Mexp = estimacion(M1,N,k,incluirse)
    
    Mexp=zeros(N,N,3);
    for y = 1:N
        for x = 1:N
            Mexp(y,x,:)=estimar(M1,y,x,N,k,incluirse);
        end
    end
    
end