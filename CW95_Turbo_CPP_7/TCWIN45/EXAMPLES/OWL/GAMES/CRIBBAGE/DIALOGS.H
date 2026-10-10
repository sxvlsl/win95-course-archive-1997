//--------------------------------------------------------------------------
// Turbo Cribbage -- Copyright (c) 1995, Borland International
//--------------------------------------------------------------------------
#ifndef DIALOGS_H
#define DIALOGS_H

#include <owl/dialog.h>
#include <owl/vbxctl.h>
#include <owl/static.h>
#include <owl/button.h>
#include <owl/listbox.h>
#include <owl/color.h>
#include <owl/dc.h>

#include "cards.h"
#include "mhcd200.h"
#include "cribbage.rh"

// TCutDeckDialog -- a dialog which shows a deck of cards, and allows the
// user to cut.
//
class TCutDeckDialog: public TDialog {
  TDeck& deck;
  TVbxMhCardDeck *topcard;
  int selectedCard;
public:
  TCutDeckDialog( TWindow* parent, TDeck& aDeck ):
    TDialog( parent, CUT_DIALOG ), deck(aDeck) {
      topcard = new TVbxMhCardDeck( this, 42, "", 193, 50, 71, 95 );
    selectedCard=-1;
  }
  void SetupWindow() {
    TDialog::SetupWindow();
    topcard->SetPropBackColor( TColor( 192, 192, 192 ) );
    topcard->SetPropCardBack( deck[0].backStyle );
  }
  void EvPaint() {
    TDialog::EvPaint();
    TClientDC dc( HWindow );
    TMemoryDC memDC( dc );
    TBitmap bitmap( _hInstance, CUT_BITMAP );
    memDC.SelectObject( bitmap );
    dc.BitBlt( 40, 50, bitmap.Width(), bitmap.Height(), memDC, 0, 0, SRCCOPY );
    topcard->Invalidate();
  }
  void EvLButtonDown( uint, TPoint& point ) {
    if ((point.y>50) &&
        (point.y<145) &&
        (point.x>40) &&
        (point.y<193)) {
      selectedCard = (point.x - 40)/3;
      CloseWindow();
    }
  }
  int Execute() {
    TDialog::Execute();
    return selectedCard;
  }
  void Ignore() {}

  DECLARE_RESPONSE_TABLE( TCutDeckDialog );
};

class TCutResultDialog: public TDialog {
  TVbxMhCardDeck *c1,*c2;
  const TCard& player;
  const TCard& computer;
  TStatic *msg;
public:
  TCutResultDialog( TWindow* parent, const TCard& aPlayer, const TCard& aComputer ):
    TDialog( parent, CUT_RESULT_DIALOG ),
    player(aPlayer), computer(aComputer) {
      c1 = new TVbxMhCardDeck( this, 1, "", 40, 50, 71, 95 );
      c2 = new TVbxMhCardDeck( this, 2, "", 180, 50, 71, 95 );
      msg = new TStatic( this, IDS_RESULT_MSG );
  }
  void SetupWindow() {
    TDialog::SetupWindow();
    c1->SetPropBackColor( TColor( 192, 192, 192 ) );
    c2->SetPropBackColor( TColor( 192, 192, 192 ) );
    c1->SetPropValue( player.rank );
    c1->SetPropSuit( player.suit );
    c2->SetPropValue( computer.rank );
    c2->SetPropSuit( computer.suit );
    if (player.rank==computer.rank)
      msg->SetText("A tie.  Click OK to cut again.");
    else
      if (player.rank<computer.rank)
        msg->SetText("You deal first.");
      else
        msg->SetText("Computer deals first.");
  }
};

class TGoDialog: public TDialog {
  TButton *button;
  bool canPlay;
public:
  TGoDialog( TWindow* parent, bool aCanPlay ):
    TDialog( parent, GO_DIALOG ), canPlay( aCanPlay ) {
    button = new TButton( this, IDOK );
  }
  void SetupWindow() {
    TDialog::SetupWindow();
    if (canPlay)
      SetDlgItemText( IDOK, "OK" );
    else
      SetDlgItemText( IDOK, "Take 1 Point" );
  }
};

class TQuickPointsDialog: public TDialog {
  int points;
  const char *msgText;
  TStatic *msg;
  bool  pegging;
  TButton *button[15];
  int actualPoints;
public:
  TQuickPointsDialog( TWindow* parent, const char *message, bool aPegging,
                      int aActualPoints );
  void SetupWindow();
  int Execute() {
    TDialog::Execute();
    return points;
  }
  LRESULT EvCommand( uint id, HWND, uint ) {
    points = id-IDC_PUSHBUTTON0;

    if (points>actualPoints)
      MessageBox( "Perhaps you should count again.", "Cribbage", MB_OK );
    else
      Destroy(points);
    return true;
  }
};

class TShowPointsDialog: public TDialog {
public:
  enum ModeType { mtMissed, mtCrib, mtHand, mtPegging };
private:
  TStatic *msg;
  TButton *ok,*detailBtn;
  TListBox *listbox;
  char **detail;
  int detailCount;
  int points,missedPoints;
  ModeType mode;
public:
  TShowPointsDialog( TWindow* parent, ModeType aMode,
                     int aPoints, int aMissedPoints,
                     char **aDetail, int aDetailCount ):
     TDialog( parent, SHOW_POINTS_DIALOG ), mode( aMode ),
     points(aPoints), detail(aDetail), detailCount(aDetailCount),
     missedPoints(aMissedPoints) {
    msg = new TStatic( this, IDC_SHOW_POINTS_MESSAGE );
    ok = new TButton( this, IDOK );
    detailBtn = new TButton( this, CM_DETAIL );
  }
  void SetupWindow();
  void ShowDetail();
  DECLARE_RESPONSE_TABLE( TShowPointsDialog );
};

#endif // DIALOGS_H
