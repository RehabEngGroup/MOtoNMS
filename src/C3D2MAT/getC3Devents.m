function events = getC3Devents(itf)

% Extract Event Information
% -------------------------
aIndex = itf.GetParameterIndex('EVENT', 'USED');
nEvent = round(itf.GetParameterValue(aIndex, 0));

if nEvent == 0,  
    return  %check in getInfoFromC3D    
            %events=[];
            %error(sprintf('No Events Found in c3d file.\nEnsure that the events are labeled in Vicon before proceeding...\n'));
            %disp('No events in the c3d file')
end

bIndex = itf.GetParameterIndex('EVENT', 'CONTEXTS');
cIndex = itf.GetParameterIndex('EVENT', 'LABELS');
dIndex = itf.GetParameterIndex('EVENT', 'TIMES');

for i = 1:nEvent
    %txtRawtmp = [itf.GetParameterValue(bIndex, i-1),...
    %             itf.GetParameterValue(cIndex, i-1)]; %[context + label]
    txtRawtmp = [itf.GetParameterValue(cIndex, i-1)];  %original label without adding context
    timeRaw(i) = double(itf.GetParameterValue(dIndex, 2*i-1));
    
    txtcontext{i}=itf.GetParameterValue(bIndex, i-1);
    
    %Maintain original labels otherwise user do not know
    %     if     strmatch(upper(txtRawtmp),'RIGHTFOOT OFF')    txtRawtmp= 'rTO';
    %     elseif strmatch(upper(txtRawtmp),'LEFTFOOT OFF')     txtRawtmp= 'lTO';
    %     elseif strmatch(upper(txtRawtmp),'RIGHTFOOT STRIKE') txtRawtmp= 'rHS';
    %     elseif strmatch(upper(txtRawtmp),'LEFTFOOT STRIKE')  txtRawtmp= 'lHS';
    %     end
    
    txtRaw{i} = txtRawtmp;
end

[timeNew, idNew] = sort(timeRaw);       % sort the events in time order

for i = 1:nEvent;
    j = idNew(i);
    events(i).label = txtRaw{j};
    events(i).context=txtcontext{j};
    events(i).time = timeRaw(j);
end







