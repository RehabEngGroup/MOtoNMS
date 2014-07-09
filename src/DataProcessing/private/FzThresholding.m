function [thrForces, thrMoments] = FzThresholding(filtForces,filtMoments)
% for COP computation
% find when vertical forces drop below threshold, and then make
% all of the force and COP values 0.0 at these points
% refere to http://www.kwon3d.com/theory/grf/cop.html:
% CP position can be very sensitive to errors in the moment & force for a
% small Fz. This is why we get erroneous CP positions at the beginning and
% end of the foot contact phase where Fz is fairly small. A small error can
% be easily introduced during the zero-setting procedure if the system is 
% not well set up. For this reason,one needs to set the threshold for Fz.
% If Fz is smaller than the threshold, the program does not generate the
% CP coordinates.

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
% values are still in FP action based reference system
FPlateThreshold=-40;     %N: compromise between 20, 40 and 60 (all tested)
%the same threshold is used for ComputeStancePhase method
    
for k=1:length(filtForces)
    
    thrForces{k}=filtForces{k};
    thrMoments{k}= filtMoments{k};
    
    n_FP=size(filtForces{k},3);
    
    for i=1:n_FP
            
            force_zero=find(filtForces{k}(:,3,i) > FPlateThreshold);
            
            thrForces{k}(force_zero,:,i) = 0.0;
            thrMoments{k}(force_zero,:,i) = 0.0;          
    end
end