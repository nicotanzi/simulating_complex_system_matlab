function votoE = contarE(M,Mfav,N)
    votoE=zeros(4,1);
    votoE(1) = sum(sum(M~=Mfav))/(N^2)*100;
    for j= -1:1
        votoE(j+3) = 100 * sum(sum( (M~=Mfav).*(Mfav==j) )) / sum(sum( Mfav==j ));
    end
end

