function ForcePlateList = setForcePlateList (StancesOnFP,leg)
%
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

for k=1:length(StancesOnFP)
    
    StanceOnFP=StancesOnFP{k};
    
    for j=1:length(StanceOnFP)  %when more than a FP is struck
        
        if strcmp(StanceOnFP(j).Leg,leg)
            ForcePlateList{k}=StanceOnFP(j).Forceplatform;
        end
    end
    save_to_base(1)
    if isempty(ForcePlateList{k})
        error(['Trial ' num2str(k) ': the instrumented leg does not strike correctly the force platforms. Change method for the Analysis Window Computation or check the Acquisition.xml file']);
    end
    clear StanceOnFP
end
    

