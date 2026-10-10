

ReportSmith Version 2.5.2 Release Notes
=====================================================================

Contents
I.    New Features in this Version
II.   Borland Database Engine (BDE) Installation Notes
III.  BDE Driver for InterBase and Informix
IV.   ODBC Installation Notes
V.    BDECFG.EXE and BDE Connections for Paradox
VI.   Customizing Sorting
VII.  Warnings and Known Problems
VIII. International Issues
IX.   Changes since last version
=====================================================================

I. New Features in this Version

ReportSmith 2.5 introduces new features to create more types of reports, as
well as to simplify building reports.

This version allows you to perform the following tasks:
-Create master/detail reports to combine multiple reports in one using
 heterogenous data.
-Choose to group, sort or summarize data locally or on a database server.
-Access data using Borland's BDE drivers.
-Include columns in a report for query-only or value-only.
-Utilize an updated ReportBasic macro language.
-Place page totals to display summary values for each page in a report.
-Create data dictionaries to use with the PC or SQL versions of ReportSmith,
 to simplify the view of the data.


Undocumented New Features
-------------------------

A. Source Database Name Editor
------------------------------

The Data Dictionary administrative tool now contains a Source Database
Name Editor. The feature allows you to edit the name assigned to database
sources within Data Dictionary views. To edit database source names,
follow these steps:

1. Choose File|Edit source database names and the Source Database
   Editor dialog box appears.

2. Select the dictionary on which you want to change the source name. If
   the dictionary was created on a local database such as dBASE or Paradox,
   the source names will be displayed. If the dictionary was created on
   a remote database, you must first log in to the database before the
   source is displayed.

3. Select the source name that you want to edit and enter the new name
   in the Add New Source Database Name edit box.

4. Press Rename and the new source name appears in the source list.

5. Press Done.

B. Preloading Records
---------------------

ReportSmith now offers the option of preloading records in the
Tools|Options dialog box. When the Preload Records option is unchecked
ReportSmith loads only the number of records necessary for display.
When checked, this option will load all records in a query. When performing
queries with multiple modifications this option may be preferable.


C. New local SQL String Functions for BDE
------------------------------------------

Two string functions are now available: upper and lower. The following
example shows their use. These can be used in either the Selection criteria
or Derived Fields.

select *
from customer
where upper(Name) = "TODD JONES"
=======================================================================

II. Borland Database Engine (BDE) Installation Notes

Note: The Borland Database Engine (BDE) may be referenced as IDAPI
in some parts of the product and documentation.

ReportSmith automatically installs the BDE drivers for dBASE and Paradox.
The BDE drivers support the following Borland table types:

- dBASE for DOS types 3 (III) and 4 (IV)
- dBASE for Windows type 5 (5.0)
- Paradox for DOS types 3 (version 3.5) and 4 (version 4.0)
- Paradox for Windows type 5 (version 5.0)

Note: ReportSmith does not currently support the new data types BLOB.

You can still use ODBC drivers to connect to dBASE table types 3 (III)
and 4 (IV) and Paradox table types 3 (version 3.5) and 4 (version 4.0).

======================================================================

III. BDE Driver for InterBase and Informix

ReportSmith requires the appropriate BDE drivers and Borland's
SQL Links to connect to an InterBase and Informix data sources.
ReportSmith will recognize InterBase and Informix data sources
during the install.  Use the BDE configuration utility (BDECFG.EXE)
to configure and set up additional InterBase and Informix aliases.

=======================================================================

IV. ODBC Installation Notes

During the ReportSmith installation you can choose to install the
ODBC 1.0 drivers that are shipped with the product. If these drivers
are newer than the drivers you have installed on your machine, the install
will overwrite them.  Otherwise, the install program will not overwrite
your existing ODBC drivers.

The ReportSmith installation also creates data source names for each
ODBC driver that you choose to install.  Each name is given the prefix
RS_ followed by the database name (e.g.  RS_dBASE.)  These names appear
in the data type list in ReportSmith.  If you do not wish to keep these
data source names, you can easily delete or rename them through the ODBC
administrator located in the Windows Control Panel.

This version of ReportSmith supports Microsoft ODBC 1.0 and 2.0 drivers.

========================================================================

V. BDECFG.EXE and BDE Connections for Paradox

 -    ReportSmith will not correctly build Paradox SQL if the location of
      the NETDIR item of the BDECFG.EXE is incorrect or missing.

      To correct or enter the NETDIR setting, select Paradox in the Driver
      Name list box in the BDE Configuration Utility, browse to locate the
      pdoxusrs.net file. Ask your Systems Administrator if you're unsure
      of the location of this file. After selecting a valid directory for
      this file, press return and File | Save before exiting the BDE
      Configuration Utility.

 -    You should also set the Paradox Network Control File Path in the
      Paradox Engine Network Configuration utility (PXENGCFG.EXE), and
      a valid User Name.

 -    If you are running Paradox in a Network environment and want to
      share data files, then all users MUST set the same Network Control
      File Path.  See HELP in PXENGCFG.EXE.

========================================================================

VI. Customizing Sorting

With this version of ReportSmith, sorting is performed locally whenever
possible. ReportSmith automatically determines whether sorting should
occur locally or on the server based on available memory or disk space.

