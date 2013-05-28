function def_EMGSystems=setEMGSystemFromFile(nEMGSystems,oldAcquisition)

for k=1:nEMGSystems
    
    if (nargin>1 && isfield(oldAcquisition,'EMGSystems'))
        
        try
            def_EMGSystems{k,1}=num2str(oldAcquisition.EMGSystems.EMGSystem(k).Name);
        catch
            disp('EMGSystem Name missing in the loaded acquisition.xml file')
            def_EMGSystems{k,1}='';
        end
        
        try
            def_EMGSystems{k,2}=num2str(oldAcquisition.EMGSystems.EMGSystem(k).Rate);
        catch
            disp('EMGSystem Rate missing in the loaded acquisition.xml file')
            def_EMGSystems{k,2}='';
        end
        
        try
            %Number of Channels can not miss!!!Required
            def_EMGSystems{k,3}=num2str(oldAcquisition.EMGSystems.EMGSystem(k).NumberOfChannels);
        catch
            disp(['EMGSystem' num2str(k) ' Rate missing in the loaded acquisition.xml file'])
            def_EMGSystems{k,3}='';
        end
    else
        
        def_EMGSystems{k,1}='';
        def_EMGSystems{k,2}='';
        def_EMGSystems{k,3}='';
        
    end
end
