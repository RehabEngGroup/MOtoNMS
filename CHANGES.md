##RELEASE 2.2##
_June 5, 2015_

###New Features###

- Processing of data along different motion directions with respect to the laboratory reference system (``forward``, ``backward``, ``90right``, ``90left``)
- Computation of CoP coordinates for force platforms with pads
- Possibility to skip the computation of joint centers in ``StaticElaboration``
- Interpolation of gaps in marker trajectories with size less than ``MaxGapSize`` (chosen by the user in the ``elaboration.xml`` file)
- Piecewise filtering for marker trajectories having NaN values due to a missed interpolation
- Inclusion of EMG labels while saving EMG data in ``.mat`` format
- Definition of a ``maxemg`` output folder for each dynamic elaboration, to group log data related to the maximum EMG values computation
- Storing of all raw EMGs selected for the maximum EMG values computation and the corresponding envelopes as ``.mat`` files
- Addition of information about the trial and the time corresponding to each maximum EMG value, when printing the ``maxemg.txt`` output file and logging in ``.mat`` format (``maxemg.mat``)
- Plot of raw EMG and envelope for each muscle, corresponding to the trial where the maximum EMG value occurs
- Availability of multiple formats documentation (`GitHub Project Pages`)
- Compatibility with MATLAB R2014b

###Code Changes###

- Added optional ``MotionDirection`` element in ``acquisition.xsd`` to support trials with different directions of motion  
- Added optional ``PadThickness`` element in ``laboratory.xsd`` and ``acquisition.xsd``, to account for plate padding in the computation of CoP coordinates
- Added ``MarkersInterpolationType`` with ``MaxGapSize`` element in ``elaboration.xsd``, to let the user define the gaps' maximum size for the interpolation of marker trajectories 
- Modified identification of the first and last frame for marker trajectories: added case of NaN values when markers are initially not visible
- Added possibility to disable warnings from BTK tool in ``C3D2MAT_btk``
- Moved saving of ``maxemg.txt`` output file inside ``maxemg`` folder
- Handled error that can occur if input C3D file names do not include the repetition number (as required)
- Handled error in Y axis scale setting in ``EnvelopePlotting.m``
- Renamed ``CHANGES.txt`` to ``CHANGES.md``

###Bug Fixes###

- Fixed reading of C3D files without data from force platforms (FP)
- Fixed handling of FP data when a laboratory has more than 2 FPs of different types
- Fixed selection of ``Leg on ForcePlatform`` in ``AcquisitionInterface`` when there are more than 2 FPs in the laboratory
- Fixed definition of ``timeStartFrame`` and ``timeEndFrame`` in ``selectionData.m`` to account for an initial starting condition of t=0 and frame number=1. Fixed accordingly the definition of ``frameArray`` in ``writetrc.m``
- Fixed computation of the hip joint center (HJC) with the Harrington method (``HJCHarrington.m``) when the input static file has a frame number lower than 3


##RELEASE 2.1##
_September 8, 2014_

###New Features###
- Compatibility with MacOS X operating systems 
- Envelope plots with normalization scale (% max)
- Plot of normalized EMG linear envelopes for all the muscles
- `.sto` (OpenSim storage) file format for EMG output 
- `.mot` (SIMM and OpenSim motion) file format for EMG output (new default)

###Code Changes###
- Changed `elaboration.xsd` to add support of different output file formats, preserving compatibility with previous versions.
- Renamed `mainStaticElaboration.m` as `StaticInterface.m`
- Moved main programs (`C3D2MAT.m`,`ElaborationInterface.m`, `StaticInterface.m`) to functions
- Moved internal functions in  private folders
- Renamed all `readme.txt` to `README.md`
- Modified y axis scale setting of envelope plots
- Modified data storage structure: added `dynamicElaborations` folder to group all the multiple executions of DataProcessing

###Bug Fixes###
- Removed addition of mean values after EMG filtering
- Fixed units in EMGs plotting
- Fixed x label of envelope plots
- Fixed trial type identification for filtering cutoff definition


##RELEASE 2.0##
_May 9, 2014_

###New Features###
- Support to MATLAB 64 bit and multiplatform (`C3D2MAT` based on BTK)  
- EMG selection using Analog Labels from each C3D input file
- Shoulder, elbow, and wrist JC computation for static trials, and examples of setup files for Griffith University markerset
- Missing values for markers trajectories identified by NaN instead of 0 in `.trc` output files
      
###Code Changes###
- Added `src/shared` folder to store functions common to several steps
- Modified filtering of markers trajectories: they are filtered only when visible and only if they have no gaps (`DataFiltering.m`, `ZeroLagButtFiltfilt.m`)
- Modified filtering of GRF data from type 1 force platform: filtering is applied only to non zero values to avoid smoothing due to zero values 
 (data from force platform of type 1 are stored in C3D files after thresholding)
- Modified data interpolation: markers trajectories are interpolated only if gaps of consecutive frames are shorter than a fixed number 
  defined according to the video frame rate (`DataInterpolation.m`)
- Modified retrieval of Analog Data in `C3D2MAT`: removed assumption of analog data stored only in analog channels subsequent to those dedicated to force data. 
Now they can be stored in any analog channel indipendently from force data.
- Renamed `replaceWithNans.m` as `replaceMissingWithNaNs.m`
- Renamed `matfiltfilt2.m` as `ZeroLagButtFiltfilt.m` 
- Removed warning messages caused by the lack of subject's first and last names when loading a predefined `acquisition.xml`
- Added last selected folder in text fields of graphical user interfaces (GUIs)

###Bug Fixes###
- Modified transformation of COP coordinates from local to global reference system: translation added only for non zero values.
- User is not required to set a new identifier each time he/she load an already available `elaboration.xml` file as in version 1.0.  
- Changed the definition of the interval where markers are visible in `replaceMissingWithNaNs.m` (the definition of var `index`)
- Fixed the computation of the hip joint center (HJC) with the Harrington method (`HJCHarrington.m`)


##RELEASE 1.0##
_February 17, 2014_

###Initial Release###