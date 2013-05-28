function [EMGDataLinEnv] = EMGLinearEnvelope(EMGDataRaw,EMGRate)
%   APMProcessEMGData.m
%   Developed in:           Matlab r2006a
%   Developed by:           Chris Winby
%
%   Version:        1.00
%   Last modified:  April 2013 by Alice Mantoan
%
% This routine filters and rectifies the emg data for the entire trial,
% creating a linear envelope

% Outputs: n x numChannels array EMGDataLinEnv for the entire trial


%% Create linear envelope

%remove any offset that is in the signal
nEMGChannels=size(EMGDataRaw,2);

for col = 1:nEMGChannels
    EMGDataRawZeroMean(:,col) = EMGDataRaw(:,col) - mean(EMGDataRaw(:,col));
end

%Raw EMG: filter, rectify, and then filter again to obtain EMG linear envelope.
BPFiltEMGPointsAll = matfiltfilt2((1/EMGRate), [30,300], 2, 'bp', EMGDataRawZeroMean);
RectBPFiltEMGPointsAll = abs(BPFiltEMGPointsAll);
LinEnvEMGAll = matfiltfilt2((1/EMGRate), 6, 2, 'lp', RectBPFiltEMGPointsAll);
for col = 1:size(LinEnvEMGAll,2)
    for row = 1:size(LinEnvEMGAll,1)
        if LinEnvEMGAll(row,col) < 0;
            LinEnvEMGAll(row,col) = 0;
        end
    end
end

for col = 1:nEMGChannels
    LinEnvEMGAll(:,col) = LinEnvEMGAll(:,col) + mean(EMGDataRaw(:,col));
end

EMGDataLinEnv = LinEnvEMGAll;

%save_to_base(1)

