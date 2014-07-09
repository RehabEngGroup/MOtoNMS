function [] = writeMot(grfOpenSim,time,fname)
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

% Initialize 'motion file data matrix' for writing data of interest.
nRows = length(grfOpenSim);
nCols=size(grfOpenSim,2)+1;

motData = zeros(nRows, nCols);

% Write time array to data matrix.
motData(:, 1) = time;

motData(:, 2:end) = grfOpenSim;          

% Generate column labels for forces, COPs, and vertical torques taking into
% account that the number of force platforms may change
nFP=round(nCols/9);

% Order: GRF_1(xyz),COP_1(xyz),GRF_2(xyz),COP_2(xyz),T_1(xyz),T_2(xyz)...

label=generateMotLabels(nFP); %depends on the number of FP


% Open file for writing.
fid = fopen(fname, 'wt');

fprintf('\n------------------------------------------');
fprintf('\n      Printing mot file     ');
fprintf('\n------------------------------------------');

if fid == -1
    error(['unable to open ', fname])
end

% Write header.
fprintf(fid, 'name %s\n', fname);
fprintf(fid, 'datacolumns %d\n', nCols);
fprintf(fid, 'datarows %d\n', nRows);
fprintf(fid, 'range %d %d\n', time(1), time(nRows));
fprintf(fid, 'endheader\n\n');

% Write column labels.
fprintf(fid, 'time');
fprintf(fid,'\t');

for i = 1:nCols-1,
	fprintf(fid, '%20s\t', label{i});
end

% Write data.
for i = 1:nRows
    fprintf(fid, '\n'); 
	for j = 1:nCols
        if j == 1
            fprintf(fid,'%g\t', motData(i));
        else
            fprintf(fid, '%20.8f\t', motData(i, j));
        end
    end
end

fclose(fid);
return;