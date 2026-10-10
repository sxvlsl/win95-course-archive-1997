





  PRODUCT  :  Delphi                                 NUMBER  :  2815
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/1

    TITLE  :  How to handle text drawing in a TDBGrid




The following method can be used as the event handler for a 
TDBGrid.OnDrawDataCell event.  This method demonstrates how
to paint the text in one column a different color than the
rest of the text in the grid.
 
procedure TForm1.DBGrid1DrawDataCell(Sender: TObject; const Rect: TRect;
  Field: TField; State: TGridDrawState);
{ NOTE: DefaultDrawing propery of Grid(s) must be set to False }
begin
  { if field name is "NAME" }
  if Field.FieldName = 'NAME' then       
    { change font color to red }
    (Sender as TDBGrid).Canvas.Font.Color := clRed;  
  { draw text in the grid }
  (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2,
                                      Field.AsString);
end;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
