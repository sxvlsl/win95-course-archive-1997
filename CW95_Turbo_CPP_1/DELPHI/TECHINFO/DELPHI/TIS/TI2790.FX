





  PRODUCT  :  Delphi                                 NUMBER  :  2790
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/2

    TITLE  :  Creating & Deleting TFields at run-time




TField components (or more appropriately, descendants of the TField
component of types corresponding to field types) can be created at design-
time using the Fields Editor. The Fields Editor is invoked by double-
clicking on the design icon for a TTable or TQuery component. But TField 
descendants can also be created and deleted at run-time.
 
Descendants of the TField component (such as TStringField, TIntegerField, 
etc.) are created by invoking the Create method for the type of TField 
descendant appropriate to the field in the data set. That is, the Create 
method for the TStringField descendant of TField would be called to create
a TField descendant for a string-type field in the current data set. The 
Create method requires one parameter, that of the owner of the TField 
descendant, which is the containing TForm. After creating the TField 
descendant component, a number of key properties need to be set in order
to connect it with the field in the data set. These are:
 
FieldName: the name of the field in the table.
Name:      a unique identifier for the TField descendant component.
Index:     the TField descendant component’s position in the array of 
           TFields (the Fields property of the TTable or TQuery with which
           the TField will be associated).
DataSet:   the TTable or TQuery with which the TField will be associated.
 
The code snippet below demonstrates creating a TStringField. The 
containing TForm is called Form1 (referred to here with the Self 
variable), the active data set is a TQuery named Query1, and the field for
which the TStringField component is being created is a dBASE table field
named CO_NAME. This new TField descendant will be the second TField in the
Fields array property of Query1. Note that the data set with which the new
TField descendant will be associated (in this case, Query1) must be closed
prior to adding the TField and then reopened afterwards.
 
procedure TForm1.Button2Click(Sender: TObject);
var
  T: TStringField;
begin
  Query1.Close;
  T := TStringField.Create(Self);













  PRODUCT  :  Delphi                                 NUMBER  :  2790
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/2

    TITLE  :  Creating & Deleting TFields at run-time




  T.FieldName := 'CO_NAME';
  T.Name := Query1.Name + T.FieldName;
  T.Index := Query1.FieldCount;
  T.DataSet := Query1;
  Query1.FieldDefs.UpDate;
  Query1.Open;
end;
 
The example above example creates a new TStringField named Query1CO_NAME.
 
Deleting an existing TField descendant is merely a matter of invoking the 
Free method for that component. In the example below, the TForm's Find-
Component method is used to return a pointer to the TStringField component 
named Query1CO_NAME. The return value for the FindComponent will either be
of type TComponent if successful or nil if unsuccessful. This return value
can be used to determine whether the component actually exists prior to 
invoking its Free method.
 
procedure TForm1.Button1Click(Sender: TObject);
var
  TC: TComponent;
begin
  TC := FindComponent('Query1CO_NAME');
  if not (TC = nil) then begin
    Query1.Close;
    TC.Free;
    Query1.Open;
  end;
end;
 
As with creating a TField, if the data set associated with the TField 
descendant is currently active, it must be closed or deactivated prior to 
invoking this method.
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
