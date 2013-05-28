function def_channel=setChannelFromFile(n,muscleList,oldAcquisition)

if nargin>2 && length(oldAcquisition.Channels.Channel)>=n
    
    if ischar(oldAcquisition.Channels.Channel(n).ID)
        def_channel{1}=oldAcquisition.Channels.Channel(n).ID;
    else
        def_channel{1}=num2str(oldAcquisition.Channels.Channel(n).ID);
    end
    
    if (isfield(oldAcquisition.Channels.Channel(n),'Muscle') && isempty(oldAcquisition.Channels.Channel(n).Muscle)==0)
        def_channel{2}=oldAcquisition.Channels.Channel(n).Muscle;
        def_channel{3}='';
        def_channel{4}='';
    else
        def_channel{2}='';
        if isfield(oldAcquisition.Channels.Channel(n),'FootSwitch')
            def_channel{3}=num2str(oldAcquisition.Channels.Channel(n).FootSwitch.ID);
            def_channel{4}=oldAcquisition.Channels.Channel(n).FootSwitch.Position;
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