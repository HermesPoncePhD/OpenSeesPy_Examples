#
# MODELO NUMÉRICO DEL ESPÉCIMEN: FVED1
#
# 
# 
#==================================================================================================
# Unidades Fuerza(N), Distancia(mm), Tiempo(seg), Masa(T)
# [1 N = 1 T.mm/s^2], [1 Ton = 1 N.s^2/mm]
#===============================================================================================================================================================================================================================

wipe; # borra de la memoria modelos anteriores
model BasicBuilder -ndm 3 -ndf 6; # defino el modelo 2d y 3gdl por nudo.
set dataDir OutputsSD3; # asigno el nombre "Outputs" al directorio Outputs.
file mkdir $dataDir; # defino mi directorio de salida de datos.

#                   -----O---------------------O----
#                        |\                    |\
#                        | \                   | \
#                        |  \                  |  \    
#                        ----O---------------------O----
#                    ----O---|-----------------O---|-                                       
#                        |\  |                 |\  |
#                        | \ |                 | \ |                   
#                        |  \|                 |  \|     
#                       -----O-----------------|---O----            
#                        |   |                 |   |                       
#                        |   |                 |   |       		   [Z]         
#                    [1]---  |             [2]---  |       		 	^          
#                            |                     |    		[Y] |                 
#     [Actuador X]--->       |                     |       		   \| 
#                            |                     | 				+----> [X]
#                        [3]---			 ^	   [4]-+-
#									     |					[Coordenadas Globales]
#								         |
#								   [Actuador Y]				 
# ======== [MATERIALES] ========================================================================================================================================================================================================
# Nota: Configurados parte VE para C25. Definir tema de hormigón confinado en secciones fibra.
		
	source "Materials.tcl"
	puts "MATERIALES DEFINIDOS"


# ======== [SECCIONES] =========================================================================================================================================================================================================
# Nota: Están metidas las secciones elásticas de SAP2000 y las no lineales reales a emplear.

	source "Sections.tcl"
	puts "SECCIONES DEFINIDAS"

# ======== [MODELO] ============================================================================================================================================================================================================

# NUDOS-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Nota: Introducidos según salen de SAP2000 y con las masas en las tres direcciones.

	source "Nodes.tcl"
	puts "NUDOS DEFINIDOS"
	set Nudos [getNodeTags]; # Display: Number of nodes
	set ::NodeEnd [lindex $Nudos end]; # :: se utiliza para hacer una variable global
	puts "N de Nudos: $::NodeEnd"; # global NodeEnd

# CONDICIONES DE CONTORNO ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    #  Nudo UX UY UZ RX RY RZ
	fix  1   1  1  1  1  1  1; # Pilar 1
	fix  2   1  1  1  1  1  1; # Pilar 2
	fix  3   1  1  1  1  1  1; # Pilar 3
	fix  4   1  1  1  1  1  1; # Pilar 4
		
	# Rótulas (Liberamos rotaciones en X-Y. Aquí las coordenadas son globales)
    equalDOF 57 121 1 2 3 6
    equalDOF 46 116 1 2 3 6
    equalDOF 58 122 1 2 3 6
	equalDOF 25 107 1 2 3 6
    equalDOF 36 112 1 2 3 6
    equalDOF 47 117 1 2 3 6
    equalDOF 35 111 1 2 3 6
    equalDOF 68 126 1 2 3 6
	
	# Células de carga que rotan en pilar
	rigidLink bar $rNodeTag $cNodeTag;
	rigidLink bar $rNodeTag $cNodeTag;
	rigidLink bar $rNodeTag $cNodeTag;
	rigidLink bar $rNodeTag $cNodeTag;
	
	# El nudo que marca el movimiento será el 127 (CDM - Nudo central de las planchas de acero)
	rigidDiaphragm 3 127 21 22 23 24 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 
	
