 !  Universidad Nacional de Colombia 
 !  Dinamica de fluidos Computacional
 ! ------------------------------------------------------------------
 !  Tarea 1:   Movimiento de una esfera en un medio fluido                    
 !  Autor:     Leonardo Correa  
 !  Fecha:     15/03/2018
 !  Versión:   V02
 ! ------------------------------------------------------------------  
 !  Este programa calcula mediante tres metodos numericos                    
 !  [Runge kutta 4 orden, Euler Forward y Euler Backward]                  
 !  como varia la velocidad y la posicion  horizontal y vertical 
 !  de una esfera en un medio fluido, cuya velocidad NO es
 !  constante en ninguna direccion                                     
 ! ------------------------------------------------------------------
 
program hw1CFD

implicit none
integer, parameter::np=16 ! np = 4 para simple precisión,
                          ! np = 8 para doble precisión,
                          ! np = 16 para cuadruple precisión.
                            
real(kind=np):: t0,u,x,Ueb,Uef,Xeb,Xef,tf,h,k1,k2,k3,k4,f,VfluidX,Vfx
real(kind=np):: v,y,Uyeb,Uyef,Yeb,Yef,k1y,k2y,k3y,k4y,fy,VfluidY,Vfy
real(kind=np):: errorUef,errorUeb,errorXef,errorXeb,abs
real(kind=np):: errorUyef,errorUyeb,errorYef,errorYeb
real(kind=np):: k1x,k2x,k3x,k4x,k1yy,k2yy,k3yy,k4yy,vart(26)
integer:: n,int,i,s
 
