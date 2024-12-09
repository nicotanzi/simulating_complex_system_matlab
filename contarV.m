function resultado = contarV(M,N)
    Az=sum(sum(M==-1))/(N^2)*100;
    Ve=sum(sum(M==0))/(N^2)*100;
    Am=sum(sum(M==1))/(N^2)*100;
    resultado=[Az Ve Am];
end

