function coef = bolillero(Paz,Pam,VerAz)

    a=rand(1);
    if a<Paz
        coef=rand(1)/3;
    elseif a>1-Pam
        coef=rand(1)/3 + 2/3;
    elseif a<VerAz
        coef=rand(1)/6 +1/3;
    else
        coef=rand(1)/6 +0.5;
    end
        
end

