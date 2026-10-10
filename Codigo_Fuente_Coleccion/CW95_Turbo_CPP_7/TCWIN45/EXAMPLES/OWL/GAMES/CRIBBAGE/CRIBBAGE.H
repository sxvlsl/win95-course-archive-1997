//--------------------------------------------------------------------------
// Turbo Cribbage -- Copyright (c) 1995, Borland International
//--------------------------------------------------------------------------
#ifndef CRIBBAGE_H
#define CRIBBAGE_H

#include <owl/window.h>
#include "carddisp.h"
#include "board.h"
#include "dialogs.h"

const int DETAIL_MAXCOUNT = 20;
const int DETAIL_MAXLEN = 128;

// TGameWindow -- This class defines all the logic which controls the
// game.
//

class TGameWindow: public TWindow {

  enum TGameState { gsNewGame,       // waiting for new game command

                    gsDeal,          // waiting for user to press the deal
                                     // button

                    gsDiscard,       // waiting for user to discard 2 cards

                    gsCutAfterDeal,  // waiting for user to cut the deck, to
                                     // show the fifth card

                    gsPegging,       // waiting for user to play a card, or
                                     // click the 'go' button

                    gsPeggingFinish, // same as gsPegging, but the computer
                                     // is out of cards

                    gsPeggingGo,     // computer has said 'go' to player,
                                     // waiting for player to hit 31

                    gsGameOver       // somebody reached 121 points and won
                 };

  static TPoint handCardPos[6],cribCardPos[4],pegCardPos[8],topCardPos[1];

  TCardDisplay   *player[2],           // the two hands
                 *crib,                // the crib
                 *pegCards,            // where the cards are played
                 *topCard;             // top card on the deck

  TCribbageBoard *board;               // the score board

  TButton        *deal, *go, *done;    // buttons used during game play

  TStatic        *instructions;        // a window to display help in

  TGameState   state;                  // current state of the game
  uint         dealer;                 // who dealt the current hand

  TDeck    deck;                       // 52 cards
  int      currentCribPos;
  int      cardBackStyle;
  int      pegCardOwner[8];            // keeps track of who owns each card
                                       // that is played during pegging

  HBRUSH   greenBrush;   // used for the buttons and the static text control

  char *detail[DETAIL_MAXCOUNT];  // used for displaying individual point counts
  int  detailCount;

  bool humor;

public:
  TGameWindow();
  ~TGameWindow();

  void SetupWindow();

  bool GameOver();
  int  FaceValue( int rank ) {
    return (rank>10)?10:rank;   // return the vace value of the card
  }
  int  RunSize( int *ranks, int count );
  int  ComputeHandPoints( TCardGroup* cards, TCard* extraCard, bool crib );
  int  ComputePegPoints( int cardPlayer, bool goInEffect );
  void ResetPegCardDisplay();
  void ReclaimPegCards();
  void PegCard( TCard* card, int player );
  void ScoreComputerPegPoints();
  bool ComputerPlayPegCard( bool goInEffect );
  void TurnOverPegCards();
  int  PlayableCards( TCardGroup* cards, bool *playable = 0 );
  void SetState( TGameState newState );
  void Deal( bool prompt );
  void ShowPoints();
  void NewGame();
  void DealButton();
  void FixDeck();
  void SaveGame() {}
  void Exit() {
    CloseWindow();
  }
  void SaveGameEnabler( TCommandEnabler& tce ) {
    tce.Enable( state!=gsNewGame );
  }
  void AboutBox() {
    TDialog( this, ABOUT_DIALOG ).Execute();
  }
  void LoadGame() {}
  void Paint( TDC& dc, bool erase, TRect& rect );

  // when you put a button on a window with a non-white background,
  // there will be 4 white pixels in the corners of the button.
  // handing the WM_CTLCOLOR message fixes the problem.  Also, we
  // have a static text control inserted into the window, and we need
  // to adjust its colors to match the window
  //
  HBRUSH EvCtlColor( HDC hdc, HWND hWndChild, uint ctlType ) {
    // if it's a button, just return the green brush
    if (ctlType==CTLCOLOR_BTN)
      return greenBrush;
    // if it's a static text, modify the dc to use the text color
    // we want, and return a green brush
    if (ctlType==CTLCOLOR_STATIC) {
      ::SetTextColor( hdc, 0x0000FF00 );
      ::SetBkColor( hdc, 0x00008000  );
      return greenBrush;
    }
    // otherwise, use the default control colors
    return NULL;
  }

  LRESULT CardSelected( WPARAM wparam, LPARAM lparam );

  int  PegCardsSum();
  bool CanClose();
  void GoButton();
  void DoneButton();
  void ComputerDiscard( int dealer );
  void ComputerPlayCard( bool go = false );
  void CountPoints( TCardGroup* cards );

  DECLARE_RESPONSE_TABLE( TGameWindow );
};

#endif // CRIBBAGE_H
