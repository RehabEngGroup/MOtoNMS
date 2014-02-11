function [] = printMaxEMGvalues(dirPath, EMGLabels, MaxEMGvalues)
%
% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
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
%
% Note: I'd like to acknowledge contributions from Mr. Michele Vivian

%%

nEMGChannels=length(EMGLabels);

fid = fopen([dirPath, '\maxemg.txt'], 'w');

for i=1:nEMGChannels
    MaxEMGLabel = [char(EMGLabels{i}),'_max '];
    fprintf(fid,'%s%6.6f\n', char(MaxEMGLabel), MaxEMGvalues(i));
end

fclose(fid);

save([dirPath '\maxemg.mat'],'MaxEMGvalues')