!Inicializacion de variables
 t0=0.0D0        ;u=0.0D0         ;x=0.0D0        ;Ueb=0.0D0       ;Uef=0.0D0  
 Xeb=0.0D0       ;Xef=0.0D0       ;tf=0.0D0       ;h=0.0D0        ;k1=0.0D0   ;k2=0.0D0 
 k3=0.0D0        ;k4=0.0D0       !;f=0.0D0        ;VfluidX=0.0D0  ;Vfx=0.0D0
 v=0.0D0         ;y=0.0D0         ;Uyeb=0.0D0     ;Uyef=0.0D0     ;Yeb=0.0D0  ;Yef=0.0D0  
 k1y=0.0D0       ;k2y=0.0D0       ;k3y=0.0D0      ;k4y=0.0D0     !;fy=0.0D0   ;VfluidY=0.0D0 ;Vfy=0.0D0
 errorUef=0.0D0  ;errorUeb=0.0D0  ;errorXef=0.0D0 ;errorXeb=0.0D0
 errorUyef=0.0D0 ;errorUyeb=0.0D0 ;errorYef=0.0D0 ;errorYeb=0.0D0 
 k1x=0.0D0       ;k2x=0.0D0       ;k3x=0.0D0      ;k4x=0.0D0      ;k1yy=0.0D0 ;k2yy=0.0D0 ;k3yy=0.0D0 ;k4yy=0.0D0
 n=0.0D0         ;i=0.0D0;
 

 x=0.1D0;Xeb=0.1D0;Xef=0.1D0;y=0.0D0;Yeb=0.0D0;Yef=0.0D0 !Ubicacion inicial de la particula
 u=0.1D0;u=Ueb    ;u=Uef    ;u=v    ;u=Uyeb   ;u=Uyef    !Velocidad inicial de la particula
 !---------------------------------------------------------------------------------------------------------
 !Se abren los archivos para guardar resultados 
 open(unit=1,file="hw1[Results01]-V01") ! abre el documento para guardar los datos obtenidos de POSICION X Y
 open(unit=2,file="hw1[Results02]-V01") ! abre el documento para guardar los datos obtenidos de VELOCIDAD X Y
 
 !Formatos de escritura
  97 format (2x,A25,3x,f5.3)
  98 format (11(4x,A10))
  99 format (11(4x,A12))
 100 format (4x,f10.2,10(4x,ES10.3))
 101 format (3x,f12.2,10(4x,ES12.3))
 !---------------------------------------------------------------------------------------------------------
 
 
 !lee los datos necesarios para correr la simulacion
 
  open(unit=10,file="1hm[datain]-V01.txt",status="old")
     do s=1,26
        read(10,*)vart(s) !leyendo los datos del documento 10 y asignadolos al vector var() en la posicion i
     end do
     t0=vart(24);tf=vart(26);h=vart(22)

     n=int((tf-t0)/h)
   write(*,*) ' '
   write(*,*) 'numero de iteraciones a realizar:',n
   write(*,*) ' '
  close(10)

 
 
 
 !------------------------------------------------------------------------------------------------------------------------------------
 !Escribir encabezado RESULTADOS
 !-----------------Encabezado documento RESULTADOS-01 datos de Desplazamiento-----------------
 write(1,"(40x,A75)") "TAREA 1[Movimiento de una esfera en un medio fluido]: datos POSICION X-Y" 
 write(1,*) "----------------------------------------------&
 ----------------------------------------------------------&
 ----------------------------------------------------------"
 
 write(1,98)"T[s]","X(EF)[m]","Y(EF)[m]","X(EB)[m]","Y(EB)[m]","X(RK4)[m]","Y(RK4)[m]","ErrX-EF","ErrY-EF","ErrX-EB","ErrY-EB" 
 write(1,*) "----------------------------------------------&
 ----------------------------------------------------------&
 ----------------------------------------------------------"

 
 !-----------------Encabezado documento RESULTADOS-02 datos de Velocidad-----------------
 write(2,"(50x,A75)") "TAREA 1[Movimiento de una esfera en un medio fluido]: datos VELOCIDAD X-Y" 
 write(2,*) "----------------------------------------------------&
 ----------------------------------------------------------------&
 ----------------------------------------------------------------"
 
 write(2,99)"T[s]","Vx(EF)[m/s]","Vy(EF)[m/s]","Vx(EB)[m/s]","Vy(EB)[m/s]","Vx(RK4)[m/s]","Vy(RK4)[m/s]","ErrVx-EF",&
 "ErrVy-EF","ErrVx-EB","ErrVy-EB" 
 write(2,*) "----------------------------------------------------&
 ----------------------------------------------------------------&
 ----------------------------------------------------------------"
 !------------------------------------------------------------------------------------------------------------------------------------
   
   
   
   do i=1,n
   
        Vfx=VfluidX(x,y,t0)!Velocidad del fluido claculada con los datos x,y obtenidos en RK4
        Vfy=VfluidY(x,y,t0)!Velocidad del fluido claculada con los datos x,y obtenidos en RK4
      
      !---------------------------------------------------------------
      !Metodo EULER FORWARD Velocidad-posicion 
      !Direccion X
        Uef=Uef+( h*f(t0,Uef,Vfx) ) 
        Xef=Xef+(h*Uef)
      !Direccion Y
        Uyef=Uyef+( h*fy(t0,Uyef,Vfy) ) 
        Yef=Yef+(h*Uyef)
      !---------------------------------------------------------------
    
      !---------------------------------------------------------------
      !Metodo RK 4 ORDEN Velocidad 
      !Direccion X
        k1=h*f(t0,u,Vfx)
        k2=h*f(t0+(0.5*h),u+(0.5*k1),Vfx)
        k3=h*f(t0+(0.5*h),u+(0.5*k2),Vfx)
        k4=h*f(t0+h,u+k3,Vfx)
        t0=t0+h !Variacion de tiempo utilizada para los tres metodos
        u=u+(k1+(2.0*k2)+(2.0*k3)+k4)*(1.0/6.0)
      !Direccion Y 
        k1y=h*fy(t0,v,Vfy)
        k2y=h*fy(t0+(0.5*h),v+(0.5*k1y),Vfy)
        k3y=h*fy(t0+(0.5*h),v+(0.5*k2y),Vfy)
        k4y=h*fy(t0+h,v+k3y,Vfy)
        v=v+(k1y+(2.0*k2y)+(2.0*k3y)+k4y)*(1.0/6.0)     
      !---------------------------------------------------------------
    
      !---------------------------------------------------------------
      !Metodo RK 4 ORDEN posicion 
      !Direccion X
        k1x=h*u
        k2x=h*(u+(0.5*k1x))
        k3x=h*(u+(0.5*k2x))
        k4x=h*(u+k3x)
        x=x+(k1x+(2.0*k2x)+(2.0*k3x)+k4x)*(1.0/6.0)
      !Direccion Y 
        k1yy=h*v
        k2yy=h*(v+(0.5*k1yy))
        k3yy=h*(v+(0.5*k2yy))
        k4yy=h*(v+k3yy)
        y=y+(k1yy+(2.0*k2yy)+(2.0*k3yy)+k4yy)*(1.0/6.0)
      !---------------------------------------------------------------
    
      !---------------------------------------------------------------
      !Metodo EULER BACKWARD Velocidad-posicion usando la prediccion de Euler Forward
      !Direccion X
        Ueb=Ueb+( h*f(t0,Uef,Vfx) )
        Xeb=Xeb+(h*Ueb)
      !Direccion Y
        Uyeb=Uyeb+( h*fy(t0,Uyef,Vfy) )
        Yeb=Yeb+(h*Uyeb)
      !---------------------------------------------------------------
    
    
      !-------------------------ERRORES-------------------------------
      !---------------------------------------------------------------
      !Calculo de los errores VEL,OCIDAD 
      !Direccion X
        errorUef=abs(u-Uef)
        errorUeb=abs(u-Ueb)
      !Direccion Y  
        errorUyef=abs(v-Uyef)
        errorUyeb=abs(v-Uyeb)
        
      !Calculo de los errores POSICION 
      !Direccion X
        errorXef=abs(x-Xef)
        errorXeb=abs(x-Xeb)
      !Direccion Y
        errorYef=abs(y-Yef)
        errorYeb=abs(y-Yeb)        
      !---------------------------------------------------------------
      !---------------------------------------------------------------
       write(1,100) t0,Xef,Yef,Xeb,Yeb,x,y,errorXef,errorYef,errorXeb,errorYeb 
       write(2,101) t0,Uef,Uyef,Ueb,Uyeb,u,v,errorUef,errorUyef,errorUeb,errorUyeb
       
   end do
    
 !cierra los archivos donde se guardaron los datos obtenidos
 close(1); close(2)
 
  open(unit=1,file="hw1[Reporte-Datos]-V00") ! Archivo con reporte general de datos usados para obtención de resultados
    write(1,"(40x,A75)") "Archivo con reporte general de datos usados para obtención de resultados" 
    write(1,*) "----------------------------------------------&
    ----------------------------------------------------------&
    ----------------------------------------------------------";
    write(1,97) "Tiempo caracteristico",h
    write(1,97) "Valor A0",vart(14);write(1,97) "frecuencia temporal w",vart(20) 
    write(1,97) "Kx",vart(16); write(1,97) "Ky",vart(18)
 close(1)
 
 
 
 write(*,*) "programa ejecutado con exito"
 write(*,*) ' '

 
 
 
 
