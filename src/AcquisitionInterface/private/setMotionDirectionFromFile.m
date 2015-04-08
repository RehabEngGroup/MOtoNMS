function def_String=setMotionDirectionFromFile(nTrials, oldAcquisition)
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
if nargin>1
    
    for k=1:length(oldAcquisition.Trials.Trial)
        
        if isfield(oldAcquisition.Trials.Trial(k), 'MotionDirection')
            
            old_TopString{k}=num2str(oldAcquisition.Trials.Trial(k).MotionDirection);
                      
            switch lower(old_TopString{k})
                case 'forward'
                    def_String{k}='forward|backward|90left|90right|-';
                case 'backward'
                    def_String{k}='backward|forward|90left|90right|-';
                case '90left'
                    def_String{k}='90left|90right|backward|forward|-';
                case '90right'
                    def_String{k}='90right|90left|backward|forward|-';
                case 'unconventional'
                    def_String{k}='-|forward|backward|90left|90right';
                    
                otherwise
                    disp(' ')
                    error('ErrorTests:convertTest', ...
                        ['----------------------------------------------------------------\nWARNING: WRONG motion direction in the loaded acquisition.xml file! Motion directions for all trials MUST be selected among the following values: [forward, backward, 90left, 90right, NoneOfAbove]. \nPlease, refer to the user manual and check the loaded acquisition.xml file']);
            end
        else
            def_String{k}='forward|backward|90left|90right|-';
            
        end
    end
    
else
    for k=1:nTrials
        def_String{k}='forward|backward|90left|90right|-';
    end
    
end