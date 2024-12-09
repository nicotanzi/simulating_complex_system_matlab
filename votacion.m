% Matriz de votacion

function Mvoto = votacion(M,M1,N,k,incluirse)
    
    Mvoto=M;
    for y = 1:N
        for x = 1:N
            Mvoto(y,x)=votar(M,M1,y,x,N,k,incluirse);
        end
    end
    
end