Error Messages
==============

A complete section dedicated to handled error messages will be
available in the next version of this User Manual.

Meanwhile, for any doubt or problem, please refer to the MOtoNMS Public Forum, available from the SimTK project page (`<https://simtk.org/home/motonms>`_), or write an email to Alice
Mantoan, ali.mantoan@gmail.com.


In case of error, a useful function for debugging is ``save_to_base()``,
with input argument set to 1 (``save_to_base(1)``). It copies all
variables in the calling function to the base MATLAB workspace.This
allow to check the internal variables from the MATLAB command prompt
after the calling function ends.