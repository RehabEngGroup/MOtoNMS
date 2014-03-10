function itf = c3dserver()
% C3DSERVER - activates C3DServer as a COM (COM.c3dserver_c3d), 
% and returns 'itf' as a COM object for the server.
% 
% USAGE: itf = c3dserver() 

%   C3D directory contains C3DServer activation and wrapper Matlab functions.
%   This function written by:
%   Matthew R. Walker, MSc. <matthewwalker_1@hotmail.com>
%   Michael J. Rainbow, BS. <Michael_Rainbow@brown.edu>
%   Motion Analysis Lab, Shriners Hospitals for Children, Erie, PA, USA
%   Questions and/or comments are most welcome.  
%   Last Updated: April 21, 2006
%   Created in: MATLAB Version 7.0.1.24704 (R14) Service Pack 1
%               O/S: MS Windows XP Version 5.1 (Build 2600: Service Pack 2)
%   
%   Please retain the author names, and give acknowledgement where necessary.  
%   DISCLAIMER: The use of these functions is at your own risk.  
%   The authors do not assume any responsibility related to the use 
%   of this code, and do not guarantee its correctness. 


%  clc;
itf = actxserver('C3DServer.C3D');
%  disp('Motion Lab Systems C3DServer is now Active within MATLAB');
%  disp('Your COM object variable is now loaded');
%  disp(' ');
%  disp('Written by:  Matthew Walker and Michael Rainbow, Shriners Motion Analysis Lab - Erie, PA');
%  disp(' ');
%  Mode = itf.GetRegistrationMode;
% if Mode == 0, disp('Unregistered C3DServer');
% elseif Mode == 1, disp('Evaluation C3DServer');
% elseif Mode == 2, disp('Registered C3DServer');
% end
%  disp(['Version' ' ' itf.GetVersion]);
%  disp([itf.GetRegUserName]);
%  disp([itf.GetRegUserOrganization]);
%--------------------------------------------------------------------------