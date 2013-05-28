function [LKJC,RKJC,markers_kjc,markersNames_kjc]=KJCcomputation(method,input,protocolMLabels,markers)
%
% Function for Knee Joint Center Computation
% Implemented by Alice Mantoan, March 2013, <alice.mantoan@dei.unipd.it>
%--------------------------------------------------------------------------

[markersNames_kjc,markers_kjc]= JCmarkersDefintion(input,protocolMLabels,markers,'Knee');


switch method
    
    case 'KJCMidPoint'
    
        [RKJC, LKJC]=MidPoint(markers_kjc);
    
    %case
    %ADD HERE MORE METHODS
    %...        
    
    otherwise
        error('KJC Method missing')
end

disp('LKJC and RKJC have been computed')