function def_staff=setStaffValuesFromFile(oldAcquisition)
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
if nargin>0
    %Definition of oldAcquisition Values for loading old file   
    %Staff
    try
        def_staff{1}=oldAcquisition.Staff.PersonInCharge;
    catch
        disp('PersonInCharge missing in the loaded acquisition.xml file')
        def_staff{1}='';
    end
    
    if isfield(oldAcquisition.Staff,'Operators')==1
        %if isfield, there is at least one operator
        
        if iscell(oldAcquisition.Staff.Operators.Name)==1
            def_staff{2}=oldAcquisition.Staff.Operators.Name{1};
        else
            def_staff{2}=oldAcquisition.Staff.Operators.Name;
        end
        
        if (length(oldAcquisition.Staff.Operators)==1 && length(oldAcquisition.Staff.Operators.Name)==2)  %|| isempty(oldAcquisition.Staff.Operators.Name{2}))
            
            def_staff{3}=oldAcquisition.Staff.Operators.Name{2};
        else
            def_staff{3}='';
        end
        
    else
        disp('At least an Operators should be indicated in acquisition.xml. Missing in the loaded file!')
        def_staff{2}='';
        def_staff{3}='';
    end
 
    if isfield(oldAcquisition.Staff,'Physiotherapists')==1
        def_staff{4}=oldAcquisition.Staff.Physiotherapists.Name;
    else
        def_staff{4}='';
    end
else
    for i=1:4
        def_staff{i}='';
    end
end
