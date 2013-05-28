function ACHANNEL = getForceChannels(itf, index1, index2)
% getForceChannels - returns structure with nx1 force analog data fields.  
%The returned analog data is scaled with offsets removed, but is in the 
%force plate coordinate system.
% 
%   USAGE:  ACHANNEL = getForceChannels(itf, index1*, index2*)
%           * = not a necessary input
%   INPUTS:
%   itf         = variable name used for COM object
%   index1      = start frame index, all frames if not used as an argument
%   index2      = end frame index, all frames if not used as an argument
%   OUTPUTS:
%   ACHANNEL    = structure with nx1 matrix of analog data fields (+ units)

% Modified version of getAnalogChannels

if nargin == 1, 
    index1 = itf.GetVideoFrame(0); % frame start
    index2 = itf.GetVideoFrame(1); % frame end
end

 numberForcePlatform =  itf.GetParameterValue( itf.GetParameterIndex('FORCE_PLATFORM', 'USED'),0);
 nItems = numberForcePlatform*6;
 
 nIndex = itf.GetParameterIndex('ANALOG', 'LABELS');
 unitIndex = itf.GetParameterIndex('ANALOG', 'UNITS');
 rateIndex = itf.GetParameterIndex('ANALOG', 'RATE');

 ACHANNEL.Rate = itf.GetParameterValue(rateIndex, 0);
 
 cnum = 1;
for i = 1 : nItems,
    
    channel_name = itf.GetParameterValue(nIndex, i-1);  
    
    % find any labels that are numbers and change to CH1 etc
    if ~isempty(str2num(channel_name(1)))
         channel_name = ['CH_' channel_name];
    end
    
    if isfield(ACHANNEL,channel_name)
        channel_name = [channel_name '_' num2str(cnum)];
        cnum = cnum+1;
    end
    
    % find any spaces
    d = findstr(channel_name, ' ');
    if ~isempty(d)
        channel_name(d) = '_';
    end
    d = findstr(channel_name, ':');
    if ~isempty(d)
        channel_name = channel_name(d+1:end);
    end
    d = findstr(channel_name, '(');
    if ~isempty(d)
        channel_name(d) = [];
    end
    d = findstr(channel_name, ')');
    if ~isempty(d)
        channel_name(d) = [];
    end
        
    % TRY AND KEEP CONSISTENT FORMAT i.e. Fx1, Mx1 and Fx2, Mx2 (not FP1Mx
    % etc)
    d = findstr(channel_name, 'FP');
    if ~isempty(d)
        channel_name(d:d+1) = [];
        channel_name = [channel_name(2:end) channel_name(1)];
    end
    
    newstring = channel_name(1:min(findstr(channel_name, ' '))-1);
    if strmatch(newstring, [], 'exact'),
        newstring = channel_name;
    end      
    
    ACHANNEL.units.(newstring) = itf.GetParameterValue(unitIndex, i-1);
    ACHANNEL.(newstring) = ...
        itf.GetAnalogDataEx(i-1,index1,index2,'1',0,0,'0');
    
    ACHANNEL.(newstring) = cell2mat(ACHANNEL.(newstring));
    
end
