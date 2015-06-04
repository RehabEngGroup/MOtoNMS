.. _`AppendixC`:

Appendix C: Revision History
----------------------------


**RELEASE 2.2**   (*June 4, 2015*) 

----------------------------------

**New Features**

- Processing of data along different motion directions with respect to the global reference system (e.g. backward)
- CoP coordinates computation when plate pads are used
- Optionality in computation of joint centers in ``StaticElaboration``
- Interpolation of all gaps in marker trajectories with size less than ``MaxGapSize`` (with ``MaxGapSize`` defined by the user in the ``elaboration.xml`` file)
- Piecewise filtering for marker trajectories when NaN values are found
- Storing of EMG labels while saving EMG data in mat format
- Output folder named ``maxemg`` for each dynamic elaboration, to log data related to the maximum EMG values computation
- Storing of all raw EMGs selected for the maximum EMG values computation and the obtained envelopes as mat files (within ``maxemg`` folder)
- Printing of trial and time corresponding to each maximum EMG value in ``maxemg.txt`` output file, and logging in mat format (update of ``maxemg.mat``)
- Plot of the raw EMG and envelope for each muscle, corresponding to the trial where the maximum EMG value is found
- GitHub Project Pages
- Addition of the ``docs`` folder including the source files required to generate MOtoNMS documentation using Sphinx
- Compatibility with MATLAB R2014b


**Code Changes**

- Added optional ``MotionDirection`` element in ``acquisition.xsd`` to implement processing of data along different motion directions
- Added optional ``PadThickness`` element in ``laboratory.xsd`` and ``acquisition.xsd`` to account for plate padding in CoP computation
- Added ``MarkersInterpolationType`` with ``MaxGapSize`` element in ``elaboration.xsd`` to let the user define the maximum gap size for marker trajectories interpolation
- Modified identification of first and last frame for marker trajectories: added case of NaN values when markers are initially not visible
- Added way to disable warnings from BTK tool in `C3D2MAT_btk`
- Moved storing of ``maxemg.txt`` output file within ``maxemg`` folder
- Handled error that can occur if input C3D file names do not include the repetition number (as required)
- Handled error in Y axis scale setting in ``EnvelopePlotting.m``
- Renamed ``CHANGES.txt`` to ``CHANGES.md``


**Bug Fixes**

- Fixed reading C3D files when no force plate (FP) data are stored
- Fixed handling FP data when more than 2 FPs of different types are involved
- Fixed selection of ``Leg on ForcePlatform`` in ``AcquisitionInterface`` GUI when more than 2 FPs are involved
- Fixed definition of ``timeStartFrame`` and ``timeEndFrame`` in ``selectionData.m`` to account for an initial starting condition of t=0 and frame number=1. Fixed accordingly the definition of ``frameArray`` in ``writetrc.m``
- Fixed the computation of the hip joint center (HJC) with the Harrington method (``HJCHarrington.m``) when the input static file has a frame number lower than 3

|
**RELEASE 2.1**   (*September 8, 2014*) 

----------------------------------

**New Features**

- Compatibility with MacOS X operating systems
- Envelope plots with normalization scale (% max)
- Plot of normalized EMG linear envelopes for all the muscles
- ``.sto`` (OpenSim storage) file format for EMG output
- ``.mot`` (SIMM and OpenSim motion) file format for EMG output (new default)


**Code Changes**

- Changed ``elaboration.xsd`` to add support of different output file formats, preserving compatibility with previous versions.
- Renamed ``mainStaticElaboration.m`` as ``StaticInterface.m``
- Moved main programs (``C3D2MAT.m``, ``ElaborationInterface.m``, ``StaticInterface.m``) to functions
- Moved internal functions in  private folders
- Renamed all ``readme.txt`` to ``README.md``
- Modified y axis scale setting of envelope plots
- Modified data storage structure: added ``dynamicElaborations`` folder to group all the multiple executions of ``DataProcessing``


**Bug Fixes**

- Removed addition of mean values after EMG filtering
- Fixed units in EMGs plotting
- Fixed x label of envelope plots
- Fixed trial type identification for filtering cutoff definition

|
**RELEASE 2.0**  (*May 9, 2014*) 

----------------------------------

**New Features**

- Support to MATLAB 64 bit and multiplatform (``C3D2MAT`` based on BTK)
- EMG selection using Analog Labels from each C3D input file
- Shoulder, elbow, and wrist JC computation for static trials, and examples of setup files for Griffith University markerset
- Missing values for markers trajectories identified by NaN instead of 0 in ``.trc`` output files


**Code Changes**

- Added ``src/shared`` folder to store functions common to several steps
- Modified filtering of markers trajectories: they are filtered only when visible and only if they have no gaps (``DataFiltering.m``, ``ZeroLagButtFiltfilt.m``)
- Modified filtering of GRF data from type 1 force platform: filtering is applied only to non zero values to avoid smoothing due to zero values  (data from force platform of type 1 are stored in C3D files after thresholding)
- Modified data interpolation: markers trajectories are interpolated only if gaps of consecutive frames are shorter than a fixed number defined according to the video frame rate (``DataInterpolation.m``)
- Modified retrieval of ``AnalogData`` in ``C3D2MAT``: removed assumption of analog data stored only in analog channels subsequent to those dedicated to force data. Now they can be stored in any analog channel independently from force data.
- Renamed ``replaceWithNans.m`` as ``replaceMissingWithNaNs.m``
- Renamed ``matfiltfilt2.m`` as ``ZeroLagButtFiltfilt.m``
- Removed warning messages caused by the lack of subject's first and last names when loading a predefined ``acquisition.xml``
- Added last selected folder in text fields of graphical user interfaces (GUIs)


**Bug Fixes**

- Modified transformation of COP coordinates from local to global reference system: translation added only for non zero values.
- User is not required to set a new identifier each time he/she load an already available ``elaboration.xml`` file as in version 1.0.
- Changed the definition of the interval where markers are visible in ``replaceMissingWithNaNs.m`` (the definition of var 'index')
- Fixed the computation of the hip joint center (HJC) with the Harrington method (``HJCHarrington.m``)

|
**RELEASE 1.0**   (*February 17, 2014*) 

----------------------------------

**Initial Release**




