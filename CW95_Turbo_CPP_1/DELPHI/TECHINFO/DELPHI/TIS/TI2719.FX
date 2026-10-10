





  PRODUCT  :  Delphi                                 NUMBER  :  2719
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/4

    TITLE  :  College Student Guide to Reading and Writing Files




College Student Crib Notes to:
 
1) Printing out your programs' output to a file.
2) Printing out your programs' output to the printer.
3) Reading from an input file.
 
 
Printing Out Your Programs Output to a File
-------- --- ---- -------- ------ -- - ----
Often times, professors will require more than your honesty
and good faith to receive full credit for your program.  They 
will want to see both your program listing and the output 
generated from the program.  But how do you do this in Delphi
and our Pascal Products ???
 
Simply in Delphi ....
 
   program CrtApp;
   uses WinCrt; 
   var outfile: TextFile;
   begin
     AssignFile(outfile, 'c:\outfile.txt');
     Rewrite(outfile);
     writeln(outfile, 'Hello World from Delphi');
     writeln(outfile, 'My Program works, and here is ' + 
                      'the output to prove it...');
     CloseFile(outfile);
   end.
 
Simply in Pascal .....
 
   Program HelloWorld;
   var
     outfile: text;
   begin
     assign(outfile, 'c:\output.txt');
     rewrite(outfile);
     writeln(outfile, 'Hello World');













  PRODUCT  :  Delphi                                 NUMBER  :  2719
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/4

    TITLE  :  College Student Guide to Reading and Writing Files




     writeln(outfile, 'My Program works, and here is the 
             output to prove it...');
     close(outfile);
   end.
 
 
Printing Out Your Programs' Output to the Printer
-------- --- ---- --------- ------ -- --- -------
In some cases, there may be a need to print output directly to 
the printer.  This is the way.
 
In Delphi ...
 
   program CrtApp;
   uses WinCrt;
   var outfile: TextFile;
   begin
     assignfile(outfile, 'LPT1');
     rewrite(outfile);
     writeln(outfile, 'Hello World from Delphi');
     writeln(outfile, 'My Program works, and here is ' +
                      'the output to prove it...');
     closefile(outfile);
   end.
 
In Pascal ...
 
   Program HelloWorld;
   var
     outfile: text;
   begin
     assign(outfile, 'LPT1');
     rewrite(outfile);
     writeln(outfile, 'Hello World');
     writeln(outfile, 'My Program works, and here is the 
             output to prove it...');
     close(outfile);
   end.













  PRODUCT  :  Delphi                                 NUMBER  :  2719
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  3/4

    TITLE  :  College Student Guide to Reading and Writing Files




 
 
Reading From an Input File
------- ---- -- ----- ----
Many times, it will be neccessary to read information from an 
input file supplied by another person.  This is an example of 
how to implement this.
 
In Delphi ...
 
   program CrtApp;
   uses WinCrt;
   var
     infile, outfile: TextFile;
     num_lines, x: integer;
     line: string;
   begin
     assignfile(infile, 'C:\INFILE.TXT');
     assignfile(outfile, 'C:\OUTFILE.TXT');
     reset(infile);  {reset moves the pointer to the beginning}
                     {of the file.                            }
     rewrite(outfile);  {clears the contents of the file}
     readln(infile, num_lines);
     for x:= 1 to num_lines do
     begin
       readln(infile, line);
       writeln(outfile, line);
     end;
     closefile(infile);
     closefile(outfile);
   end.
 
In Pascal ...
 
    Program ReadInput;
    var
      infile, outfile: text;
      num_lines, x: integer;













  PRODUCT  :  Delphi                                 NUMBER  :  2719
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  4/4

    TITLE  :  College Student Guide to Reading and Writing Files




      line: string;
    begin
      assign(infile, 'C:\INFILE.TXT');
      assign(outfile, 'C:\OUTFILE.TXT');
      reset(infile);  {reset moves the pointer to the beginning}
                      {of the file.                            }
      rewrite(outfile);  {clears the contents of the file}
      readln(infile, num_lines);
      for x:= 1 to num_lines do
      begin
        readln(infile, line);
        writeln(outfile, line);
      end;
      close(infile);
      close(outfile);
    end.
    
{START INFILE.TXT}
2
Hello World
My Program works, and here is the output to prove it.
{END INFILE.TXT}
 
-----------------------------------------------------------------
For further reference, please check your Programmer's Reference.
Look for the topics (AssignFile, Assign, Reset, Rewrite, readln, 
writeln, Close, CloseFile)
-----------------------------------------------------------------
This document was written and inspired by the author's sympathy 
for the starving college student-- only because he was recently 
in your shoes..!!
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
