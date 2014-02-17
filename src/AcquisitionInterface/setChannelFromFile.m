function def_channel=setChannelFromFile(n,muscleList,oldAcquisition)
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
if nargin>2 && length(oldAcquisition.EMGs.Channels.Channel)>=n
    
    if ischar(oldAcquisition.EMGs.Channels.Channel(n).ID)
        def_channel{1}=oldAcquisition.EMGs.Channels.Channel(n).ID;
    else
        def_channel{1}=num2str(oldAcquisition.EMGs.Channels.Channel(n).ID);
    end
    
    if (isfield(oldAcquisition.EMGs.Channels.Channel(n),'Muscle') && isempty(oldAcquisition.EMGs.Channels.Channel(n).Muscle)==0)
        def_channel{2}=oldAcquisition.EMGs.Channels.Channel(n).Muscle;
        def_channel{3}='';
        def_channel{4}='';
    else
        def_channel{2}='';
        if isfield(oldAcquisition.EMGs.Channels.Channel(n),'FootSwitch')
            def_channel{3}=num2str(oldAcquisition.EMGs.Channels.Channel(n).FootSwitch.ID);
            def_channel{4}=oldAcquisition.EMGs.Channels.Channel(n).FootSwitch.Position;
        else
            def_channel{3}='';
            def_channel{4}='';
            disp(['Information about channel ' num2str(n) ' missing in the loaded acquisition.xml'])
        end
    end
    
else 
    def_channel{1}=num2str(n);

    if nargin>1 && length(muscleList)>=n
        def_channel{2}=muscleList{n};
    else
        def_channel{2}='';
    end
    def_channel{3}='';
    def_channel{4}='';
end