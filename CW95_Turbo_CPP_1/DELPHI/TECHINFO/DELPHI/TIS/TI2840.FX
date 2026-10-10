





  PRODUCT  :  Delphi                                 NUMBER  :  2840
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 27, 1995                            PAGE  :  1/2

    TITLE  :  Removing the vertical scrollbar from a TDBGrid




In order to remove the vertical scrollbar from a TDBGrid component, 
you must override its Paint method.  Inside the Paint method you 
must call the SetScrollRange API procedure to set the min and max 
scroll values to zero (this disables the scrollbar), and then call
the inherited Paint.  The code below is a unit containing a new 
component called TNoVertScrollDBGrid that does this.  You can copy
the code into a file called NEWGRID.PAS, and add it to the component
library as a custom component.
 
 
unit Newgrid;
 
interface
 
uses
  WinTypes, WinProcs, Classes, DBGrids;
 
type
  TNoVertScrollDBGrid = class(TDBGrid)
  protected
    procedure Paint; override;
  end;
 
procedure Register;
 
implementation
 
procedure TNoVertScrollDBGrid.Paint;
begin
  SetScrollRange(Self.Handle, SB_VERT, 0, 0, False);
  inherited Paint;
end;
 
procedure Register;
begin
  RegisterComponents('Data Controls', [TNoVertScrollDBGrid]);
end;
 













  PRODUCT  :  Delphi                                 NUMBER  :  2840
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 27, 1995                            PAGE  :  2/2

    TITLE  :  Removing the vertical scrollbar from a TDBGrid




end.
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
