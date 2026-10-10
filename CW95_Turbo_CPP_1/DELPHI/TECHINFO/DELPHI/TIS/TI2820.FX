





  PRODUCT  :  Delphi                                 NUMBER  :  2820
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/4

    TITLE  :  Searching Through Query Result Sets




The TQuery component does not offer the index-based search capabilities of
the TTable component (FindKey, GotoKey, and GotoNearest). So how do you
search within the result data set from a TQuery to find a row with a spec-
ific field value?
 
One way to search a query result set is a sequential search. This type of
search starts at the first row in the data set and, in a While loop, 
sequentially compares the value of a field in the row with a search value.
One of two results are possible: a value will be found (success) or the
end of the data set will be reached (failure). The problem with this way
of searching the data set is that the further into the data set a row with
a matching value is, the longer it takes to arrive at that row. And, a
failed search takes longest of all because it must go all the way to the
last row in the data set. If the data set being searched is a large one,
this process may take a considerable amount of time.
 
Here is a function that will perform a sequential search of the result set
from a TQuery:
 
  function SeqSearch(AQuery: TQuery; AField, AValue: String): Boolean;
  begin
    with AQuery do begin
      First;
      while (not Eof) and (not (FieldByName(AField).AsString = AValue)) do
        Next;
      SeqSearch := not Eof;
    end;
  end;
 
This function takes three parameters:
 
  1. AQuery: type TQuery; the TQuery component in which the search is to
             be executed.
  2. AField: type String; the name of the field against which the search
             value will be compared.
  3. AValue: type String; the value being searched for. If the field is of
             a data type other than String, this search value should be
             changed to the same data type.













  PRODUCT  :  Delphi                                 NUMBER  :  2820
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/4

    TITLE  :  Searching Through Query Result Sets




             
The Boolean return value of this function indicates the success (True) or
failure (False) of the search.
  
An alternative is using a bracketing approach. On a conceptual level, this
method acts somewhat like a b-tree index. It is based on the given that
for a row at a given point in the data set, the value of the field being
searched compared to the search value will produce one of three possible
conditions:
 
  1. The field value will be greater than the search value, or...
  2. The field value will be less than the search value, or...
  3. The field value will be equal to the search value.
 
A bracketing search process uses this means of looking at the current row
in respect to the search value and uses it to successively reduce the rows
to be search by half, until only one row remains. This search field value
for this sole remaining row will either be a match to the search value
(success) or it will not (failure, and no match exists in the data set).
 
Functionally, this process lumps the condition of the search field being
less than or equal to the search value into a single condition. This
leaves only two possible results for the comparison of the current
search field value with the search value: less than/equal to or greater
than. Initially, a range of numbers is established. The low end of the
range is represented by an Integer, at the start of the search process set
to 0 or one less than the first row in the data set. The far end of the
range is also an Integer, with the value of the RecordCount property of
the TQuery. The current row pointer is then moved to a point half way
between the low and high ends of the range. The search field value at that
row is then compared to the search value. If the field value is less than
or equal to the search value, the row being sought must be in the lower
half of the range of rows so the high end of the range is reduced to the
current row position. If the field value is greater than the search value,
the sought value must be in the higher half of the range and so the low
end is raised to the current point. By repeating this process, the number
of rows that are encompassed in the range are successively reduced by
half. Eventually, only one row will remain.













  PRODUCT  :  Delphi                                 NUMBER  :  2820
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  3/4

    TITLE  :  Searching Through Query Result Sets




 
Putting this into a modular, transportable function, the code would look
like that below:
 
  function Locate(AQuery: TQuery; AField, AValue: String): Boolean;
  var
    Hi, Lo: Integer;
  begin
    with AQuery do begin
      First;
      {Set high end of range of rows}
      Hi := RecordCount;
      {Set low end of range of rows}
      Lo := 0;
      {Move to point half way between high and low ends of range}
      MoveBy(RecordCount div 2);
      while (Hi - Lo) > 1 do begin
        {Search field greater than search value, value in first half}
        if (FieldByName(AField).AsString > AValue) then begin
          {Lower high end of range by half of total range}
          Hi := Hi - ((Hi - Lo) div 2);
          MoveBy(((Hi - Lo) div 2) * -1);
        end
        {Search field less than search value, value in far half}
        else begin
          {Raise low end of range by half of total range}
          Lo := Lo + ((Hi - Lo) div 2);
          MoveBy((Hi - Lo) div 2);
        end;
      end;
      {Fudge for odd numbered rows}
      if (FieldByName(AField).AsString > AValue) then Prior;
      Locate := (FieldByName(AField).AsString = AValue)
    end;
  end;
 
Because there will never be a difference of less than one between the low
and high ends of the range of rows, a final fudge was added to allow the













  PRODUCT  :  Delphi                                 NUMBER  :  2820
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  4/4

    TITLE  :  Searching Through Query Result Sets




search to find the search value in odd numbered rows.
 
This function takes the same three three parameters as the SeqSearch
function described earlier.
 
The return value of this function is of type Boolean, and reflects the
success or failure of the search. As the search does move the row pointer,
the effects of this movement on the implicit posting of changed data and
on where the desired position of the row pointer should be after a failed
search should be taken into account in the calling application. For
instance, a TBookmark pointer might be used to return the row pointer to
where it was prior to a search if that search fails.
 
How is this process better than a sequential search? First, in bracketing
the search value, only a fraction of the number of rows will be visited as
would be the case in a sequential search. Unless the row with the value
being sought is in the first 1,000 rows, this search method will be faster
than a sequential search. Because this process always uses the same number
of records, the search time will be consistent whether searching for the
value in row 1,000 or row 90,000. This is in contrast with the sequential
search that takes longer the farther into the data set the desired row is.
 
Can this method be used with any TQuery result set? No. Because of the way
this method works in basing the direction of the search as either high or
low, it depends on the row being ordered in a descending manner based on
the field in which the search will be conducted. This means that it can
only be used if the data set is naturally in a sequential order or an
ORDER BY clause is used in the SQL statement for the TQuery. The size of
the result set will also be a factor when deciding whether to perform a
sequential or bracketing search. This process is most advantageous for
speed when used with larger result sets. With smaller sets (1,00 or less
rows), though, a sequential search will often be as fast or faster.
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
