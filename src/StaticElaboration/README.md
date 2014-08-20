# MOtoNMS: Static Elaboration #

## Instructions ##

### Create settings file for static elaboration (Static Interface) ###

1) Set MATLAB path to <code>src\StaticElaboration</code> folder

2) Run  <code>StaticInterface.m </code>

<b>Output</b>: it generates *static.xml* file. 
At the end of the program the user is prompted with the request if he/she wants to run the elaboration code with the just created *static.xml* file.

### Run processing ###

If you have already the configuration file with the parameters of your elaboration (*static.xml*), you can run directly the static elaboration with the command:

<code>runStaticElaboration(ConfigFilePath)</code>

where *ConfigFilePath* is the full path of the folder where your *static.xml* file is located.

<b>Output</b>:  static.trc, with the processed markers trajectories and the computed JC.

Additional files are also generated to help in validation of obtained results:

- computed joint centers coordinate in .mat format
- plot of estimated JCs in the laboratory reference system

## Note ##

- C3D files must be converted in .mat with <code>C3D2MAT.m</code> - C3D2MAT- before running Static Elaboration step.
- *acquisition.xml* file is required and can be generated with <code>mainAquisitionInterface.m </code> - Acquisition Interface -.

Refer to MOtoNMS User Manual included with this release, chapter *Static Elaboration: process your static trials*.
If you do not have a copy please visit <http://goo.gl/Ukrw5B>.