# MOtoNMS: Data Processing #

## Instructions ##

### Create settings file for elaboration (Elaboration Interface) ###

1) Set MATLAB path to <code>src\DataProcessing</code> folder

2) Run  <code>ElaborationInterface.m </code>

<b>Output</b>: it generates *elaboration.xml* file, which will be saved in the elaboration folder. 
It also asks if the user wants to run the data processing code using parameters from the *elaboration.xml* file just created.

### Run processing ###

If you already have the XML settings file, you can skip the execution of the Elaboration Interface and run directly the code through the command:

<code>runDataProcessing(ElaborationFilePath)</code>

where *ElaborationFilePath* is the path of the folder where the *elaboration.xml* file you want to run is located.

## Note ##

- C3D files must be converted in .mat with <code>C3D2MAT.m</code> - C3D2MAT - before running Data Processing step.
- *acquisition.xml* file is required and can be generated with <code>mainAquisitionInterface.m </code> - Acquisition Interface -.

Refer to MOtoNMS User Manual included with this release, chapter *Data Processing: elaborate your dynamic trials*.
If you do not have a copy please visit <http://goo.gl/Ukrw5B>.






