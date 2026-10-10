





  PRODUCT  :  Delphi                                 NUMBER  :  2837
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 20, 1995                            PAGE  :  1/3

    TITLE  :  Cascading Deletes With Pdox Referential Integrity




Paradox tables offer a Referential Integrity feature. This feature pre-
vents adding records to a child table for which there is no matching
record in the parent table. It will also cause the key field(s) in the
child table to be changed when the corresponding key field(s) in the
parent are changed (commonly referred to as a cascading update). These
events occur automatically, requiring no intervention by a Delphi appli-
cation using these tables. However, the Paradox Referential Integrity
feature will not accommodate cascading deletes. That is, Delphi will not
allow you to delete a record in the parent table while matching records
exist in the child table. This would make "orphans" of the child records,
losing referential integrity. Delphi raises an exception when an attempt
is made to delete such a parent record.
 
To effect a cascading delete requires that the deletion of the matching
child records be deleted programmatically -- before the parent record is
deleted. In a Delphi application, this is done by interrupting the process
of deleting the record in the parent table, deleting the matching records
in the child table (if there are any), and then continuing with the dele-
tion of the parent record.
 
A record in a table is deleted by a call to the Delete method of the
TTable component, which deletes the current record in the associated
table. Interrupting the this process to first perform some other opera-
tions is a matter creating a procedure associated with the BeforeDelete
event of the TTable. Any commands in a BeforeDelete event procedure are
executed before the call actually goes out from the application to the
Borland Database Engine (BDE) to physically remove the record from the
table file.
 
To handle the deletion of one or more child records, in a BeforeDelete
event procedure the Delete method for the TTable representing the child
table is called in a loop. The loop is based on the condition of the
record pointer in the table not being positioned at the end of the data
set, as indicated by the Eof method of the TTable. This also accounts for
there being no child records at all matching the parent record to be
deleted: if there are no matching records, the record pointer will already
be at the end of the data set, the loop condition will evaluate to False,
and the Delete method in the loop nevers gets executed.













  PRODUCT  :  Delphi                                 NUMBER  :  2837
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 20, 1995                            PAGE  :  2/3

    TITLE  :  Cascading Deletes With Pdox Referential Integrity




 
  procedure TForm1.Table1BeforeDelete(DataSet: TDataset);
  begin
    with Table2 do begin
      DisableControls;
      First;
      while not Eof do
        Delete;
      EnableControls;
    end;
  end;
 
In the above example, the parent table is represented by the TTable comp-
onent Table1 and the child by Table2. The DisableControls and Enable-
Controls methods are used as a cosmetic measure to freeze any data-aware
components that might be displaying data from Table2 while the records
are being deleted. These two methods make the process visually appear
smoother, but are only optional and not essential to this process. The
Next method need not be called within this loop. This is because the loop
begins at the first record and, as each record is deleted, the record that
previously followed the deleted record moves up in the data set, becoming
both the first and the current record.
 
This example presumes that the parent and child tables are linked with a
Master-Detail relationship, as is typical for tables for which such
Referntial Integrity is configured. Linking the tables in this manner
results in only those records in the child table that match the current
record in the parent table being available. All other records in the child
table are made unavailable through the Master-Detail filtering. If the
tables are not so linked, there are two additional considerations that
must be accounted for when deleting the child records. The first is that
a call to the First method may or may not put the record pointer on a
record that matches the current record in the parent table. This necessi-
tates using a search method to manually move the record pointer to a
matching record. The second consideration affects the condition for the
loop. Because records other than those matching the current record in the
parent table will be accessible, the condition for the loop must check
that each record is a matching record before attempting to delete it. This













  PRODUCT  :  Delphi                                 NUMBER  :  2837
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 20, 1995                            PAGE  :  3/3

    TITLE  :  Cascading Deletes With Pdox Referential Integrity




checking is in addition to querying the Eof method. Because the records
will be ordered by this key field (from a primary or secondary index),
all of the matching records will be contiguous. This leads to the given
that, as soon as the first non-matching record is reached, it can be
assumed that all matching records have been deleted. Thus, the previous
example would be modified to:
 
  procedure TForm1.Table1BeforeDelete(DataSet: TDataset);
  begin
    with Table2 do begin
      DisableControls;
      FindKey([Table1.Fields[0].AsString])
      while (Fields[0].AsString = Table1.Fields[0].AsString) and 
        (not Eof) do
        Delete;
      EnableControls;
    end;
  end;
 
In the above, it is the first field in the parent table (Table1) upon
which the Referential Integrity is based, and the first field in the
child table (Table2) against which matching is judged.
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
