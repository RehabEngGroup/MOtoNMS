function [] = saveMat(Markers, AnalogData, FPdata, Events, trialMatFolder)
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

%% save data only if they are present in the c3d file

if isempty(Markers)==0
    save([trialMatFolder 'Markers.mat'], 'Markers')
end

if isempty(AnalogData)==0
    save([trialMatFolder 'AnalogData.mat'], 'AnalogData')
end

if isempty(FPdata)==0
    save([trialMatFolder 'FPdata.mat'], 'FPdata')
end

% save([trialMatFolder 'Markers.mat'], 'Markers')
% save([trialMatFolder 'AnalogData.mat'], 'AnalogData')
% save([trialMatFolder 'FPdata.mat'], 'FPdata')

%save events only if they are present in the c3d file
if isempty(Events)==0
    save([trialMatFolder 'Events.mat'], 'Events')
end
