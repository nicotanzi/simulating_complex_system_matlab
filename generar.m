% GENERAR función que me crea una matriz según los siguientes parámetros:
% P(x<0.333)  probabilidad de que azul sea tu favorito
% P(x>0.666) probabilidad de que amarillo sea tu favorito
% P(x<0.5 | 0.33<x>0.66)  probabilidad de que tu segundo mejor sea el azul
% dado que sos verde
% tamaño de la matriz

function M = generar(Paz,Pam,Saz,N)

    M=zeros(N,N);
    
    Pverde=1-Pam-Paz;
    VerAz=Paz+Pverde*Saz;
    
    for y = 1:N
        for x = 1:N
            M(y,x)=bolillero(Paz,Pam,VerAz);
        end
    end

end

