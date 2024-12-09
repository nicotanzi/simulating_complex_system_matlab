function exp = estimar(M1,y,x,N,k,incluirse)
    
    % M es la matriz con el par�metro de las preferencias
    % M1 es la matriz es lo que miran de sus vecinos los votantes al
    % decidir. Con total miop�a (m=0) M1 es la matriz de favoritos.
    
    
   vecindario = vecindad(x,y,k,N); % me devuelve la ubicaci�n de cada uno de mis vecinos en una lista
   
   favVecinos = []; % vector con los favoritos de cada uno de su vecindario
   
   vecinos=length(vecindario); % cantidad total de vecinos inclueyndome a mi (incluso aunque no quiera contar mi intenci�n de voto).
   
   for i = 1:vecinos
       favVecinos(i)=M1(vecindario{i}(2),vecindario{i}(1));
   end
   
   azul=sum(favVecinos==-1);
   verde=sum(favVecinos==0);
   amarillo=sum(favVecinos==1);
   
   if incluirse==0 % Si no me incluyo quito mi intenci�n de voto de la encuesta
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
   
   Nmuestra=vecinos-1+incluirse; % si no me incluyo resto uno
   
   pz=azul/Nmuestra;
   pv=verde/Nmuestra;
   pa=amarillo/Nmuestra;
   
   exp=[pz, pv, pa];
end

