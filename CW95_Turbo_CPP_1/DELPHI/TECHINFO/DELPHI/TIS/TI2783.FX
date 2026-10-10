





  PRODUCT  :  Delphi                                 NUMBER  :  2783
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/6

    TITLE  :  Creating Database Aliases in Code




This Technical Information document will help step thru 
concepts regarding the creation and use of ALIASES within 
your Delphi Applications.
 
Typically, you use the BDE Configuration Utility BDECFG.EXE to
create and configure aliases outside of Delphi.  However, with 
the use of the TDatabase component, you have the ability to 
create and use this ALIAS within your application-- not 
pre-defined in the IDAPI.CFG.
 
The ability to create Aliases that are only available within 
your application is important.  Aliases specify the location 
of database tables and connection parameters for database servers. 
Ultimately, you can gain the advantages of using ALIASES within 
your applications-- without having to worry about the existance 
of a configuration entry in the IDAPI.CFG when you deploy your 
application.  
 
Summary of Examples:
------- -- ---------
Example #1:  
	Example #1 creates and configures an Alias to use 
	STANDARD (.DB, .DBF) databases.  The Alias is
   	then used by a TTable component.
Example #2:
	Example #2 creates and configures an Alias to use
 	an INTERBASE database (.gdb).  The Alias is then
	used by a TQuery component to join two tables of
	the database.
Example #3:
	Example #3 creates and configures an Alias to use
        STANDARD (.DB, .DBF) databases.  This example 
	demonstrates how user input can be used to 
	configure the Alias during run-time.
 
 
Example #1:  Use of a .DB or .DBF database (STANDARD)
 













  PRODUCT  :  Delphi                                 NUMBER  :  2783
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/6

    TITLE  :  Creating Database Aliases in Code




1.  Create a New Project.
2.  Place the following components on the form:
     - TDatabase, TTable, TDataSource, TDBGrid, and TButton 
3.  Double-click on the TDatabase component or choose Database 
    Editor from the TDatabase SpeedMenu to launch the Database 
    Property editor.
4.  Set the Database Name to 'MyNewAlias'.  This name will 
    serve as your ALIAS name used in the DatabaseName Property for 
    dataset components such as TTable, TQuery, TStoredProc.
5.  Select STANDARD as the Driver Name.
6.  Click on the Defaults Button.  This will automatically add 
    a PATH= in the Parameter Overrides section.
7.  Set the PATH= to C:\DELPHI\DEMOS\DATA
    (PATH=C:\DELPHI\DEMOS\DATA)
8.  Click the OK button to close the Database Dialog.
9.  Set the TTable DatabaseName Property to 'MyNewAlias'.
10.  Set the TDataSource's DataSet Property to 'Table1'.
11.  Set the DBGrid's DataSource Property to 'DataSource1'.
 
12.  Place the following code inside of the TButton's 
     OnClick event.
 
	procedure TForm1.Button1Click(Sender: TObject);
	begin
          Table1.Tablename:= 'CUSTOMER';
          Table1.Active:= True;
	end;
 
13.  Run the application.
 
 
***  If you want an alternative way to steps 3 - 11, place the 
      following code inside of the TButton's OnClick event.
 
	procedure TForm1.Button1Click(Sender: TObject);
	begin
          Database1.DatabaseName:= 'MyNewAlias';
          Database1.DriverName:= 'STANDARD';













  PRODUCT  :  Delphi                                 NUMBER  :  2783
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  3/6

    TITLE  :  Creating Database Aliases in Code




	  Database1.Params.Clear;
          Database1.Params.Add('PATH=C:\DELPHI\DEMOS\DATA');
          Table1.DatabaseName:= 'MyNewAlias';
          Table1.TableName:= 'CUSTOMER';
          Table1.Active:= True;
          DataSource1.DataSet:= Table1;
          DBGrid1.DataSource:= DataSource1;
	end;
 
*****
 
Example #2: Use of a INTERBASE database
 
1.  Create a New Project.
2.  Place the following components on the form:
     - TDatabase, TQuery, TDataSource, TDBGrid, and TButton 
3.  Double-click on the TDatabase component or choose Database 
    Editor from the TDatabase SpeedMenu to launch the Database 
    Property editor.