To disable local sorting, put the following entry into the [OptionsSection]
of the RPTSMITH.INI:

LocalSort=0

========================================================================

VII. Warnings and Known Problems

  a.  When connecting to InterBase through BDE, each InterBase server and
      each userID must have a separate alias.

  b.  Best fit cannot be performed on fields in headers.

  c.  Text and FoxPro ODBC drivers cannot be used as a data source in a
      named connection.

  d.  Some third party components may not be available under Windows95
      for client/server connectivity. Check with your third party vendors
      for availability.

  e.  The new Microsoft ODBC 2.0 text driver does not support file names
      with extensions. To open text files, either rename the files so
      they do not have extensions, or within ReportSmith, use table aliases.

  f.  For Oracle connections, if using any lowercase for column or table names,
      then put the following entry into the RS_SQLIF.INI under the [Oracle]
      section:

      IDQUOTE="


  Data Dictionary
  -----------------
  a.  ODBC and BDE connections for dBASE are treated as entirely different
      connections by the Data Dictionary, as are Paradox ODBC and BDE
      connections.

  b.  If a Data Dictionary view is created with a drive or directory mapping
      in a source database that is different than the connection with which
      it is associated in ReportSmith, the dictionary view will not be
      applied. To apply the view, create an additional source database within
      the first view, or create an additional view.

  c.  Apostrophes are not permissable in the name of a Data Dictionary view.

  d.  InterBase columns that have the same name as the table (such as
      Country.Country) cannot be included in a Data Dictionary after an
      exclude all is performed, and vice versa.

  e.  Data Dictionaries cannot be created in dBASE using the Microsoft
      ODBC 2.0 dBASE driver. NOTE: Entries in a data dictionary can refer to
      the 2.0 driver.

  f.  Database grouping does not function properly using data dictionaries.


  Macro Language
  ---------------
  a.   The CloseReport and CloseRS commands will no longer return non-zero if
       the user selects Cancel when prompted to save a report. The functions
       will now return zero when executed successfully, or non-zero on error,
       (such as no report open for the CloseReport command).

  b.   Str2Date, Date2Str, and DateField are now obsolete commands. These
       commands are still supported for compatibility. The new Date/Time
       commands should be used in place of these commands.

  c.   It is not valid to use the LoadReport command in the "Before Report
       Open" event or the "After Report Open" event.

  d.   The LoadReport command cannot be used to initialize report variables
       in the detail section of a master/detail report.

  e.  To disable a menu item for all reports, execute the macro command to
      enable macros in the Application Startup event, or, place a '!' before
      the menu to be disabled.

      For example: EnableMenu "!File|New"

  f.  SelectReport cannot be run from the macro dialog box.


========================================================================

VIII. International Issues


A. To enable OEM<==>ANSI character translation for a native SQL ORACLE
   connection, update the RS_SQLIF.INI to include:

[Oracle]
LD=ldname
   where ldname is the name of the language driver used to perform the
   translation. See BDECFG online help or The Borland SQL Link User's
   Guide for a list of language driver names.


B. To enable OEM<==>ANSI character translation for a native SQL Server type
   connection including Sybase, update the RS_SQLIF.INI to include:

[SQL Server]
LD=ldname
   where ldname is the name of the language driver used to perform the
   translation. See BDECFG online help or The Borland SQL Link User's
   Guide for a list of language driver names.


C. To enable generation of SQL that conforms to that of a server configured
   for a localized date format update the appropriate RS_SQLIF.INI section to
   include a DateTimeFormat specification. For a server expecting dates in
   dd/mm/yyyy format the following line would be added to the appropriate
   connection section:

   DateTimeFormat=""'"dd\/mm\/yyyy hh:mm:ss"'""

========================================================================

IX.  Changes since 2.5.1

A.  BDE aliases are now available for use in the connections type combobox.
    The information for the alias is read from the IDAPI.CFG file, and
    fields such as Server Name and User Name are filled in
    automatically.

B.  Negative money fields for SQL Server are now displayed correctly.

C.  Improved speed of record retrieval for all databases.

D.  Crosstab currency formatting in a style remains constant.  For
    example, a report with a crosstab created in the US with $ that is
    sent to another country will retain the $ format.  It will not
    change to the local currency format that's set in the control panel.

    NOTE: the date/time format and decimal seperator will change to reflect the
    current control panel setting.

E.  The macro dataset object Connect now properly recognizes named
    connections.

F.  Fixed GPF with dragging columns to a header/footer, then deleting
    the header/footer, and inserting that field again.

G.  Fixed problem with GDI memory leak after printing reports. For example,
    printing the same report 50 times in a single ReportSmith session
    would cause GDI memory to decrease significantly.


H.  A new Oracle setting was added to ReportSmith so that it will not qualify
    synonymns with its owner in the SQL statment.

    Add the following item in the [Oracle] section of the RS_SQLIF.INI:
    QualifySynonymsWithOwners=0

I.  In the RunTime product, can now enable/disable toolbar buttons
    from the macro language.

J.  In the RunTime product, reports will never come up in draft mode.

K.  Fixed problem with custom sort order in a crosstab with international
    numeric format.

L.  Fixed display problem when 2 graphs are in the same section.

M.  Macros linked to the "Before SQL is Executed" application event will
    now execute.

========================================================================
