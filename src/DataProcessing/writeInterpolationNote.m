function []=writeInterpolationNote(note,path)
% Write interpolation note in FilterData Folder for each trial

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
    
for k=1:length(note)
    
    %check for FilterData folder: should already exist as created in
    %saveFilteredData.m
    FilteredDataFolderPath=[path{k} 'FilteredData\'];
    
    if exist(FilteredDataFolderPath,'dir') ~= 7
        mkdir(FilteredDataFolderPath);
    end
    
    fid = fopen([FilteredDataFolderPath 'InterpolationNote.txt'], 'wt');
    
    fprintf(fid,'Trial\t');
    fprintf(fid,'%g', k);
    fprintf(fid,'\n\n');
    trialNote=note{k};
    save_to_base(1)
    for j=1:length(trialNote)
        fprintf(fid,trialNote{j});
        fprintf(fid,'\n');
    end
    fprintf(fid,'\n');
    
    fclose(fid);
end

