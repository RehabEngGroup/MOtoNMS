function fdata = ZeroLagButtFiltfilt(dt, fcut, order, type, data,idx)
%Adapted from matfiltfilt2, written by Rod Barrett and Peter Mills
%fdata = MATFILTFILT(dt, fcut, order, data)l
%Zero-lag Butterworth filter where fdata = the filtered data, 
%dt = 1/sampling frerquency, fcut = the desired cutoff frequency(s), 
%order = the order of the filter, type = the type of filter
%(lp = low pass, hp = high pass, bs = bandstop and bp = bandpass) and 
%data = the raw data. Where bs or bp are used, fcut must be 2 element
%argument where the 1st element refers to lower end of the pass/stopband
%and the 2nd element refers to the upper end of the pass/stopband. 
%matfiltfilt utilises signal processing toolbox functions: BUTTER & 
%FILTFILT.  a and fcut must be either a scalar or a 1 * 2 vector. 
%idx optional: used for filtering markers trajectories only in the interval
%in which they are visible and only if there are gaps due to occlusions
%shorter than 20 frames

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
%Ensure input areguments are correct
if type == 'bp' | type == 'bs'
    if max(size(fcut)) ~= 2 && min(size(fcut)) ~= 1
        error('2 cutoff frequencies are required for a bandpass or bandstop filter');
    end
elseif type == 'hp' | type == 'lp'
    if max(size(fcut)) ~= 1 && min(size(fcut)) ~= 1
        error('Only 1 cutoff frequency is required for a lowpass or high pass filter or bandstop filter');
    end
else
    error('Unknown filter type specified');
end
    
%Correction for filter order to ensure 1/sqrt(2) transfer at fcut
if order == 0
   fcut = fcut;
else
   fcut = fcut /(sqrt(2) - 1)^(0.5/order);
end
Wn = 2 * fcut * dt;

%Define filter coefficients
switch type
    case 'lp'
        [b, a] = butter(order, Wn);
    case 'hp'
        [b, a] = butter(order, Wn, 'high');
    case 'bp'
        [b, a] = butter(order, Wn);
    case 'bs'
        [b, a] = butter(order, Wn, 'stop');
end

fdata=data;
counter=0;
%Filter data
[nRows, nCols] = size(data);
for i = 1:nCols

    if nargin>5 %if we are filtering markers
        %before filtering check for NaN values (if no interpolation before)
        if isempty(find(isnan(data(idx(1,i):idx(2,i),i)))) && size(data(idx(1,i):idx(2,i),i),1)>order*3
            %filtering only in the interval defined by idx, that is when
            %each marker is visible. This interval must have a length more
            %than 3 times the filter order for the filtfilt function
            fdata(idx(1,i):idx(2,i),i) = filtfilt(b, a, double(data(idx(1,i):idx(2,i),i)));
            
        else %otherwise: piecewise filtering
             %filtering only within the intervals with no NaN values
             counter=counter+1;
             if counter==1 %printing only once for each trial
                 fprintf(['Piecewise filtering for markers trajectories still having NaN values (not interpolated)\n'])
             end
             fdata(idx(1,i):idx(2,i),i) = piecewiseFiltering(b, a, order, data(idx(1,i):idx(2,i),i));           
        end
            
    else  % filtering other data type (grf and emg)
        fdata(:,i) = filtfilt(b, a, double(data(:,i)));
    end
end