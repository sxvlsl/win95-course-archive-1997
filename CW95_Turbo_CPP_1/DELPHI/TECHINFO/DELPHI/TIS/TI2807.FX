





  PRODUCT  :  Delphi                                 NUMBER  :  2807
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/3

    TITLE  :  Loading Bitmaps Into dBASE And Paradox BLOB Fields




There are a number of ways to load a bitmap image into the BLOB field of a
dBASE or Paradox table. Three of the easier methods involve 1) copying the
data from the Windows clipboard into a TDBImage component connected to the
BLOB field, 2) using the LoadFromFile method of the TBLOBField component,
and 3) using the Assign method to copy an object of type TBitmap into the
Picture property of a TBDBImage.
 
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













  PRODUCT  :  Delphi                                 NUMBER  :  2807
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/3

    TITLE  :  Loading Bitmaps Into dBASE And Paradox BLOB Fields




    finally
      C.Free;
    end;
  end;
 
The second method of filling a BLOB field with a bitmap involves loading
the bitmap directly from a file on disk into the BLOB field. This method
lends itself equally well to uses at run-time for the end-user as for
the developer building an application's data.
 
This method uses the LoadFromFile method of the TBLOBField component, the
Delphi representation of a dBASE for Windows Binary field or a Paradox for
Windows Graphic field, either of which may be used to store bitmap data
in a table.
 
The LoadFromFile method of the TBLOBField component requires a single
parameter: the name of the bitmap file to load, which is of type String.
The value for this parameter may come from a number of sources from the
end-user manually keying in a valid file name to the program providing a
string to the contents of the FileName property of the TOpenDialog comp-
onent.
 
Here is an example showing the use of the LoadFromFile method for a
TBLOBField component named Table1Bitmap (a field called Bitmap in the
table associated with a TTable component named Table1):
 
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













  PRODUCT  :  Delphi                                 NUMBER  :  2807
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  3/3

    TITLE  :  Loading Bitmaps Into dBASE And Paradox BLOB Fields




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
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
