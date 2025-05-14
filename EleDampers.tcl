# ==========[Dampers element] ================================================================================================
# Units: Force(N), Distance(mm), Time(sec), --mass(Ton, Ns^2/mm)
# 
# Coordenadas del eje local y respecto el eje de coordenadas global
#
#              Y (plane)
#    D1/D5 o   ^
#           \  |
#            \ |
#       D3    \|    D6
#       o------+-----o> X (plane)
#             /Z(out)
#            /
#           /
#    D2/D4 o
#
#            Xglobal    Yglobal   Zglobal
# Damper 1    -0.3841224  0.9232822 0.0; # ylocal respecto XYZglobal
# Damper 2    -0.3841224 -0.9232822 0.0
# Damper 3    -1.0        0.0       0.0
# Damper 4    -0.3841224 -0.9232822 0.0
# Damper 5    -0.3841224  0.9232822 0.0
# Damper 6     1.0        0.0       0.0
# element twoNodeLink $eleTag $iNode $jNode -mat $matTags -dir $dirs <-orient <$x1 $x2 $x3> $y1 $y2 $y3> 


# $BWTag; Hysteretic Damper Material
# $GapBwTagS; Gap-Hysteretic Damper Material

# element twoNodeLink 4001  1  18 -mat $GapBwTagS -dir 1 -orient -0.3841224  0.9232822 0.0; # Damper 1
# element twoNodeLink 4002  1  17 -mat $GapBwTagS -dir 1 -orient -0.3841224 -0.9232822 0.0; # Damper 2
# element twoNodeLink 4003  3  17 -mat $GapBwTagS -dir 1 -orient -1.0        0.0       0.0; # Damper 3
# element twoNodeLink 4004 16  31 -mat $GapBwTagS -dir 1 -orient -0.3841224 -0.9232822 0.0; # Damper 4
# element twoNodeLink 4005 16  32 -mat $GapBwTagS -dir 1 -orient -0.3841224  0.9232822 0.0; # Damper 5
# element twoNodeLink 4006 17 411 -mat $GapBwTagS -dir 1 -orient  1.0        0.0       0.0; # Damper 6


element twoNodeLink 4001  1  18 -mat $DAMPERTag1 -dir 1 -orient -0.3841224  0.9232822 0.0; # Damper 1
element twoNodeLink 4002  1  17 -mat $DAMPERTag2 -dir 1 -orient -0.3841224 -0.9232822 0.0; # Damper 2
element twoNodeLink 4003  3  17 -mat $DAMPERTag3 -dir 1 -orient -1.0        0.0       0.0; # Damper 3
element twoNodeLink 4004 16  31 -mat $DAMPERTag4 -dir 1 -orient -0.3841224 -0.9232822 0.0; # Damper 4
element twoNodeLink 4005 16  32 -mat $DAMPERTag5 -dir 1 -orient -0.3841224  0.9232822 0.0; # Damper 5
element twoNodeLink 4006 17 411 -mat $DAMPERTag6 -dir 1 -orient  1.0        0.0       0.0; # Damper 6

