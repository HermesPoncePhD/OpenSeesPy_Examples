# ==========[MATERIALS] =========================================================================================================================================================================
# Units: Force(N), Distance(mm), Time(sec), Mass(Ton, Ns^2/mm)

# Constantes globales ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	set g 9807; # Aceleración de la gravedad en mm/s^2
	set pi [expr acos(-1.0)];

# ========== STRUCTURAL MATERIALS ===============================================================================================================================================================


# ELASTIC-SHELL Structural Steel Material [S-275] -------------------------------------------------------------------------------------------------------------------------------------------------------------

	set SELTag 101; 		# material ID tag
	set vsSEL                          0.3; # Coeficiente de Poisson
	set EsSEL                     210000.0;	# Módulo de elasticidad del material (MPa)
	set GsSEL [expr $EsSEL/(2*($vsSEL+1.0))];	# Módulo elasticidad transversal
    nDMaterial ElasticIsotropic $SELTag $EsSEL $vsSEL

# ELASTIC-SHELL Bar Steel Material [B-525] -------------------------------------------------------------------------------------------------------------------------------------------------------------

	set BSLTag 102; 		# material ID tag
	set vsBSL                          0.3; # Coeficiente de Poisson
	set EsBSL                     200000.0;	# Módulo de elasticidad del material (MPa)
	set GsBSL [expr $EsBSL/(2*($vsBSL+1.0))];	# Módulo elasticidad transversal
    nDMaterial ElasticIsotropic $BSLTag $EsBSL $vsBSL

# ELASTIC-SHELL Concrete (LOSA) [HA-55] -------------------------------------------------------------------------------------------------------------------------------------------------------------

	set CULTag 103; 		# material ID tag
	set vsCUL                            0.2;   # Coeficiente de Poisson
	set EsCUL                       39272.34;	# Módulo de elasticidad del material (MPa)
	set GsCUL [expr $EsCUL/(2*($vsCUL+1.0))];	# Módulo elasticidad transversal
	nDMaterial ElasticIsotropic $CULTag $EsCUL $vsCUL
	
# Rigid Material --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	set RMTag 104
	set Erg  1e10; # Young's modulus
	set Grg  1e10; # Shear modulus
	uniaxialMaterial Elastic $RMTag $Erg; # uniaxialMaterial Elastic $matTag $E <$eta> <$Eneg>

# NONLINEAR-INELASTIC Structural Steel Material [S-275] -------------------------------------------------------------------------------------------------------------------------------------------------------------

	set SETag 105; 		# material ID tag
	set dsSE   7.85e-9; # Peso específico del material [T/mm3]	
	set vsSE       0.3; # Coeficiente de Poisson
	set FySE     275.0;	# Resistencia característica del material (MPa)
	set EsSE  210000.0;	# Módulo de elasticidad del material (MPa)
	set GsSE [expr $EsSE/(2*($vsSE+1.0))];	# Módulo elasticidad transversal
	set bsSE      0.01;	# strain-hardening ratio. Ratio para la pendiente del módulo de elasticidad en rango plástico.
	uniaxialMaterial Steel01 $SETag $FySE $EsSE $bsSE; # definición de la ley de comportamiento del material

# NONLINEAR-INELASTIC Bar Steel Material [B-525] --------------------------------------------------------------------------------------------------------------------------------------------------------------------

	set dsBS        7.85e-9; # Peso específico del material [T/mm3]	
	set vsBS            0.3; # Coeficiente de Poisson
	set EsBS       200000.0; # Módulo de elasticidad del material (MPa)
	set GsBS [expr $EsBS/(2*($vsBS+1.0))]; # Módulo elasticidad transversal
	set FyBS          525.0; # Resistencia característica del material (MPa)
	set VyBS [expr $FyBS/2]; # Resistencia característica a cortante del material (MPa)
	set bsBS          0.003; # strain-hardening ratio. Ratio para la pendiente del módulo de elasticidad en rango plástico.
	set R0BS          18.50; # parameters to control the transition from elastic to plastic branches. Recommended values: $R0=between 10 and 20, $cR1=0.925, $cR2=0.15 
	set cR1BS         0.925
	set cR2BS         0.150
	
	set BSnTag 106; # [Axial material]
	uniaxialMaterial Steel02 $BSnTag $FyBS $EsBS $bsBS $R0BS $cR1BS $cR2BS; # uniaxialMaterial Steel02 $SETag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>

    set BSvTag 107; # [Shear material]
	uniaxialMaterial Steel02 $BSvTag $VyBS $GsBS $bsBS $R0BS $cR1BS $cR2BS; # uniaxialMaterial Steel02 $SETag $Fy $E $b $R0 $cR1 $cR2 <$a1 $a2 $a3 $a4 $sigInit>

