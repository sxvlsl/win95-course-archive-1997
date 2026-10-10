





  PRODUCT  :  Delphi                                 NUMBER  :  2683
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/3

    TITLE  :  Drag a form without clicking the caption bar




{
Q: How can I make a form move by clicking and dragging in the client area
   instead of on the caption bar?
 
A: The easiest way to do this is to "fool" Windows into thinking that
   you're actually clicking on the caption bar of a form.  Do this by
   handling the wm_NCHitTest windows message as shown in the sample unit
   below.
 
   TIP: If you want a captioness borderless window similar to a floating
   toolbar, set the Form's Caption to an empty string, disable all of the
   BorderIcons, and set the BorderStyle to bsNone.
}
 
unit Dragmain;
 
interface
 
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;
 
type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    procedure WMNCHitTest(var M: TWMNCHitTest); message wm_NCHitTest;
  end;
 
var
  Form1: TForm1;
 
implementation
 
{$R *.DFM}
 
procedure TForm1.WMNCHitTest(var M: TWMNCHitTest);













  PRODUCT  :  Delphi                                 NUMBER  :  2683
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/3

    TITLE  :  Drag a form without clicking the caption bar




begin
  inherited;                    { call the inherited message handler }
  if  M.Result = htClient then  { is the click in the client area?   }
    M.Result := htCaption;      { if so, make Windows think it's     }
                                { on the caption bar.                }
end;
 
procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;
 
end.
 
{ The text representation of the .DFM file is below:
 
object Form1: TForm1
  Left = 203
  Top = 94
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 273
  ClientWidth = 427
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 16
  object Button1: TButton
    Left = 160
    Top = 104
    Width = 89
    Height = 33
    Caption = 'Close'
    TabOrder = 0
    OnClick = Button1Click
  end













  PRODUCT  :  Delphi                                 NUMBER  :  2683
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  3/3

    TITLE  :  Drag a form without clicking the caption bar




end
 
}
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
