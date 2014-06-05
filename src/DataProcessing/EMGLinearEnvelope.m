function [EMGDataLinEnv] = EMGLinearEnvelope(EMGDataRaw,EMGRate)
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

%% Create linear envelope

%remove any offset that is in the signal
nEMGChannels=size(EMGDataRaw,2);

for col = 1:nEMGChannels
    EMGDataRawZeroMean(:,col) = EMGDataRaw(:,col) - mean(EMGDataRaw(:,col));
end

%Raw EMG: filter, rectify, and then filter again to obtain EMG linear envelope.
BPFiltEMGPointsAll = ZeroLagButtFiltfilt((1/EMGRate), [30,300], 2, 'bp', EMGDataRawZeroMean);
RectBPFiltEMGPointsAll = abs(BPFiltEMGPointsAll);
LinEnvEMGAll = ZeroLagButtFiltfilt((1/EMGRate), 6, 2, 'lp', RectBPFiltEMGPointsAll);
for col = 1:size(LinEnvEMGAll,2)
    for row = 1:size(LinEnvEMGAll,1)
        if LinEnvEMGAll(row,col) < 0;
            LinEnvEMGAll(row,col) = 0;
        end
    end
end

EMGDataLinEnv = LinEnvEMGAll;

