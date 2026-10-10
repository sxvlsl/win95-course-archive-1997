





  PRODUCT  :  Delphi                                 NUMBER  :  2811
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/6

    TITLE  :  Bitmaps And InterBase BLOB Fields




dBASE and Paradox tables provide a BLOB field to store binary data that,
when the stored data is of bitmap-format, work as-is with the TDBImage
component to display images. In Database Desktop, these field types are
listed as Binary and Graphic (for dBASE and Paradox tables, respectively).
However, the process of storing bitmap images in InterBase BLOB fields
and using the stored data with TDBImage components is not as straight-
forward.
 
InterBase tables do not have just one type of BLOB field. There are three
variants, or sub-types: type 0, type 1, and user-defined sub-types. Types
0 and 1 are pre-defined types. Type 0 BLOB fields (the default type) are
for storing general binary data. Type 1 BLOB fields are for storing text
BLOB data. Neither of the pre-defined types allow the automated retrieval
of bitmap data from the BLOB field that is displayed in a TDBImage comp-
onent. Type 0 BLOB fields may be used for storing bitmap-format data, but
the data must be programmatically extracted and piped into an object of
type TBitmap. Here is an example of manually extracting the bitmap data
stored in a type 0 BLOB field (Table1BLOBField) and displaying the data in
a (non-data-aware) ITImage component:
 
  procedure TForm1.ExtractBtnClick(Sender: TObject);
  begin
    Image1.Picture.Bitmap.Assign(Table1BLOBField);
  end;
 
Naturally, because this has to be done manually, this process is less
desireable in an application than relying on the BDE and a TDBImage comp-
onent to automatically display the bitmap data. This is where the user-
defined BLOB field sub-types come in. When using a BLOB field sub-type,
the storing of the first data establishes the type of data for that field
throughout the entire table. Thus, if bitmap-format data is the first type
of data stored, that must subsequently be the only type stored in that
field. While the default binary BLOB field type (pre-defined type 0)
stores the data in too general a format for the BDE to read the data in
a manner usable to a TDBImage component, a sub-type with an established
storage type is usable.
 
The Database Desktop utility will allow the creation only of type 0 binary













  PRODUCT  :  Delphi                                 NUMBER  :  2811
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/6

    TITLE  :  Bitmaps And InterBase BLOB Fields




BLOB fields, no provision was made for user-defined BLOB field sub-types.
Because of this, a table to be used to store and display bitmap images
must be created with an SQL statement. Typically this would be through the
WISQL utility, but an appropriate SQL statement in a TQuery would suffice.
Here is an SQL statement that creates a table with a user-defined BLOB
field sub-type:
 
  CREATE TABLE WITHBMP
  (
  FILENAME CHAR(12),
  BITMAP   BLOB SUB_TYPE -1
  )
 
Once a table with a compatible BLOB field is created, storing bitmap data
to the BLOB field and displaying the bitmap images in a TDBImage component
uses the same methods as would be used with dBASE or Paradox tables.
 
There are a number of ways to load a bitmap image into a BLOB field. Three
of the easier methods involve 1) copying the data from the Windows clip-
board into a TDBImage component connected to the BLOB field, 2) using the
LoadFromFile method of the TBLOBField component, and 3) using the Assign
method to copy an object of type TBitmap into the Picture property of a 
TBDBImage.
 
The first method, copying the bitmap from the clipboard, is probably most
handy when an application needs to add bitmaps to a table when the end-
user is running the application. A TDBImage component is used to act as an
interface between the BLOB field in the table and the image stored in the
clipboard. The PasteFromClipboard method of the TDBImage component is
invoked to copy the bitmap data from the clipboard into the TDBImage. When
the record is posted, the image is stored into the BLOB field in the
table.
 
Because the Windows clipboard can contain data in formats other than just
bitmap, it is advisable to check the format prior to calling the CopyFrom-
Clipboard method. To do this, a TClipboard object is created and its Has-
Format method is used to determine if the data in the clipboard is indeed
of bitmap format. Note that to use a TClipboard object, the Clipbrd unit













  PRODUCT  :  Delphi                                 NUMBER  :  2811
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  3/6

    TITLE  :  Bitmaps And InterBase BLOB Fields




