function [missingFrames,maxMissing]=MissingFramesCounter(data)
% data should be a vector
% Implemented by Alice Mantoan, February 2013, <alice.mantoan@dei.unipd.it>
%--------------------------------------------------------------------------

[r,c]=size(data);
maxMissing=zeros(1,c);
counter=zeros(1,c);
missingFrames=[];

for i=1:r	%frames
    
    if isnan(data(i,1))
        counter=counter+1;
        missingFrames=[missingFrames i];
    else
        %reset to 0: increase only if they are consecutive frames
        counter=0;
    end
    
    %keep the max interval of consecutive missing frames
    if (counter>maxMissing)
        maxMissing=counter;
    end
end


                