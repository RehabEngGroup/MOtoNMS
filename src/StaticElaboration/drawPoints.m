function []=drawPoints(f,LJC,RJC, markersUsed,markerUsedNames,frame,LineSpec,tag)
% Add points to figure: left and right joint center and markers used for
% their computation
% Implemented by Alice Mantoan, March 2013, <alice.mantoan@dei.unipd.it>
%--------------------------------------------------------------------------

figure(f)
hold on

plot3(LJC(frame,1),LJC(frame,2),LJC(frame,3),LineSpec)
plot3(RJC(frame,1),RJC(frame,2),RJC(frame,3),LineSpec)

text('Position',[(LJC(frame,1)+3) (LJC(frame,2)+3) (LJC(frame,3)+3)], 'String', ['L' tag])
text('Position',[(RJC(frame,1)+3) (RJC(frame,2)+3) (RJC(frame,3)+3)], 'String', ['R' tag])

for i=1:length(markersUsed)
    plot3(markersUsed{i}(frame,1),markersUsed{i}(frame,2),markersUsed{i}(frame,3),'*k')
    text('Position',[(markersUsed{i}(frame,1)+3) (markersUsed{i}(frame,2)+3) (markersUsed{i}(frame,3)+3)], 'String', markerUsedNames{i})
end