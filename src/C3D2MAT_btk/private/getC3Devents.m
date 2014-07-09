function events = getC3Devents(h)
%getC3Devents
%Extract Event Information

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

nEvent=btkGetEventNumber(h);

if nEvent == 0,  
    return  %check in getInfoFromC3D    
            %events=[];
            %error(sprintf('No Events Found in c3d file.\nEnsure that the events are labeled in Vicon before proceeding...\n'));
            %disp('No events in the c3d file')
end

[times, labels] = btkGetEventsValues(h);
context = btkGetMetaData(h,'EVENT','CONTEXTS');

[timeNew, idNew] = sort(times); 

for i = 1:nEvent;
    
    j = idNew(i);

    events(i).label = labels{j};
    events(i).context= context.info.values{j};
    events(i).time = times(j);
end







