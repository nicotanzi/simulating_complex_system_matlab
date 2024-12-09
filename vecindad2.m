function vecindario = vecindad2(x,y,k,N)
    
    % Cada agente es en esta función un par ordenado. En otras palabras un
    % agente es cu ubicación en la matriz, la fila y la columna en la que
    % pertence.
    
    % Un vecindario en consecuencia es un conjunto de pares ordenados.
    
    % Los argumentos, x e y, son las coordenadas del agente centro del vecindario
    % un vecindario estará compuesto por el y cierta cantidad de vecinos a
    % su alrededor. La cantidad total de vecinos es k*4, la cantidad total
    % de personas en el vecindario es k*4+1

    % Hay dos tipos de vecindarios, uno cuadrado o convexo y otro que es cóncavo
    % Un ejemplo de esto último es cuando hay solo 4 vecinos, uno al norte
    % otro al este otro al sur y el último al oeste.
    % Lo primero que quiero hacer es determinar "la envolvente convexa", o
    % sea el mínimo vecindario cuadrado que engloba al vecindario en
    % cuestión, por ejemplo el mínimo vecindario cuadrado para 4 vecinos,
    % es un cuadrado de 3x3 (recordemos que el medio esta ubicado por el
    % individuo). Otro ejemplo, el mínimo vecindario convexo para 8 vecinos
    % es también el compuesto del cuaadrado de 3x3.
    
    % La cantidad de vecinos está dada por k*4, si incluimos al agente
    % tenemos k*4+1. Por otro lado, los cuadrados como tienen un centro en
    % un agente están dados por un número impar m al cuadrado m^2.
    % Lo cual es lo mismo que introducir la noción de número impar m=2n+1.
    % Y elevarla al cuadrado: (2n+1)^2.
    % Cuando 4k+1=(2n+1)^2 estamos en un k límite. Por ejemplo, k=2, k=6,
    % k=12, k=20, etc.
    
    % Con esto puedo determinar el mínimo cuadrado
    
    nvecindario=4*k+1; % número total de personas
    
    
    
    
    
    % Cuál es el mínimo vecindario cuadrado al que pertenece?
    nconvex=0; %nconvex va a ir tomando los distintos valores de los vecindarios convexos, 9, 25, 49
    anillos=0; 
    while nconvex<nvecindario
        anillos=anillos+1;
        nconvex=(2*anillos+1)^2;
    end
    
    % Cuál es el mínimo vecindario cuadrado al que pertenece?
    % Si nconvex=nvecindario => la rpta es anillos
    % Sino => la rpta es anillos-1
    % Contruyo así la variable ai (anillos interiores)
    if nconvex==nvecindario
        ai=anillos;
    else
        ai=anillos-1;
    end
    
    % Contruyo primero el máximo vecindario convexo interior:
    vecindario_int={};
    
    % Inicializo algunas variables de posición:
    oeste=x;
    este=x;
    norte=y;
    sur=y;
    % Inicializo algunos vectores que guardaran cierta info:
    izq=[];
    der=[];
    arr=[];
    aba=[];
    
    % mod() me da el resto mod(13,4)=1   mod(12,4)=0  mod(4,12)=4  mod(0,12)=0   mod(12,12)=0   mod(-1,12)=11 
    for i = 1:ai
        oeste = mod(oeste-2,N)+1;   % si x=1 N=20 =>  mod(-1,20)=19    
        este = mod(este,N)+1;      % si x=20 N=20 =>  mod(20,20)=0    
        norte = mod(norte-2,N)+1;   % si y=1 N=20 =>  mod(-1,20)=19    
        sur = mod(sur,N)+1;       % si y=20 N=20 =>  mod(20,20)=0 

        izq(i)=oeste;    
        der(i)=este;
        arr(i)=norte;   
        aba(i)=sur;    
    end

    horiz=[];
    for i = 1:ai
        horiz(i)=izq(ai+1-i);    
    end
    horiz(ai+1)=x;
    for i = 1:ai
        horiz(ai+1+i)=der(i);    
    end

    verti=[];
    for i = 1:ai
        verti(i)=arr(ai+1-i);    
    end
    verti(ai+1)=y;
    for i = 1:ai
        verti(ai+1+i)=aba(i);    
    end

    for i = 1:(2*ai+1)
        for j = 1:(2*ai+1)
            vecindario_int{(2*ai+1)*(i-1)+j}=[horiz(i) verti(j)];
        end
    end
    
    
    
    % Ahora contruyo la parte cóncava, si la hay.
    % Tengo un vecindario cuadrado construido. ¿De cuántas personas es?
    % ¿Cuántas me faltan para el vecindario que deseo?
    vi=length(vecindario_int);
    resto=nvecindario-vi;
    
    % Ahora esa cantidad de personas que me falta se distribuirá en los
    % cuatro lados del vecindario.
    f=resto/4;
    
    % Habrá entonces cuatro conjuntos de vecinos extra en cada lado, cada
    % conjunto compartirá cierta ubicación. El lado norte por ejemplo
    % estára ubicado una posición más arriba que la máxima fila del
    % vecindario interior.
    
    oeste = mod(y-anillos,N);
    este = mod(y+anillos,N);
    norte = mod(x+anillos,N);
    sur = mod(x-anillos,N);
    if oeste==0
        oeste=N;
    end
    if este==0
        oste=N;
    end
    if norte==0
        norte=N;
    end
    if sur==0
        sur=N;
    end
    
    
    % Ahora me falta descubrir cuales la otra coordenada de cada vecino, de
    % estos lados del vecindario. Por ejemplo si f=3, en el lado norte uno
    % estará ubicado en la misma columna que el agente centro, otro una
    % columna a la izquierda, otro una columna a la derecha.
    % Entonces en este ejemplo respecto del agente centro: primero 0
    % columnas, luego una a la izquierda (-1), luego 1 a la derecha (+1) y
    % así. Es decir: 1) 0   2) -1   3) +1  4) -2  5) +2  6)-3  ...
    
    mov=[];
    for i = 1:f
        mov(i)=floor(i/2)*(-1)^(i+1); % Esta formula me da 0 -1 +1 -2 +2 etc
    end
    
    posh = mod(y+mov,N); % mod(y,N) va desde 0 a N-1 casi perfecto
    posv = mod(x+mov,N);

    for i = 1:f
        if posh(i)==0
            posh(i)=N;
        end
        if posv(i)==0
            posv(i)=N;
        end
    end
    
    % Ya tengo todo lo necesario para calcular los vecinos de cada lado
    ladonorte={};
    ladosur={};
    ladooeste={};
    ladoeste={};
    for i = 1:f
        ladonorte{i}=[norte posh(i)];
        ladosur{i}=[sur posh(i)];
        ladooeste{i}=[posv(i) oeste];
        ladoeste{i}=[posv(i) este];
    end
    
    % Combino todos los subvecindarios en unos solo
    vecindario=cat(2,vecindario_int,ladonorte,ladosur,ladoeste,ladooeste);  

    
end

