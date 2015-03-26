function def_String=setTrialsStancesFromFile(nTrials,n_FP, oldAcquisition)
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
if nargin>2
    
    for k=1:length(oldAcquisition.Trials.Trial)
        
        %creating th acquisition.xml file with the interface, these can not
        %be empty
        if isempty(oldAcquisition.Trials.Trial(k).StancesOnForcePlatforms)==0
                                    
            for i=1:n_FP
               
                if length(oldAcquisition.Trials.Trial(k).StancesOnForcePlatforms.StanceOnFP)>1
                    
                    old_TopString{k,i}=oldAcquisition.Trials.Trial(k).StancesOnForcePlatforms.StanceOnFP(i).Leg;
                else
                    old_TopString{k,1}=oldAcquisition.Trials.Trial(k).StancesOnForcePlatforms.StanceOnFP.Leg;
                end
            end
            
            for i=1:n_FP
                switch old_TopString{k,i}
                    case 'Right'
                        def_String{k,i}='Right|Left|Both|None|-';
                    case 'Left'
                        def_String{k,i}='Left|Right|Both|None|-';
                    case 'Both'
                        def_String{k,i}='Both|None|Right|Left|-';
                    case 'None'
                        def_String{k,i}='None|Both|Right|Left|-';
                    case '-'
                        def_String{k,i}='-|Right|Left|Both|None';
                end
            end
        else
             for i=1:n_FP
                 def_String{k,i}='-|Right|Left|Both|None';
             end
        end
    end
    
else
    for k=1:nTrials
        for i=1:n_FP
            def_String{k,i}='-|Right|Left|Both|None';
        end
    end
    
end