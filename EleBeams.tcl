# ==========[Beams Elements] ================================================================================================
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

# ===========================================================================================================================================================
# Nota: Los elementos están construidos desde un Vano extremo de voladizo al otro.
# 		Por eso tiene esta sucesión [Vig_Ext Vig_Ext Ele_rig Ele_rig Vig_Cen Vig_Cen Vig_Cen Vig_Cen Ele_rig Ele_rig Vig_Ext Vig_Ext]. 
#		Los nudos del cruce pilares-vigas son P1(69), P2(70), P3(71), P4(72).
#		Solo están definidos los elementos elásticos como en SAP2000 (se actualizarían solo las vigas).
#		Son 4 vigas por 12 elementos = 48 elementos de vigas anotados con 2000.
#		Son 2 nervios por 8 elementos = 16 elementos de nervios anotados con 3000.
#		Son 4 zunchos por 8 elementos = 32 elementos de zunchos anotados con 4000.
#		Son 4 planchas por 6 elementos + 2 diagonales = 28 elementos de planchas anotados con 5000.

# ELASTIC ELEMENTS (SAP2000):
# ==== [NIVEL 1: VIGAS, NERVIOS Y ZUNCHOS] ==========================================================================================================
# ---- [Viga 1 - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 2001 25 26 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano extremo 
element ElasticTimoshenkoBeam 2002 26 27 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano extremo 
element ElasticTimoshenkoBeam 2003 27 70 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 1 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2004 70 28 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 1 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2005 28 29 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 2006 29 30 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 2007 30 31 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 2008 31 32 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 2009 32 72 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 1 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2010 72 33 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 1 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2011 33 34 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano extremo 
element ElasticTimoshenkoBeam 2012 34 35 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano extremo 
# ---- [Viga 2 - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 2013 36 37 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano extremo 
element ElasticTimoshenkoBeam 2014 37 38 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano extremo 
element ElasticTimoshenkoBeam 2015 38 70 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 2 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2016 70 39 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 2 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2017 39 40 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 2018 40 41 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 2019 41 42 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 2020 42 43 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 2021 43 69 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 2 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2022 69 44 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 2 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2023 44 45 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano extremo 
element ElasticTimoshenkoBeam 2024 45 46 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano extremo
# ---- [Viga 3 - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 2025 47 48 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano extremo 
element ElasticTimoshenkoBeam 2026 48 49 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano extremo 
element ElasticTimoshenkoBeam 2027 49 72 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 2 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2028 72 50 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 2 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2029 50 51 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 2030 51 52 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 2031 52 53 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 2032 53 54 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 2033 54 71 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 2 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2034 71 55 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 2 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2035 55 56 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano extremo 
element ElasticTimoshenkoBeam 2036 56 57 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano extremo
# ---- [Viga 4 - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 2037 58 59 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano extremo 
element ElasticTimoshenkoBeam 2038 59 60 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano extremo 
element ElasticTimoshenkoBeam 2039 60 69 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 1 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2040 69 61 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 1 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2041 61 62 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 2042 62 63 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 2043 63 64 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 2044 64 65 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 2045 65 71 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 1 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2046 71 66 $E2 $G2 $Anx2 $Jx2 $Iy2 $Iz2 $Avy2 $Avz2 1 ;  # Cruce con losa
element ElasticTimoshenkoBeam 2047 66 67 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano extremo 
element ElasticTimoshenkoBeam 2048 67 68 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano extremo
# ---- [Nervio Dir X - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 3001 73 74 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 3002 74 63 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 3003 63 75 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 3004 75 76 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 3005 76 77 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 3006 77 30 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 3007 30 78 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 3008 78 79 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano Vano extremo
# ---- [Nervio Dir Y - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 3009 81 82 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 3010 82 41 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 3011 41 83 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 3012 83 76 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 3013 76 84 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 3014 84 52 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 3015 52 85 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 3016 85 86 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano Vano extremo
# ---- [Zuncho 1 - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 4001 87 88 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 4002 88 36 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 4003 36 89 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 4004 89 79 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 4005 79 90 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 4006 90 47 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 4007 47 91 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 4008 91 92 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano Vano extremo
# ---- [Zuncho 2 - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 4009 87 93 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 4010 93 25 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 4011 25 94 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 4012 94 81 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 4013 81 95 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 4014 95 58 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 4015 58 96 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 4016 96 97 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano Vano extremo
# ---- [Zuncho 3 - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 4017 92   98 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 4018 98   35 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 4019 35   99 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 4020 99   86 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 4021 86  100 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 4022 100  68 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano central 
element ElasticTimoshenkoBeam 4023 68  101 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 4024 101 102 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 2 ;  # Vano Vano extremo
# ---- [Zuncho 4 - 100x100] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 4025 97  103 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 4026 103  46 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 4027 46  104 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 4028 104  73 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 4029 73  105 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 4030 105  57 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano central 
element ElasticTimoshenkoBeam 4031 57  106 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano Vano extremo 
element ElasticTimoshenkoBeam 4032 106 102 $E1 $G1 $Anx1 $Jx1 $Iy1 $Iz1 $Avy1 $Avz1 1 ;  # Vano Vano extremo

