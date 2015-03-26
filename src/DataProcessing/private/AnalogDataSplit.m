function [Forces,Moments, COP]= AnalogDataSplit(AnalogData,ForcePlatformInfo)
% Function to split AnalogData 
% Analog data from c3d files are organized like this:
% ForcePlatform type 1: [Fx1 Fy1 Fz1 Px1 Py1 Mz1 Fx2 Fy2 Fz2 Px2 Py2 Mz2..]
% ForcePlatform type 2: [Fx1 Fy1 Fz1 Mx1 My1 Mz1 Fx2 Fy2 Fz2 Mx2 My2 Mz2..]
% ForcePlatform type 3: [F1x12 F1x34 F1y14 F1y23 F1z1 F1z2 F1z3 F1z4 ...]
% ForcePlatform type 4: [Fx1 Fy1 Fz1 Mx1 My1 Mz1 Fx2 Fy2 Fz2 Mx2 My2 Mz2..]

% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2012-2014 Alice Mantoan, Monica Reggiani
%
% MOtoNMS is free software: you can redistribute it and/or modify it under 
% the terms of the GNU General Public License as published by the Free 
% Software Foundation, either version 3 of the License, or (at your option)
% any later version.
%
% Matlab MOtion data elaboration TOolbox for NeuroMusculoSkeletal applications
% is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
% PARTICULAR PURPOSE.  See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along 
% with MOtoNMS.  If not, see <http://www.gnu.org/licenses/>.
%
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
nFP=length(ForcePlatformInfo);
newAnalogData=AnalogData;

for k=1: length(AnalogData)
    
    for i=1:nFP
        
        switch ForcePlatformInfo{i}.type
                 
            case 1
                
                Forces{k}(:,:,i)=newAnalogData{k}(:,1:3); %it's the same for type 1,2,4 of FP
                
                COPz = zeros(size(newAnalogData{k}, 1),1);
                COP{k}(:,:,i)=[newAnalogData{k}(:,4:5) COPz];    %COPx, COPy
                
                Moments{k}(:,:,i)=[COPz COPz newAnalogData{k}(:,6)];
                       
                newAnalogData{k}=newAnalogData{k}(:,7:end);
            
            case {2,4}
                
                Forces{k}(:,:,i)=newAnalogData{k}(:,1:3);
                
                Moments{k}(:,:,i)=newAnalogData{k}(:,4:6);
                %COP compute later..set to 0 here
                COP{k}(:,:,i) = zeros(size(newAnalogData{k},1),3);
                
                newAnalogData{k}=newAnalogData{k}(:,7:end);
                
            case 3
                
                ForcesFP3{k}(:,:,i)=newAnalogData{k}(:,1:8);
                
                Forces{k}(:,:,i)=computeTotalForcesFP3(ForcesFP3{k}(:,:,i));
                
                Moments{k}(:,:,i)=computeMomentsFP3(ForcesFP3{k}(:,:,i),ForcePlatformInfo{i});
                
                %COP compute later..set to 0 here
                COP{k}(:,:,i) = zeros(size(newAnalogData{k},1),3);

                newAnalogData{k}=newAnalogData{k}(:,9:end);
         end
    end
end                               

