function globalCOP = convertCOPToGlobal(localCOP,rotFP_glParameters,fpInfo)
%reactionGRF=[reactionF1{k} reactionCOP1{k} reactionF2{k} reactionCOP2{k} reactionT1{k}  reactionT2{k}]

%Rotation to Global
globalCOP = RotateCS (localCOP,rotFP_glParameters);

%Compute COP translation

corner1 = fpInfo.corners(1, :);
corner2 = fpInfo.corners(2, :);
corner3 = fpInfo.corners(3, :);
corner4 = fpInfo.corners(4, :);

%Origin of FP CS --> ASSUMED TO BE IN THE CENTER --> TO BE VERIFIED!
FPcenter_lab = (corner1 + corner2 + corner3 + corner4)/4;

Xo_Offset=FPcenter_lab(1);
Yo_Offset=FPcenter_lab(2);
Zo_Offset=FPcenter_lab(3);


%COP translation + conversion in m

globalCOP(:,1)=(globalCOP(:,1)+Xo_Offset)/1000;

%COPy1
globalCOP(:,2)=(globalCOP(:,2)+Yo_Offset)/1000;
globalCOP(:,3)=(globalCOP(:,3)+Zo_Offset)/1000;

