# ==========[Columns element] ================================================================================================
# Units: Force(N), Distance(mm), Time(sec), --mass(Ton, Ns^2/mm)
# 
# $eleTag;    Unique element object tag
# $iNode;     Initial node
# $jNode;     End nodes
# $E;         Young's Modulus
# $G;         Shear Modulus
# $A;         cross-sectional area of element
# $Jx;        torsional moment of inertia of cross section
# $Iy;        second moment of area about the local y-axis
# $Iz;        second moment of area about the local z-axis
# $Avy;       Shear area for the local y-axis
# $Avz;       Shear area for the local z-axis
# $transfTag; identifier for previously-defined coordinate-transformation (CrdTransf) object
# $massDens;  element mass per unit length (optional, default = 0.0)
# -cMass;     to form consistent mass matrix (optional, default = lumped mass matrix) 
#
# element ElasticTimoshenkoBeam $eleTag $iNode $jNode $E $G $A $Jx $Iy $Iz $Avy $Avz $transfTag <-mass $massDens> <-cMass>
# element forceBeamColumn $eleTag $iNode $jNode $transfTag "HingeRadau $secTagI $LpI $secTagJ $LpJ $secTagInterior" <-mass $massDens> <-iter $maxIters $tol>

# ===========================================================================================================================================================
# Nota: Los elementos están construidos desde la base hasta las planchas.
# 		Por eso tiene esta sucesión [Ele_rig Col_N1 Ele_rig Ele_rig Col_N2 Ele_rig] .
#		Los nudos del cruce pilares-vigas son P1(69), P2(70), P3(71), P4(72).
# 		Solo están definidos los elementos elásticos como en SAP2000.
#		Son 4 pilares por 6 elementos = 24 elementos de pilares anotados con 1000.

# ELASTIC ELEMENTS (SAP2000):
# ---- [Pilar 1 - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 1001   1  5 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Arranque en zapata 
element ElasticTimoshenkoBeam 1005   5  9 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 3 ; # Pilar N1 (Planta Baja)
element ElasticTimoshenkoBeam 1009   9 69 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Cabeza pilar N1 en losa
element ElasticTimoshenkoBeam 1013  69 13 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Arranque pilar N2 en losa
element ElasticTimoshenkoBeam 1017  13 17 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 3 ; # Pilar N2 (PLanta Alta)
element ElasticTimoshenkoBeam 1021  17 21 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Células de carga
# ---- [Pilar 2 - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 1002   2  6 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Arranque en zapata 
element ElasticTimoshenkoBeam 1006   6 10 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 3 ; # Pilar N1 (Planta Baja)
element ElasticTimoshenkoBeam 1010  10 70 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Cabeza pilar N1 en losa
element ElasticTimoshenkoBeam 1014  70 14 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Arranque pilar N2 en losa
element ElasticTimoshenkoBeam 1018  14 18 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 3 ; # Pilar N2 (PLanta Alta)
element ElasticTimoshenkoBeam 1022  18 22 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Células de carga
# ---- [Pilar 3 - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 1003   3  7 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Arranque en zapata 
element ElasticTimoshenkoBeam 1007   7 11 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 3 ; # Pilar N1 (Planta Baja)
element ElasticTimoshenkoBeam 1011  11 71 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Cabeza pilar N1 en losa
element ElasticTimoshenkoBeam 1015  71 15 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Arranque pilar N2 en losa
element ElasticTimoshenkoBeam 1019  15 19 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 3 ; # Pilar N2 (PLanta Alta)
element ElasticTimoshenkoBeam 1023  19 23 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Células de carga
# ---- [Pilar 4 - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 1004   4  8 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Arranque en zapata 
element ElasticTimoshenkoBeam 1008   8 12 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 3 ; # Pilar N1 (Planta Baja)
element ElasticTimoshenkoBeam 1012  12 72 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Cabeza pilar N1 en losa
element ElasticTimoshenkoBeam 1016  72 16 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Arranque pilar N2 en losa
element ElasticTimoshenkoBeam 1020  16 20 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 3 ; # Pilar N2 (PLanta Alta)
element ElasticTimoshenkoBeam 1024  20 24 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 3 ; # Células de carga


# ===========================================================================================================================================================

# HINGE + ELASTIC CORE COLUMNS
# element ElasticTimoshenkoBeam 1001   1  4 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN [Pilar 1 - 120x120]
# element forceBeamColumn       1004   4 13 9 "HingeRadau $SecTag811 120.0 $SecTag811 120.0 $SecTag50"; # FIBER SECTION COLUMN
# element ElasticTimoshenkoBeam 1013  13 16 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN
# element ElasticTimoshenkoBeam 1016  16 19 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN
# element forceBeamColumn       1019  19 25 9 "HingeRadau $SecTag812 120.0 $SecTag50 120.0 $SecTag50"; # FIBER SECTION COLUMN
# element ElasticTimoshenkoBeam 1025 625 28 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN




# ===========================================================================================================================================================

# HINGE + FIBER CORE COLUMNS
# element ElasticTimoshenkoBeam 1001   1  4 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN [Pilar 1 - 120x120]
# element forceBeamColumn       1004   4 13 9 "HingeRadau $SecTag811 120.0 $SecTag811 120.0 $SecTag70"; # FIBER SECTION COLUMN
# element ElasticTimoshenkoBeam 1013  13 16 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN
# element ElasticTimoshenkoBeam 1016  16 19 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN
# element forceBeamColumn       1019  19 25 9 "HingeRadau $SecTag812 120.0 $SecTag70 120.0 $SecTag70"; # FIBER SECTION COLUMN
# element ElasticTimoshenkoBeam 1025 625 28 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN





# ===========================================================================================================================================================

# FIBER + ELASTIC CORE COLUMNS
# element ElasticTimoshenkoBeam 1001   1  4 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN [Pilar 1 - 120x120]
# element forceBeamColumn       1004   4 13 9 "HingeRadau $SecTag70 120.0 $SecTag70 120.0 $SecTag50"; # FIBER SECTION COLUMN
# element ElasticTimoshenkoBeam 1013  13 16 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN
# element ElasticTimoshenkoBeam 1016  16 19 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN
# element forceBeamColumn       1019  19 25 9 "HingeRadau $SecTag70 120.0 $SecTag50 120.0 $SecTag50"; # FIBER SECTION COLUMN
# element ElasticTimoshenkoBeam 1025 625 28 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN
 
 

# ===========================================================================================================================================================

# FIBER + FIBER CORE COLUMNS
# element ElasticTimoshenkoBeam 1001   1  4 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN [Pilar 1 - 120x120]
# element forceBeamColumn       1004   4 13 9 "HingeRadau $SecTag70 120.0 $SecTag70 120.0 $SecTag70"; # FIBER SECTION COLUMN
# element ElasticTimoshenkoBeam 1013  13 16 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN
# element ElasticTimoshenkoBeam 1016  16 19 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN
# element forceBeamColumn       1019  19 25 9 "HingeRadau $SecTag70 120.0 $SecTag70 120.0 $SecTag70"; # FIBER SECTION COLUMN
# element ElasticTimoshenkoBeam 1025 625 28 $E6 $G6 $Anx6 $Jx6 $Iy6 $Iz6 $Avy6 $Avz6 2 ; # RIGID COLUMN
 

# =========================================================================================================================================================