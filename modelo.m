%% Definir par�metros

% Probabilidad de que AZUL sea tu favorito
Paz=0.4;
% Probabilidad de que AMARILLO sea tu favorito
Pam=0.4;
% Probabilidad de que AZUL sea tu SEGUNDO MEJOR dado que sos verde
Saz=0.5;

% Dimensi�n de la matriz ( el n�mero de la poblaci�n ser� N^2)
N=500;
% Numero de vecinos = k*4
k=6;
% Nivel de miop�a (0 es el m�ximo nivel de miop�a; debe ser un n�mero entero)
m=20;

% �Incluirse a si mismo en el conteo de votos?
incluirse = 1;

parametros = {
    'Par�mteros:';
    ['Prob Azul ',num2str(Paz),'   Prob Verde ',num2str(1-Paz-Pam),'   Prob Amarillo ',num2str(Pam)];
    ['Prob Segundo Mejor Azul, Dado Verde ',num2str(Saz),'   Prob Segundo Mejor Amarillo, Dado Verde ',num2str(1-Saz)];
    ['Poblaci�n ',num2str(N^2),'   Miop�a ',num2str(m),'   Tama�o del vecindario ',num2str(4*k+incluirse)];
    ['expectativas incluyen a las propias pref.: ',num2str(incluirse)]
    };

disp(parametros)

% PAR�METRO EXTRA:
% �Quiero guardar los resultados de esta especificaci�n del modelo a parte?
% 1=SI, 0=NO
guardar = 0; 


%% Generar Matrices

% Genero la matriz madre, con el par�metro de preferencias (n�mero real
% entre 0 y 1) de cada individuo.
M=generar(Paz,Pam,Saz,N);

% Genero la matriz de favoritos, que le asigna -1, 0 o 1 seg�n el par�metro
% de preferencias.
Mfav = favorito(M,N);

% �Cu�ntas personas tienen de favorito al partido -1 (Azul)? Y as�...
% Computo las tres respuestas en un vector
favAz=sum(sum(Mfav==-1))/(N^2)*100;
favVe=sum(sum(Mfav==0))/(N^2)*100;
favAm=sum(sum(Mfav==1))/(N^2)*100;
fav=[favAz favVe favAm]

% Creo una cuyas columnas van a ser porcentajes de azules verdes y
% amarillos
Vot=zeros(m+2,3);
% La primer fila va a ser el vector de favoritos.
Vot(1,:)=fav;

% Creo un conjunto, que va a guardar matrices
Mat={};
% La primera matriz ser� la matriz de favoritos.
Mat{1}=Mfav;

%% Votar

% Creo una matriz que muestra a qui�n voto cada uno
% -1 voto azul, 0 voto verde, 1 voto amarillo
Mvoto = votacion(M,Mfav,N,k,incluirse);
% Guardo esa matriz como el segundo elemento en la lista de matrices
Mat{2}=Mvoto;

% Computo los resultados de las votaciones (en %)
votoAz=sum(sum(Mvoto==-1))/(N^2)*100;
votoVe=sum(sum(Mvoto==0))/(N^2)*100;
votoAm=sum(sum(Mvoto==1))/(N^2)*100;
% Lo guardo como un vector
voto=[votoAz votoVe votoAm]
% Al cual guardo en la lista de vectores
Vot(2,:)=voto;


% Repito este proceso si hay muchos niveles de miop�a
for i = 1:m
    Mvoto=votacion(M,Mvoto,N,k,incluirse);
    Mat{2+i}=Mvoto;
    votoAz=sum(sum(Mvoto==-1))/(N^2)*100;
    votoVe=sum(sum(Mvoto==0))/(N^2)*100;
    votoAm=sum(sum(Mvoto==1))/(N^2)*100;
    voto=[votoAz votoVe votoAm]
    Vot(2+i,:)=voto;
end
    
%% Visualizaci�n

if guardar == 1 % si lo queremos guardar aparte
    Carpeta_Nueva = strrep(datestr(datetime), ':', '_'); % La nueva carpeta se va a llamar como la fecha y hora exacta
    mkdir(Carpeta_Nueva); % Creo la nueva carpeta
end

h=figure; % creame una "figura", es decir un lugar donde graficar cosas
filename = 'votacion.gif'; % �C�mo se va a llamar el gif que voy a crear?
for i = 1:(m+2) % i va desde 1 hasta la cantidad de elementos de las listas
    imagesc(Mat{i}) % mostrame la matriz como una imagen con colores en la figura abierta
    votoAz=Vot(i,1); % los votos del azul de la matriz i est�n en el vecctor nro i de la lista de vectores, y son el primer elemento de ese vector
    votoVe=Vot(i,2); % los del verde son el segundo elemento de ese vector
    votoAm=Vot(i,3); % los del amarillo son el tercer elemento de ese vector
    if i == 1 % si estamos en la matriz y vector de favoritos
        title({'Favoritos';'nivel de miop�a: --';['Azul: ',num2str(round(Vot(i,1))),'%   Verde: ',num2str(round(Vot(i,2))),'%   Amarillo: ',num2str(round(Vot(i,3))),'%']}) % Ponemo de t�tulo "Favorito" y mostrame de subt�tulo los % de fav de cada color.
    else % sino
        title({'Votaci�n';['nivel de miop�a: -',num2str(i-1)];['Azul: ',num2str(round(Vot(i,1))),'%   Verde: ',num2str(round(Vot(i,2))),'%   Amarillo: ',num2str(round(Vot(i,3))),'%']}) % Ponemo de t�tulo "Votaci�n", decime en que nivel de miop�a estamos y mostrame de subt�tulo los % de votos de cada color.
    end
    
    % Guardar imagen como jpg
    if guardar == 1
        Imagen = getframe(h); % Agarro la imagen que se muestra en h
        nombre_img = strcat('matriz ',num2str(i),'.jpg'); % Creo el nombre de la imagen 'matriz i.jpg'
        imwrite(Imagen.cdata, nombre_img); % Guardo la imagen
        movefile(nombre_img,Carpeta_Nueva,'f'); % Muevo la imagen a la carpeta nueva
    end

    % Guardar GIF de las imagenes
    drawnow % pasa cada imagen a una parte de un gif
        frame = getframe(h); % agarra el dibujo de la figura
        im = frame2im(frame); % metelo como el primer elemento de un archivo de muchas imagenes
        [imind,cm] = rgb2ind(im,256); 
        % Write to the GIF File 
        if i == 1 
            imwrite(imind,cm,filename,'gif', 'Loopcount',inf);  % imwrite(A,filename) writes image data A to the file specified by filename
        else 
            imwrite(imind,cm,filename,'gif','WriteMode','append'); 
        end 
end
close all;

if guardar == 1 % si lo queremos guardar aparte
    movefile('votacion.gif',Carpeta_Nueva,'f'); % Muevo el gif a la nueva carpeta
    
    % Tambi�n quiero un txt con los par�metros del modelo
    texto = fopen('parametros.txt','wt'); % Creo un txt y lo pongo en modo escritura
    fprintf(texto,'%s\n',string(parametros)); % Escribo los par�metros en el txt
    fclose(texto); % Cierro el txt
    movefile('parametros.txt',Carpeta_Nueva,'f'); % Muevo el texto a la carpeta nueva
    
end

