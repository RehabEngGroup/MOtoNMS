function def_subject=setSubjectValuesFromFile(oldAcquisition)
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
    try
        def_subject{1}=char(oldAcquisition.Subject.FirstName);
    catch
        def_subject{1}='';
        %m=msgbox('Subject First Name missing in the loaded file. It shouldnt!!','acquisition.xml file loaded','warn');
        %uiwait(m)
        disp('Subject First Name missing in the loaded file.')
    end
    
    try
        def_subject{2}=char(oldAcquisition.Subject.LastName);
    catch
        def_subject{2}='';
        %m=msgbox('Subject Last Name missing in the loaded file. It shouldnt!!','acquisition.xml file loaded','warn');
        %uiwait(m); 
        disp('Subject Last Name missing in the loaded file.')
    end
    try
        def_subject{3}=char(oldAcquisition.Subject.Code);
    catch
        def_subject{3}='';
        m=msgbox('Subject Code missing in the loaded file. It shouldnt!!','acquisition.xml file loaded','warn');
        uiwait(m); 
        %disp('Subject Code missing in the loaded file. It shouldnt!!')
    end
    
    try
        def_subject{4}=char(oldAcquisition.Subject.BirthDate);
    catch
        def_subject{4}='';
        %msgbox('Subject Birth Data missing in the loaded file.','acquisition.xml file loaded','warn')
        disp('Subject Birth Data missing in the loaded acquisition.xml file.')
    end
    
    try
        def_subject{5}=num2str(oldAcquisition.Subject.Age);
    catch
        def_subject{5}='';
        %msgbox('Subject Age missing in the loaded file. It shouldnt!!','acquisition.xml file loaded','warn')
        disp('Subject Age missing in the loaded acquisition.xml file.')    
    end
    
    try
        def_subject{6}=num2str(oldAcquisition.Subject.Weight);
    catch
        def_subject{6}='';
        %msgbox('Subject Weight missing in the loaded Acquisition.xml file.','acquisition.xml file loaded','warn')
        disp('Subject Weight missing in the loaded acquisition.xml file.')
    end
    
    try
        def_subject{7}=num2str(oldAcquisition.Subject.Height);
    catch
        def_subject{7}='';
        %msgbox('Subject Height missing in the loaded file. It shouldnt!!','acquisition.xml file loaded','warn')
        disp('Subject Height missing in the loaded acquisition.xml.')
    end
    
    try
        def_subject{8}=num2str(oldAcquisition.Subject.FootSize);
    catch
        def_subject{8}='';
        %msgbox('Subject Footsize missing in the loaded Acquisiion.xml file.','acquisition.xml file loaded','warn')
        disp('Subject Footsize missing in the loaded acquisition.xml file.')    
    end
    
    try
        def_subject{9}=char(oldAcquisition.Subject.Pathology);
    catch
        def_subject{9}='';
        %msgbox('Subject Pathology missing in the loaded file. It shouldnt!!','acquisition.xml file loaded','warn')
        disp('Subject Pathology missing in the loaded acquisition.xml file.')
    end
else
    for i=1:9
        def_subject{i}='';
    end
    
end