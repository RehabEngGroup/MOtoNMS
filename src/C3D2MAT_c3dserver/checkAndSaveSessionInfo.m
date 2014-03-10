function [] = checkAndSaveSessionInfo(ForcePlatformInfo, Rates, dMLabels, AnalogDataLabels, sessionFolder)
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
infoSet={ForcePlatformInfo, Rates, dMLabels, AnalogDataLabels};
infoLabels={'ForcePlatformInfo', 'Rates', 'dMLabels', 'AnalogDataLabels'};

for i=1: length(infoSet)
    
    tag=infoLabels{i};
    
    eval([tag '=infoSet{i};']);  %data are loaded with their names
    
    filename=[sessionFolder tag '.mat']; 
    
    %if data are not empty 
    if eval(['(isempty(' tag ')==0)']) 
        %if are not present in session folder
        if eval(['(exist(filename) == 0)']) 
            eval(['save (filename, tag)']);  %they are saved
        else
            %else, check if the new info corresponds to the one already saved
            eval(['new' tag '=' tag ';']);
            load([filename]);
            eval(['checkInfoConsistency(' tag ', new' tag ', infoLabels{i})']);
        end
    else
        disp([tag ' empty'])
    end
end

% Corresponding code without generalization with for cycle 
%
% if (isempty(ForcePlatformInfo)==0 && exist([sessionFolder 'ForcePlatformInfo.mat']) == 0)
%     save ([sessionFolder 'ForcePlatformInfo.mat'],'ForcePlatformInfo')
% else
%     newForcePlatformInfo=ForcePlatformInfo;
%     load([sessionFolder 'ForcePlatformInfo.mat'])
%     checkForcePlatformInfoConsistency(ForcePlatformInfo,newForcePlatformInfo)
% end
% 
% if (isempty(AnalogFrameRate)==0 && exist([sessionFolder 'Rates.mat']) == 0)
%     save ([sessionFolder 'Rates.mat'],'VideoFrameRate', 'AnalogFrameRate')
% else
%     newRates=Rates;
%     load([sessionFolder 'Rates.mat']);
%     checkRatesConsistency(Rates,newRates)
% end
% 
% if (isempty(MLabels)==0 && exist([sessionFolder 'MLabels.mat']) == 0)
%     save ([sessionFolder 'MLabels.mat'],'MLabels')
% else
%     newMLabels=MLabels;
%     load([sessionFolder 'MLabels.mat']);
%     checkMLabelsConsistency(MLabels,newMLabels)
% end
%     