# TRANSFORMADA GEOMÉTRICA (Matriz de transformación) ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Nota: Controlar que el sentido sea el mismo en los elementos con la misma dirección.
# 		Los disipadores llevan la misma transformada que la viga que tienen encima. No influye su inclinación en el plano, mientras estén en el plano.
# 		Todos los elementos tienen secciones simétricas, por lo que si un elemento en lugar de tener un sentido tuviera otro, simplemente colocaría la sección al revés.

	# Elementos con sección en plano XZ (Elementos dirección -Y - Viga 1, Viga 4, Zuncho 1, Zuncho 4, Nervio DirY, 3 Planchas):
	geomTransf Linear 1  -1  0  0; # z local en  Xglobal
	
	# Elementos con sección en plano YZ (Elementos dirección -X - Viga 2, Viga 3, Zuncho 2, Zuncho 3, Nervio DirX volteado, 2+2 Planchas):
	geomTransf Linear 2  0  1  0; # z local en  Yglobal
	
	# Pilares:
	geomTransf PDelta 3  0  1  0; # z local en  Yglobal Nonlinear-Columns

	# Diagonal P2-P3 para CMD:
	geomTransf Linear 4  -0.5  0.5  0; # z local en  diagonal perfecta del plano XY
	
	# Diagonal P1-P4 para CMD:
	geomTransf Linear 5  -0.5  -0.5  0; # z local en  diagonal perfecta del plano XY
	
# ELEMENTOS (Frames, beams and columns) ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Nota: Solo he introducido los elementos elásticos empleados en SAP2000 para comparar valores iniciales.

	source "EleColumns.tcl"
	source "EleBeams.tcl"
	source "EleShells.tcl"	
	source "EleDampers.tcl"		
	puts "ELEMENTOS DEFINIDOS"
	set Elem [getEleTags]; # Display: Number of elements
	set ElemEnd [lindex $Elem end]
	puts "N de Elementos: $ElemEnd"

# ======== [OUTPUTS] ==========================================================================================================================================================================================================
# Defino los archivos de salida que generará el programa en base a lo que yo le pida.

	source "Recorders.tcl"
	
# ======== [ANALYSIS] ==========================================================================================================================================================================================================	

set TypeAnalysis 4

  if     {$TypeAnalysis == 0} {set AnalysisType "Gravitatory"
} elseif {$TypeAnalysis == 1} {set AnalysisType "Matrix" 
} elseif {$TypeAnalysis == 2} {set AnalysisType "Modal"   
} elseif {$TypeAnalysis == 3} {set AnalysisType "PushOver"
} elseif {$TypeAnalysis == 4} {set AnalysisType "Transient"
}
puts "ANALYSIS TYPE: $AnalysisType"

# ANÁLISIS ESTÁTICO LINEAL < CONTROL DE FUERZAS APLICADAS > (ANÁLISIS GRAVITATORIO) --------------------------------------------------------------------------------------------------------------------------------------------

	wipeAnalysis; # borra los parámetros de análisis antes definidos.

	set StepsF 5; # Número de pasos en los que introducir la fuerza
	set dF [expr 1.0/$StepsF]; # Porcentaje de fuerza introducida en cada paso (Para introducir la carga en 5 pasos en cada uno se debe introducir un 20% de la total).
	set tol 1e-5; 	# tolerancia para test de convergencia.
	set iter 10; 	# Número de iteraciones permitidas por paso.
	set ConvInf 0; 	# 0 print nothing, 1 print information on norms each time test() is invoked, 2 print information on norms and number of iterations at end of successful test.
	timeSeries Linear 1
	source "LoadNode.tcl"
	constraints Transformation; # Defino la forma en que se manejan las restricciones de nudo.
	numberer Plain; # reenumera los dof para minimizar el ancho de banda.
	system UmfPack; # Defino como se resuelven las ecuaciones en el análisis.
	test NormDispIncr $tol  $iter $ConvInf; #Defino la tolerancia, el número de iteraciones por paso y la información que quiero recibir del test.
	algorithm KrylovNewton; # Defino el algoritmo utilizado para determinar la solución.
	integrator LoadControl $dF; # Indico en el integrador el porcentaje de la carga gravitatoria que se va a aplicar en cada paso.
	analysis Static; # defino el tipo de análisis (estático)
	analyze $StepsF; # Indico en cuantos pasos debe realizar el análisis.
	loadConst -time 0.0; # Congela aplicación de cargas gravit y reinicia el tiempo
	puts "STATIC FORCE CONTROL ANALYSIS FINISHED"


