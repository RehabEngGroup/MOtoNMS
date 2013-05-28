function def_VRate=setVideoFrameRateFromFile(oldAcquisition)

if (nargin>0 && isfield(oldAcquisition,'VideoFrameRate')==1)
    
    def_VRate{1}=num2str(oldAcquisition.VideoFrameRate);
else
    
    def_VRate{1}='';
end