# Unconfined Concrete (RECUBRIMIENTO) [HA-30] ------------------------------------------------------------------------------------------------------------------------------------------------------------

	# AXIAL DEVELOPMENT

	set CUnTag 108;  # [Axial material]
	set dcCU                      2.50e-9; # Peso específico del material [T/mm3]	
	set vcCU                          0.2; # Coeficiente de Poisson
	set EcCU                      30000.0; # Módulo elasticidad longitudinal 
	set GcCU [expr $EcCU/(2*($vcCU+1.0))]; # Módulo elasticidad transversal
	set fcCU                        -30.0; # Tensión característica a los 28 días (Negativo por que la compresión es negativa para OpenSees)								
	set epscCU     [expr 2.0*$fcCU/$EcCU]; # Deformación para la tensión característica
	set fcuCU           [expr 0.01*$fcCU]; # Tensión de rotura en ensayo
	set epscuCU                    -0.015; # Deformación para la tensión de rotura
	set ftCU                          2.8; # Tensión de tracción en ensayo
	set EtcCU            [expr 0.1*$EcCU]; # Tensión para la pérdida de rigidez
	set lambdaCU                      0.1; # Radio entre la pendiente de descarga y la pendiente inicial
	uniaxialMaterial Concrete02 $CUnTag $fcCU $epscCU $fcuCU $epscuCU $lambdaCU $ftCU $EtcCU; # uniaxialMaterial Concrete02 $matTag $fpc $epsc0 $fpcU $epsU  $lambda $ft $Ets

	# SHEAR DEVELOPMENT

		set CUcvTag 109;   # [Compression part]
		set fcCUcv               [expr $fcCU/4]; # Tensión característica a los 28 días (Negativo por que la compresión es negativa para OpenSees)								
		set epscCUcv     [expr 2.0*$fcCUcv/$GcCU]; # Deformación para la tensión característica
		set fcuCUcv           [expr 0.01*$fcCUcv]; # Tensión de rotura en ensayo
		set ftCUcv                          0.0; # Tensión de tracción en ensayo
		set EtcCUcv                         0.0; # Tensión para la pérdida de rigidez
		uniaxialMaterial Concrete02 $CUcvTag $fcCUcv $epscCUcv $fcuCUcv $epscuCU $lambdaCU $ftCUcv $EtcCUcv; # uniaxialMaterial Concrete02 $matTag $fpc $epsc0 $fpcU $epsU  $lambda $ft $Ets

		set CUtvTag 110; ;   # [traction part]
		set sigt1CUtv 	   [expr -1*$fcCU]; # 	peak tensile stress
		set epst1CUtv 	   [expr -1*$epscCU]; # 	strain at peak tensile stress
		set sigt0CUtv	   [expr $sigt1CUtv*0.66]; # tensile cracking stress
		set epst0CUtv 	  [expr $epst1CUtv*0.35]; # strain at tensile cracking stress
		set epst2CUtv 	  0.0151; # 	ultimate tensile strain
		set alphaT1CUtv 	1.503; # 	exponent of the unloading curve in tensile strain hardening region
		set alphaT2CUtv $alphaT1CUtv; # 	exponent of the unloading curve in tensile softening region
		set betaTCUtv 	[expr (2.0*$sigt1CUtv/$epst1CUtv)/(2.0*$sigt0CUtv/$epst0CUtv)]; # 	parameter to determine permanent strain in tension
		uniaxialMaterial ECC01 $CUtvTag $sigt0CUtv $epst0CUtv $sigt1CUtv $epst1CUtv $epst2CUtv 0.0 0.0 0.0 $alphaT1CUtv $alphaT2CUtv 0.0 0.0 $betaTCUtv 0.0 
 
	set CUvTag 109110;  # [Shear material]
	uniaxialMaterial Parallel $CUvTag $CUcvTag $CUtvTag; # Se vinculan en paralelo dos materiales (Suma de fuerzas).


# Confined Concrete (PILARES SUPERIORES) [HA-47] [Axial material] ----------------------------------------------------------------------------------------------------------------------------------------------

	# AXIAL DEVELOPMENT

	set HA47nTag 111;  # [Axial material] 
	set dcHA47                      2.50e-9; # Peso específico del material [T/mm3]	
	set vcHA47                          0.2; # Coeficiente de Poisson
	set EcHA47                     38266.52; # Módulo elasticidad longitudinal 
	set GcHA47 [expr $EcHA47/(2*($vcHA47+1.0))]; # Módulo elasticidad transversal
	set fcHA47                       -47.28; # Tensión característica a los 28 días (Negativo por que la compresión es negativa para OpenSees)								
	set epscHA47     [expr 2.0*$fcHA47/$EcHA47]; # Deformación para la tensión característica
	set fcuHA47           [expr 0.01*$fcHA47]; # Tensión de rotura en ensayo
	set epscuHA47                    -0.015; # Deformación para la tensión de rotura
	set ftHA47                          2.8; # Tensión de tracción en ensayo
	set EtcHA47            [expr 0.1*$EcHA47]; # Tensión para la pérdida de rigidez
	set lambdaHA47                      0.1; # Radio entre la pendiente de descarga y la pendiente inicial
	uniaxialMaterial Concrete02 $HA47nTag $fcHA47 $epscHA47 $fcuHA47 $epscuHA47 $lambdaHA47 $ftHA47 $EtcHA47; # uniaxialMaterial Concrete02 $matTag $fpc $epsc0 $fpcU $epsU  $lambda $ft $Ets


	# SHEAR DEVELOPMENT

		set HA47cvTag 112;   # [Compression part]
		set fcHA47cv               [expr $fcHA47/4]; # Tensión característica a los 28 días (Negativo por que la compresión es negativa para OpenSees)								
		set epscHA47cv     [expr 2.0*$fcHA47cv/$GcHA47]; # Deformación para la tensión característica
		set fcuHA47cv           [expr 0.01*$fcHA47cv]; # Tensión de rotura en ensayo
		set ftHA47cv                          0.0; # Tensión de tracción en ensayo
		set EtcHA47cv                         0.0; # Tensión para la pérdida de rigidez
		uniaxialMaterial Concrete02 $HA47cvTag $fcHA47cv $epscHA47cv $fcuHA47cv $epscuHA47 $lambdaHA47 $ftHA47cv $EtcHA47cv; # uniaxialMaterial Concrete02 $matTag $fpc $epsc0 $fpcU $epsU  $lambda $ft $Ets

		set HA47tvTag 113; ;   # [traction part]
		set sigt1HA47tv 	   [expr -1*$fcHA47]; # 	peak tensile stress
		set epst1HA47tv 	   [expr -1*$epscHA47]; # 	strain at peak tensile stress
		set sigt0HA47tv	   [expr $sigt1HA47tv*0.66]; # tensile cracking stress
		set epst0HA47tv 	  [expr $epst1HA47tv*0.35]; # strain at tensile cracking stress
		set epst2HA47tv 	  0.0151; # 	ultimate tensile strain
		set alphaT1HA47tv 	1.642; # 	exponent of the unloading curve in tensile strain hardening region
		set alphaT2HA47tv $alphaT1HA47tv; # 	exponent of the unloading curve in tensile softening region
		set betaTHA47tv 	[expr (2.0*$sigt1HA47tv/$epst1HA47tv)/(2.0*$sigt0HA47tv/$epst0HA47tv)]; # 	parameter to determine permanent strain in tension
		uniaxialMaterial ECC01 $HA47tvTag $sigt0HA47tv $epst0HA47tv $sigt1HA47tv $epst1HA47tv $epst2HA47tv 0.0 0.0 0.0 $alphaT1HA47tv $alphaT2HA47tv 0.0 0.0 $betaTHA47tv 0.0 
 
	set HA47vTag 112113;  # [Shear material]
	uniaxialMaterial Parallel $HA47vTag $HA47cvTag $HA47tvTag; # Se vinculan en paralelo dos materiales (Suma de fuerzas).


