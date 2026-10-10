





  PRODUCT  :  Delphi                                 NUMBER  :  2792
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/1

    TITLE  :  How to match file date/time stamps.




Q: "How can I write a function that sets the date of one file equal to the
   date of another file?"
 
A: No problem.  Just use the following function, which takes two strings
   representing full DOS path/file names.  The file who's date you
   wish to set is the second parameter, and the date you wish to set it to
   is given by the file in the first parameter.
 
procedure CopyFileDate(const Source, Dest: String);
var
  SourceHand, DestHand: word;
begin
  SourceHand := FileOpen(Source, fmOutput);       { open source file }
  DestHand := FileOpen(Dest, fmInput);            { open dest file }
  FileSetDate(DestHand, FileGetDate(SourceHand)); { get/set date }
  FileClose(SourceHand);                          { close source file } 
  FileClose(DestHand);                            { close dest file }
end;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
