%%  Read event information
for i=1:length(ParameterGroup);
    name=char(ParameterGroup(i).name);
    if strcmp(name,'EVENT')
        eventGroup = i;
        break
    end
end

%   Events used?
for i=1:length(ParameterGroup(eventGroup).Parameter);
    name=char(ParameterGroup(eventGroup).Parameter(i).name);
    if strcmp(name,'USED')
        eventUsedGroup = i;
        break
    end
end
eventUsed = ParameterGroup(eventGroup).Parameter(eventUsedGroup).data;


if eventUsed ~= 0
    %   Event times
    for i=1:length(ParameterGroup(eventGroup).Parameter);
        name=char(ParameterGroup(eventGroup).Parameter(i).name);
        if strcmp(name,'TIMES')
            eventTimesGroup = i;
            break
        end
    end
    EventTimes = ParameterGroup(eventGroup).Parameter(eventTimesGroup).data(2,:) - ((StartFrame-1)/VideoFrameRate);

    %   Event sides - 'left', 'right', 'general'
    for i=1:length(ParameterGroup(eventGroup).Parameter);
        name=char(ParameterGroup(eventGroup).Parameter(i).name);
        if strcmp(name,'CONTEXTS')
            eventSidesGroup = i;
            break
        end
    end
    EventSides = ParameterGroup(eventGroup).Parameter(eventSidesGroup).data;

    %   Event types - general(|) = 0, foot-strike(<>) = 1, foot-off (+) = 2;
    for i=1:length(ParameterGroup(eventGroup).Parameter);
        name=char(ParameterGroup(eventGroup).Parameter(i).name);
        if strcmp(name,'ICON_IDS')
            eventTypesGroup = i;
            break
        end
    end
    EventTypes = ParameterGroup(eventGroup).Parameter(eventTypesGroup).data;

    %   Event labels - these are user defined labels;
    for i=1:length(ParameterGroup(eventGroup).Parameter);
        name=char(ParameterGroup(eventGroup).Parameter(i).name);
        if strcmp(name,'LABELS')
            eventLabelsGroup = i;
            break
        end
    end
    EventLabels = ParameterGroup(eventGroup).Parameter(eventLabelsGroup).data;
end