# Confined Concrete (PILARES INFERIORES) [HA-68] [Axial material] ----------------------------------------------------------------------------------------------------------------------------------------------

	# AXIAL DEVELOPMENT

	set HA68nTag 114;  # [Axial material] 
	set dcHA68                      2.50e-9; # Peso específico del material [T/mm3]	
	set vcHA68                          0.2; # Coeficiente de Poisson
	set EcHA68                     40679.33; # Módulo elasticidad longitudinal 
	set GcHA68 [expr $EcHA68/(2*($vcHA68+1.0))]; # Módulo elasticidad transversal
	set fcHA68                       -67.94; # Tensión característica a los 28 días (Negativo por que la compresión es negativa para OpenSees)								
	set epscHA68     [expr 2.0*$fcHA68/$EcHA68]; # Deformación para la tensión característica
	set fcuHA68           [expr 0.01*$fcHA68]; # Tensión de rotura en ensayo
	set epscuHA68                    -0.015; # Deformación para la tensión de rotura
	set ftHA68                          2.8; # Tensión de tracción en ensayo
	set EtcHA68            [expr 0.1*$EcHA68]; # Tensión para la pérdida de rigidez
	set lambdaHA68                      0.1; # Radio entre la pendiente de descarga y la pendiente inicial
	uniaxialMaterial Concrete02 $HA68nTag $fcHA68 $epscHA68 $fcuHA68 $epscuHA68 $lambdaHA68 $ftHA68 $EtcHA68; # uniaxialMaterial Concrete02 $matTag $fpc $epsc0 $fpcU $epsU  $lambda $ft $Ets


	# SHEAR DEVELOPMENT

		set HA68cvTag 115;   # [Compression part]
		set fcHA68cv               [expr $fcHA68/4]; # Tensión característica a los 28 días (Negativo por que la compresión es negativa para OpenSees)								
		set epscHA68cv     [expr 2.0*$fcHA68cv/$GcHA68]; # Deformación para la tensión característica
		set fcuHA68cv           [expr 0.01*$fcHA68cv]; # Tensión de rotura en ensayo
		set ftHA68cv                          0.0; # Tensión de tracción en ensayo
		set EtcHA68cv                         0.0; # Tensión para la pérdida de rigidez
		uniaxialMaterial Concrete02 $HA68cvTag $fcHA68cv $epscHA68cv $fcuHA68cv $epscuHA68 $lambdaHA68 $ftHA68cv $EtcHA68cv; # uniaxialMaterial Concrete02 $matTag $fpc $epsc0 $fpcU $epsU  $lambda $ft $Ets

		set HA68tvTag 116; ;   # [traction part]
		set sigt1HA68tv 	   [expr -1*$fcHA68]; # 	peak tensile stress
		set epst1HA68tv 	   [expr -1*$epscHA68]; # 	strain at peak tensile stress
		set sigt0HA68tv	   [expr $sigt1HA68tv*0.66]; # tensile cracking stress
		set epst0HA68tv 	  [expr $epst1HA68tv*0.35]; # strain at tensile cracking stress
		set epst2HA68tv 	  0.0151; # 	ultimate tensile strain
		set alphaT1HA68tv 	1.642; # 	exponent of the unloading curve in tensile strain hardening region
		set alphaT2HA68tv $alphaT1HA68tv; # 	exponent of the unloading curve in tensile softening region
		set betaTHA68tv 	[expr (2.0*$sigt1HA68tv/$epst1HA68tv)/(2.0*$sigt0HA68tv/$epst0HA68tv)]; # 	parameter to determine permanent strain in tension
		uniaxialMaterial ECC01 $HA68tvTag $sigt0HA68tv $epst0HA68tv $sigt1HA68tv $epst1HA68tv $epst2HA68tv 0.0 0.0 0.0 $alphaT1HA68tv $alphaT2HA68tv 0.0 0.0 $betaTHA68tv 0.0 
 
	set HA68vTag 115116;  # [Shear material]
	uniaxialMaterial Parallel $HA68vTag $HA68cvTag $HA68tvTag; # Se vinculan en paralelo dos materiales (Suma de fuerzas).
	
	
	# Confined Concrete (VIGAS Y LOSA) [HA-55] [Axial material] ----------------------------------------------------------------------------------------------------------------------------------------------

	# AXIAL DEVELOPMENT

	set HA55nTag 117;  # [Axial material] 
	set dcHA55                      2.50e-9; # Peso específico del material [T/mm3]	
	set vcHA55                          0.2; # Coeficiente de Poisson
	set EcHA55                     39272.34; # Módulo elasticidad longitudinal 
	set GcHA55 [expr $EcHA55/(2*($vcHA55+1.0))]; # Módulo elasticidad transversal
	set fcHA55                       -54.63; # Tensión característica a los 28 días (Negativo por que la compresión es negativa para OpenSees)								
	set epscHA55     [expr 2.0*$fcHA55/$EcHA55]; # Deformación para la tensión característica
	set fcuHA55           [expr 0.01*$fcHA55]; # Tensión de rotura en ensayo
	set epscuHA55                    -0.015; # Deformación para la tensión de rotura
	set ftHA55                          2.8; # Tensión de tracción en ensayo
	set EtcHA55            [expr 0.1*$EcHA55]; # Tensión para la pérdida de rigidez
	set lambdaHA55                      0.1; # Radio entre la pendiente de descarga y la pendiente inicial
	uniaxialMaterial Concrete02 $HA55nTag $fcHA55 $epscHA55 $fcuHA55 $epscuHA55 $lambdaHA55 $ftHA55 $EtcHA55; # uniaxialMaterial Concrete02 $matTag $fpc $epsc0 $fpcU $epsU  $lambda $ft $Ets


	# SHEAR DEVELOPMENT

		set HA55cvTag 118;   # [Compression part]
		set fcHA55cv               [expr $fcHA55/4]; # Tensión característica a los 28 días (Negativo por que la compresión es negativa para OpenSees)								
		set epscHA55cv     [expr 2.0*$fcHA55cv/$GcHA55]; # Deformación para la tensión característica
		set fcuHA55cv           [expr 0.01*$fcHA55cv]; # Tensión de rotura en ensayo
		set ftHA55cv                          0.0; # Tensión de tracción en ensayo
		set EtcHA55cv                         0.0; # Tensión para la pérdida de rigidez
		uniaxialMaterial Concrete02 $HA55cvTag $fcHA55cv $epscHA55cv $fcuHA55cv $epscuHA55 $lambdaHA55 $ftHA55cv $EtcHA55cv; # uniaxialMaterial Concrete02 $matTag $fpc $epsc0 $fpcU $epsU  $lambda $ft $Ets

		set HA55tvTag 119; ;   # [traction part]
		set sigt1HA55tv 	   [expr -1*$fcHA55]; # 	peak tensile stress
		set epst1HA55tv 	   [expr -1*$epscHA55]; # 	strain at peak tensile stress
		set sigt0HA55tv	   [expr $sigt1HA55tv*0.66]; # tensile cracking stress
		set epst0HA55tv 	  [expr $epst1HA55tv*0.35]; # strain at tensile cracking stress
		set epst2HA55tv 	  0.0151; # 	ultimate tensile strain
		set alphaT1HA55tv 	1.642; # 	exponent of the unloading curve in tensile strain hardening region
		set alphaT2HA55tv $alphaT1HA55tv; # 	exponent of the unloading curve in tensile softening region
		set betaTHA55tv 	[expr (2.0*$sigt1HA55tv/$epst1HA55tv)/(2.0*$sigt0HA55tv/$epst0HA55tv)]; # 	parameter to determine permanent strain in tension
		uniaxialMaterial ECC01 $HA55tvTag $sigt0HA55tv $epst0HA55tv $sigt1HA55tv $epst1HA55tv $epst2HA55tv 0.0 0.0 0.0 $alphaT1HA55tv $alphaT2HA55tv 0.0 0.0 $betaTHA55tv 0.0 
 
	set HA55vTag 118119;  # [Shear material]
	uniaxialMaterial Parallel $HA55vTag $HA55cvTag $HA55tvTag; # Se vinculan en paralelo dos materiales (Suma de fuerzas).
	

