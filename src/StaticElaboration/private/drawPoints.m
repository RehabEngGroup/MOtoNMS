function []=drawPoints(f,LJC,RJC, markersUsed,markerUsedNames,frame,LineSpec,tag)
% Add points to figure: left and right joint center and markers used for
% their computation

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

figure(f)
hold on

plot3(LJC(frame,1),LJC(frame,2),LJC(frame,3),LineSpec)
plot3(RJC(frame,1),RJC(frame,2),RJC(frame,3),LineSpec)

text('Position',[(LJC(frame,1)+3) (LJC(frame,2)+3) (LJC(frame,3)+3)], 'String', ['L' tag])
text('Position',[(RJC(frame,1)+3) (RJC(frame,2)+3) (RJC(frame,3)+3)], 'String', ['R' tag])

for i=1:length(markersUsed)
    plot3(markersUsed{i}(frame,1),markersUsed{i}(frame,2),markersUsed{i}(frame,3),'*k')
    text('Position',[(markersUsed{i}(frame,1)+3) (markersUsed{i}(frame,2)+3) (markersUsed{i}(frame,3)+3)], 'String', markerUsedNames{i})
end