This folder contains MOtoNMS source code divided in four sub-folders, 
each one for a different processing step.

In the following you will find a brief description of the process pipeline. 
Nevertheless, this README file does not provide enough information to 
succesfully run MOtoNMS.  
Before using the software you MUST carefully read the user manual 
distributed with this release. If you do not have a copy please visit 
http://goo.gl/Ukrw5B

--- Processing pipeline 

1) AcquisitionInterface
This processing step generate an acquisition.xml file that includes all 
the required information for a new dataset to be processed with MOtoNMS. 
See chapter "Acquisition Interface: describing your data" of the User Manual
 
2) C3D2MAT
C3D2MAT converts data from c3d in .mat format and save them in a 
sessionData folder. See chapter "C3DtoMAT: from C3D to MATLAB format" of 
the User Manual.

3) StaticElaboration
Static Elaboration processes markers trajectories and computes 
subject-specific joint centers from data recorded during static standing 
trials, storing them in .trc files. 
See chapter "Static Elaboration: process your static trials" of the User Manual.

4) Data Processsing
Data Processing produces .trc and .mot files for OpenSim, storing respectively 
markers and forces information. When collected, it also processes EMG signals. 
See chapter "Data Processing: elaborate your dynamic trials" of the User Manual.


