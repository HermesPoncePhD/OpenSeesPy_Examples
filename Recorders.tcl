# ==========[RECORDERS] =========================================================================================================================================================================
# Units: Force(N), Distance(mm), Time(sec), Mass(Ton, Ns^2/mm)


	file mkdir $dataDir/Modes
	file mkdir $dataDir/Matrices

	file mkdir $dataDir/GDLNode
	
		recorder Node -file $dataDir/GDLNode/DispNodes.out -time -nodeRange 1 "$::NodeEnd" -dof 1 2 3 disp;

	file mkdir $dataDir/Displacement
	
		recorder Node -file $dataDir/Displacement/DespB001.out -time -node 1 -dof 1 2 3 4 5 6 disp; # P1, Desplazamientos en arranque de pilares
	    recorder Node -file $dataDir/Displacement/DespB002.out -time -node 2 -dof 1 2 3 4 5 6 disp; # P2
		recorder Node -file $dataDir/Displacement/DespB003.out -time -node 3 -dof 1 2 3 4 5 6 disp; # P3
		
		recorder Node -file $dataDir/Displacement/DespN016.out -time -node 16 -dof 1 2 3 4 5 6 disp; # P1, Desplazamientos en cabeza de pilares en Nivel 1
		recorder Node -file $dataDir/Displacement/DespN017.out -time -node 17 -dof 1 2 3 4 5 6 disp; # P2
		recorder Node -file $dataDir/Displacement/DespN018.out -time -node 18 -dof 1 2 3 4 5 6 disp; # P3

		recorder Node -file $dataDir/Displacement/DespN028.out -time -node 28 -dof 1 2 3 4 5 6 disp; # P1, Desplazamientos en cabeza de pilares en Nivel 2
		recorder Node -file $dataDir/Displacement/DespN029.out -time -node 29 -dof 1 2 3 4 5 6 disp; # P2
		recorder Node -file $dataDir/Displacement/DespN030.out -time -node 30 -dof 1 2 3 4 5 6 disp; # P3

	    recorder Node -file $dataDir/Displacement/DespN203.out -time -node 203 -dof 1 2 3 4 5 6 disp; # Desplazamientos en CM Nivel 1
		recorder Node -file $dataDir/Displacement/DespN576.out -time -node 576 -dof 1 2 3 4 5 6 disp; # Desplazamientos en CM Nivel 2

	file mkdir $dataDir/Reactions
	
		recorder Node -file $dataDir/Reactions/ReacB001.out -time -node 1 -dof 1 2 3 4 5 6 reaction; # P1, Reacciones en arranque de pilares
		recorder Node -file $dataDir/Reactions/ReacB002.out -time -node 2 -dof 1 2 3 4 5 6 reaction; # P2	
		recorder Node -file $dataDir/Reactions/ReacB003.out -time -node 3 -dof 1 2 3 4 5 6 reaction; # P3
		
	file mkdir $dataDir/Acceleration
	
		recorder Node -file $dataDir/Acceleration/AccB001.out -time -node 1 -dof 1 2 3 4 5 6 accel; # P1, Aceleraciones en arranque de pilares
		recorder Node -file $dataDir/Acceleration/AccB002.out -time -node 2 -dof 1 2 3 4 5 6 accel;	# P2
		recorder Node -file $dataDir/Acceleration/AccB003.out -time -node 3 -dof 1 2 3 4 5 6 accel; # P3

		recorder Node -file $dataDir/Acceleration/AccN016.out -time -node 16 -dof 1 2 3 4 5 6 accel; # P1, Aceleraciones en cabeza de pilares en Nivel 1
		recorder Node -file $dataDir/Acceleration/AccN017.out -time -node 17 -dof 1 2 3 4 5 6 accel; # P2	
		recorder Node -file $dataDir/Acceleration/AccN018.out -time -node 18 -dof 1 2 3 4 5 6 accel; # P3

		recorder Node -file $dataDir/Acceleration/AccN028.out -time -node 28 -dof 1 2 3 4 5 6 accel; # P1, Aceleraciones en cabeza de pilares en Nivel 2
		recorder Node -file $dataDir/Acceleration/AccN029.out -time -node 29 -dof 1 2 3 4 5 6 accel; # P2	
		recorder Node -file $dataDir/Acceleration/AccN030.out -time -node 30 -dof 1 2 3 4 5 6 accel; # P3	

		recorder Node -file $dataDir/Acceleration/AccN203.out -time -node 203 -dof 1 2 3 4 5 6 accel; # Aceleraciones en CM Nivel 1
		recorder Node -file $dataDir/Acceleration/AccN576.out -time -node 576 -dof 1 2 3 4 5 6 accel; # Aceleraciones en CM Nivel 2
	
	file mkdir $dataDir/GlobalForce
	
		recorder Element -file $dataDir/GlobalForce/F101.out -time -ele 1004 globalForce; # Fuerzas globales en P1 Nivel 0-1
		recorder Element -file $dataDir/GlobalForce/F112.out -time -ele 1019 globalForce; # Fuerzas globales en P1 Nivel 1-2

		recorder Element -file $dataDir/GlobalForce/F201.out -time -ele 1005 globalForce; # Fuerzas globales en P2 Nivel 0-1
		recorder Element -file $dataDir/GlobalForce/F212.out -time -ele 1020 globalForce; # Fuerzas globales en P2 Nivel 1-2
		
		recorder Element -file $dataDir/GlobalForce/F301.out -time -ele 1006 globalForce; # Fuerzas globales en P3 Nivel 0-1
		recorder Element -file $dataDir/GlobalForce/F312.out -time -ele 1021 globalForce; # Fuerzas globales en P3 Nivel 1-2	
		
	file mkdir $dataDir/Damper
	
		recorder Element -file $dataDir/Damper/D1damp.out -time -ele 4001 deformations; # Damper 1 - Displacement
		recorder Element -file $dataDir/Damper/F1damp.out -time -ele 4001 localForce;   # Damper 1 - Force
	
		recorder Element -file $dataDir/Damper/D2damp.out -time -ele 4002 deformations; # Damper 2 - Displacement
		recorder Element -file $dataDir/Damper/F2damp.out -time -ele 4002 localForce;   # Damper 2 - Force
		
		recorder Element -file $dataDir/Damper/D3damp.out -time -ele 4003 deformations; # Damper 3 - Displacement
		recorder Element -file $dataDir/Damper/F3damp.out -time -ele 4003 localForce;   # Damper 3 - Force
		
		recorder Element -file $dataDir/Damper/D4damp.out -time -ele 4004 deformations; # Damper 4 - Displacement
		recorder Element -file $dataDir/Damper/F4damp.out -time -ele 4004 localForce;   # Damper 4 - Force
		
		recorder Element -file $dataDir/Damper/D5damp.out -time -ele 4005 deformations; # Damper 5 - Displacement
		recorder Element -file $dataDir/Damper/F5damp.out -time -ele 4005 localForce;   # Damper 5 - Force
		
		recorder Element -file $dataDir/Damper/D6damp.out -time -ele 4006 deformations; # Damper 6 - Displacement
		recorder Element -file $dataDir/Damper/F6damp.out -time -ele 4006 localForce;   # Damper 6 - Force
	
	file mkdir $dataDir/Section
		
		recorder Element -file $dataDir/Section/D101sec1h.out -time -ele 1004 section 1 deformation; # P1 Nivel 0-1, Sec 1 Rótula (i)
		recorder Element -file $dataDir/Section/F101sec1h.out -time -ele 1004 section 1 force;
		
		recorder Element -file $dataDir/Section/D101sec2i.out -time -ele 1004 section 2 deformation; # P1 Nivel 0-1, Sec 2 Interior
		recorder Element -file $dataDir/Section/F101sec2i.out -time -ele 1004 section 2 force;
		recorder Element -file $dataDir/Section/D101sec3i.out -time -ele 1004 section 3 deformation; # P1 Nivel 0-1, Sec 3 Interior
		recorder Element -file $dataDir/Section/F101sec3i.out -time -ele 1004 section 3 force;
		recorder Element -file $dataDir/Section/D101sec4i.out -time -ele 1004 section 4 deformation; # P1 Nivel 0-1, Sec 4 Interior
		recorder Element -file $dataDir/Section/F101sec4i.out -time -ele 1004 section 4 force;
		recorder Element -file $dataDir/Section/D101sec5i.out -time -ele 1004 section 5 deformation; # P1 Nivel 0-1, Sec 5 Interior
		recorder Element -file $dataDir/Section/F101sec5i.out -time -ele 1004 section 5 force;

		recorder Element -file $dataDir/Section/D101sec6h.out -time -ele 1004 section 6 deformation; # P1 Nivel 0-1, Sec 6 Rótula (j)
		recorder Element -file $dataDir/Section/F101sec6h.out -time -ele 1004 section 6 force;		
		
		recorder Element -file $dataDir/Section/D112sec1h.out -time -ele 1019 section 1 deformation; # P1 Nivel 1-2, Sec 1 Rótula (i)
		recorder Element -file $dataDir/Section/F112sec1h.out -time -ele 1019 section 1 force;
	
		recorder Element -file $dataDir/Section/D112sec2i.out -time -ele 1019 section 2 deformation; # P1 Nivel 1-2, Sec 2 Interior
		recorder Element -file $dataDir/Section/F112sec2i.out -time -ele 1019 section 2 force;
		recorder Element -file $dataDir/Section/D112sec3i.out -time -ele 1019 section 3 deformation; # P1 Nivel 1-2, Sec 3 Interior
		recorder Element -file $dataDir/Section/F112sec3i.out -time -ele 1019 section 3 force;
		recorder Element -file $dataDir/Section/D112sec4i.out -time -ele 1019 section 4 deformation; # P1 Nivel 1-2, Sec 4 Interior
		recorder Element -file $dataDir/Section/F112sec4i.out -time -ele 1019 section 4 force;
		recorder Element -file $dataDir/Section/D112sec5i.out -time -ele 1019 section 5 deformation; # P1 Nivel 1-2, Sec 5 Interior
		recorder Element -file $dataDir/Section/F112sec5i.out -time -ele 1019 section 5 force;

		recorder Element -file $dataDir/Section/D112sec6h.out -time -ele 1019 section 6 deformation; # P1 Nivel 1-2, Sec 6 Rótula (j)
		recorder Element -file $dataDir/Section/F112sec6h.out -time -ele 1019 section 6 force;			
		
		
		
		recorder Element -file $dataDir/Section/D201sec1h.out -time -ele 1005 section 1 deformation; # P2 Nivel 0-1, Sec 1 Rótula (i)
		recorder Element -file $dataDir/Section/F201sec1h.out -time -ele 1005 section 1 force;
		
		recorder Element -file $dataDir/Section/D201sec2i.out -time -ele 1005 section 2 deformation; # P2 Nivel 0-1, Sec 2 Interior
		recorder Element -file $dataDir/Section/F201sec2i.out -time -ele 1005 section 2 force;
		recorder Element -file $dataDir/Section/D201sec3i.out -time -ele 1005 section 3 deformation; # P2 Nivel 0-1, Sec 3 Interior
		recorder Element -file $dataDir/Section/F201sec3i.out -time -ele 1005 section 3 force;
		recorder Element -file $dataDir/Section/D201sec4i.out -time -ele 1005 section 4 deformation; # P2 Nivel 0-1, Sec 4 Interior
		recorder Element -file $dataDir/Section/F201sec4i.out -time -ele 1005 section 4 force;
		recorder Element -file $dataDir/Section/D201sec5i.out -time -ele 1005 section 5 deformation; # P2 Nivel 0-1, Sec 5 Interior
		recorder Element -file $dataDir/Section/F201sec5i.out -time -ele 1005 section 5 force;

		recorder Element -file $dataDir/Section/D201sec6h.out -time -ele 1005 section 6 deformation; # P2 Nivel 0-1, Sec 6 Rótula (j)
		recorder Element -file $dataDir/Section/F201sec6h.out -time -ele 1005 section 6 force;		
		
		recorder Element -file $dataDir/Section/D212sec1h.out -time -ele 1020 section 1 deformation; # P2 Nivel 1-2, Sec 1 Rótula (i)
		recorder Element -file $dataDir/Section/F212sec1h.out -time -ele 1020 section 1 force;
	
		recorder Element -file $dataDir/Section/D212sec2i.out -time -ele 1020 section 2 deformation; # P2 Nivel 1-2, Sec 2 Interior
		recorder Element -file $dataDir/Section/F212sec2i.out -time -ele 1020 section 2 force;
		recorder Element -file $dataDir/Section/D212sec3i.out -time -ele 1020 section 3 deformation; # P2 Nivel 1-2, Sec 3 Interior
		recorder Element -file $dataDir/Section/F212sec3i.out -time -ele 1020 section 3 force;
		recorder Element -file $dataDir/Section/D212sec4i.out -time -ele 1020 section 4 deformation; # P2 Nivel 1-2, Sec 4 Interior
		recorder Element -file $dataDir/Section/F212sec4i.out -time -ele 1020 section 4 force;
		recorder Element -file $dataDir/Section/D212sec5i.out -time -ele 1020 section 5 deformation; # P2 Nivel 1-2, Sec 5 Interior
		recorder Element -file $dataDir/Section/F212sec5i.out -time -ele 1020 section 5 force;

		recorder Element -file $dataDir/Section/D212sec6h.out -time -ele 1020 section 6 deformation; # P2 Nivel 1-2, Sec 6 Rótula (j)
		recorder Element -file $dataDir/Section/F212sec6h.out -time -ele 1020 section 6 force;	
		
		
		
		recorder Element -file $dataDir/Section/D301sec1h.out -time -ele 1006 section 1 deformation; # P3 Nivel 0-1, Sec 1 Rótula (i)
		recorder Element -file $dataDir/Section/F301sec1h.out -time -ele 1006 section 1 force;
		
		recorder Element -file $dataDir/Section/D301sec2i.out -time -ele 1006 section 2 deformation; # P3 Nivel 0-1, Sec 2 Interior
		recorder Element -file $dataDir/Section/F301sec2i.out -time -ele 1006 section 2 force;
		recorder Element -file $dataDir/Section/D301sec3i.out -time -ele 1006 section 3 deformation; # P3 Nivel 0-1, Sec 3 Interior
		recorder Element -file $dataDir/Section/F301sec3i.out -time -ele 1006 section 3 force;
		recorder Element -file $dataDir/Section/D301sec4i.out -time -ele 1006 section 4 deformation; # P3 Nivel 0-1, Sec 4 Interior
		recorder Element -file $dataDir/Section/F301sec4i.out -time -ele 1006 section 4 force;
		recorder Element -file $dataDir/Section/D301sec5i.out -time -ele 1006 section 5 deformation; # P3 Nivel 0-1, Sec 5 Interior
		recorder Element -file $dataDir/Section/F301sec5i.out -time -ele 1006 section 5 force;

		recorder Element -file $dataDir/Section/D301sec6h.out -time -ele 1006 section 6 deformation; # P3 Nivel 0-1, Sec 6 Rótula (j)
		recorder Element -file $dataDir/Section/F301sec6h.out -time -ele 1006 section 6 force;		
		
		recorder Element -file $dataDir/Section/D312sec1h.out -time -ele 1021 section 1 deformation; # P3 Nivel 1-2, Sec 1 Rótula (i)
		recorder Element -file $dataDir/Section/F312sec1h.out -time -ele 1021 section 1 force;
	
		recorder Element -file $dataDir/Section/D312sec2i.out -time -ele 1021 section 2 deformation; # P3 Nivel 1-2, Sec 2 Interior
		recorder Element -file $dataDir/Section/F312sec2i.out -time -ele 1021 section 2 force;
		recorder Element -file $dataDir/Section/D312sec3i.out -time -ele 1021 section 3 deformation; # P3 Nivel 1-2, Sec 3 Interior
		recorder Element -file $dataDir/Section/F312sec3i.out -time -ele 1021 section 3 force;
		recorder Element -file $dataDir/Section/D312sec4i.out -time -ele 1021 section 4 deformation; # P3 Nivel 1-2, Sec 4 Interior
		recorder Element -file $dataDir/Section/F312sec4i.out -time -ele 1021 section 4 force;
		recorder Element -file $dataDir/Section/D312sec5i.out -time -ele 1021 section 5 deformation; # P3 Nivel 1-2, Sec 5 Interior
		recorder Element -file $dataDir/Section/F312sec5i.out -time -ele 1021 section 5 force;

		recorder Element -file $dataDir/Section/D312sec6h.out -time -ele 1021 section 6 deformation; # P3 Nivel 1-2, Sec 6 Rótula (j)
		recorder Element -file $dataDir/Section/F312sec6h.out -time -ele 1021 section 6 force;	
		

	# file mkdir $dataDir/Drift
		# recorder Drift -file $dataDir/Drift/DerivP11.out -time -iNode  4 -jNode 13 -dof 1 2 3 4 5 6 - perpDirn 1 ; # DERIVA LATERAL
		# recorder Drift -file $dataDir/Drift/DerivP12.out -time -iNode 19 -jNode 25 -dof 1 2 3 4 5 6 - perpDirn 1 ; 
		
		# recorder Drift -file $dataDir/Drift/DerivP21.out -time -iNode  5 -jNode 14 -dof 1 2 3 4 5 6 - perpDirn 1 ; # DERIVA LATERAL
		# recorder Drift -file $dataDir/Drift/DerivP22.out -time -iNode 20 -jNode 26 -dof 1 2 3 4 5 6 - perpDirn 1 ; 
		
		# recorder Drift -file $dataDir/Drift/DerivP31.out -time -iNode  6 -jNode 15 -dof 1 2 3 4 5 6 - perpDirn 1 ; # DERIVA LATERAL
		# recorder Drift -file $dataDir/Drift/DerivP32.out -time -iNode 21 -jNode 27 -dof 1 2 3 4 5 6 - perpDirn 1 ;
		