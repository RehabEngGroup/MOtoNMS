function def_staff=setStaffValuesFromFile(oldAcquisition)

if nargin>0
    %Definition of oldAcquisition Values for loading old file   
    %Staff
    try
        def_staff{1}=oldAcquisition.Staff.PersonInCharge;
    catch
        disp('PersonInCharge missing in the loaded acquisition.xml file')
        def_staff{1}='';
    end
    
    try
        if length(oldAcquisition.Staff.Operators)==1
            def_staff{2}=oldAcquisition.Staff.Operators.Name;
        else
            def_staff{2}=oldAcquisition.Staff.Operators.Name{1};
        end
    catch
        disp('At least an Operators should be indicated in acquisition.xml. Missing in the loaded file!')
        def_staff{2}='';
        oldAcquisition.Staff.Operators.Name{1}='';       
    end
    
    if (length(oldAcquisition.Staff.Operators)==1 || isempty(oldAcquisition.Staff.Operators.Name{2}))
        def_staff{3}='';
    else
        def_staff{3}=oldAcquisition.Staff.Operators.Name{2};
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
