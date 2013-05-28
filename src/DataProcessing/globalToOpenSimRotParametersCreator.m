%Convention for global reference system:
%1st axis: direction of motion
%2nd axis: vertical axis
%3rd axis: right hand rule
%Assumption:1st axis assumed to be in the same versus of OpenSim 1st axis,
%that should be the positive direction of motion

function globalToOpenSimRotations = globalToOpenSimRotParametersCreator(GlobalReferenceSystem)
%%globalToOpenSimRotParametersCreator
%compute global to OpenSim Rotations Parameters

switch GlobalReferenceSystem
    
    case 'XYZ'       %OpenSim
        
        RotX = 0;
        RotY = 0;
        RotZ = 0;
        Rot1 = 0;
        Rot2 = 0;
               
    case 'XZY'      %UWA
        
        RotX = 1;
        RotY = 0;
        RotZ = 0;
        Rot1 = 90;
        Rot2 = 0;
               
    case 'ZYX'      %DEI-Unipd 
        
        RotX = 0;
        RotY = 1;
        RotZ = 0;
        Rot1 = -90;
        Rot2 = 0;        
               
    case 'ZXY'      
        
        RotX = 1;
        RotY = 0;
        RotZ = 2;
        Rot1 = -90;
        Rot2 = -90;
        
    case 'YXZ'      
        
        RotX = 0;
        RotY = 2;
        RotZ = 1;
        Rot1 = -90;
        Rot2 = 180;        
               
    case 'YZX'      
        
        RotX = 1;
        RotY = 2;
        RotZ = 0;
        Rot1 = 90;
        Rot2 = 90;        
end

globalToOpenSimRotations.RotX = RotX;
globalToOpenSimRotations.RotY = RotY;
globalToOpenSimRotations.RotZ = RotZ;
globalToOpenSimRotations.Rot1deg = Rot1;
globalToOpenSimRotations.Rot2deg = Rot2;
%globalToOpenSimRotations.rot180 = str2num(char(answer(6)));
%globalToOpenSimRotations.numberPointKinematics = str2num(char(answer(7)));

