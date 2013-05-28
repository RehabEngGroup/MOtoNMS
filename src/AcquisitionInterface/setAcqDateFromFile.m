function def_AcqDate=setAcqDateFromFile(oldAcquisition)

if (nargin>0 && isfield(oldAcquisition,'AcquisitionDate')==1)
    
    def_AcqDate{1}=num2str(oldAcquisition.AcquisitionDate);    
else
    
    def_AcqDate{1}='';
end