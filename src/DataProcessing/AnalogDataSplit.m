
function [Forces,Moments, COP]= AnalogDataSplit(AnalogData,ForcePlatformInfo)
% Function to split AnalogData 
% Analog data from c3d files are organized like this:
% ForcePlatform type 2: [Fx1 Fy1 Fz1 Mx1 My1 Mz1 Fx2 Fy2 Fz2 Mx2 My2 Mz2..]
% ForcePlatform type 1: [Fx1 Fy1 Fz1 Px1 Py1 Mz1 Fx2 Fy2 Fz2 Px2 Py2 Mz2 ]
% Implemented by Alice Mantoan, August 2012, <alice.mantoan@dei.unipd.it>

nFP=length(ForcePlatformInfo);

for k=1: length(AnalogData)
    
    for i=1:nFP
        
        Forces{k}(:,:,i)=AnalogData{k}(:,(i+5*(i-1)):(i+5*(i-1)+2)); %are the same for different type of FP
                
        %if (ForcePlatformInfo{1}.type==ForcePlatformInfo{2}.type & ForcePlatformInfo{2}.type==2)
        %FP{1}.type should be equal to FP{2}.type in any case
        
        if (ForcePlatformInfo{i}.type==2) %UWA case
            
            Moments{k}(:,:,i)=AnalogData{k}(:,(i+3+5*(i-1)):(i+3+5*(i-1)+2));
            %COP compute later..set to 0 here
            COP{k}(:,:,i) = zeros(length(AnalogData{k}(:,(i+3+5*(i-1)):(i+3+5*(i-1)+1))),3);
           
        else if ( ForcePlatformInfo{i}.type==1)  %Padova type: it returns Px & Py
                               
                COPz = zeros(length(AnalogData{k}(:,(i+3+5*(i-1)):(i+3+5*(i-1)+1))),1);
                COP{k}(:,:,i)=[AnalogData{k}(:,(i+3+5*(i-1)):(i+3+5*(i-1)+1)) COPz];    %COPx, COPy
                
                Moments{k}(:,:,i)=[COPz COPz AnalogData{k}(:,6*i)];
                
            end
        end        
    end
end
