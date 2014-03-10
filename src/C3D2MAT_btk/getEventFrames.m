function eventFrames = getEventFrames(tevents,VideoFrameRate)
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
% Note that a video frame V is equivalent to an analog frame A where
% A = (V-1)*r + 1, where r is the analog/video frame ratio. For example
% if r = 9 and we start at video frame 8, this is equivalent to analog
% frame (8-1)*9 + 1 = 64

if isempty(tevents)
    eventFrames=[];
else    
    for i=1:size(tevents,2)      
        eventFrames(i)=round(tevents(i).time*VideoFrameRate+1);
    end
end