# HINGE ELEMENT - MOMENT-CURVATURE + AXIAL COMBINATION - COLUMN SECTIONS ----------------------------------------------------------------------------------------------------------------------------------------------
	
	# PILARES PLANTA BAJA - AXIL 29740.72 N
	set HMPTagN1 	 120; 
	set ePf1HgN1     1383080.0; # [N.mm] floating point values defining force points on the positive response envelope   
	set ePf2HgN1     3716010.0; # [N.mm] 
	set ePf3HgN1     3838870.0; # [N.mm] 
	set ePf4HgN1     1858010.0; # [N.mm] 
	set ePd1HgN1     0.0000006410; # [rad/mm] floating point values defining deformation points on the positive response envelope
	set ePd2HgN1     0.0001426617; # [rad/mm] 
	set ePd3HgN1     0.0006143093; # [rad/mm]
	set ePd4HgN1     0.0006757403; # [rad/mm]
	set rDispPHgN1   0.50; # floating point value defining the ratio of the deformation at which reloading occurs to the maximum historic deformation demand
	set rForcePHgN1  0.80; # floating point value defining the ratio of the force at which reloading begins to force corresponding to the maximum historic deformation demand
	set uForcePHgN1  0.05; # floating point value defining the ratio of strength developed upon unloading from negative load to the maximum strength developed under monotonic loading
	set gK1HgN1      1.00; # floating point values controlling cyclic degradation model for unloading stiffness degradation
	set gK2HgN1      0.00;
	set gK3HgN1      0.20;
	set gK4HgN1      0.00;
	set gKLimHgN1    0.95;
	set gD1HgN1      0.00; # floating point values controlling cyclic degradation model for reloading stiffness degradation
	set gD2HgN1      0.00;
	set gD3HgN1      0.00;
	set gD4HgN1      0.00;
	set gDLimHgN1    0.00;
	set gF1HgN1      0.25; # floating point values controlling cyclic degradation model for strength degradation
	set gF2HgN1      0.00;
	set gF3HgN1      1.00;
	set gF4HgN1      0.00;
	set gFLimHgN1    0.30;	
	set gEHgN1       8.00; # floating point value used to define maximum energy dissipation under cyclic loading. Total energy dissipation capacity is defined as this factor multiplied by the energy dissipated under monotonic loading.
	set dmgTypeHgN1  "energy"; # string to indicate type of damage (option: "cycle", "energy") 
	uniaxialMaterial Pinching4 $HMPTagN1 $ePf1HgN1 $ePd1HgN1 $ePf2HgN1 $ePd2HgN1 $ePf3HgN1 $ePd3HgN1 $ePf4HgN1 $ePd4HgN1 $rDispPHgN1 $rForcePHgN1 $uForcePHgN1 $gK1HgN1 $gK2HgN1 $gK3HgN1 $gK4HgN1 $gKLimHgN1 $gD1HgN1 $gD2HgN1 $gD3HgN1 $gD4HgN1 $gDLimHgN1 $gF1HgN1 $gF2HgN1 $gF3HgN1 $gF4HgN1 $gFLimHgN1 $gEHgN1 $dmgTypeHg11

	# PILARES PLANTA ALTA - AXIL 21057.92 N
	set HMPTagN2 	 121; 
	set ePf1HgN2     1051000.0; # [N.mm] floating point values defining force points on the positive response envelope   
	set ePf2HgN2     3375490.0; # [N.mm] 
	set ePf3HgN2     3490610.0; # [N.mm] 
	set ePf4HgN2     1687740.0; # [N.mm] 
	set ePd1HgN2     0.0000005138; # [rad/mm] floating point values defining deformation points on the positive response envelope
	set ePd2HgN2     0.0001297027; # [rad/mm] 
	set ePd3HgN2     0.0005720535; # [rad/mm]
	set ePd4HgN2     0.0006292589; # [rad/mm]
	set rDispPHgN2   0.50; # floating point value defining the ratio of the deformation at which reloading occurs to the maximum historic deformation demand
	set rForcePHgN2  0.80; # floating point value defining the ratio of the force at which reloading begins to force corresponding to the maximum historic deformation demand
	set uForcePHgN2  0.05; # floating point value defining the ratio of strength developed upon unloading from negative load to the maximum strength developed under monotonic loading
	set gK1HgN2      1.00; # floating point values controlling cyclic degradation model for unloading stiffness degradation
	set gK2HgN2      0.00;
	set gK3HgN2      0.20;
	set gK4HgN2      0.00;
	set gKLimHgN2    0.95;
	set gD1HgN2      0.00; # floating point values controlling cyclic degradation model for reloading stiffness degradation
	set gD2HgN2      0.00;
	set gD3HgN2      0.00;
	set gD4HgN2      0.00;
	set gDLimHgN2    0.00;
	set gF1HgN2      0.25; # floating point values controlling cyclic degradation model for strength degradation
	set gF2HgN2      0.00;
	set gF3HgN2      1.00;
	set gF4HgN2      0.00;
	set gFLimHgN2    0.30;	
	set gEHgN2       8.00; # floating point value used to define maximum energy dissipation under cyclic loading. Total energy dissipation capacity is defined as this factor multiplied by the energy dissipated under monotonic loading.
	set dmgTypeHgN2  "energy"; # string to indicate type of damage (option: "cycle", "energy") 
	uniaxialMaterial Pinching4 $HMPTagN2 $ePf1HgN2 $ePd1HgN2 $ePf2HgN2 $ePd2HgN2 $ePf3HgN2 $ePd3HgN2 $ePf4HgN2 $ePd4HgN2 $rDispPHgN2 $rForcePHgN2 $uForcePHgN2 $gK1HgN2 $gK2HgN2 $gK3HgN2 $gK4HgN2 $gKLimHgN2 $gD1HgN2 $gD2HgN2 $gD3HgN2 $gD4HgN2 $gDLimHgN2 $gF1HgN2 $gF2HgN2 $gF3HgN2 $gF4HgN2 $gFLimHgN2 $gEHgN2 $dmgTypeHg11

	# VIGAS CENTRALES 
	set HMPTagVCen     122; 
	set ePf1HgVCen      765731.0; # [N.mm] floating point values defining force points on the positive response envelope   
	set ePf2HgVCen     2571490.0; # [N.mm] 
	set ePf3HgVCen     2661430.0; # [N.mm] 
	set ePf4HgVCen     1285750.0; # [N.mm] 
	set ePd1HgVCen     0.0000003666; # [rad/mm] floating point values defining deformation points on the positive response envelope
	set ePd2HgVCen     0.0001608364; # [rad/mm] 
	set ePd3HgVCen     0.0007233518; # [rad/mm]
	set ePd4HgVCen     0.0007956870; # [rad/mm]
	set rDispPHgVCen   0.50; # floating point value defining the ratio of the deformation at which reloading occurs to the maximum historic deformation demand
	set rForcePHgVCen  0.80; # floating point value defining the ratio of the force at which reloading begins to force corresponding to the maximum historic deformation demand
	set uForcePHgVCen  0.05; # floating point value defining the ratio of strength developed upon unloading from negative load to the maximum strength developed under monotonic loading
	set gK1HgVCen      1.00; # floating point values controlling cyclic degradation model for unloading stiffness degradation
	set gK2HgVCen      0.00;
	set gK3HgVCen      0.20;
	set gK4HgVCen      0.00;
	set gKLimHgVCen    0.95;
	set gD1HgVCen      0.00; # floating point values controlling cyclic degradation model for reloading stiffness degradation
	set gD2HgVCen      0.00;
	set gD3HgVCen      0.00;
	set gD4HgVCen      0.00;
	set gDLimHgVCen    0.00;
	set gF1HgVCen      0.25; # floating point values controlling cyclic degradation model for strength degradation
	set gF2HgVCen      0.00;
	set gF3HgVCen      1.00;
	set gF4HgVCen      0.00;
	set gFLimHgVCen    0.30;	
	set gEHgVCen       8.00; # floating point value used to define maximum energy dissipation under cyclic loading. Total energy dissipation capacity is defined as this factor multiplied by the energy dissipated under monotonic loading.
	set dmgTypeHgVCen  "energy"; # string to indicate type of damage (option: "cycle", "energy") 
	uniaxialMaterial Pinching4 $HMPTagVCen $ePf1HgVCen $ePd1HgVCen $ePf2HgVCen $ePd2HgVCen $ePf3HgVCen $ePd3HgVCen $ePf4HgVCen $ePd4HgVCen $rDispPHgVCen $rForcePHgVCen $uForcePHgVCen $gK1HgVCen $gK2HgVCen $gK3HgVCen $gK4HgVCen $gKLimHgVCen $gD1HgVCen $gD2HgVCen $gD3HgVCen $gD4HgVCen $gDLimHgVCen $gF1HgVCen $gF2HgVCen $gF3HgVCen $gF4HgVCen $gFLimHgVCen $gEHgVCen $dmgTypeHg11

	# VIGAS EXTREMOS 
	set HMPTagVExt     123; 
	set ePf1HgVExt      765731.0; # [N.mm] floating point values defining force points on the positive response envelope   
	set ePf2HgVExt     2571490.0; # [N.mm] 
	set ePf3HgVExt     2678190.0; # [N.mm] 
	set ePf4HgVExt     1285750.0; # [N.mm] 
	set ePd1HgVExt     0.0000003666; # [rad/mm] floating point values defining deformation points on the positive response envelope
	set ePd2HgVExt     0.0000989515; # [rad/mm] 
	set ePd3HgVExt     0.0005095033; # [rad/mm]
	set ePd4HgVExt     0.0005604536; # [rad/mm]
	set rDispPHgVExt   0.50; # floating point value defining the ratio of the deformation at which reloading occurs to the maximum historic deformation demand
	set rForcePHgVExt  0.80; # floating point value defining the ratio of the force at which reloading begins to force corresponding to the maximum historic deformation demand
	set uForcePHgVExt  0.05; # floating point value defining the ratio of strength developed upon unloading from negative load to the maximum strength developed under monotonic loading
	set gK1HgVExt      1.00; # floating point values controlling cyclic degradation model for unloading stiffness degradation
	set gK2HgVExt      0.00;
	set gK3HgVExt      0.20;
	set gK4HgVExt      0.00;
	set gKLimHgVExt    0.95;
	set gD1HgVExt      0.00; # floating point values controlling cyclic degradation model for reloading stiffness degradation
	set gD2HgVExt      0.00;
	set gD3HgVExt      0.00;
	set gD4HgVExt      0.00;
	set gDLimHgVExt    0.00;
	set gF1HgVExt      0.25; # floating point values controlling cyclic degradation model for strength degradation
	set gF2HgVExt      0.00;
	set gF3HgVExt      1.00;
	set gF4HgVExt      0.00;
	set gFLimHgVExt    0.30;	
	set gEHgVExt       8.00; # floating point value used to define maximum energy dissipation under cyclic loading. Total energy dissipation capacity is defined as this factor multiplied by the energy dissipated under monotonic loading.
	set dmgTypeHgVExt  "energy"; # string to indicate type of damage (option: "cycle", "energy") 
	uniaxialMaterial Pinching4 $HMPTagVExt $ePf1HgVExt $ePd1HgVExt $ePf2HgVExt $ePd2HgVExt $ePf3HgVExt $ePd3HgVExt $ePf4HgVExt $ePd4HgVExt $rDispPHgVExt $rForcePHgVExt $uForcePHgVExt $gK1HgVExt $gK2HgVExt $gK3HgVExt $gK4HgVExt $gKLimHgVExt $gD1HgVExt $gD2HgVExt $gD3HgVExt $gD4HgVExt $gDLimHgVExt $gF1HgVExt $gF2HgVExt $gF3HgVExt $gF4HgVExt $gFLimHgVExt $gEHgVExt $dmgTypeHg11

	# Elemento rígido:
	set PTag 124;
	uniaxialMaterial Elastic $PTag $Erg
	
	# Pilares planta alta:
	set TTagHA47 125;
	uniaxialMaterial Elastic $TTag $GcHA47

	# Pilares planta baja:
	set TTagHA68 126;
	uniaxialMaterial Elastic $TTag $GcHA68
	
	# Vigas:
	set TTagHA55 127;
	uniaxialMaterial Elastic $TTag $GcHA55
	
