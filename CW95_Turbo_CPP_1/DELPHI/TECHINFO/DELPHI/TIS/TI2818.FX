





  PRODUCT  :  Delphi                                 NUMBER  :  2818
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/1

    TITLE  :  Searching your application's help file




The following code demonstrates how to bring up the WinHelp "Search"
dialog for your application's help file.  You can use TApplication's
HelpCommand method to send the Help_PartialKey command to the WinHelp
system. The parameter for this command should be a PChar (cast to a
longint to circumvent typechecking) that contains the string on
which you'd like to search.  The example below uses an empty string,
which invokes "Search" dialog and leaves the edit control in the
dialog empty.
 
procedure TForm1.SearchHelp;
var
  P: PChar;
begin
  Application.HelpFile := 'c:\delphi\bin\delphi.hlp';
  P := StrNew('');
  Application.HelpCommand(Help_PartialKey, longint(P));
  StrDispose(P);
end;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
