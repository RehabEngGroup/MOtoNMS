function [LHJC,RHJC,markers_hjc,markerNames_hjc]=HJCcomputation(method,input,protocolMLabels,markers)
% Function for Hip Joint Center Computation
%
% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2013 Alice Mantoan, Monica Reggiani
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
    
[markerNames_hjc,markers_hjc]= JCmarkersDefintion(input,protocolMLabels,markers,'Hip');
    

switch method
    
    case 'HJCHarrington'
        
        %Harrington method        
        [RHJC, LHJC]=HJCHarrington(markers_hjc);
        
    %case ...
    %ADD HERE MORE METHODS
    %...
        
    otherwise
        error('Choosen HJC Method missing')
end


disp('LHJC and RHJC have been computed')