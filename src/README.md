# MOtoNMS: source code #

This folder contains MOtoNMS source code divided in different sub-folders, 
according to the different processing steps.
*shared* sub-folder includes MATLAB functions common to more than one processing step.

In the following you will find a brief description of the process pipeline. 
Nevertheless, this README file does not provide enough information to 
succesfully run MOtoNMS.  
Before using the software you MUST carefully read the user manual 
distributed with this release. If you do not have a copy please visit 
<http://goo.gl/Ukrw5B>

## Processing pipeline ##

### 1) Acquisition Interface ###
This processing step generate an acquisition.xml file that includes all 
the required information for a new dataset to be processed with MOtoNMS. 
See chapter *Acquisition Interface: describing your data* of the User Manual
 
### 2a) C3D2MAT_btk  ###
C3D2MAT converts data from C3D in .mat format and save them in a 
sessionData folder. Two alternatives are provided to accomplish this task.
This part exploits BTK (Biomechanical Toolkit) to access C3D files.
You need to download the BTK version for your system from the BTK project site: 

<https://code.google.com/p/b-tk/wiki/MatlabBinaries>

You will also need to add the correct BTK folder to the path of MATLAB.
See chapter *C3DtoMAT: from C3D to MATLAB format* of the User Manual.


### 2b) C3D2MAT_c3dserver  ###

C3D2MAT_c3dserver converts data from C3D files in .mat format as C3D2MAT_btk, but 
it is based on c3dserver. It requires Matlab 32 bit and Windows environment.
You can use alternatively C3D2MAT_btk or C3D2MAT_c3dserver.
See chapter *C3DtoMAT: from C3D to MATLAB format* of the User Manual.

### 3) Static Elaboration ###
Static Elaboration processes markers trajectories and computes 
subject-specific joint centers from data recorded during static standing 
trials, storing them in .trc files. 
See chapter *Static Elaboration: process your static trials* of the User Manual.

### 4) Data Processsing  ###
Data Processing produces .trc and .mot files for OpenSim, storing respectively 
markers and forces information. When collected, it also processes EMG signals. 
See chapter *Data Processing: elaborate your dynamic trials* of the User Manual.


