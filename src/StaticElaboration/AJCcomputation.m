function [LAJC,RAJC,markers_ajc,markersNames_ajc]=AJCcomputation(method,input,protocolMLabels,markers)
%
% Function for Ankle Joint Center Computation
% Implemented by Alice Mantoan, March 2013, <alice.mantoan@dei.unipd.it>
%--------------------------------------------------------------------------

[markersNames_ajc,markers_ajc]= JCmarkersDefintion(input,protocolMLabels,markers,'Ankle');


switch method
    
    case 'AJCMidPoint'
    
        [RAJC, LAJC]=MidPoint(markers_ajc);

    %case
    %ADD HERE MORE METHODS
    %...        
    
    otherwise
        error('AJC Method missing')
end

disp('LAJC and RAJC have been computed')

