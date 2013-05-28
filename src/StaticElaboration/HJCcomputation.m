function [LHJC,RHJC,markers_hjc,markerNames_hjc]=HJCcomputation(method,input,protocolMLabels,markers)
%
% Function for Hip Joint Center Computation
% Implemented by Alice Mantoan, March 2013, <alice.mantoan@dei.unipd.it>
%--------------------------------------------------------------------------
    
[markerNames_hjc,markers_hjc]= JCmarkersDefintion(input,protocolMLabels,markers,'Hip');
    

switch method
    
    case 'HJCHarrington'
        
        %Harrington method        
        [RHJC, LHJC]=HJCHarrington(markers_hjc);
        
    %case ...
    %ADD HERE MORE METHODS
    %...
        
    otherwise
        error('Choosen HJC Method missing')
end


disp('LHJC and RHJC have been computed')