# ==== [NIVEL 2: PLACAS] ==========================================================================================================
# ---- [Planchas Viga 1 - 3 Planchas] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 5001 107 108 $E4 $G4 $Anx4 $Jx4 $Iy4 $Iz4 $Avy4 $Avz4 1 ; # Vano extremo
element ElasticTimoshenkoBeam 5002 108  22 $E4 $G4 $Anx4 $Jx4 $Iy4 $Iz4 $Avy4 $Avz4 1 ; # Vano extremo
element ElasticTimoshenkoBeam 5003 22  109 $E4 $G4 $Anx4 $Jx4 $Iy4 $Iz4 $Avy4 $Avz4 1 ; # Vano central
element ElasticTimoshenkoBeam 5004 109  24 $E4 $G4 $Anx4 $Jx4 $Iy4 $Iz4 $Avy4 $Avz4 1 ; # Vano central
element ElasticTimoshenkoBeam 5005 24  110 $E4 $G4 $Anx4 $Jx4 $Iy4 $Iz4 $Avy4 $Avz4 1 ; # Vano extremo
element ElasticTimoshenkoBeam 5006 110 111 $E4 $G4 $Anx4 $Jx4 $Iy4 $Iz4 $Avy4 $Avz4 1 ; # Vano extremo
# ---- [Planchas Viga 2 - 2+2 Planchas] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 5007 112 113 $E5 $G5 $Anx5 $Jx5 $Iy5 $Iz5 $Avy5 $Avz5 2 ; # Vano extremo
element ElasticTimoshenkoBeam 5008 113  22 $E5 $G5 $Anx5 $Jx5 $Iy5 $Iz5 $Avy5 $Avz5 2 ; # Vano extremo
element ElasticTimoshenkoBeam 5009 22  114 $E5 $G5 $Anx5 $Jx5 $Iy5 $Iz5 $Avy5 $Avz5 2 ; # Vano central
element ElasticTimoshenkoBeam 5010 114  21 $E5 $G5 $Anx5 $Jx5 $Iy5 $Iz5 $Avy5 $Avz5 2 ; # Vano central
element ElasticTimoshenkoBeam 5011 21  115 $E5 $G5 $Anx5 $Jx5 $Iy5 $Iz5 $Avy5 $Avz5 2 ; # Vano extremo
element ElasticTimoshenkoBeam 5012 115 116 $E5 $G5 $Anx5 $Jx5 $Iy5 $Iz5 $Avy5 $Avz5 2 ; # Vano extremo
# ---- [Planchas Viga 3 - 2+2 Planchas] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 5013 117 118 $E5 $G5 $Anx5 $Jx5 $Iy5 $Iz5 $Avy5 $Avz5 2 ; # Vano extremo
element ElasticTimoshenkoBeam 5014 118  24 $E5 $G5 $Anx5 $Jx5 $Iy5 $Iz5 $Avy5 $Avz5 2 ; # Vano extremo
element ElasticTimoshenkoBeam 5015 24  119 $E5 $G5 $Anx5 $Jx5 $Iy5 $Iz5 $Avy5 $Avz5 2 ; # Vano central
element ElasticTimoshenkoBeam 5016 119  23 $E5 $G5 $Anx5 $Jx5 $Iy5 $Iz5 $Avy5 $Avz5 2 ; # Vano central
element ElasticTimoshenkoBeam 5017 23  120 $E5 $G5 $Anx5 $Jx5 $Iy5 $Iz5 $Avy5 $Avz5 2 ; # Vano extremo
element ElasticTimoshenkoBeam 5018 120 121 $E5 $G5 $Anx5 $Jx5 $Iy5 $Iz5 $Avy5 $Avz5 2 ; # Vano extremo
# ---- [Planchas Viga 4 - 3 Planchas] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 5019 122 123 $E4 $G4 $Anx4 $Jx4 $Iy4 $Iz4 $Avy4 $Avz4 1 ; # Vano extremo
element ElasticTimoshenkoBeam 5020 123  21 $E4 $G4 $Anx4 $Jx4 $Iy4 $Iz4 $Avy4 $Avz4 1 ; # Vano extremo
element ElasticTimoshenkoBeam 5021 21  124 $E4 $G4 $Anx4 $Jx4 $Iy4 $Iz4 $Avy4 $Avz4 1 ; # Vano central
element ElasticTimoshenkoBeam 5022 124  23 $E4 $G4 $Anx4 $Jx4 $Iy4 $Iz4 $Avy4 $Avz4 1 ; # Vano central
element ElasticTimoshenkoBeam 5023 23  125 $E4 $G4 $Anx4 $Jx4 $Iy4 $Iz4 $Avy4 $Avz4 1 ; # Vano extremo
element ElasticTimoshenkoBeam 5024 125 126 $E4 $G4 $Anx4 $Jx4 $Iy4 $Iz4 $Avy4 $Avz4 1 ; # Vano extremo
# ---- [Diagonales CMD - P1-P4] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 5025 21 127 $E3 $G3 $Anx3 $Jx3 $Iy3 $Iz3 $Avy3 $Avz3 5 ; # Vano central
element ElasticTimoshenkoBeam 5026 127 24 $E3 $G3 $Anx3 $Jx3 $Iy3 $Iz3 $Avy3 $Avz3 5 ; # Vano central
# ---- [Diagonales CMD - P2-P3] ----------------------------------------------------------------------------------------------------------------------------------
element ElasticTimoshenkoBeam 5027 22 127 $E3 $G3 $Anx3 $Jx3 $Iy3 $Iz3 $Avy3 $Avz3 4 ; # Vano central
element ElasticTimoshenkoBeam 5028 127 23 $E3 $G3 $Anx3 $Jx3 $Iy3 $Iz3 $Avy3 $Avz3 4 ; # Vano central
