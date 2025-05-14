# ==========[SECTIONS] =========================================================================================================================================================================
# Units: Force(N), Distance(mm), Time(sec), Mass(Ton, Ns^2/mm)


# ELASTIC & LINEAR SECTIONS =================================================================================================================== 

# SEC_01 - COLUMNAS, VIGAS, NERVIOS Y ZUNCHOS (100x100) ---------------------------------------------------------------------------------------------------
set SecTag1 1;  # Section Tag
set E1         $EcCC; # [MPa,N/mm^2], Young's Modulus
set G1         $GcCC; # [MPa,N/mm^2], Shear Modulus
set Anx1    10000.00; # [mm^2], Area section in x-direction (Axial Force)
set Avy1     8333.33; # [mm^2], Area section in y-direction (Shear Force) 
set Avz1     8333.33; # [mm^2], Area section in z-direction (Shear Force)  
set Jx1  14083333.00; # [mm^4], Moment of inertia about the local x-axis yz-plane (Torsional moment)
set Iy1   8333333.33; # [mm^4], Moment of inertia about the local y-axis xz-plane (Lateral moment)
set Iz1   8333333.33; # [mm^4], Moment of inertia about the local z-axis xy-plane (Bending moment)
section Elastic $SecTag1 $E1 $Anx1 $Iz1 $Iy1 $G1 $Jx1 $alphaY1 $alphaZ1


# SEC_02 - ELEMENTO RÍGIDO HA (100x100) ---------------------------------------------------------------------------------------------------
set SecTag2 2;  # Section Tag
set E2          $Erg; # [MPa,N/mm^2], Young's Modulus
set G2          $Grg; # [MPa,N/mm^2], Shear Modulus
set Anx2    10000.00; # [mm^2], Area section in x-direction (Axial Force)
set Avy2     8333.33; # [mm^2], Area section in y-direction (Shear Force) 
set Avz2     8333.33; # [mm^2], Area section in z-direction (Shear Force)  
set Jx2  14083333.00; # [mm^4], Moment of inertia about the local x-axis yz-plane (Torsional moment)
set Iy2   8333333.33; # [mm^4], Moment of inertia about the local y-axis xz-plane (Lateral moment)
set Iz2   8333333.33; # [mm^4], Moment of inertia about the local z-axis xy-plane (Bending moment)
section Elastic $SecTag2 $E2 $Anx2 $Iz2 $Iy2 $G2 $Jx2 $alphaY2 $alphaZ2


# SEC_03 - ELEMENTO RÍGIDO RÓTULA (Ø25) ---------------------------------------------------------------------------------------------------
set SecTag3 3;  # Section Tag
set E3         $Erg; # [MPa,N/mm^2], Young's Modulus
set G3         $Grg; # [MPa,N/mm^2], Shear Modulus
set Anx3     490.87; # [mm^2], Area section in x-direction (Axial Force)
set Avy3     441.79; # [mm^2], Area section in y-direction (Shear Force) 
set Avz3     441.79; # [mm^2], Area section in z-direction (Shear Force)  
set Jx3    38349.52; # [mm^4], Moment of inertia about the local x-axis yz-plane (Torsional moment)
set Iy3    19174.76; # [mm^4], Moment of inertia about the local y-axis xz-plane (Lateral moment)
set Iz3    19174.76; # [mm^4], Moment of inertia about the local z-axis xy-plane (Bending moment)
section Elastic $SecTag3 $E3 $Anx3 $Iz3 $Iy3 $G3 $Jx3 $alphaY3 $alphaZ3


# SEC_04 - ELEMENTO RÍGIDO PLANCHA ACERO (3 PLANCHAS JUNTAS) ---------------------------------------------------------------------------------------------------
set SecTag4 4;  # Section Tag
set E4          $Erg; # [MPa,N/mm^2], Young's Modulus
set G4          $Grg; # [MPa,N/mm^2], Shear Modulus
set Anx4       52500; # [mm^2], Area section in x-direction (Axial Force)
set Avy4    43750.00; # [mm^2], Area section in y-direction (Shear Force) 
set Avz4    43750.00; # [mm^2], Area section in z-direction (Shear Force)  
set Jx4  167400000.0; # [mm^4], Moment of inertia about the local x-axis yz-plane (Torsional moment)
set Iy4 1094000000.0; # [mm^4], Moment of inertia about the local y-axis xz-plane (Lateral moment)
set Iz4   48234375.0; # [mm^4], Moment of inertia about the local z-axis xy-plane (Bending moment)
section Elastic $SecTag4 $E4 $Anx4 $Iz4 $Iy4 $G4 $Jx4 $alphaY4 $alphaZ4


