function trialMatFolder= mkOutputPath(pathName,trialName)
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
warning off
%Change in the pathName 'InputData' with 'ElaboratedData'
sessionDataFolderPath=regexprep(pathName, 'InputData', 'ElaboratedData');

%create ElaboratedData folder if it does not exit
if exist(sessionDataFolderPath,'dir') ~= 7
    mkdir (sessionDataFolderPath);
end

%create sessionData folder if it does not exit
if exist([sessionDataFolderPath 'sessionData'],'dir') ~= 7
    mkdir ([sessionDataFolderPath filesep 'sessionData']);
end

%create trial folder if it does not exit
if exist([sessionDataFolderPath 'sessionData' filesep trialName],'dir') ~= 7
    mkdir ([sessionDataFolderPath filesep 'sessionData' filesep trialName]);
end

trialMatFolder=[sessionDataFolderPath filesep 'sessionData' filesep trialName filesep];
%folder where mat files will be stored