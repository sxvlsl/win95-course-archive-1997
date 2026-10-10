





  PRODUCT  :  Delphi                                 NUMBER  :  2796
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/2

    TITLE  :  Using OnHint Events Among Mulitiple Forms




               Using OnHint Among Multiple Forms
               ---------------------------------
 
Delphi's Online Help and Visual Component Library Reference
describe an example for processing TApplication's OnHint event.
The example shows how a panel can be used to display hints
associated with other components. As the example sets the
Application's OnHint method in the Form's OnCreate event, a
program involving more than one form will have difficulty using
this technique.
 
Moving the assignment of OnHint from the Form's OnCreate event
to its OnActivate method will allow different forms involved in
the application to treat Hints in their own way.
 
Here is an altered form of the source code presented in the
Online Help and the VCL Reference.
 
type
  TForm1 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Edit1: TEdit;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure DisplayHint(Sender: TObject);
  end;
 
implementation
 
{$R *.DFM}
 
procedure TForm1.DisplayHint(Sender: TObject);
begin
  Panel1.Caption := Application.Hint;
end;













  PRODUCT  :  Delphi                                 NUMBER  :  2796
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/2

    TITLE  :  Using OnHint Events Among Mulitiple Forms




 
procedure TForm1.FormActivate(Sender: TObject);
begin
  Application.OnHint := DisplayHint;
end;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
