function events = getC3Devents(itf)
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

aIndex = itf.GetParameterIndex('EVENT', 'USED');
nEvent = round(itf.GetParameterValue(aIndex, 0));

if nEvent == 0,  
    return  %check in getInfoFromC3D    
            %events=[];
            %error(sprintf('No Events Found in c3d file.\nEnsure that the events are labeled in Vicon before proceeding...\n'));
            %disp('No events in the c3d file')
end

bIndex = itf.GetParameterIndex('EVENT', 'CONTEXTS');
cIndex = itf.GetParameterIndex('EVENT', 'LABELS');
dIndex = itf.GetParameterIndex('EVENT', 'TIMES');

for i = 1:nEvent
    %txtRawtmp = [itf.GetParameterValue(bIndex, i-1),...
    %             itf.GetParameterValue(cIndex, i-1)]; %[context + label]
    txtRawtmp = [itf.GetParameterValue(cIndex, i-1)];  %original label without adding context
    timeRaw(i) = double(itf.GetParameterValue(dIndex, 2*i-1));
    
    txtcontext{i}=itf.GetParameterValue(bIndex, i-1);
    
    txtRaw{i} = txtRawtmp;
end

[timeNew, idNew] = sort(timeRaw);       % sort the events in time order

for i = 1:nEvent;
    j = idNew(i);
    events(i).label = txtRaw{j};
    events(i).context=txtcontext{j};
    events(i).time = timeRaw(j);
end