!--------------------------------------- GRAFICAS ---------------------------------------------------------- 
!-----------------------------------------------------------------------------------------------------------
!Grafica datos POSICION
 call system ("gnuplot -p SCRIPT-hw1[Results01]-V01.gp")
!Grafica datos VELOCIDAD
 call system ("gnuplot -p SCRIPT-hw1[Results02]-V01.gp")
!-----------------------------------------------------------------------------------------------------------
!-----------------------------------------------------------------------------------------------------------







end program hw1CFD


!-----------------------------------------------------------------------------------------------------------
!Funcion VELOCIDAD fluido en X
!Valor kind tiene que ser igual al valor np definido al inicio del programa
real(kind=16) function VfluidX(x,y,t)
implicit none  
real(kind=16)::x,y,t,sin
integer:: i
real(kind=16):: var(20)

 open(unit=10,file="1hm[datain]-V01.txt",status="old")
     do i=1,20
        read(10,*)var(i) !leyendo los datos del documento 10 y asignadolos al vector var() en la posicion i
     end do
   VfluidX= ( (var(14))/(var(16)) ) * ( sin(var(20)*t) ) * ( sin(var(16)*x) ) * ( sin(var(18)*y) )
 close(10)
 
end function
!-----------------------------------------------------------------------------------------------------------


