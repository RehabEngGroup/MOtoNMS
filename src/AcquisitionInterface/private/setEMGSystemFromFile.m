function def_EMGSystems=setEMGSystemFromFile(nEMGSystems,oldAcquisition)
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
for k=1:nEMGSystems
    
    if (nargin>1 && isfield(oldAcquisition,'EMGs'))
        
        try
            def_EMGSystems{k,1}=num2str(oldAcquisition.EMGs.Systems.System(k).Name);
        catch
            disp('EMG System Name missing in the loaded acquisition.xml file')
            def_EMGSystems{k,1}='';
        end
        
        try
            def_EMGSystems{k,2}=num2str(oldAcquisition.EMGs.Systems.System(k).Rate);
        catch
            disp('EMG System Rate missing in the loaded acquisition.xml file')
            def_EMGSystems{k,2}='';
        end
        
        try
            %Number of Channels can not miss!!!Required
            def_EMGSystems{k,3}=num2str(oldAcquisition.EMGs.Systems.System(k).NumberOfChannels);
        catch
            disp(['EMG System' num2str(k) ' Rate missing in the loaded acquisition.xml file'])
            def_EMGSystems{k,3}='';
        end
    else
        
        def_EMGSystems{k,1}='';
        def_EMGSystems{k,2}='';
        def_EMGSystems{k,3}='';
        
    end
end
