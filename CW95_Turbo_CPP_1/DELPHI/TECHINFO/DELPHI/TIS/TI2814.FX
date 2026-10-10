





  PRODUCT  :  Delphi                                 NUMBER  :  2814
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/3

    TITLE  :  Handling EDBEngineError Exceptions




Information that describes the conditions of a database engine error can
be obtained for use by an application through the use of an EDBEngineError
exception. EDBEngineError exceptions are handled in an application through
the use of a try..except construct. When an EDBEngineError exception
occurs, a EDBEngineError object would be created and various fields in that
EDBEngineError object would be used to programmatically determine what
went wrong and thus what needs to be done to correct the situation. Also,
more than one error message may be generated for a given exception. This
requires iterating through the multiple error messages to get needed info-
rmation.
 
The fields that are most pertinent to this context are:
 
   ErrorCount: type Integer; indicates the number of errors that are in
     the Errors property; counting begins at zero.
 
   Errors: type TDBError; a set of record-like structures that contain
     information about each specific error generated; each record is
     accessed via an index number of type Integer.
 
   Errors.ErrorCode: type DBIResult; indicating the BDE error code for the
     error in the current Errors record.
 
   Errors.Category: type Byte; category of the error referenced by the
     ErrorCode field.
 
   Errors.SubCode: type Byte; subcode for the value of ErrorCode.
 
   Errors.NativeError: type LongInt; remote error code returned from the
     server; if zero, the error is not a server error; SQL statement
     return codes appear in this field.
 
   Errors.Message: type TMessageStr; if the error is a server error, the
     server message for the error in the current Errors record; if not a
     server error, a BDE error message.
 
In a try..except construct, the EDBEngineError object is created directly
in the except section of the construct. Once created, fields may be













  PRODUCT  :  Delphi                                 NUMBER  :  2814
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/3

    TITLE  :  Handling EDBEngineError Exceptions




accessed normally, or the object may be passed to another procedure for
inspection of the errors. Passing the EDBEngineError object to a special-
ized procedure is preferred for an application to make the process more
modular, reducing the amount of repeated code for parsing the object for
error information. Alternately, a custom component could be created to
serve this purpose, providing a set of functionality that is easily trans-
ported across applications. The example below only demonstrates creating
the DBEngineError object, passing it to a procedure, and parsing the
object to extract error information.
 
In a try..except construct, the DBEngineError can be created with syntax
such as that below:
 
  procedure TForm1.Button1Click(Sender: TObject);
  var
    i: Integer;
  begin
    if Edit1.Text > ' ' then begin
      Table1.FieldByName('Number').AsInteger := StrToInt(Edit1.Text);
      try
        Table1.Post;
      except on E: EDBEngineError do
        ShowError(E);
      end;
    end;
  end;
 
In this procedure, an attempt is made to change the value of a field in a
table and then call the Post method of the corresponding TTable component.
Only the attempt to post the change is being trapped in the try..except
construct. If an EDBEngineError occurs, the except section of the con-
struct is executed, which creates the EDBEngineError object (E) and then
passes it to the procedure ShowError. Note that only an EDBEngineError
exception is being accounted for in this construct. In a real-world sit-
uation, this would likely be accompanied by checking for other types of
exceptions.
 
The procedure ShowError takes the EDBEngineError, passed as a parameter,













  PRODUCT  :  Delphi                                 NUMBER  :  2814
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  3/3

    TITLE  :  Handling EDBEngineError Exceptions




and queries the object for contained errors. In this example, information
about the errors are displayed in a TMemo component. Alternately, the
extracted values may never be displayed, but instead used as the basis for
logic branching so the application can react to the errors. The first step
in doing this is to establish the number of errors that actually occurred.
This is the purpose of the ErrorCount property. This property supplies a
value of type Integer that may be used to build a for loop to iterate
through the errors contained in the object. Once the number of errors
actually contained in the object is known, a loop can be used to visit
each existing error (each represented by an Errors property record) and
extract information about each error to be inserted into the TMemo comp-
onent.
 
  procedure TForm1.ShowError(AExc: EDBEngineError);
  var
    i: Integer;
  begin
    Memo1.Lines.Clear;
    Memo1.Lines.Add('Number of errors: ' + IntToStr(AExc.ErrorCount));
    Memo1.Lines.Add('');
    {Iterate through the Errors records}
    for i := 0 to AExc.ErrorCount - 1 do begin
      Memo1.Lines.Add('Message: ' + AExc.Errors[i].Message);
      Memo1.Lines.Add('   Category: ' + 
        IntToStr(AExc.Errors[i].Category));
      Memo1.Lines.Add('   Error Code: ' + 
        IntToStr(AExc.Errors[i].ErrorCode));
      Memo1.Lines.Add('   SubCode: ' + 
        IntToStr(AExc.Errors[i].SubCode));
      Memo1.Lines.Add('   Native Error: ' + 
        IntToStr(AExc.Errors[i].NativeError));
      Memo1.Lines.Add('');
    end;
  end;
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