must be included in the Uses section of the unit that will be creating
the object.
 
Here is an example showing the contents of the clipboard being copied into
a TDBImage component, if the contents of the clipboard are of bitmap
format:
 
  procedure TForm1.Button1Click(Sender: TObject);
  var
    C: TClipboard;
  begin
    C := TClipboard.Create;
    try
      if Clipboard.HasFormat(CF_BITMAP) then
        DBImage1.PasteFromClipboard
      else
        ShowMessage('Clipboard does not contain a bitmap!');
    finally
      C.Free;
    end;
  end;
 
The second method of filling a BLOB field with a bitmap involves loading
the bitmap directly from a file on disk into the BLOB field. This method
lends itself equally well to uses at run-time for the end-user as for
the developer building an application's data. This method uses the Load-
FromFile method of the TBLOBField component, the Delphi representation of
an InterBase BLOB field.
 
The LoadFromFile method of the TBLOBField component requires a single
parameter: the name of the bitmap file to load, which is of type String.
The value for this parameter may come from a number of sources from the
end-user manually keying in a valid file name to the program providing a
string to the contents of the FileName property of the TOpenDialog comp-
onent.
 
Here is an example showing the use of the LoadFromFile method for a TBLOB-
Field component named Table1Bitmap (a field called Bitmap in the table













  PRODUCT  :  Delphi                                 NUMBER  :  2811
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  4/6

    TITLE  :  Bitmaps And InterBase BLOB Fields




associated with a TTable component named Table1):
 
  procedure TForm1.Button2Click(Sender: TObject);
  begin
    Table1Bitmap.LoadFromFile(
      'c:\delphi\images\splash\16color\construc.bmp');
  end;
 
The third method uses the Assign method to copy the contents of an object
of type TBitmap into the Picture property of a TDBImage component. An
object of type TBitmap might be the Bitmap property of the Picture object
property of a TImage component or it may be a stand-alone TBitmap object.
As with the method copying the data from the clipboard into a TDBImage
component, the bitmap data in the TDBImage component is saved into the
BLOB field in the table when the record is successfully posted.
 
Here is an example using the Assign method. In this case, a stand-alone
TBitmap object is used. To put a bitmap image into the TBitmap, the
LoadFromFile method of the TBitmap component is called.
 
  procedure TForm1.Button3Click(Sender: TObject);
  var
    B: TBitmap;
  begin
    B := TBitmap.Create;
    try
      B.LoadFromFile('c:\delphi\images\splash\16color\athena.bmp');
      DBImage1.Picture.Assign(B);
    finally
      B.Free;
    end;
  end;
 
******************************************
 
Going the opposite direction -- extracting a bitmap from an InterBase BLOB
field (without first saving the bitmap out to a file) is a simple process
of using the Assign method of the TBLOBField object to store the contents













  PRODUCT  :  Delphi                                 NUMBER  :  2811
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  5/6

    TITLE  :  Bitmaps And InterBase BLOB Fields




of the BLOB field to an object of type TBitmap. A stand-alone TBitmap
object or the Bitmap property of the Picture object property of a TIMage
component are examples of compatible destinations for this operation.
 
Here is an example demonstrating using the Assign method to copy a bitmap
from a BLOB field into a TImage component (Table1Bitmap is the TBLOBfield
for the BLOB field in the table).
 
  procedure TForm1.Button1Click(Sender: TObject);
  begin
    Image1.Picture.Bitmap.Assign(Table1Bitmap);
  end;
 
In this example, the TBLOBField object Table1Bitmap is a BLOB field in an
InterBase table. This TBLOBField object was created using the Fields
Editor. If the Fields Editor is not used to create TFields for the fields
in the table, the fields must be referenced using either the FieldByName
method or the Fields property, both part of the TTable and TQuery comp-
onents. In cases where one of those means is used to reference the BLOB
field in a table, the field reference must be type-cast as a TBLOBField
object prior to using the Assign method. For example:
 
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
    try
      B.Assign(Table1Bitmap);













  PRODUCT  :  Delphi                                 NUMBER  :  2811
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  6/6

    TITLE  :  Bitmaps And InterBase BLOB Fields




      Image1.Picture.Bitmap.Assign(B);
    finally
      B.Free;
    end;
  end;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
