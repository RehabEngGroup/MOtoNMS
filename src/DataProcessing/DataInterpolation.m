function [interpData,note] = DataInterpolation(data,index)
%Data interpolation
%index for piecewise interpolation
%If markers are not visible from the beginning, 0 value is set and
%interpolation is done from first and last frame contained in index array
%if index is empty the whole trajectory is interpolated
%Implemented by Alice Mantoan, February 2013, <alice.mantoan@dei.unipd.it>

for k=1: length(data)
    
    interpData{k}=data{k};
    
    [r,c]=size(data{k});
    xi=1:r;
    x=1:r;
    
    for j=1:c  %markers(3Columns each)
        
        if isempty(index{k})==1
            %There weren't 0 values at the beginning -> whole interpolation
            interpData{k}(:,j) = interp1(x,data{k}(:,j),xi,'pchip' );
            markerNote{j}=['Column ' num2str(j) ' has been interpolated from the beginning'];
            
        else
            %Nan at the beggining are re-set to 0
            interpData{k}(1:index{k}(1,j)-1,j)=0;  
            interpData{k}(index{k}(2,j)+1:end,j)=0;
            
            %interpolation only if there are NaN in the trajectories and
            %only between first and last frame in which markers appear;
            %at the beginning and the end, 0 value is preserved.
            %Here it is possibile to decide the length of the
            %interpolation: we can interpolate and dont care for how many
            %frames a marker is missing, or we can check and interpolate 
            %only if it is missing for few fixed frames
            %probl: it is not a check on consecutive values, just how many
            %frames in total!the legth should be of consecutive missing fr
            if (length(find(isnan(data{k}(index{k}(1,j):index{k}(2,j),j))==1))>1) % && length(find(isnan(data{k}(index{k}(1,j):index{k}(2,j),j))==1))<4)
                
                [allMissingFrames{k,j},counterMissing{k}(j)]=MissingFramesCounter(data{k}(index{k}(1,j):index{k}(2,j),j));
                
                OriginalMissingFrames{k,j}=allMissingFrames{k,j}+index{k}(1,j)-1;
                
                interpolation=pchip(x(index{k}(1,j):index{k}(2,j)),data{k}(index{k}(1,j):index{k}(2,j),j),xi(index{k}(1,j):index{k}(2,j)));
                %interpolation=interp1(x(index{k}(1,j):index{k}(2,j)),data{k}(index{k}(1,j):index{k}(2,j),j),xi(index{k}(1,j):index{k}(2,j)),'spline');
                interpData{k}(index{k}(1,j):index{k}(2,j),j) = interpolation; 
                %markerNote{j}=['Marker ' num2str(j) ' has been interpolated between first and last frame in which it appear (if there were less than 10 frames missing)'];
                markerNote{j}=['Column ' num2str(j) ' has been interpolated between first and last frame in which it appear for a maximun of ' num2str(counterMissing{k}(j)) ' consecutive frames (' num2str(OriginalMissingFrames{k,j}) ')' ];
            
            else                
               %no missing markers: interpData= Data (or missing for more than 10 frames)
               % interpData{k}(index{k}(1,j):index{k}(2,j),j)=data{k}(index{k}(1,j):index{k}(2,j),j);
               % not necessary: at the begininng we did interpData=data
                markerNote{j}=['Column ' num2str(j) ' not missing frames: no interpolation'];
            end
            
            %NaN at the end are set to the last nn-zero or non-Nan value (keep the last value...not set to 0!)
            %interpData{k}(index{k}(2,j)+1:end,j)=interpData{k}(index{k}(2,j),j);
        end
    clear interpolation     
    end
    note{k}=markerNote;
end

%save_to_base(1)
