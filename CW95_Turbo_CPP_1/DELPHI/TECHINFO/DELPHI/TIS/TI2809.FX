





  PRODUCT  :  Delphi                                 NUMBER  :  2809
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/2

    TITLE  :  Printing the contents of a TMemo or TListbox




Q: How can I print all of the lines within a TMemo or TListbox component?
 
A: The function below accepts a TStrings object as a parameter and prints
   out each string to the default printer.  Because it uses a TStrings, the
   function will work with any type of component that contains a 
   TStrings-type property, such as a TDBMemo or TOutline.
 
{ Begin code listing }
 
uses Printers;
 
procedure PrintStrings(Strings: TStrings);
var
  Prn: TextFile;
  i: word;
begin
  AssignPrn(Prn);
  try
    Rewrite(Prn);
    try
      for i := 0 to Strings.Count - 1 do
        writeln(Prn, Strings.Strings[i]);
    finally
      CloseFile(Prn);
    end;
  except
    on EInOutError do
      MessageDlg('Error Printing text.', mtError, [mbOk], 0);
  end;
end;
 
{ End code listing }
 
To print out the contents of a TMemo or TListbox, use the following
code:
 
PrintStrings(Memo1.Lines);
 













  PRODUCT  :  Delphi                                 NUMBER  :  2809
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/2

    TITLE  :  Printing the contents of a TMemo or TListbox




or
 
PrintStrings(Listbox1.Items);
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
