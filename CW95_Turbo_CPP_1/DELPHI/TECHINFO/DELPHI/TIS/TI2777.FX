





  PRODUCT  :  Delphi                                 NUMBER  :  2777
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/2

    TITLE  :  Instructions for Running Delphi from CD-ROM




                RUNNING DELPHI FROM THE CD-ROM
                ------------------------------
 
Delphi can be run from a CD-ROM directly. However, it is highly
recommended that at least a minimum installatiion be seriously
considered before opting for running Delphi from CD-ROM.
 
For a minimum installation, 33MB of available hard disk space is
required.
 
Running from a CD-ROM, 9MB of available hard disk space is
required.
 
To configure the system to run Delphi from the CD-ROM,
 
1. Copy all files found in the CD's \RUNIMAGE\WINDOWS directory to the
Windows directory of the hard disk.
 
2. Copy all files found in the CD's \RUNIMAGE\WINDOWS\SYSTEM
directory to the Windows SYSTEM directory of the hard disk.
 
3. Edit DELPHI.INI in a text editor like Windows Notepad. Look
for the section titled [Globals]. Make entry for the PrivateDir
setting that resides on a writeable disk, preferably a local
hard disk.
 
For instance, if a directory on the C: drive where chosen called
DELPRIV, the relevant section of DELPHI.INI would look as
follows.
 
[Globals]
PrivateDir=C:\DELPRIV\
 
Now, Delphi can be run from the \RUNIMAGE\DELPHI\BIN directory
of the CD-ROM.
 
                     MODIFYING COMPONENTS
                     --------------------













  PRODUCT  :  Delphi                                 NUMBER  :  2777
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/2

    TITLE  :  Instructions for Running Delphi from CD-ROM




 
To allow modification of the component library used by Delphi
while running from a CD ROM an copy of the Component Library
must exist on a writeable disk. Use the following steps as a
guide.
 
1. Copy COMPLIB.DCL from the CD's \RUNIMAGE\DELPHI\BIN directory
to a desired directory on the hard disk.
 
2. Run Delphi.
 
3. Bring down the Options menu and select Open Library.
 
4. Specify the directory and file name for the COMPLIB.DCL
copied to the hard disk.
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