4.  Set the Database Name to 'MyNewAlias'.  This name will 
    serve as your ALIAS name used in the DatabaseName Property for 
    dataset components such as TTable, TQuery, TStoredProc.
5.  Select INTRBASE as the Driver Name.
6.  Click on the Defaults Button.  This will automatically add 
    the following entries in the Parameter Overrides section.
 
	SERVER NAME=IB_SERVER:/PATH/DATABASE.GDB
	USER NAME=MYNAME
	OPEN MODE=READ/WRITE
	SCHEMA CACHE SIZE=8
	LANGDRIVER=
	SQLQRYMODE=
	SQLPASSTHRU MODE=NOT SHARED
	SCHEMA CACHE TIME=-1
	PASSWORD=
 
7.  Set the following parameters
 













  PRODUCT  :  Delphi                                 NUMBER  :  2783
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  4/6

    TITLE  :  Creating Database Aliases in Code




	SERVER NAME=C:\IBLOCAL\EXAMPLES\EMPLOYEE.GDB
	USER NAME=SYSDBA
	OPEN MODE=READ/WRITE
	SCHEMA CACHE SIZE=8
	LANGDRIVER=
	SQLQRYMODE=
	SQLPASSTHRU MODE=NOT SHARED
	SCHEMA CACHE TIME=-1
	PASSWORD=masterkey
 
8.  Set the TDatabase LoginPrompt Property to 'False'.  If you 
    supply the PASSWORD in the Parameter Overrides section and set 
    the LoginPrompt to 'False', you will not be prompted for the 
    password when connecting to the database.  WARNING:  If an 
    incorrect password in entered in the Parameter Overrides 
    section and LoginPrompt is set to 'False', you are not prompted 
    by the Password dialog to re-enter a valid password.
 
9.  Click the OK button to close the Database Dialog.
10.  Set the TQuery DatabaseName Property to 'MyNewAlias'.
11.  Set the TDataSource's DataSet Property to 'Query1'.
12.  Set the DBGrid's DataSource Property to 'DataSource1'.
 
13.  Place the following code inside of the TButton's 
     OnClick event.
 
	procedure TForm1.Button1Click(Sender: TObject);
	begin
          Query1.SQL.Clear;
          Query1.SQL.ADD(
		'SELECT DISTINCT * FROM CUSTOMER C, SALES S
		WHERE (S.CUST_NO = C.CUST_NO)
		ORDER BY C.CUST_NO, C.CUSTOMER');
          Query1.Active:= True;
	end;
 
14.  Run the application.
 













  PRODUCT  :  Delphi                                 NUMBER  :  2783
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  5/6

    TITLE  :  Creating Database Aliases in Code




Example #3: User-defined Alias Configuration
 
This example brings up a input dialog and prompts the 
user to enter the directory to which the ALIAS is to 
be configured to.  
 
The directory, servername, path, database name, and other 
neccessary Alias parameters can be read into the 
application from use of an input dialog or .INI file.
 
1.  Follow the steps (1-11) in Example #1.
2.  Place the following code inside of the TButton's 
    OnClick event.
 
procedure TForm1.Button1Click(Sender: TObject);
var
  NewString: string;
  ClickedOK: Boolean;
begin
  NewString := 'C:\';
  ClickedOK := InputQuery('Database Path', 
	'Path: --> C:\DELPHI\DEMOS\DATA', NewString);
  if ClickedOK then
  begin
    Database1.DatabaseName:= 'MyNewAlias';
    Database1.DriverName:= 'STANDARD';
    Database1.Params.Clear;
    Database1.Params.Add('Path=' + NewString);
     Table1.DatabaseName:= 'MyNewAlias';
    Table1.TableName:= 'CUSTOMER';
    Table1.Active:= True;
    DataSource1.DataSet:= Table1;
    DBGrid1.DataSource:= DataSource1;
  end;
end;
 
3.  Run the Application.
 













  PRODUCT  :  Delphi                                 NUMBER  :  2783
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  6/6

    TITLE  :  Creating Database Aliases in Code




-------------------------------------
See Also:
 
Delphi On-line help -->  
	Database Properties Editor
	TDatabase
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
