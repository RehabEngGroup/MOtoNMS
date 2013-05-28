function [] = checkAndSaveSessionInfo(ForcePlatformInfo, Rates, MLabels, EMGLabels, sessionFolder)

infoSet={ForcePlatformInfo, Rates, MLabels, EMGLabels};
infoLabels={'ForcePlatformInfo', 'Rates', 'MLabels', 'EMGLabels'};

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

