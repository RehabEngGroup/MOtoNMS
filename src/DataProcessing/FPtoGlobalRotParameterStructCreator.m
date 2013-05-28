function FPtoGlobalRotationsParameters = FPtoGlobalRotParameterStructCreator(FProtations)

RotX=0;
RotY=0;
RotZ=0;

for i=1:size(FProtations,2)
    
    ax=FProtations(i).Axis;  %axis already exist as Matlab command
    
    if length(ax)==0
        error('No FPtoGlobalRotationsParameters for the second force platform are defined in Acquisition.xml file')
    end
        

    switch ax
        case 'X'
            
            RotX=i;
            
        case 'Y'
            
            RotY=i;
            
        case 'Z'
            
            RotZ=i;
    end
    
    degrees(i)=FProtations(i).Degrees;
end

%degrees size will be never bigger than 2 (maximum 2 rotations)...
Rot1=degrees(1);
%...but could be just 1 if there's no second rotation
if length(degrees)>1
    Rot2=degrees(2);
else
    Rot2=0;
end


FPtoGlobalRotationsParameters.RotX = RotX;
FPtoGlobalRotationsParameters.RotY = RotY;
FPtoGlobalRotationsParameters.RotZ = RotZ;
FPtoGlobalRotationsParameters.Rot1deg = Rot1;
FPtoGlobalRotationsParameters.Rot2deg = Rot2;