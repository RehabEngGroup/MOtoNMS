.. _`C3D2MAT`:

C3DtoMAT: from C3D to MATLAB format
===================================

This step retrieves data from the C3D input files and store them in organized MATLAB structures (``.mat`` files). This avoid to have continuous accesses to C3D files, which are computationally expensive and redundant. Any setup or configuration file is required in this step.

C3D2MAT only requires to specify the input file path. If not already available, it generates corresponding folders for the elaborated data (:ref:`Folders: organize your work <DataOrganization>`, ``MyData\ElaboratedData\subjectXXX\Year-Month-Day\``) and then converts all the data in mat format and stored them in the ``sessionData`` folder (``MyData\ElaboratedData\subjectXXX\Year-Month-Day\sessionData\``). For each trial (i.e., C3D file in the input folder), a new subfolder is created with Markers (``Markers.mat``), Force Platform Data (``FPdata.mat``) and all data stored in the analog channels (``AnalogData.mat``). When C3D files include events, they are converted and stored as well (``Events.mat``).

You can add events to your C3D files using Mokka, a freely available software for biomechanical data analysis (`<http://b-tk.googlecode.com/svn/web/mokka/index.html>`_), which supports many different file formats and allows to write on C3D files with a very user-friendly interface.

Information common to all the trials of the session are saved in the ``sessionData`` folder. This includes markers labels of dynamic trials (``dMLabels.mat``), analog data labels (``AnalogDataLabels.mat``), force platform information (``ForcePlatformInfo.mat``), rates (``Rates.mat``), and the trials list (``trialsName.mat``). If any inconsistency is found, it is pointed out in the MATLAB Command Window.


Two implementations for ``C3D2MAT`` are available, one using `C3Dserver <http://www.c3dserver.com/>`_ software and one exploiting `BTK <https://code.google.com/p/b-tk/>`_. They return the same results, but are based on two different tools to access C3D files. You can choose among the two alternatives according to your system requirements (refer to :ref:`Installation <installation>`).


.. _`C3D2MATrun`:

How to run the program
----------------------


#. Set MATLAB path on ``src\C3D2MAT_btk`` (or ``C3D2MAT_c3dserver``) folder
#. Run ``C3D2MAT.m``
#. Select your C3D input data folder


**Output**: data from C3D files in the specified data folder are converted and saved in mat format.


Please pay ATTENTION to the following IMPORTANT NOTES:

.. warning::

   + Input files folder MUST be inside a folder named ``InputData`` (:ref:`Folders: organize your work <DataOrganization>`).

   + The execution of ``C3D2MAT`` does not overwrite information common to the acquisition session, i.e. that must be the same for all trials collected during an acquisition, as ``trialsName.mat``, ``Rates.mat``, ``dMLabels``, ``AnalogDataLabels.mat``, ``ForcePlatformsInfo.mat``. Please, keep in mind to cancel the ``sessionData`` folder before running again the program if you add trials or modify your data set.

   + Different events MUST have different name (`Analysis Window Definition <analysisWindDef>`_, ``WindowFromC3D``).

   + Events for foot strike and foot off must identify frames with non-zero force values (`Analysis Window Definition <analysisWindDef>`_, ``StanceOnFPfromC3D``).

   + If you are using ``C3D2MAT_c3dserver``, remember to install `C3Dserver <http://www.c3dserver.com/>`_ software (:ref:`Installation <installation>`) and that it works only on MATLAB 32 bit.

   + If you are using ``C3D2MAT_btk``, remember to download the correct `BTK <https://code.google.com/p/b-tk/wiki/MatlabBinaries>`_ version for your    system and to add it to the path of MATLAB. Type the command ``help btk`` in the MATLAB command window to verify that BTK is loaded in MATLAB (:ref:`Installation <installation>`).

   + Data gathered using FP of type 4 are stored in the C3D files in :math:`V` (`<http://www.c3d.org/pdf/c3dformat_ug.pdf>`_). ``C3D2MAT`` retrieves and directly converts force data in :math:`N` and :math:`N \cdot mm` or :math:`N \cdot m` (according to the used distance unit). Be aware that the scale of results saved in ``FPdata.mat`` does not match with the one you see in the input C3D files.

   + C3D files storing data gathered with FPs of type 4 must include information about the corresponding FP calibration matrix. This is required to convert force data from :math:`V` to :math:`N` and :math:`N \cdot mm` or :math:`N \cdot m`.
