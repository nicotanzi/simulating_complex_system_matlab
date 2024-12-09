function voto = votar(M,M1,y,x,N,k,incluirse)

    % M es la matriz con el parámetro de las preferencias
    % M1 es la matriz es lo que miran de sus vecinos los votantes al
    % decidir. Con total miopía (m=0) M1 es la matriz de favoritos.
    
    
   vecindario = vecindad(x,y,k,N); % me devuelve la ubicación de cada uno de mis vecinos en una lista
    
   vecinos=length(vecindario); % cantidad total de vecinos inclueyndome a mi (incluso aunque no quiera contar mi intención de voto).
   
   favVecinos = zeros(vecinos,1); % vector con los favoritos de cada uno de su vecindario
   for i = 1:vecinos
       favVecinos(i)=M1(vecindario{i}(2),vecindario{i}(1));
   end
   
   azul=sum(favVecinos==-1);
   verde=sum(favVecinos==0);
   amarillo=sum(favVecinos==1);
   
   if incluirse==0 % Si no me incluyo quito mi intención de voto de la encuesta
       if M1(y,x)==-1
           azul=azul-1;
       end
       if M1(y,x)==0
           verde=verde-1;
       end
       if M1(y,x)==1
           amarillo=amarillo-1;
       end
   end
                     
   
   if M(y,x)<=1/3 % si mi favorito es el azul
       if azul<verde && azul<amarillo % si el azul no tiene chances de ganar en mi vecindario
           voto=0; % voto al verde
       else % sino
           voto=-1; % voto al azul
       end
   end
   
   if M(y,x)>=2/3 %si mi favorito es el amarillo
       if amarillo<verde && amarillo<azul % si el amarillo no tiene chances de ganar
           voto=0; % voto al verde
       else % sino
           voto=1; % voto al amarillo
       end
   end     

   if M(y,x)>1/3 && M(y,x)<2/3 % si mi favorito es el verde
       if verde<amarillo && verde<azul % si el verde sale último en mi vecindario
           if M(y,x)<0.5 % si mi segundo mejor es el azul
               voto=-1; % voto al azul
           else % sino
               voto=1; % voto al amarrillo
           end
       else % y si el verde sale segundo o primero en mi vecindario
           voto=0; % voto al verde
       end
   end  
    
end
