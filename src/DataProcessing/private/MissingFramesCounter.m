 function [missingFrames]=MissingFramesCounter(data)
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

if c>1
    error('Data are not in the correct format! Please check markers trajectories data')
end

counter=0; %# missing frames consecutives
ngapcounter=0;

for i=1:r	%frames
    
    if isnan(data(i,1))
 
        if counter==0
            ngapcounter=ngapcounter+1;
            missingFrames{ngapcounter}=[];
        end
        counter=counter+1;
        missingFrames{ngapcounter}=[missingFrames{ngapcounter} i];       
    else
        %reset to 0: increase only if they are consecutive frames
        counter=0;
    end
end


