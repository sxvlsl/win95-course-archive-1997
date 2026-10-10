********************************************************************************
***********  A Delphi Application Installation Using InstallShield3  ***********
********************************************************************************
THIS TEMPLATE FOR INSTALLING DELPHI APPLICATIONS IS PROVIDED BY INSTALLSHIELD
CORPORATION.  PLEASE DO NOT CONTACT BORLAND OR BORLAND TECHNICAL SUPPORT WITH
QUESTIONS REGARDING THIS TEMPLATE.

PLEASE CONTACT INSTALLSHIELD CORPORATION ONLY. INSTALLSHIELD TECHNICAL SUPPORT
WILL BE PLEASED TO HELP YOU WITH ANY QUESTIONS RELATED TO INSTALLATION OF
DELPHI APPLICATIONS.

This InstallShield3 template provides an easy-to-customize installation for
Delphi applications. The template shows how to install a Delphi application,
plus it contains the basis for extending the installation to install the Borland
Database Engine (BDE) and Local InterBase Server (LIBS).  The template can also
be easily extended to include Borland ReportSmith runtime files.

This template consists of this README.TXT file and the installation SETUP.RUL
file.

********************************************************************************
************************  Requirements and Information  ************************

This Delphi application installation template is an InstallShield installation
script and therefore requires InstallShield to compile and run.

InstallShield is the world's leading installation creation software, providing
unmatched power and versatility to installations.

To obtain a copy of InstallShield, contact InstallShield Corporation at:

Internet:               info@installshield.com

Fax:                    (708) 240-9120

Phone:                  708-619-7013
                        708-619-7012

Mail:                   InstallShield Corporation
                        1100 Woodfield Road
                        Suite 108, Schaumburg, IL 60173-9946
                        USA

World Wide Web:         http://www.installshield.com
                        (available October 1995)

If you have technical questions about the installation, or about Borland
Delphi-related products as they relate to this installation template, contact
InstallShield Technical Support at the following e-mail address, and specify
Sanjay Shroff as the e-mail recipient:

Internet:               support@installshield.com

NOTE: Do not contact Borland with questions related to this installation
template.

********************************************************************************
**********************  Installation Directory Structure  **********************

The installation created by this sample template requires a directory structure
like the one shown below. The files and directories are not provided with the
template. You must create the directories and copy files from the Borland
Delphi CD (for the DATA directory and subdirectories) and from your InstallShield
ISHIELD\PROGRAM directory (for the ISEXE directory).

DATA         <DIR>
SETUP        <DIR>
DLL          <DIR>
ISEXE        <DIR>
DISK         <DIR>

DATA Directory
==============
The DATA directory will contain all the project files, BDE files, and LIBS
files. The files should be logically grouped in different directories, as shown
below, to make it very easy to update files of any component. The files for
BDE and LIBS must be copied from the Delphi installation CD. The sample
application installed by this template is provided on the Delphi CD in the
DEMOS\DB\ANIMALS directory.

The DATA directory has three subdirectories: BDE, IBLOCAL, and MYAPP.
The following shows the structure of the DATA directory:

DATA                  <DIR>

DATA\BDE              <DIR>
DATA\BDE\LANGDRV      <DIR>

DATA\IBLOCAL          <DIR>
DATA\IBLOCAL\BIN      <DIR>

DATA\MYAPP            <DIR>
DATA\MYAPP\PROJ       <DIR>
DATA\MYAPP\DATA       <DIR>



DATA\BDE Directory
==================
The BDE directory contains all the Borland Database Engine Files. It has
a subdirectory, LANGDRV, which contains all the language driver files. When
installed on the user's system, a similar directory structure will be created
there.

DATA\IBLOCAL Directory
======================
The IBLOCAL directory contains all the InterBase Local Server files. The BIN
directory contains all the DLLs and executables. All the DLLs and executable
files are checked for version information, and only the most up-to-date files
will be installed.

DATA\MYAPP Directory
====================
The MYAPP directory contains all the application executables and the data files.
This is where the Delphi sample application files should be located. You can use
this template to quickly create an installation for your Delphi application by
placing your application files in this directory. If you use a directory name
other than MYAPP, you must modify the SETUP.RUL file accordingly (wherever
"MYAPP" is used as a product name, directory name, etc.).

SETUP Directory
===============
The SETUP directory will include the script file, SETUP.RUL, which performs all
the essential requirements.

DLL Directory
=============
The DLL directory will store all DLLs.

ISEXE Directory
===============
The ISEXE directory can be used to store the InstallShield executable and
program files, which are used to build the installation.

DISK Directory
==============
The DISK directory is the parent directory for the distribution disk image
directories.


********************************************************************************
*************************  Creating Distribution Disks  ************************

Use the following steps as a guide to creating distribution disks. Refer to
your InstallShield3 documentation for more details on creating the installation.

1. Create distribution disk image directories. These directories are mirror
   images of the contents of each distribution disk used for your installation.

2. Create a packaging list (.PKG) file and place it on distribution disk 1.

3. Copy all required InstallShield3 executable and resource files onto
   distribution disk 1. These files include SETUP.INS (compiled SETUP.RUL),
   _SETUP.LIB, SETUP.EXE, _INST16.EX_, and _SETUP.DLL.

4. Compress all files (including subdirectories) in the DATA directory into a
   library file named DATA.Z.  Split this file and place the split parts onto
   the distribution disks. The first split part should fit onto distribution
   disk 1 (its size depends on the amount of space available), and the remaining
   parts should be placed onto the remaining distribution disks.

5. Create a disk ID file (DISK1.ID, DISK2.ID, etc.) for each distribution disk
   and place each disk ID file onto the corresponding disk.