if {$AnalysisType == "Matrix"} {

# MATRIZ DE RIGIDEZ (Sin nudos con condiciones de contorno o restringidos) ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Sin condiciones de contorno quiere decir que no aporta datos de los nudos que estén constreñidos o fijados mediante alguna condición.
	
	wipeAnalysis; # borra los parámetros de análisis antes definidos.
	
	constraints Transformation; # Defino la forma en que se manejan las restricciones de nudo.
	numberer Plain; # reenumera los dof para minimizar el ancho de banda.
	system FullGeneral; # Defino como se resuelven las ecuaciones en el análisis.
	set ConvInf 0;  # imprime información sobre las normas y el número de iteraciones al final de la prueba exitosa <0> No impresión, <2> Impresión
	test NormDispIncr 1.0e-10 10 $ConvInf; 
	integrator LoadControl 1
	algorithm Newton
	analysis Static
	analyze 1
	printA -file $dataDir/Matrices/K.out;
	reset
	puts "STIFFNESS MATRIX FINISHED"


# MATRIZ DE MASAS (Sin nudos con condiciones de contorno o restringidos) --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Sin condiciones de contorno quiere decir que no aporta datos de los nudos que estén constreñidos o fijados mediante alguna condición.

	wipeAnalysis; # borra los parámetros de análisis antes definidos.
	
	constraints Transformation; # Defino la forma en que se manejan las restricciones de nudo.
	numberer Plain; # reenumera los dof para minimizar el ancho de banda.
	system FullGeneral; # Defino como se resuelven las ecuaciones en el análisis.
	set ConvInf 0;  # imprime información sobre las normas y el número de iteraciones al final de la prueba exitosa
	test NormDispIncr 1.0e-10  10 $ConvInf;
	integrator NewmarkExplicit 0.5; 	# it should be an explicit integrator		
	algorithm Newton;					
	analysis Transient;					
	analyze 1 1; # it should be 1 step of size 1
	printA -file $dataDir/Matrices/M.out; 
	reset
	puts "MASS MATRIX FINISHED"


} elseif {$AnalysisType == "Modal"} {
# ANÁLISIS MODAL --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

	# wipeAnalysis; # borra los parámetros de análisis antes definidos.

	set numModes 6; # Número de modos analizados.
	constraints Transformation; # Defino la forma en que se manejan las restricciones de nudo.
	numberer Plain; # reenumera los dof para minimizar el ancho de banda.
	system UmfPack; # Defino como se resuelven las ecuaciones en el análisis.	
	set lambda [eigen -fullGenLapack  $numModes]; #in case of [nº modes=ngdl and masses]
	set omega {}
	set f {}
	set T {}
	foreach lam $lambda {
		lappend omega [expr sqrt($lam)]
		lappend f [expr sqrt($lam)/(2*$pi)]
		lappend T [expr (2*$pi)/sqrt($lam)]
	}
	for { set k 1 } { $k <= $numModes } { incr k } {
		recorder Node -file [format "$dataDir/Modes/mode%i.out" $k] -time -nodeRange 1 "$::NodeEnd" -dof 1 2 3 "eigen $k"
	}
	record
	set Periods [open "$dataDir/Modes/Periods.txt" "w"]
	foreach t $T {
		puts $Periods " $t"
	}
	set Frequency [open "$dataDir/Modes/Frequency.txt" "w"]
	foreach fr $f {
		puts $Frequency " $fr"
	}
	puts "Periods are: $T -s-"
	puts "Frequencies are: $f -Hz-"
	puts "MODAL ANALYSIS FINISHED"


} elseif {$AnalysisType == "PushOver"} {
# ANÁLISIS ESTÁTICO NO LINEAL < CONTROL DE DESPLAZAMIENTOS APLICADOS > (ANÁLISIS PUSHOVER) -------------------------------------------------------------------------------------------------------------------------------------

	# wipeAnalysis; # borra los parámetros de análisis antes definidos.
	
	set maxU 20.0; # maximum displacement of pushover (mm)	
	set StepsU 200.0; # Número de pasos en los que introducir el desplazamiento.
	set dU [expr $maxU/$StepsU]; # Porcentaje de desplazamiento introducido en cada paso. (1% en el paso 1. Por lo tanto son necesarios 500 pasos para introducir la carga completa).
	set ControlNode 576; # Nudo controlado en el análisis.
	set dof 1; # Grados de libertad en los cuales se controla el desplazamiento (De 1 a ndf(3) del modelo). <1> Dirección X, <2> Dirección 2, <3> Dirección Z
	set tol 1e-2; # tolerancia para test de convergencia
	set iter 1000; # Número de iteraciones permitidas por paso.
	set ConvInf 0; 	# 0 print nothing, 1 print information on norms each time test() is invoked, 2 print information on norms and number of iterations at end of successful test.
	timeSeries Linear 2
	pattern Plain 2 2 {
		# sp $ControlNode $dof [expr 1.0*$dU]; # sp [Etiqueta del Nudo] [GdL controlado] [Valor de desplazamiento]
        # sp 203          $dof [expr 0.825*$dU]
		
		load $ControlNode [expr 1.0*$dU] 0.0 0.0 0.0 0.0 0.0; #Carga introducida en el GDLglobal UX UY UZ RX RY RZ 
		load 28           [expr 1.0*$dU] 0.0 0.0 0.0 0.0 0.0
		load 29           [expr 1.0*$dU] 0.0 0.0 0.0 0.0 0.0
		load 30           [expr 1.0*$dU] 0.0 0.0 0.0 0.0 0.0
		
		load 203          [expr 0.825*$dU] 0.0 0.0 0.0 0.0 0.0
		load 16           [expr 0.825*$dU] 0.0 0.0 0.0 0.0 0.0
		load 17           [expr 0.825*$dU] 0.0 0.0 0.0 0.0 0.0
        load 18           [expr 0.825*$dU] 0.0 0.0 0.0 0.0 0.0
		}	
	constraints Penalty 1.0e25 1.0e25; # Defino la forma en que se manejan las restricciones de nudo.
	numberer Plain; # reenumera los dof para minimizar el ancho de banda.
	system UmfPack; # Defino como se resuelven las ecuaciones en el análisis.
	set TestType NormDispIncr ;	# Convergence-test type
	test $TestType $tol  $iter $ConvInf; #Defino la tolerancia, el número de iteraciones por paso y la información que quiero recibir del test.
	set algorithmType KrylovNewton
	algorithm $algorithmType; # Defino el algoritmo utilizado para determinar la solución.     
	integrator DisplacementControl $ControlNode $dof $dU 1 $dU $dU; # Control por desplazamientos en Story 1
	analysis Static
	set ok [analyze [expr int($StepsU)]];                # this will return zero if no convergence problems were encountered

if {$ok != 0} {; # change some analysis parameters to achieve convergence. Performance is slower inside this loop
	set ok 0;
	set controlDisp 0.0;		# start from zero
	set D0 0.0;		# start from zero
	set Dstep [expr ($controlDisp-$D0)/($maxU-$D0)]
	while {$Dstep < 1.0 && $ok == 0} {	
		set controlDisp [nodeDisp $ControlNode $dof ]
		set Dstep [expr ($controlDisp-$D0)/($maxU-$D0)]
		set ok [analyze 1 ]
		if {$ok != 0} {
			puts "Trying Newton with Initial Tangent .."
			test NormDispIncr $tol 2000  0
			algorithm Newton -initial
			set ok [analyze 1 ]
			test $TestType $tol  $iter 0
			algorithm $algorithmType
		}
		if {$ok != 0} {
			puts "Trying Broyden .."
			algorithm Broyden 8
			set ok [analyze 1 ]
			algorithm $algorithmType
		}
		if {$ok != 0} {
			puts "Trying NewtonWithLineSearch .."
			algorithm NewtonLineSearch .8
			set ok [analyze 1 ]
			algorithm $algorithmType
		}
	}
	};      # end if ok !0
	puts "STATIC PUSHOVER ANALYSIS FINISHED"
	

} elseif {$AnalysisType == "Transient"} {
# ANÁLISIS DINÁMICO NO LINEAL <(ANÁLISIS SÍSMICO) (TIME HISTORY ANALYSIS) ------------------------------------------------------------------------------------------------------------------------------------------------------

	# wipeAnalysis; # borra los parámetros de análisis antes definidos. Es necesario activarlo si se corre el pushover antes del dinámico por las condiciones de contorno aplicadas en los gdl monitorizados

	set FM 600.0; # [Hz] Frecuencia de muestreo de la señal
	set AccXfile "Earthquakes/AccX300f600.txt";	# Nombre del archivo con la historia de desplazamientos [u].
	set AccYfile "Earthquakes/AccY300f600.txt";  # Nombre del archivo con la historia de velocidades     [u' = du/dt].
	set GMfactX [expr 1.0*$g];	# Defino el factor de escala del terremoto. i.e: Combinar el 100% de la señal del terremo en dirección X (1) con el 30% de la dirección Y (0.3)
	set GMfactY [expr 1.0*$g];	# Defino el factor de escala del terremoto. i.e: Combinar el 100% de la señal del terremo en dirección X (1) con el 30% de la dirección Y (0.3)

# Se define el amortiguamiento del sistema basado en el modelo de Rayleigh (Para definir la Matriz (C) de amortiguamiento). 
	
	set DampingRatio 0.05; # Ratio de amortiguamiento del sistema respecto al amortiguamiento crítico (1.00)
	set ModeI 1; # Primer modo usado en el modelo de rayleigh
	set ModeJ 3; # Último modo usado en el modelo se rayleigh

	# [C] = alpha*[M] + beta[K]
	# Si alpha = 1.0 y Beta_1 = 1.0, [C1] constante en el análisis. Modelo para sistemas elásticos.
	# Si alpha = 1.0 y Beta_2 = 1.0, [C2] variable en el análisis.  Modelo para sistemas inelásticos en una dirección
	# Si alpha = 1.0 y Beta_3 = 1.0, [C3] variable en el análisis.  Modelo para sistemas inelásticos en dos direcciones
	set MpropSwitch 1.0; # alpha.  Factor aplicado a la matriz de masas inicial.   Alpha constante y [M] constante en el análisis. 
	set KinitSwitch 0.0; # beta_1. Factor aplicado a la matriz de rigidez inicial. Beta constante  y [K] constante en el análisis 
	set KcurrSwitch 0.0; # beta_2. Factor aplicado a la matriz de rigidez actual.  Beta constante  y [K] variable  en el análisis. 
	set KcommSwitch 1.0; # beta_3. Factor aplicado a la matriz de rijidez actual.  Beta variable   y [K] variable  en el análisis.

	set lambdaN [eigen [expr $ModeJ]];			# eigenvalue analysis for ModeJ modes
	set lambdaI [lindex $lambdaN [expr $ModeI-1]]; 	# eigenvalue mode i
	set lambdaJ [lindex $lambdaN [expr $ModeJ-1]]; 	# eigenvalue mode j
	set omegaI [expr pow($lambdaI,0.5)];
	set omegaJ [expr pow($lambdaJ,0.5)];
	set alphaM [expr $MpropSwitch*$DampingRatio*(2*$omegaI*$omegaJ)/($omegaI+$omegaJ)];	# M-prop. damping; D = alphaM*M
	set betaKcurr [expr $KcurrSwitch*2.*$DampingRatio/($omegaI+$omegaJ)];         		# current-K;      +beatKcurr*KCurrent
	set betaKcomm [expr $KcommSwitch*2.*$DampingRatio/($omegaI+$omegaJ)];   			# last-committed K;   +betaKcomm*KlastCommitt
	set betaKinit [expr $KinitSwitch*2.*$DampingRatio/($omegaI+$omegaJ)];         		# initial-K;     +beatKinit*Kini
	rayleigh $alphaM $betaKcurr $betaKinit $betaKcomm; 				# RAYLEIGH damping


# Definición de la Acción sísmica

	set ::Dtfile [expr 1.0/$FM];	# Paso de tiempo del archivo de datos. dt = 1/FM, FM es la frecuencia de muestreo de la señal.	
	set Stepfile [llength [split [read [open "$AccXfile" r]] "\n"]]; # Abre el archivo, lee la posición de cada fila y calcula la longitud del mismo como número de pasos.
	set DtAnalysis [expr 1.0*$Dtfile];	# Definimos el paso de tiempo para el análisis dinámico. Se ha definido cada por cada Step del archivo de datos del terremoto (paso entre 2 datos) nos genere 1 resultados.
	set TmaxAnalysis [expr 1.0*(($Stepfile*$Dtfile)-$Dtfile)]; 	     # duración de acción dinámica (seg). NOTA1: el "-Dtfile" es por la fila libre sin datos al final del archivo del terremoto. NOTA2: meter un factor multiplicador ej:1.2*(__) para analizar la respuesta en vibración libre.
	set StepAnalysis [expr int($TmaxAnalysis/$Dtfile)]; 		 	 # número de pasos del análisis. Se define un número de pasos de análisis igual al nºde pasos del archivo del terremoto.

    set AccelSeriesX "Series -dt $Dtfile -filePath $AccXfile -factor $GMfactX";  # defino acelerograma en la dirección Xglobal
	set AccelSeriesY "Series -dt $Dtfile -filePath $AccYfile -factor $GMfactY";  # defino acelerograma en la dirección Yglobal
	
	pattern UniformExcitation 100 1 -accel $AccelSeriesX; # Definición de la acción dinámica en la dirección Xglobal
	pattern UniformExcitation 200 2 -accel $AccelSeriesY; # Definición de la acción dinámica en la dirección Yglobal

	set tol 1e-2; 	# tolerancia para test de convergencia.
	set iter 1000; 	# Número de iteraciones permitidas por paso.
	set ConvInf 0; 	# 0 print nothing, 1 print information on norms each time test() is invoked, 2 print information on norms and number of iterations at end of successful test.
	set gamma 0.5; # Gamma factor for Integrator Newmark. Average Acceleration Method gamma = 0.5;  Linear Acceleration Method gamma = 0.5
	set beta 0.25; # Beta factor for Integrator Newmark.  Average Acceleration Method  Beta = 0.25; Linear Acceleration Method  Beta = 0.5
	set TestType EnergyIncr; # tipo de prueba de convergencia
	set algorithmType KrylovNewton;
	constraints Transformation; # Defino la forma en que se manejan las restricciones de nudo.
	numberer Plain; 			# reenumera los dof para minimizar ancho de banda
	system UmfPack; 			# system FullGeneral,  in case of obtaining K in each step. Defino como se resuelven las ecuaciones en el análisis.
	test $TestType $tol $iter $ConvInf; #Defino la tolerancia, el número de iteraciones por paso y la información que quiero recibir del test.
	algorithm $algorithmType; # Defino el algoritmo utilizado para determinar la solución.
	# integrator Newmark $gamma $beta; # Defino el integrador.
	integrator HHT 0.9
	analysis Transient;		 # defino el tipo de análisis (transitorio, dependiente del tiempo).
	set ok [analyze $StepAnalysis $DtAnalysis]; # se realiza el análisis; retorna ok=0 si el análsis fue exitoso

if {$ok != 0} { ; # si el análisis no es exitoso. Se cambia algunos parámetros de análisis para alcanzar la convergencia. Proceso es más lento dentro de este lazo. Análisis controlado por tiempo
	set ok 0;
	set controlTime [getTime];
while {$controlTime < $TmaxAnalysis && $ok == 0} {
	set ok [analyze 1 $DtAnalysis]
	set controlTime [getTime]
	set ok [analyze 1 $DtAnalysis]
if {$ok != 0} {
	puts "Trying Newton with Initial Tangent .."
	test NormDispIncr $tol 1000 0
	algorithm Newton -initial
	set ok [analyze 1 $DtAnalysis]
	test $TestType $tol $iter 0
	algorithm $algorithmType
}
if {$ok != 0} {
	puts "Trying Broyden .."
	algorithm Broyden 8
	set ok [analyze 1 $DtAnalysis]
	algorithm $algorithmType
}
if {$ok != 0} {
	puts "Trying NewtonWithLineSearch .."
	algorithm NewtonLineSearch .8
	set ok [analyze 1 $DtAnalysis]
	algorithm $algorithmType
}
}
}; # Finaliza si ok !0
puts "ANALISIS DINAMICO REALIZADO: [getTime]"
}
exit