# ========== DAMPER MATERIALS ===================================================================================================================================================================

# HYSTERETIC MODEL ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	# GAP Material
	
	set GAPTag 1;    # Etiqueta del material
	set Gap   5.0;   # [mm] Punto de transición entre pendientes
	set EP1g  0.0;   # Pendiente del tramo 1
	set EP2g 1e10;   #1e10;# Pendiente del tramo 2
	uniaxialMaterial ElasticBilin $GAPTag $EP1g $EP2g $Gap
	
	# BOUCWEN Material
		
	set BWTag 2;                     # material ID tag. Definido como variable global.	
	set tauBW       [expr 2.063**6]; #[expr 2.1**6]
	set alphaBW [expr 0.0484/$tauBW] ; #[expr 0.0462/$tau]; ratio of post-yield stiffness to the initial elastic stiffenss [0<alpha<1]
	set koBW    [expr 21870.0*$tauBW]; # initial elastic stiffness: 21.94
	set nBW                     1.2; # parameter that controls transition from linear to nonlinear range (as n increases the transition becomes sharper; n is usually grater or equal to 1) 
	set gammaBW                 0.5; # parameters that control shape of hysteresis loop;
	set betaBW                  0.5; # parameters that control shape of hysteresis loop;
	set AoBW        [expr 1.0/$tauBW]; # parámetro que corrige al factor Ko de la pendiente
	set deltaABW                0.0; # parameters that control tangent stiffness 
	set deltaNuBW              4e-9; # Controla la degradación[+] o aumento[-] de rigidez por ciclo en el tramo de carga (esqueleto)
	set deltaEtaBW           3.0e-9; # Controla la degradación[+] de rigidez por ciclo en el tramo de descarga (bauschinguer)
	uniaxialMaterial BoucWen $BWTag $alphaBW $koBW $nBW $gammaBW $betaBW $AoBW $deltaABW $deltaNuBW $deltaEtaBW 
   
	#SERIES Material [GAP + BOUCWEN]
	set GapBwTagS 12;   # material ID tag.
	uniaxialMaterial Series $GapBwTagS $GAPTag $BWTag; # Se vinculan en Serie dos materiales (Suma de desplazamientos).


