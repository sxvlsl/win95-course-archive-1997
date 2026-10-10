





  PRODUCT  :  Delphi                                 NUMBER  :  2810
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/2

    TITLE  :  Extracting A Bitmap From A BLOB Field




Extracting a bitmap from a dBASE or Paradox blob field -- without first
saving the bitmap out to a file -- is a simple process of using the Assign
method to store the contents of the BLOB field to an object of type
TBitmap. A stand-alone TBitmap object or the Bitmap property of the
Picture object property of a TIMage component are examples of compatible
destinations for this operation.
 
Here is an example demonstrating using the Assign method to copy a bitmap
from a BLOB field into a TImage component.
 
  procedure TForm1.Button1Click(Sender: TObject);
  begin
    Image1.Picture.Bitmap.Assign(Table1Bitmap);
  end;
 
In this example, the TBLOBField object Table1Bitmap is a BLOB field in a
dBASE table. This TBLOBField object was created using the Fields Editor.
If the Fields Editor is not used to create TFields for the fields in the
table, the fields must be referenced using either the FieldByName method
or the Fields property, both part of the TTable and TQuery components. In
cases where one of those means is used to reference the BLOB field in a
table, the field reference must be type-cast as a TBLOBField object prior
to using the Assign method. For example:
 
  procedure TForm1.Button1Click(Sender: TObject);
  begin
    Image1.Picture.Bitmap.Assign(TBLOBField(Table1.Fields[1]));
  end;
 
A bitmap stored in a BLOB field may also be copied directly to a stand-
alone TBitmap object. Here is an example showing the creation of a
TBitmap object and storing into it a bitmap from a BLOB field.
 
  procedure TForm1.Button2Click(Sender: TObject);
  var
    B: TBitmap;
  begin
    B := TBitmap.Create;













  PRODUCT  :  Delphi                                 NUMBER  :  2810
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/2

    TITLE  :  Extracting A Bitmap From A BLOB Field




    try
      B.Assign(Table1Bitmap);
      Image1.Picture.Bitmap.Assign(B);
    finally
      B.Free;
    end;
  end;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
