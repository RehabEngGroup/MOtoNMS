function shiftedWindow=WindowShift(Window,Offset)
%
% Implemented by Alice Mantoan, March 2013, <alice.mantoan@dei.unipd.it>

for k=1:length(Window)
    
    %shiftedWindow{k}.startFrame=((Window{k}.startFrame/(Window{k}.rate))-Offset)*Window{k}.rate;
    %if offset in frame
    shiftedWindow{k}.startFrame=Window{k}.startFrame-Offset;
    %conversion of endFrame into Rate
    %shiftedWindow{k}.endFrame=((Window{k}.endFrame/(Window{k}.rate))+Offset)*Window{k}.rate;
    shiftedWindow{k}.endFrame=Window{k}.endFrame+Offset;
    
    shiftedWindow{k}.rate=Window{k}.rate;
end