# VISCOELASTIC KELVIN-MODEL [DAMPER 1]-----------------------------------------------------------------------------------------------------------------------------------------------------------

		#ELASTIC Material
		set VMTag1 10;      # material ID tag. Definido como variable global.
		set Kv1 1255.24;
		set Cv1 1e6;
		set av1 1.00;
		uniaxialMaterial ViscousDamper $VMTag1 $Kv1 $Cv1 $av1; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha
	
		#VISCOUS MATERIAL 
		set EMTag1 11;      # material ID tag. Definido como variable global.
		set Ke1 1e6;
		set Ce1 71.55;
		set ae1 1.00;
		uniaxialMaterial ViscousDamper $EMTag1 $Ke1 $Ce1 $ae1; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha
	
		#PARALLEL Material [ELASTIC + VISCOUS]
		set VETag1 1011;  # material ID tag.
		uniaxialMaterial Parallel $VETag1 $VMTag1 $EMTag1; # Se vinculan en paralelo dos materiales (Suma de fuerzas).

	# DAMPER 1 [GAP-BOUCWEN + VISCOELASTIC] PARALLEL Material 
	set DAMPERTag1 121011;  # material ID tag.
	uniaxialMaterial Parallel $DAMPERTag1 $GapBwTagS $VETag1; # Se vinculan en paralelo dos materiales (Suma de fuerzas).


