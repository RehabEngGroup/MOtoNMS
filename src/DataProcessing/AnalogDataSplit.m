
function [Forces,Moments, COP]= AnalogDataSplit(AnalogData,ForcePlatformInfo)
% Function to split AnalogData 
% Analog data from c3d files are organized like this:
% ForcePlatform type 1: [Fx1 Fy1 Fz1 Px1 Py1 Mz1 Fx2 Fy2 Fz2 Px2 Py2 Mz2..]
% ForcePlatform type 2: [Fx1 Fy1 Fz1 Mx1 My1 Mz1 Fx2 Fy2 Fz2 Mx2 My2 Mz2..]
% ForcePlatform type 3: [F1x12 F1x34 F1y14 F1y23 F1z1 F1z2 F1z3 F1z4 ...]
% ForcePlatform type 4: [Fx1 Fy1 Fz1 Mx1 My1 Mz1 Fx2 Fy2 Fz2 Mx2 My2 Mz2..]
% Implemented by Alice Mantoan, August 2012, <alice.mantoan@dei.unipd.it>
% Last update August 2013

nFP=length(ForcePlatformInfo);

for k=1: length(AnalogData)
    
    for i=1:nFP
        
        switch ForcePlatformInfo{i}.type
            
            case 1
                
                Forces{k}(:,:,i)=AnalogData{k}(:,(i+5*(i-1)):(i+5*(i-1)+2)); %it's the same for type 1,2,4 of FP
                
                COPz = zeros(length(AnalogData{k}(:,(i+3+5*(i-1)):(i+3+5*(i-1)+1))),1);
                COP{k}(:,:,i)=[AnalogData{k}(:,(i+3+5*(i-1)):(i+3+5*(i-1)+1)) COPz];    %COPx, COPy
                
                Moments{k}(:,:,i)=[COPz COPz AnalogData{k}(:,6*i)];
                
            case {2,4}
                
                Forces{k}(:,:,i)=AnalogData{k}(:,(i+5*(i-1)):(i+5*(i-1)+2)); 
                
                Moments{k}(:,:,i)=AnalogData{k}(:,(i+3+5*(i-1)):(i+3+5*(i-1)+2));
                %COP compute later..set to 0 here
                COP{k}(:,:,i) = zeros(length(AnalogData{k}(:,(i+3+5*(i-1)):(i+3+5*(i-1)+1))),3);
           

            case 3   
                
                ForcesFP3{k}(:,:,i)=AnalogData{k}(:,(i+7*(i-1)):(i+7*(i-1)+7));
                
                Forces{k}(:,:,i)=computeTotalForcesFP3(ForcesFP3{k}(:,:,i));
                
                Moments{k}(:,:,i)=computeMomentsFP3(ForcesFP3{k}(:,:,i),ForcePlatformInfo{i});
                
                %COP compute later..set to 0 here
                COP{k}(:,:,i) = zeros(length(AnalogData{k}(:,(i+3+5*(i-1)):(i+3+5*(i-1)+1))),3);
                
        end
    end
end
                

