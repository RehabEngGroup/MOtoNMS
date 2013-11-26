function def_channel=setChannelFromFile(n,muscleList,oldAcquisition)

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