# VISCOELASTIC KELVIN-MODEL [DAMPER 2]-----------------------------------------------------------------------------------------------------------------------------------------------------------

		#ELASTIC Material
		set VMTag2 20;      # material ID tag. Definido como variable global.
		set Kv2 3399.58;
		set Cv2 1e6;
		set av2 1.00;
		uniaxialMaterial ViscousDamper $VMTag2 $Kv2 $Cv2 $av2; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#VISCOUS MATERIAL 
		set EMTag2 21;      # material ID tag. Definido como variable global.
		set Ke2 1e6;
		set Ce2 66.27;
		set ae2 1.00;
		uniaxialMaterial ViscousDamper $EMTag2 $Ke2 $Ce2 $ae2; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#PARALLEL Material [ELASTIC + VISCOUS]
		set VETag2 2021;  # material ID tag.
		uniaxialMaterial Parallel $VETag2 $VMTag2 $EMTag2; # Se vinculan en paralelo dos materiales (Suma de fuerzas).

	# DAMPER 2 [GAP-BOUCWEN + VISCOELASTIC] PARALLEL Material 
	set DAMPERTag2 122021;  # material ID tag.
	uniaxialMaterial Parallel $DAMPERTag2 $GapBwTagS $VETag2; # Se vinculan en paralelo dos materiales (Suma de fuerzas).


# VISCOELASTIC KELVIN-MODEL [DAMPER 3]-----------------------------------------------------------------------------------------------------------------------------------------------------------

		#ELASTIC Material
		set VMTag3 30;      # material ID tag. Definido como variable global.
		set Kv3 2872.48;
		set Cv3 1e6;
		set av3 1.00;
		uniaxialMaterial ViscousDamper $VMTag3 $Kv3 $Cv3 $av3; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#VISCOUS MATERIAL 
		set EMTag3 31;      # material ID tag. Definido como variable global.
		set Ke3 1e6;
		set Ce3 51.15;
		set ae3 1.00;
		uniaxialMaterial ViscousDamper $EMTag3 $Ke3 $Ce3 $ae3; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#PARALLEL Material [ELASTIC + VISCOUS]
		set VETag3 3031;  # material ID tag.
		uniaxialMaterial Parallel $VETag3 $VMTag3 $EMTag3; # Se vinculan en paralelo dos materiales (Suma de fuerzas).

	# DAMPER 3 [GAP-BOUCWEN + VISCOELASTIC] PARALLEL Material 
	set DAMPERTag3 123031;  # material ID tag.
	uniaxialMaterial Parallel $DAMPERTag3 $GapBwTagS $VETag3; # Se vinculan en paralelo dos materiales (Suma de fuerzas).


# VISCOELASTIC KELVIN-MODEL [DAMPER 4]-----------------------------------------------------------------------------------------------------------------------------------------------------------

		#ELASTIC Material
		set VMTag4 40;      # material ID tag. Definido como variable global.
		set Kv4 2476.76;
		set Cv4 1e6;
		set av4 1.00;
		uniaxialMaterial ViscousDamper $VMTag4 $Kv4 $Cv4 $av4; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#VISCOUS MATERIAL 
		set EMTag4 41;      # material ID tag. Definido como variable global.
		set Ke4 1e6;
		set Ce4 113.03;
		set ae4 1.00;
		uniaxialMaterial ViscousDamper $EMTag4 $Ke4 $Ce4 $ae4; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#PARALLEL Material [ELASTIC + VISCOUS]
		set VETag4 4041;  # material ID tag.
		uniaxialMaterial Parallel $VETag4 $VMTag4 $EMTag4; # Se vinculan en paralelo dos materiales (Suma de fuerzas).

	# DAMPER 4 [GAP-BOUCWEN + VISCOELASTIC] PARALLEL Material 
	set DAMPERTag4 124041;  # material ID tag.
	uniaxialMaterial Parallel $DAMPERTag4 $GapBwTagS $VETag4; # Se vinculan en paralelo dos materiales (Suma de fuerzas).


