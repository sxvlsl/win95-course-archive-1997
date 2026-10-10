





  PRODUCT  :  Delphi                                 NUMBER  :  2824
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/2

    TITLE  :  Passing a Variable to a ReportSmith Report




The following code demonstrates how to pass variables to a ReportSmith
report.
 
Note: this technical information sheet assumes that you know how to
create a report that includes report variables. For additional
information see chapter four of the ReportSmith manual 'Creating
Reports' that shipped with Delphi.
 
In this case we are assigning a value ('CA') to a string report
variable named 'state'.
 
ReportSmith Code:
This is the info in the ReportVariables Dialog box in ReportSmith.
You can get to this dialog from the reportsmith menu by choosing
Tools | Report Query and pushing the Report Variables button.
 
Name: state
Type: string
Title: state var
Prompt: Enter your favorite state.
Entry: type-in
Report Variables: state ; Note this variable and the value it holds are
                          both case sensitive when passed to ReportSmith.
 
Delphi Code:
 
This code assumes that you have placed a TReport component on your form
named 'Report1' and set the ReportName property to the name of the report
that will be accepting the variable as defined above.
 
Place the following code in the OnClick Method of a pushbutton on your
form.  I use a pushbutton for simplicity, but this code could just as
easily be triggered by any other event.
 
	 procedure TForm1.Button1Click(Sender: TObject);
	  var s: string;
	  begin
  	    s:='CA';













  PRODUCT  :  Delphi                                 NUMBER  :  2824
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/2

    TITLE  :  Passing a Variable to a ReportSmith Report




 	    Report1.InitialValues.Add('@state=<'+s+'>');
   	    Report1.run;
	  end;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
