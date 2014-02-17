function [LKJC,RKJC,markers_kjc,markersNames_kjc]=KJCcomputation(method,input,protocolMLabels,markers)
% Function for Knee Joint Center Computation
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

[markersNames_kjc,markers_kjc]= JCmarkersDefintion(input,protocolMLabels,markers,'Knee');


switch method
    
    case 'KJCMidPoint'
    
        [RKJC, LKJC]=MidPoint(markers_kjc);
    
    %case
    %ADD HERE MORE METHODS
    %...        
    
    otherwise
        error('KJC Method missing')
end

disp('LKJC and RKJC have been computed')