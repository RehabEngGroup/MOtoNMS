function def_String=setTrialsStancesFromFile(nTrials,oldAcquisition)

if nargin>1
    
    for k=1:length(oldAcquisition.Trials.Trial)
        
        %creating th acquisition.xml file with the interface, these can not
        %be empty
        if isempty(oldAcquisition.Trials.Trial(k).StancesOnForcePlatforms)==0
            
            if length(oldAcquisition.Trials.Trial(k).StancesOnForcePlatforms.StanceOnFP)>1
                old_TopString{k,1}=oldAcquisition.Trials.Trial(k).StancesOnForcePlatforms.StanceOnFP(1).Leg;
                old_TopString{k,2}=oldAcquisition.Trials.Trial(k).StancesOnForcePlatforms.StanceOnFP(2).Leg;
            else
                old_TopString{k,1}=oldAcquisition.Trials.Trial(k).StancesOnForcePlatforms.StanceOnFP.Leg;
                old_TopString{k,2}='-'; %not defined
            end
            
            for i=1:2
                switch old_TopString{k,i}
                    case 'Right'
                        def_String{k,i}='Right|Left|Both|None|-';
                    case 'Left'
                        def_String{k,i}='Left|Right|Both|None|-';
                    case 'Both'
                        def_String{k,i}='Both|None|Right|Left|-';
                    case 'None'
                        def_String{k,i}='None|Both|Right|Left|-';
                    case '-'
                        def_String{k,i}='-|Right|Left|Both|None';
                end
            end
        else
             for i=1:2
                 def_String{k,i}='-|Right|Left|Both|None';
             end
        end
    end
    
else
    for k=1:nTrials
        for i=1:2
            def_String{k,i}='-|Right|Left|Both|None';
        end
    end
    
end