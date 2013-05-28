function eventFrames = getEventFrames(tevents,VideoFrameRate)

% Note that a video frame V is equivalent to an analog frame A where
% A = (V-1)*r + 1, where r is the analog/video frame ratio. For example
% if r = 9 and we start at video frame 8, this is equivalent to analog
% frame (8-1)*9 + 1 = 64

if isempty(tevents)
    eventFrames=[];
else
    
    for i=1:size(tevents,2)
        
        eventFrames(i)=round(tevents(i).time*VideoFrameRate+1);
    end
end

