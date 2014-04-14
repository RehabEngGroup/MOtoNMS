 function [missingFrames,maxMissing]=MissingFramesCounter(data)
% data should be a vector

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

[r,c]=size(data);
maxMissing=zeros(1,c);
counter=zeros(1,c);
missingFrames=[];

for i=1:r	%frames
    
    if isnan(data(i,1))
        counter=counter+1;
        missingFrames=[missingFrames i];       
    else
        %reset to 0: increase only if they are consecutive frames
        counter=0;
    end
    
    %keep the max interval of consecutive missing frames
    if (counter>maxMissing)
        maxMissing=counter;
    end
end


