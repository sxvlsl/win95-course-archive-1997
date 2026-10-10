





  PRODUCT  :  Delphi                                 NUMBER  :  2816
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 20, 1995                            PAGE  :  1/1

    TITLE  :  Trouble running Delphi programs from Delphi




 
                        Delphi Integrated Debugger
                        --------------------------
 
Delphi's integrated debugger is a feature of the IDE that allows
you to execute, step, trace, and otherwise debug your Delphi
applications.  By default, Delphi's integrated debugger is enabled (via
Options|Project|Integrated Debugging) on startup of Delphi.
 
 
The debugger handles certain interrupts and operating system debugger
hooks in an effort to trap General Protection Faults and other types
of exceptions.  Other programs that attempt to handle exceptions in the
same way will quite possibly conflict with the integrated debugger.
DataSafe is one example of a program that conficts with the integrated
debugger.  Classic symptoms include, Delphi not recognizing that you've
stopped your program and getting kicked into DOS without warning at
various stages.
 
To test for a debugger conflict, compiling the program from Delphi,
and run it from File Manager.  If it runs, then disable the integrated
debugger, and run your application.  If it still runs, then the problem
is most likely a conflict between the exception-handling software and
the integrated debugger.
 
There are two ways to fix this.   The first is to remove the
conflicting software.   The other is to disable the integrated
debugger by un-selecting Options|Enviroment|Integrated Debugging.
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