!-----------------------------------------------------------------------------------------------------------
!Funcion VELOCIDAD fluido en Y
!Valor kind tiene que ser igual al valor np definido al inicio del programa
real(kind=16) function VfluidY(x,y,t)
implicit none  
real(kind=16)::x,y,t,sin,cos
integer:: i
real(kind=16):: var(20)

 open(unit=10,file="1hm[datain]-V01.txt",status="old")
     do i=1,20
        read(10,*)var(i) !leyendo los datos del documento 10 y asignadolos al vector var() en la posicion i
     end do
   VfluidY= ( (var(14))/(var(18)) ) * ( sin(var(20)*t) ) * ( cos(var(16)*x) ) * ( cos(var(18)*y) )
 close(10)
 
end function
!-----------------------------------------------------------------------------------------------------------


!-----------------------------------------------------------------------------------------------------------
!Funcion direccion en X
!Valor kind tiene que ser igual al valor np definido al inicio del programa
real(kind=16) function f(t,u,Vfx)
implicit none  
real(kind=16)::u,t,Vfx 
integer:: i
real(kind=16):: var(10)
real(kind=16), parameter:: PI=4.0D0*atan(1.0D0)

 open(unit=10,file="1hm[datain]-V01.txt",status="old")
     do i=1,10
        read(10,*)var(i) !leyendo los datos del documento 10 y asignadolos al vector var() en la posicion i
     end do
     
       if (Vfx>=u) then 
          f=(   ( var(2)*var(4)*(PI)*var(6)**2 ) / ( 2.0*var(8) )   ) *  (( Vfx-u )**2 )+ (0*t)
       else
          f=-(   ( var(2)*var(4)*(PI)*var(6)**2 ) / ( 2.0*var(8) )   ) * (( Vfx-u )**2 )+ (0*t)
       end if
       
 close(10)
 
end function
!-----------------------------------------------------------------------------------------------------------
  
  
!-----------------------------------------------------------------------------------------------------------
!Funcion direccion en Y
!Valor kind tiene que ser igual al valor np definido al inicio del programa
real(kind=16) function fy(t,v,Vfy)
implicit none  
real(kind=16)::v,t,f,Vol_esf,Vfy
integer:: i
real(kind=16):: var(12)
real(kind=16), parameter:: PI=4.0D0*atan(1.0D0)
real(kind=16), parameter:: g=9.81 

 open(unit=10,file="1hm[datain]-V01.txt",status="old")
     do i=1,12
        read(10,*)var(i) !leyendo los datos del documento 10 y asignadolos al vector var() en la posicion i
     end do
 
 Vol_esf=(4/3)*PI*(var(6)**3) 
   
     if (Vfy>=v) then 
        ! peso +        fuerza_flotacion       +                          Fuerza de arrastre
        fy= -g + (  var(2)*Vol_esf*g/var(8)  ) + (   ( var(2)*var(12)*(PI)*var(6)**2 ) / ( 2.0*var(8) )  ) * ((Vfy-v)**2) + (0*t)
     else
        fy= -g + (  var(2)*Vol_esf*g/var(8)  ) - (   ( var(2)*var(12)*(PI)*var(6)**2 ) / ( 2.0*var(8) )  ) * ((Vfy-v)**2) + (0*t)
     end if  
   
 close(10)
 
end function
!-----------------------------------------------------------------------------------------------------------