function [] = printEMGmot(folder,time,EMGsData,EMGsLabels, tag)
% Print normalized EMG linear envelopes in a .sto or mot file

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

EMGmot =[time EMGsData];

nRows = length(EMGmot);
nCols = length(EMGsLabels)+1;   % plus time

fid = fopen([folder, filesep 'emg' tag], 'w');

fprintf(fid,'Normalized EMG Linear Envelopes\n');

fprintf(fid,'nRows=%g\n', nRows);
fprintf(fid,'nColumns=%g\n',nCols); 
fprintf(fid, '\n');
fprintf(fid,'endheader\n');

% Write column labels.
%fprintf(fid, '%20s\t', 'time');
fprintf(fid,'time');
fprintf(fid, '\t');
for i = 1:nCols-1,
	fprintf(fid, '%10s\t', EMGsLabels{i});
end

% Write data.
for i = 1:nRows
    fprintf(fid, '\n');
    for j=1:nCols
        if j == 1
            fprintf(fid,'%g\t',EMGmot(i));
        else
            fprintf(fid,'%10f\t',EMGmot(i,j));
        end
    end
end

fclose(fid);