# SEC_05 - ELEMENTO RÍGIDO PLANCHA ACERO (2+2 PLANCHAS SEPARADAS) ---------------------------------------------------------------------------------------------------
set SecTag5 5;  # Section Tag
set E5          $Erg; # [MPa,N/mm^2], Young's Modulus
set G5          $Grg; # [MPa,N/mm^2], Shear Modulus
set Anx5    71050.00; # [mm^2], Area section in x-direction (Axial Force)
set Avy5     2450.00; # [mm^2], Area section in y-direction (Shear Force) 
set Avz5    58333.33; # [mm^2], Area section in z-direction (Shear Force)  
set Jx5  104300000.0; # [mm^4], Moment of inertia about the local x-axis yz-plane (Torsional moment)
set Iy5 1458000000.0; # [mm^4], Moment of inertia about the local y-axis xz-plane (Lateral moment)
set Iz5  565500000.0; # [mm^4], Moment of inertia about the local z-axis xy-plane (Bending moment)
section Elastic $SecTag5 $E5 $Anx5 $Iz5 $Iy5 $G5 $Jx5 $alphaY5 $alphaZ5


# SEC_06 - ELEMENTO SHELL DE LOSA (35) ---------------------------------------------------------------------------------------------------

set SecTag6 6
# set HSec6 35; # [mm], Espesor
# section ElasticMembranePlateSection $SecTag6 $EcCU $vcCU $HSec6 0.0

set nlayer6       3; # Número de capas del elemento
set matg61  $CULTag; # Material Capa 1 (HA-55)
set hmat61     17.0; # [mm] Espesor Capa 1
set matg62  $BSLTag; # Material Capa 2 (Ø4)
set hmat62     1.0; # [mm] Espesor Capa 2
set matg63  $CULTag; # Material Capa 3 (HA-55)
set hmat63     17.0; # [mm] Espesor Capa 3

section LayeredShell $SecTag6 $nlayer6 $matg61 $hmat61 $matg62 $hmat62 $matg63 $hmat63


# INELASTIC & NONLINEAR SECTIONS =================================================================================================================== 
# FIBER SECTION properties -------------------------------------------------------------
# 
#                      y
#                      ^
#                      |     
#                -------------   -- 
#               |   cover     |   | 
#               |c Ø-------Ø c|   | 
#               |o |  core | o|   | 
#        z <--- |v |   +   | v| Hsec 
#               |e |  [x]  | e|   | 
#               |r Ø-------Ø r|   |
#               |   cover     |   | 
#                -------------   --  
#               |----Bsec-----|
#               


# SEC_07 - NONLINEAR COLUMN-100x100 ---------------------------------------------------------------------------------------------------

set SecTag7        7; # Section Tag

set HSec7      100.0; # [mm],Column Depth
set BSec7      100.0; # [mm], Column Width
set cover7      10.0; # [mm], Column cover to reinforcing steel NA, parallel to H
set Anx7    10000.00; # [mm^2], Area section in x-direction (Axial Force)
set Avy7     8333.33; # [mm^2], Area section in y-direction (Shear Force) 
set Avz7     8333.33; # [mm^2], Area section in z-direction (Shear Force)  
set Jx7  14083333.00; # [mm^4], Moment of inertia about the local x-axis yz-plane (Torsional moment)
set Iy7   8333333.33; # [mm^4], Moment of inertia about the local y-axis xz-plane (Lateral moment)
set Iz7   8333333.33; # [mm^4], Moment of inertia about the local z-axis xy-plane (Bending moment)
set GJ7 [expr $GcCC*($Jx7/1120.0)]; # [N.mm] Rigidez torsional elástica de la sección. GJ = G*(J/L). Lcolumn = 1120.0 mm

