%Funcion que calcula el cambio en la pendiente para cierto cambio en una  %
%curva cerrada o abierta. La funci�n recibe los parametros "y" y "x", que %
%suponen estan orientados al plano cartesiano y que tienen el orden de la %
%curva, adem�s, el tercer par�metro sirve para determinar si los pixeles  %
%pertenecen a una curva cerrada (0) o abierta (1 o cualquier otro valor). %
%El c�lculo se realiza a base de vectores y condiciones en los �ngulos.   %

function alphaN=SCCF(y,x,p)

    n=size(y,1);
    
    %Para curvas cerradas
    if p==0
        
        %Una curva cerrada no puede tener menos de 3 puntos
        if n<3
            
            %disp('Insuficientes puntos para curva cerrada');
            alpha=0;
            
        else
            
            %Se aumenta el vector de "y" y "x" para trabajar con los
            %extremos
            yc=y(1,1); xc=x(1,1);
            yc2=y(2,1); xc2=x(2,1);
            y(n+1,1)=yc(1,1); x(n+1,1)=xc(1,1);
            y(n+2,1)=yc2(1,1); x(n+2,1)=xc2(1,1);%%% editar?
            
            %Como la curva es cerrada, el n�mero de cambios es igual al
            %n�mero de puntos
            alphaG=zeros(1,n);
            alphaN=zeros(1,n);
            
            for i=1:n
                
                %Se calcula el vector 1 y 2 que forman el �ngulo
                y1=y(i+1)-y(i); x1=x(i+1)-x(i);
                y2=y(i+2)-y(i+1); x2=x(i+2)-x(i+1);
                
                %Condiciones al �ngulo del primer vector
                
                if y1==0
                    
                    if x1>0
                        tetha1=0; %Sobre el eje x positivo
                    else
                        tetha1=180; %Sobre el eje x negativo
                    end
                    
                else
                   
                    if y1>0
                        
                        if x1==0
                            tetha1=90; %Sobre el eje y positivo
                        else
                            if x1>0
                                tetha1=atand(y1/x1); %Primer cuadrante
                            else
                                tetha1=atand(y1/x1)+180; %Segundo cuadrante
                            end
                        end
                        
                    else
                        
                        if x1==0
                            tetha1=270; %Sobre el eje y negativo
                        else
                            if x1>0
                                tetha1=atand(y1/x1)+360; %Cuarto cuadrante
                            else
                                tetha1=atand(y1/x1)+180; %Tercer cuadrante
                            end
                        end
                        
                    end
                    
                end
                
                %Condiciones del �ngulo del segundo vector
                
                if y2==0
                    
                    if x2>0
                        tetha2=0; %Sobre eje x positivo
                    else
                        tetha2=180; %Sobre el eje x negativo
                    end
                    
                else
                   
                    if y2>0
                        
                        if x2==0
                            tetha2=90; %Sobre el eje y positivo
                        else
                            if x2>0
                                tetha2=atand(y2/x2); %Primer cuadrante
                            else
                                tetha2=atand(y2/x2)+180; %Segundo cuadrante
                            end
                        end
                        
                    else
                        
                        if x2==0
                            tetha2=270; %Sobre el eje y negativo
                        else
                            if x2>0
                                tetha2=atand(y2/x2)+360; %Cuarto cuadrante
                            else
                                tetha2=atand(y2/x2)+180; %Tercer cuadrante
                            end
                        end
                        
                    end
                    
                end
                
                %Se calcula el angulo que va del vector 1 al vector 2
                ang=tetha2-tetha1;
                
                %Condiciones para que el �ngulo permanezca entre -180 y 180
                if ang>180
                    ang=ang-360;
                end
                if ang<-180
                    ang=360+ang;
                end
                
                %Calculo del �ngulo de contingencia entre -1 y 1
                %alpha(i)=ang/180;
                alphaG(i)=ang;
                alphaN(i)=ang/180;
                
            end
            
        end
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
    else %Si la curva es abierta
        
        %No se puede tener un �ngulo de contingencia con menos de 3 puntos
        if n<2
            
            %disp('Insuficientes puntos para curva abierta');
            alpha=0;
          
            
        else
            
            %Como la curva es abierta se pueden tener 2 cambios menos que
            %el n�mero de puntos de la curva
            alpha=zeros(1,n-2);
            
            for i=1:n-2
                
                %C�lculo de vector 1 y vector 2
                y1=y(i+1)-y(i); x1=x(i+1)-x(i);
                y2=y(i+2)-y(i+1); x2=x(i+2)-x(i+1);
                
                %Condiciones al �ngulo del vector 1
                
                if y1==0
                    
                    if x1>0
                        tetha1=0; %Sobre el eje x positivo
                    else
                        tetha1=180; %Sobre el eje x negativo
                    end
                    
                else
                   
                    if y1>0
                        
                        if x1==0
                            tetha1=90; %Sobre el eje y positivo
                        else
                            if x1>0
                                tetha1=atand(y1/x1); %Primer cuadrante
                            else
                                tetha1=atand(y1/x1)+180; %Segundo cuadrante
                            end
                        end
                        
                    else
                        
                        if x1==0
                            tetha1=270; %Sobre el eje y negativo
                        else
                            if x1>0
                                tetha1=atand(y1/x1)+360; %Cuarto cuadrante
                            else
                                tetha1=atand(y1/x1)+180; %Tercer cuadrante
                            end
                        end
                        
                    end
                    
                end
                
                %Condiciones del �ngulo del vector 2
                
                if y2==0
                    
                    if x2>0
                        tetha2=0; %Sobre el eje x positivo
                    else
                        tetha2=180; %Sobre el eje x negativo
                    end
                    
                else
                   
                    if y2>0
                        
                        if x2==0
                            tetha2=90; %Sobre el eje y positivo
                        else
                            if x2>0
                                tetha2=atand(y2/x2); %Primer cuadrante
                            else
                                tetha2=atand(y2/x2)+180; %Segundo cuadrante
                            end
                        end
                        
                    else
                        
                        if x2==0
                            tetha2=270; %Sobre el eje y negativo
                        else
                            if x2>0
                                tetha2=atand(y2/x2)+360; %Cuarto cuadrante
                            else
                                tetha2=atand(y2/x2)+180; %Tercer cuadrante
                            end
                        end
                        
                    end
                    
                end
                
                %Calculo del �ngulo que va del vector 1 al vector 2
                ang=tetha2-tetha1;
                
                %Condiciones para que el �ngulo est� entre -180 y 180
                if ang>180
                    ang=ang-360;
                end
                if ang<-180
                    ang=360+ang;
                end
                
                %C�lculo del angulo de contingencia entre -1 y 1
                alphaG(i)=ang;
                alphaN(i)=ang/180;
                %fprintf(1,'TD GENERAL: %f\n',  alpha(i))
                
            end
            
        end
        
    end
    
end