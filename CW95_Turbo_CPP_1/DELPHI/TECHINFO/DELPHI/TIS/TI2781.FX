





  PRODUCT  :  Delphi                                 NUMBER  :  2781
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/3

    TITLE  :  Step by Step Configuration of an ODBC Driver




        CONFIGURING AN ODBC DRIVER AND ALIAS FOR DELPHI
        -----------------------------------------------
 
CONTROL PANEL'S ODBC OPTION
 
Delphi installs an ODBC option to the Windows Control Panel
program. The ODBC option indicates the available data sources
(drivers) installed for use by ODBC. As you will find by
selecting the ODBC option, a number of formats are installed
with Delphi and are seen in the main window titled Data Sources.
Additional formats may be supported by the drivers installed and
can be configured by selecting the Add... button.
 
If a new driver is to be added or removed,
 
1. Select the Drivers... button from the Data Sources Window.
From the drivers dialog, select the Add... button and provide
the path where the ODBC driver will be found.
 
2. Return to the Data Sources Windows and include the possible
data sources available through the new driver by selecting its
Add... button.
 
3. To configure options available for a particular data
source use the Setup... button. The function of the Setup...
button will vary with each data format. Very often options like
the working directory for the driver are configured in this
area.
 
Online help is available for each dialog involved with the ODBC
option.
 
 
BDE CONFIGURATION UTILITY
 
After installing the ODBC driver, run the BDE Configuration
utility to configure the database engine to use the new driver.
 













  PRODUCT  :  Delphi                                 NUMBER  :  2781
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/3

    TITLE  :  Step by Step Configuration of an ODBC Driver




1. From the drivers page, select the New ODBC driver button.
 
2. A dialog titled Add ODBC driver will appear. The option for
SQL link driver is what will distinguish the databases created
using this ODBC driver.
 
3. Next select the default ODBC driver. Dropping down the list
from the combobox will reveal the file types supported by ODBC
drivers installed on the system.
 
4. Select the default data source for the ODBC driver. Having
set the ODBC driver in step 3 above, the list of this combobox
will have the data source names appropriate for use with the
selected driver.
 
5. Select Ok.
 
6. Returning to the drivers page, select File/Save from the main
menu to save this configuration.
 
CREATING AN ALIAS IN THE DATABASE DESKTOP
 
While this can be done from the BDE Configuration utility, it is
more convenient overall to create ODBC aliases from the Database
Desktop.
 
1. From the File menu, select Aliases...
 
2. From the resulting Alias Manager dialog, select New.
 
3. Type the name for your new alias in the area labeled Database
Alias.
 
4. Use the drop down list of the Driver Type combobox to select
the driver appropriate for this alias. Paradox and dBase tables
are considered STANDARD. If the ODBC driver was properly
configured in the BDE Configuration utility it's name will
appear in this list.













  PRODUCT  :  Delphi                                 NUMBER  :  2781
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  3/3

    TITLE  :  Step by Step Configuration of an ODBC Driver




 
5. Additional options may appear depending upon the driver type
you select.
 
6. When finished, select Keep New to store the new alias. Then
select Ok. You will be prompted for whether or not to save the
aliases to IDAPI.CFG. Select Okay.
 
The alias will now be usable from both the Database Desktop and
Delphi.
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