set coverY7 [expr $HSec7/2.0];	# The distance from the section z-axis to the edge of the cover concrete -- outer edge of cover concrete
set coverZ7 [expr $BSec7/2.0];	# The distance from the section y-axis to the edge of the cover concrete -- outer edge of cover concrete
set coreY7  [expr $coverY7-$cover7]
set coreZ7  [expr $coverZ7-$cover7]

set numBarsTop7 2;		# number of longitudinal-reinforcement bars in steel layer. -- top
set DimBarsTop7 8.0;	# Diameter of longitudinal-reinforcement bars in steel layer. -- top
set numBarsBot7 2;		# number of longitudinal-reinforcement bars in steel layer. -- bot
set DimBarsBot7 8.0;	# Diameter of longitudinal-reinforcement bars in steel layer. -- bot
set barAreaTop7 [expr 0.25*$pi*$DimBarsTop7**2];	# area of each longitudinal-reinforcement bars -- top
set barAreaBot7 [expr 0.25*$pi*$DimBarsBot7**2];	# area of each longitudinal-reinforcement bars -- bot

 section fiberSec $SecTag7 -GJ $GJ7 {;	# Define the fiber section
  # fiber_type  Mat_tag nºfiber_Zdirec_[v,^] nºfiber_Ydirec_[<,>]    coord_-Y_+Z_[v,<]    coord_-Y_-Z_[v,>]    coord_+Y_-Z_[^,>]   coord_+Y_+Z_[^,<]
	patch quadr $CCnTag 	16 						16 				-$coreY7  $coreZ7  	 -$coreY7  -$coreZ7    $coreY7  -$coreZ7   $coreY7  $coreZ7 ; # Define Núcleo confinado de la sección de hormigón
	patch quadr $CUnTag 	20 						 2 				 $coreY7  $coverZ7 	  $coreY7  -$coverZ7   $coverY7 -$coverZ7  $coverY7 $coverZ7; # Define recubrimiento superior  [^]  de la sección de hormigón
	patch quadr $CUnTag 	20 						 2 				-$coverY7 $coverZ7 	 -$coverY7 -$coverZ7  -$coreY7  -$coverZ7 -$coreY7  $coverZ7; # Define recubrimiento inferior  [v]  de la sección de hormigón
	patch quadr $CUnTag 	2  						16 				-$coreY7  $coverZ7 	 -$coreY7   $coreZ7    $coreY7   $coreZ7   $coreY7  $coverZ7; # Define recubrimiento izquierdo [<] de la sección de hormigón
	patch quadr $CUnTag 	2  						16 				-$coreY7 -$coreZ7  	 -$coreY7  -$coverZ7   $coreY7  -$coverZ7  $coreY7 -$coreZ7 ; # Define recubrimiento derecho   [>] de la sección de hormigón
	layer straight $BSnTag $numBarsBot7 $barAreaTop7 -$coreY7 $coreZ7 -$coreY7 -$coreZ7;	# bottom layer reinfocement
	layer straight $BSnTag $numBarsTop7 $barAreaBot7  $coreY7 $coreZ7  $coreY7 -$coreZ7;	# top layer reinforcement
    };	# end of fibersection definition


# Pilares planta baja: 
set SecTag8N1 81;  
section Aggregator $SecTag8N1 $PTag P $HMPTagN1 My $HMPTagN1 Mz $TTagHA68 T

# Pilares planta alta:
set SecTag8N2 82;  
section Aggregator $SecTag8N2 $PTag P $HMPTagN1 My $HMPTagN1 Mz $TTagHA47 T

# Vigas centrales:
set SecTag8V 83;  
section Aggregator $SecTag8V $PTag P $HMPTagVCen My $HMPTagVCen Mz $TTagHA55 T

# Vigas extremo:
set SecTag8V 83;  
section Aggregator $SecTag8V $PTag P $HMPTagVExt My $HMPTagVExt Mz $TTagHA55 T