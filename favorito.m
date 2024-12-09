% Matriz de los mejores primeros

function Mfav = favorito(M,N)
    
    Mfav=M;
    for y = 1:N
        for x = 1:N
            if M(y,x) < 1/3
                Mfav(y,x)=-1;
            else
                if M(y,x) > 2/3
                    Mfav(y,x)=1;
                else
                    Mfav(y,x)=0;
                end
            end
        end
    end