.. _`AppendixB`:

Appendix B: Validation of Setup and Configuration Files
-------------------------------------------------------


This section is only for people that needs to create new setup files, or want to manually change their configuration files. Please, try to use the graphical user interfaces and avoid playing directly with the XML configuration files. It took us a lot of time to implement them, therefore make us happy and use them :).

The only real reason to play directly with the XML files is when you start doing something new: (1) setup a new laboratory, or a new protocol either for (2) EMGs or (3) makers or (4) you need different output labels for your processed EMGs, or maybe you want to introduce a new way to (5) compute joint center.

In all these case, you need to manually create new setup files.

Usually these XML files are really simple and you can copy one already available and easily understand what you need to change. But when you are done, it is a good practice to check the syntax of your XML file against the grammar. Again, as it took us quite a lot to develop a grammar for each possible XML file, please make us happy and use it. Additionally, this is also really helpful for you as you can be sure that your file is syntactically correct and ready to be used in MOtoNMS.Indeed, errors in editing the setup files result in execution errors when running the source code; these may not be easy to understand if you are not an expert of MATLAB language and MOtoNMS behavior.

There are many possible tools that you can use. We just suggest a couple of the easiest to be used because everything is online and you do not have to install anything on your computer.


Choose one of the following links:

`<http://www.freeformatter.com/xml-validator-xsd.html>`_

`<http://www.corefiling.com/opensource/schemaValidate.html>`_


and upload your XML file and the corresponding XMLSchema (the ``.xsd`` file).

The following tables are listing the XML Schema for each type of XML setup and configuration files that you find in MOtoNMS.


.. _making-a-table:

    +------------------------------+-----------------------+
    |``XML Setup Files``           |``XML Scheme``         |
    +==============================+=======================+
    |``GU-16muscles.xml``          |                       |
    |                              |EMGsProtocol.xsd       |
    |``UNIPD-15noside-left.xml``   |                       |
    |                              |                       |
    |``UWA-16muscles-r.xml``       |                       |
    +------------------------------+-----------------------+
    |``GU.xml``                    |Laboratory.xsd         |
    |                              |                       |
    |``UMG.xml``                   |                       |
    |                              |                       |
    |``UNIPD.xml``                 |                       |
    |                              |                       |
    |``UWA.xml``                   |                       |
    +------------------------------+-----------------------+
    |``GU-10pointsCluster.xml``    |MarkersProtocol.xsd    |
    |                              |                       |
    |``UMG-OpenSim.xml``           |                       |
    |                              |                       |
    |``UNIPD_CASTforOpenSim.xml``  |                       |
    |                              |                       |
    |``UWA-Fullbody.xml``          |                       |
    +------------------------------+-----------------------+
    |``UNIPD15nosideL-CEINMS.xml`` |                       |
    |                              |                       |
    |``UNIPD15nosideL-OpenSim.xml``|EMGLabels.xsd          | 
    |                              |                       |
    |``GU-CEINMS.xml``             |                       |
    |                              |                       |
    |``UWA-CEINMS.xml``            |                       |
    +------------------------------+-----------------------+
    |``AJCMidPoint.xml``           |JCcomputation.xsd      |
    |                              |                       |
    |``EJCMidPoint.xml``           |                       |
    |                              |                       |
    |``HJCHarrington.xml``         |                       |
    |                              |                       |
    |``KJCMidPoint.xml``           |                       |
    |                              |                       |
    |``SJCMidPoint.xml``           |                       |
    |                              |                       |
    |``WJCMidPoint.xml``           |                       |
    +------------------------------+-----------------------+

.. _making-a-table:

    ===========================  =================
    ``XML Configuration Files``  ``XML Scheme``
    ===========================  =================
    ``acquisition.xml``          acquisition.xsd
    ``elaboration.xml``          elaboration.xsd
    ``static.xml``               static.xsd
    ===========================  =================