# VISCOELASTIC KELVIN-MODEL [DAMPER 5]-----------------------------------------------------------------------------------------------------------------------------------------------------------

		#ELASTIC Material
		set VMTag5 50;      # material ID tag. Definido como variable global.
		set Kv5 2735.02;
		set Cv5 1e6;
		set av5 1.00;
		uniaxialMaterial ViscousDamper $VMTag5 $Kv5 $Cv5 $av5; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#VISCOUS MATERIAL 
		set EMTag5 51;      # material ID tag. Definido como variable global.
		set Ke5 1e6;
		set Ce5 49.34;
		set ae5 1.00;
		uniaxialMaterial ViscousDamper $EMTag5 $Ke5 $Ce5 $ae5; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#PARALLEL Material [ELASTIC + VISCOUS]
		set VETag5 5051;  # material ID tag.
		uniaxialMaterial Parallel $VETag5 $VMTag5 $EMTag5; # Se vinculan en paralelo dos materiales (Suma de fuerzas).

	# DAMPER 5 [GAP-BOUCWEN + VISCOELASTIC] PARALLEL Material 
	set DAMPERTag5 125051;  # material ID tag.
	uniaxialMaterial Parallel $DAMPERTag5 $GapBwTagS $VETag5; # Se vinculan en paralelo dos materiales (Suma de fuerzas).


# VISCOELASTIC KELVIN-MODEL [DAMPER 6]-----------------------------------------------------------------------------------------------------------------------------------------------------------

		#ELASTIC Material
		set VMTag6 60;      # material ID tag. Definido como variable global.
		set Kv6 3710.47;
		set Cv6 1e6;
		set av6 1.00;
		uniaxialMaterial ViscousDamper $VMTag6 $Kv6 $Cv6 $av6; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#VISCOUS MATERIAL 
		set EMTag6 61;      # material ID tag. Definido como variable global.
		set Ke6 1e6;
		set Ce6 60.06;
		set ae6 1.00;
		uniaxialMaterial ViscousDamper $EMTag6 $Ke6 $Ce6 $ae6; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#PARALLEL Material [ELASTIC + VISCOUS]
		set VETag6 6061;  # material ID tag.
		uniaxialMaterial Parallel $VETag6 $VMTag6 $EMTag6; # Se vinculan en paralelo dos materiales (Suma de fuerzas).

	# DAMPER 6 [GAP-BOUCWEN + VISCOELASTIC] PARALLEL Material 
	set DAMPERTag6 126061;  # material ID tag.
	uniaxialMaterial Parallel $DAMPERTag6 $GapBwTagS $VETag6; # Se vinculan en paralelo dos materiales (Suma de fuerzas).


# VISCOELASTIC KELVIN-MODEL [DAMPER 7]-----------------------------------------------------------------------------------------------------------------------------------------------------------

		#ELASTIC Material
		set VMTag7 70;      # material ID tag. Definido como variable global.
		set Kv7 4670.87;
		set Cv7 1e6;
		set av7 1.00;
		uniaxialMaterial ViscousDamper $VMTag7 $Kv7 $Cv7 $av7; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#VISCOUS MATERIAL 
		set EMTag7 71;      # material ID tag. Definido como variable global.
		set Ke7 1e6;
		set Ce7 78.31;
		set ae7 1.00;
		uniaxialMaterial ViscousDamper $EMTag7 $Ke7 $Ce7 $ae7; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#PARALLEL Material [ELASTIC + VISCOUS]
		set VETag7 7071;  # material ID tag.
		uniaxialMaterial Parallel $VETag7 $VMTag7 $EMTag7; # Se vinculan en paralelo dos materiales (Suma de fuerzas).

	# DAMPER 7 [GAP-BOUCWEN + VISCOELASTIC] PARALLEL Material 
	set DAMPERTag7 127071;  # material ID tag.
	uniaxialMaterial Parallel $DAMPERTag7 $GapBwTagS $VETag7; # Se vinculan en paralelo dos materiales (Suma de fuerzas).


# VISCOELASTIC KELVIN-MODEL [DAMPER 8]-----------------------------------------------------------------------------------------------------------------------------------------------------------

		#ELASTIC Material
		set VMTag8 80;      # material ID tag. Definido como variable global.
		set Kv8 3541.23;
		set Cv8 1e6;
		set av8 1.00;
		uniaxialMaterial ViscousDamper $VMTag8 $Kv8 $Cv8 $av8; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#VISCOUS MATERIAL 
		set EMTag8 81;      # material ID tag. Definido como variable global.
		set Ke8 1e6;
		set Ce8 54.94;
		set ae8 1.00;
		uniaxialMaterial ViscousDamper $EMTag8 $Ke8 $Ce8 $ae8; #uniaxialMaterial ViscousDamper $matTag $Kd $Cd $alpha

		#PARALLEL Material [ELASTIC + VISCOUS]
		set VETag8 8081;  # material ID tag.
		uniaxialMaterial Parallel $VETag8 $VMTag8 $EMTag8; # Se vinculan en paralelo dos materiales (Suma de fuerzas).

	# DAMPER 8 [GAP-BOUCWEN + VISCOELASTIC] PARALLEL Material 
	set DAMPERTag8 128081;  # material ID tag.
	uniaxialMaterial Parallel $DAMPERTag8 $GapBwTagS $VETag8; # Se vinculan en paralelo dos materiales (Suma de fuerzas).
