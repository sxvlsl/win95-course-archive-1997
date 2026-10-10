





  PRODUCT  :  Delphi                                 NUMBER  :  2778
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/1

    TITLE  :  Making your Delphi apps show minimized.




Q: When I select the "Run Minimized" option in Program Manager
   to attempt to make my Delphi application execute in a minimized 
   state, the Delphi application seems to ignore the setting and 
   run normally.  Why is this, and how to I fix it?
 
A: Delphi's Application object creates a hidden "application 
   window," and it is that window, rather than your main form, 
   that is being sent the command to show minimized. To fix this, 
   just enter this line of code in your main form's OnCreate event handler:
 
     ShowWindow(Handle, cmdShow);
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
