
set multiplot


## GRAPH 1 ###########################################################################################################################################

## Size and origin
 set size 0.5,0.5
 set origin 0,0.5
 
## Customization
 set title  "Posicion X Vs Tiempo"
 set xlabel "Tiempo[s]"
 set ylabel "Posicion X[m]"
 set autoscale
 set key left box

plot "/home/leopc/Documents/MCF-2018/1.HW CFD/1.HW/V02/hw1[Results01]-V01" using 1:6 lc 8 lw 1 pt 0 ps 5 with lines title 'Runge-Kutta 4od' , \
     "/home/leopc/Documents/MCF-2018/1.HW CFD/1.HW/V02/hw1[Results01]-V01" using 1:2 lc 7 lw 1 pt 0 ps 5 with lines title 'Euler Forward' , \
     "/home/leopc/Documents/MCF-2018/1.HW CFD/1.HW/V02/hw1[Results01]-V01" using 1:4 lc 6 lw 1 pt 0 ps 5 with lines title 'Euler Backward'
     
        
######################################################################################################################################################


## GRAPH 2 ###########################################################################################################################################

## Size and origin
 set size 0.5,0.5
 set origin 0.5,0.5
 
## Customization
 set title  "Posicion Y Vs Tiempo"
 set xlabel "Tiempo[s]"
 set ylabel "Posicion Y[m]"
 set autoscale
 set key right box

     
plot "/home/leopc/Documents/MCF-2018/1.HW CFD/1.HW/V02/hw1[Results01]-V01" using 1:7 lc 8 lw 1 pt 0 ps 5 with lines title 'Runge-Kutta 4od' , \
     "/home/leopc/Documents/MCF-2018/1.HW CFD/1.HW/V02/hw1[Results01]-V01" using 1:3 lc 7 lw 1 pt 0 ps 5 with lines title 'Euler Forward' , \
     "/home/leopc/Documents/MCF-2018/1.HW CFD/1.HW/V02/hw1[Results01]-V01" using 1:5 lc 6 lw 1 pt 0 ps 5 with lines title 'Euler Backward'
######################################################################################################################################################    


## GRAPH 3 ###########################################################################################################################################

## Size and origin
 set size 0.5,0.5
 set origin 0,0
 
## Customization
 set title  "Error abs Posicion X Vs Tiempo"
 set xlabel "Tiempo[s]"
 set ylabel "Error absoluto posicion X"
 set autoscale
 set key left box

     
plot "/home/leopc/Documents/MCF-2018/1.HW CFD/1.HW/V02/hw1[Results01]-V01" using 1:8  lc 7 lw 1 pt 0 ps 5 with lines title 'Euler Forward' , \
     "/home/leopc/Documents/MCF-2018/1.HW CFD/1.HW/V02/hw1[Results01]-V01" using 1:10 lc 6 lw 1 pt 0 ps 5 with lines title 'Euler Backward' 
###################################################################################################################################################### 


## GRAPH 4 ###########################################################################################################################################

## Size and origin
 set size 0.5,0.5
 set origin 0.5,0
 
## Customization
 set title  "Error abs Posicion Y Vs Tiempo"
 set xlabel "Tiempo[s]"
 set ylabel "Error absoluto posicion Y"
 set autoscale
 set key left box

     
plot "/home/leopc/Documents/MCF-2018/1.HW CFD/1.HW/V02/hw1[Results01]-V01" using 1:9  lc 7 lw 1 pt 0 ps 5 with lines title  'Euler Forward' , \
     "/home/leopc/Documents/MCF-2018/1.HW CFD/1.HW/V02/hw1[Results01]-V01" using 1:11 lc 6 lw 1 pt 0 ps 5 with lines title 'Euler Backward' 
######################################################################################################################################################



   
###################### Set command customization ##############################
###############################################################################

#linecolor | lc 8=rojo, 2=verde, 3=azul, 4=violeta, 5=celeste, 6=naranja ....
#linewidth | lw ancho de linea en orden creciente
#pointtype | pt 0=punto, 1=cruz, 3=aspa, 4=cuadrado hueco..
#pointsize | ps tamaño del punto en orden creciente

      #Create a title:                  > set title "Force-Deflection XXXXXXXXXXx Data" 
      #Put a label on the x-axis:       > set xlabel "Deflection (meters)"
      #Put a label on the y-axis:       > set ylabel "Force (kN)"
      #Change the x-axis range:         > set xrange [0.001:0.005]
      #Change the y-axis range:         > set yrange [20:500]
      #Have Gnuplot determine ranges:   > set autoscale
      #Move the key:                    > set key 0.01,100
      #Delete the key:                  > unset key
      #Put a label on the plot:         > set label "yield point" at 0.003, 260 
      #Remove all labels:               > unset label
      #Plot using log-axes:             > set logscale
      #Plot using log-axes on y-axis:   > unset logscale; set logscale y 
      #Change the tic-marks:            > set xtics (0.002,0.004,0.006,0.008)
      #Return to the default tics:      > unset xtics; set xtics auto 
   
###############################################################################
###############################################################################



