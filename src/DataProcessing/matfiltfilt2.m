function fdata = matfiltfilt2(dt, fcut, order, type, data)
%   fdata = MATFILTFILT(dt, fcut, order, data)l
%   Zero-lag Butterworth filter where fdata = the filtered data, 
%   dt = 1/sampling frerquency, fcut = the desired cutoff frequency(s), 
%   order = the order of the filter, type = the type of filter
%   (lp = low pass, hp = high pass, bs = bandstop and bp = bandpass) and 
%   data = the raw data. Where bs or bp are used, fcut must be 2 element
%   argument where the 1st element refers to lower end of the pass/stopband
%   and the 2nd element refers to the upper end of the pass/stopband. 
%   matfiltfilt utilises signal processing toolbox functions: BUTTER & 
%   FILTFILT.  a and fcut must be either a scalar or a 1 * 2 vector. Where 

%   Written by Rod Barrett and adapted by Peter Mills


%   Ensure input areguments are correct
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

    
%   Correction for filter order to ensure 1/sqrt(2) transfer at fcut
if order == 0
   fcut = fcut;
else
   fcut = fcut /(sqrt(2) - 1)^(0.5/order);
end
Wn = 2 * fcut * dt;


%   Define filter coefficients
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

%   Filter data
[nRows, nCols] = size(data);
for i = 1:nCols
    fdata(:,i) = filtfilt(b, a, double(data(:,i)));
end
        