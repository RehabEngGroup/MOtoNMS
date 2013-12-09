function leg=setAnalysisLeg(InstrumentedLeg)

if (strcmp(InstrumentedLeg,'Both') || strcmp(InstrumentedLeg,'None'))
    
    legList={'.','Left', 'Right'};
    [legIndex,v] = listdlg('PromptString','Choose Leg to Analyse',...
        'SelectionMode','single',...
        'ListString',legList,...
        'ListSize',[250 100]);
    leg=legList(legIndex);
    
else
    leg=InstrumentedLeg;
end