REM  ***************************************************************************
REM  *******************************  BUILD.BAT  *******************************
REM  ***************************************************************************

REM  BUILD.BAT carries out several tasks required to build the installation.
REM  You can modify BUILD.BAT to meet the needs of your own installations that
REM  are based on the Delphi Application sample template.

REM  ***************************************************************************
REM  ***********  Create the Distribution Disk Image Directories  **************

mkdir disk
mkdir disk\disk1
mkdir disk\disk2
mkdir disk\disk3

REM  ***************************************************************************
REM  ***********************  Create the DATA.Z Library File  ******************

del data.z
isexe\icomp  data\*.* data.z -i

REM  ***************************************************************************
REM  *************  Compile SETUP.RUL and Copy SETUP.INS to DISK1  *************

cd setup
..\isexe\compile setup.rul
copy setup.ins ..\disk\disk1
cd ..

REM  ***************************************************************************
REM  *************  Create the Packaging List and Copy It to DISK1  ************

packlist setup.lst
copy setup.pkg disk\disk1

REM  ***************************************************************************
REM  *******  Copy InstallShield Executable and Resource Files to DISK1  *******

copy isexe\_setup.lib   disk\disk1
copy isexe\setup.exe    disk\disk1
copy isexe\_inst16.ex_  disk\disk1
copy isexe\_setup.dll   disk\disk1
copy isexe\uninst16.exe disk\disk1

REM  ***************************************************************************
REM  ****  Create Disk ID Files and Copy to Matching Disk Image Directories  ***

echo "" > disk1.id
echo "" > disk2.id
echo "" > disk3.id

copy disk1.id disk\disk1
copy disk2.id disk\disk2
copy disk3.id disk\disk3

REM (Delete local copies of disk ID files.)
del disk1.id
del disk2.id
del disk3.id

REM  ***************************************************************************
REM  *********  Split DATA.Z and Copy Parts to Disk Image Directories  *********

isexe\split data.z  -d1@900 -f1415

copy data.1 disk\disk1
copy data.2 disk\disk2
copy data.3 disk\disk3

REM (Delete local copies of split DATA.Z file.)
del data.1
del data.2
del data.3