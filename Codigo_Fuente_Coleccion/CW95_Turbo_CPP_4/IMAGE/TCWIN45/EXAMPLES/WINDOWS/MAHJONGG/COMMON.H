// (C) Copyright 1995 by Borland International
//  Common.h
#ifndef __COMMON_H
#define __COMMON_H
#define  NULLH (HWND)0
#define  SHORT short

#include <math.h>
#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include <string.h>

/*----------------------------------------------------------------------------*/
/*- Constant Definitions                                                     -*/
/*----------------------------------------------------------------------------*/

#define ID_WINDOW                1000
#define DEFAULT_BGA_DX           3
#define DEFAULT_VGA_DX           2

// For using 51*66 bitmaps use 25*33(TILE_CX * TILE_CY)
// For using 34*44 bitmaps use 17*22(TILE_CX * TILE_CY)

#define TILE_CX                   17 //25
#define TILE_CY                   22 //33

#define TILE_BW                   2  /* border width */
#define TILE_LD                   2  /* level distance */
#define BOARD_FR_CX               5  /* frame arround the board */
#define BOARD_FR_CY               5  /* frame arround the board */

#define IDD_OK              DIDOK
#define IDD_CANCEL          DIDCANCEL

//---------------------------------------------------------------------------
// Help Table IDs
//---------------------------------------------------------------------------

#define IDH_MAIN_TABLE       5000
#define IDH_SUBTABLE_FRAME   5001

//---------------------------------------------------------------------------
//- pointer IDs
//---------------------------------------------------------------------------
#define IDP_CARDMOVE        1001


//---------------------------------------------------------------------------
//- String ID's
//---------------------------------------------------------------------------
#define IDS_FIRST_STRING                0
#define IDS_TITLE                       0
#define IDS_VERSION                     1
#define IDS_DASH                        2
#define IDS_UNTITLED_STR                3

#define IDS_CLASS_MAHJONGG              4
#define IDS_CLASS_TILE                  5
#define IDS_CLASS_BOARD                 6

#define IDS_LAST_STRING                 6

// User defined window messages

#define MJ_DRAW_STATUS        WM_USER + 0x0001        // to board

#define MJ_INFORM_SELECTED    WM_USER + 0x0100        // to board
#define MJ_QUERY_SELECTED     WM_USER + 0x0101        // to board
#define MJ_SELECT             WM_USER + 0x0102        // to tile
#define MJ_DESELECT           WM_USER + 0x0103        // to tile
#define MJ_REMOVE             WM_USER + 0x0104        // to tile

#define MJ_PUSH_UNDOCMD       WM_USER + 0x0250        // to board
#define MJ_ADJUST_TILES       WM_USER + 0x0340        // to board
#define MJ_SUCCESS            WM_USER + 0x0400        // to board

// Other constants

#define STRING_LENGTH          128

//---------------------------------------------------------------------------
//- Game Constants
//---------------------------------------------------------------------------
#define NBR_OF_TILES           144
#define NO_TILE                 -1

// Type Definitons

//--- Game
typedef struct {
	 char * pszTitle;                // Game Title
	 char * pszHelpFile;             // Help File
  } GAME, * PGAME;

//------ Tile Types
typedef enum {CHARACTERS,
				  DOTS,
				  BAMBOO,
				  DRAGONS,
				  WINDS,
				  FLOWERS,
				  SEASONS
				 } SUITS;

typedef struct {
	 HWND  hwnd;      /* window handle */
	 int   iTxt;      /* index into text array */
	 int   iPos;      /* board position */
	 SUITS suit;
	 int   value;
	 BOOL  bSelected;
	 BOOL  bRemoved;
  } TILE, * PTILE;

//---- Board
typedef struct {
	 int cx;
	 int cy;
	 int cxt;                // 17   default tile aspect ratio
	 int cyt;                // 22
  } BOARD, * PBOARD;

// Variable definitons / declarations

// determine SCOPE to use on global variables
#if defined(DEFINE_VARIABLES)
#define xSCOPE
#define iGLOBAL(init) = init       //  specify initialization
#else
#define xSCOPE  extern
#define iGLOBAL(init)              //  specify initialization
#endif

// Window variables

xSCOPE HINSTANCE ghInst      iGLOBAL(NULLH);     // hab for windows 3.0
xSCOPE HWND     hwndFrame    iGLOBAL(NULLH);
xSCOPE HWND     hwndBoard    iGLOBAL(NULLH);
xSCOPE HCURSOR  hptrArrow    iGLOBAL(NULLH);
xSCOPE HCURSOR  hptrWait     iGLOBAL(NULLH);
xSCOPE int      deltaX       iGLOBAL(4);        // mapping of card units
xSCOPE LONG     ColorTable[256];

// Game variables
xSCOPE GAME        Game;
xSCOPE BOARD       Board;
xSCOPE TILE        Tiles[NBR_OF_TILES];
xSCOPE SHORT       Shuffled[NBR_OF_TILES];
xSCOPE SHORT       SelectedTile;
xSCOPE int         NbrOfTilesRemaining;
xSCOPE BOOL        bSound iGLOBAL(TRUE);    // sound effects
xSCOPE BOOL        bDealing iGLOBAL(FALSE); // currently dealing

xSCOPE char        *pszStringTab[IDS_LAST_STRING - IDS_FIRST_STRING + 1];
xSCOPE int         TilePos[NBR_OF_TILES][2];

#if defined(DEFINE_VARIABLES)
// The tiles are numbered from 0 to 143.
// -1 means on that side(R, L, or A) there is no neighbouring tile
// {-1, -1, -1 } means that tile can be selected.
// {  0,   2,  -1} means on it's right there is tile 0,
// on it's left tile 2, above no tiles.
// This table allows you to determine if a tile is selectable or not.

											 // Right Left Above             
  int Neighbors[NBR_OF_TILES][3] = { { -1,  -1,  -1},      //   1
												 {  0,   2,  -1},      //   2
												 {  1,   3,  -1},      //   3
												 {  2,   4,  -1},      //   4
												 {  3,   5,  -1},      //   5
												 {  4,   6,  -1},      //   6
												 {  5,   7,  -1},      //   7
												 {  6,   8,  -1},      //   8
												 {  7,   9,  -1},      //   9
												 {  8,  10,  -1},      //  10
												 {  9,  11,  -1},
												 { -1,  -1,  -1},
												 { -1,  -1,  -1},
												 { 12,  14,  87},
												 { 13,  15,  88},      //  15
												 { 14,  16,  89},
												 { 15,  17,  90},
												 { 16,  18,  91},
												 { 17,  19,  92},
												 { -1,  -1,  -1},      //  20
												 { -1,  -1,  -1},
												 { 20,  22,  -1},
												 { 21,  23,  93},
												 { 22,  24,  94},
												 { 23,  25,  95},      //  25
												 { 24,  26,  96},
												 { 25,  27,  97},
												 { 26,  28,  98},
												 { 27,  29,  -1},
												 { -1,  -1,  -1},      //  30
												 { -1,  -1,  -1},
												 { 32,  30,  -1},
												 { 33,  31,  -1},
												 { 34,  32,  -1},
												 { 35,  33,  -1},      //  35
												 { 36,  34,  99},
												 { 37,  35, 100},
												 { 38,  36, 101},
												 { 39,  37, 102},
												 { 40,  38, 103},      //  40
												 { 41,  39, 104},
												 { 42,  40,  -1},
												 { 43,  41,  -1},
												 { 56,  42,  -1},
												 { 31,  45,  -1},      //  45
												 { 44,  46,  -1},
												 { 45,  47,  -1},
												 { 46,  48, 105},
												 { 47,  49, 106},
												 { 48,  50, 107},      //  50
												 { 49,  51, 108},
												 { 50,  52, 109},
												 { 51,  53, 110},
												 { 52,  54,  -1},
												 { 53,  55,  -1},      //  55
												 { 54,  56,  -1},
												 { -1,  -1,  -1},
												 { -1,  -1,  -1},
												 { 57,  59,  -1},
												 { 58,  60, 111},      //  60
												 { 59,  61, 112},
												 { 60,  62, 113},
												 { 61,  63, 114},
												 { 62,  64, 115},
												 { 63,  65, 116},      //  65
												 { 64,  66,  -1},
												 { -1,  -1,  -1},
												 { -1,  -1,  -1},
												 { 67,  69, 117},
												 { 68,  70, 118},      //  70
												 { 69,  71, 119},
												 { 70,  72, 120},
												 { 71,  73, 121},
												 { 72,  74, 122},
												 { -1,  -1,  -1},      //  75
												 { -1,  -1,  -1},
												 { 75,  77,  -1},
												 { 76,  78,  -1},
												 { 77,  79,  -1},
												 { 78,  80,  -1},      //  80
												 { 79,  81,  -1},
												 { 80,  82,  -1},
												 { 81,  83,  -1},
												 { 82,  84,  -1},
												 { 83,  85,  -1},      //  85
												 { 84,  86,  -1},
												 { -1,  -1,  -1},
												 { -1,  -1,  -1},
												 { 87,  89,  -1},
												 { 88,  90,  -1},      //  90
												 { 89,  91,  -1},
												 { 90,  92,  -1},
												 { -1,  -1,  -1},
												 { -1,  -1,  -1},
												 { 93,  95, 123},      //  95
												 { 94,  96, 124},
												 { 95,  97, 125},
												 { 96,  98, 126},
												 { -1,  -1,  -1},
												 { -1,  -1,  -1},      // 100
												 { 99, 101, 127},
												 {100, 102, 128},
												 {101, 103, 129},
												 {102, 104, 130},
												 { -1,  -1,  -1},      // 105
												 { -1,  -1,  -1},
												 {105, 107, 131},
												 {106, 108, 132},
												 {107, 109, 133},
												 {108, 110, 134},      // 110
												 { -1,  -1,  -1},
												 { -1,  -1,  -1},
												 {111, 113, 135},
												 {112, 114, 136},
												 {113, 115, 137},      // 115
												 {114, 116, 138},
												 { -1,  -1,  -1},
												 { -1,  -1,  -1},
												 {117, 119,  -1},
												 {118, 120,  -1},      // 120
												 {119, 121,  -1},
												 {120, 122,  -1},
												 { -1,  -1,  -1},
												 { -1,  -1,  -1},
												 {123, 125,  -1},      // 125
												 {124, 126,  -1},
												 { -1,  -1,  -1},
												 { -1,  -1,  -1},
												 {127, 129, 139},
												 {128, 130, 140},      // 130
												 { -1,  -1,  -1},
												 { -1,  -1,  -1},
												 {131, 133, 141},
												 {132, 134, 142},
												 { -1,  -1,  -1},      // 135
												 { -1,  -1,  -1},
												 {135, 137,  -1},
												 {136, 138,  -1},
												 { -1,  -1,  -1},
												 { -1,  -1, 143},      // 140
												 { -1,  -1, 143},
												 { -1,  -1, 143},
												 { -1,  -1, 143},
												 { -1,  -1,  -1}       // 144
											  };


  TILE DefTiles[NBR_OF_TILES] =
  {
							// HWND   TXT POS    SUIT     VALUE  SEL    REM
							 {NULLH,  0,  0,CHARACTERS,    1, FALSE, FALSE}, //   1
							 {NULLH,  1,  0,CHARACTERS,    2, FALSE, FALSE}, //   2
							 {NULLH,  2,  0,CHARACTERS,    3, FALSE, FALSE}, //   3
							 {NULLH,  3,  0,CHARACTERS,    4, FALSE, FALSE}, //   4
							 {NULLH,  4,  0,CHARACTERS,    5, FALSE, FALSE}, //   5
							 {NULLH,  5,  0,CHARACTERS,    6, FALSE, FALSE}, //   6
							 {NULLH,  6,  0,CHARACTERS,    7, FALSE, FALSE}, //   7
							 {NULLH,  7,  0,CHARACTERS,    8, FALSE, FALSE}, //   8
							 {NULLH,  8,  0,CHARACTERS,    9, FALSE, FALSE}, //   9
							 {NULLH,  0,  0,CHARACTERS,    1, FALSE, FALSE}, //  10
							 {NULLH,  1,  0,CHARACTERS,    2, FALSE, FALSE},
							 {NULLH,  2,  0,CHARACTERS,    3, FALSE, FALSE},
							 {NULLH,  3,  0,CHARACTERS,    4, FALSE, FALSE},
							 {NULLH,  4,  0,CHARACTERS,    5, FALSE, FALSE},
							 {NULLH,  5,  0,CHARACTERS,    6, FALSE, FALSE}, //  15
							 {NULLH,  6,  0,CHARACTERS,    7, FALSE, FALSE},
							 {NULLH,  7,  0,CHARACTERS,    8, FALSE, FALSE},
							 {NULLH,  8,  0,CHARACTERS,    9, FALSE, FALSE},
							 {NULLH,  0,  0,CHARACTERS,    1, FALSE, FALSE},
							 {NULLH,  1,  0,CHARACTERS,    2, FALSE, FALSE}, //  20
							 {NULLH,  2,  0,CHARACTERS,    3, FALSE, FALSE},
							 {NULLH,  3,  0,CHARACTERS,    4, FALSE, FALSE},
							 {NULLH,  4,  0,CHARACTERS,    5, FALSE, FALSE},
							 {NULLH,  5,  0,CHARACTERS,    6, FALSE, FALSE},
							 {NULLH,  6,  0,CHARACTERS,    7, FALSE, FALSE}, //  25
							 {NULLH,  7,  0,CHARACTERS,    8, FALSE, FALSE},
							 {NULLH,  8,  0,CHARACTERS,    9, FALSE, FALSE},
							 {NULLH,  0,  0,CHARACTERS,    1, FALSE, FALSE},
							 {NULLH,  1,  0,CHARACTERS,    2, FALSE, FALSE},
							 {NULLH,  2,  0,CHARACTERS,    3, FALSE, FALSE}, //  30
							 {NULLH,  3,  0,CHARACTERS,    4, FALSE, FALSE},
							 {NULLH,  4,  0,CHARACTERS,    5, FALSE, FALSE},
							 {NULLH,  5,  0,CHARACTERS,    6, FALSE, FALSE},
							 {NULLH,  6,  0,CHARACTERS,    7, FALSE, FALSE},
							 {NULLH,  7,  0,CHARACTERS,    8, FALSE, FALSE}, //  35
							 {NULLH,  8,  0,CHARACTERS,    9, FALSE, FALSE},
							 {NULLH,  9,  0,DOTS      ,    1, FALSE, FALSE},
							 {NULLH, 10,  0,DOTS      ,    2, FALSE, FALSE},
							 {NULLH, 11,  0,DOTS      ,    3, FALSE, FALSE},
							 {NULLH, 12,  0,DOTS      ,    4, FALSE, FALSE}, //  40
							 {NULLH, 13,  0,DOTS      ,    5, FALSE, FALSE},
							 {NULLH, 14,  0,DOTS      ,    6, FALSE, FALSE},
							 {NULLH, 15,  0,DOTS      ,    7, FALSE, FALSE},
							 {NULLH, 16,  0,DOTS      ,    8, FALSE, FALSE},
							 {NULLH, 17,  0,DOTS      ,    9, FALSE, FALSE}, //  45
							 {NULLH,  9,  0,DOTS      ,    1, FALSE, FALSE},
							 {NULLH, 10,  0,DOTS      ,    2, FALSE, FALSE},
							 {NULLH, 11,  0,DOTS      ,    3, FALSE, FALSE},
							 {NULLH, 12,  0,DOTS      ,    4, FALSE, FALSE},
							 {NULLH, 13,  0,DOTS      ,    5, FALSE, FALSE}, //  50
							 {NULLH, 14,  0,DOTS      ,    6, FALSE, FALSE},
							 {NULLH, 15,  0,DOTS      ,    7, FALSE, FALSE},
							 {NULLH, 16,  0,DOTS      ,    8, FALSE, FALSE},
							 {NULLH, 17,  0,DOTS      ,    9, FALSE, FALSE},
							 {NULLH,  9,  0,DOTS      ,    1, FALSE, FALSE}, //  55
							 {NULLH, 10,  0,DOTS      ,    2, FALSE, FALSE},
							 {NULLH, 11,  0,DOTS      ,    3, FALSE, FALSE},
							 {NULLH, 12,  0,DOTS      ,    4, FALSE, FALSE},
							 {NULLH, 13,  0,DOTS      ,    5, FALSE, FALSE},
							 {NULLH, 14,  0,DOTS      ,    6, FALSE, FALSE}, //  60
							 {NULLH, 15,  0,DOTS      ,    7, FALSE, FALSE},
							 {NULLH, 16,  0,DOTS      ,    8, FALSE, FALSE},
							 {NULLH, 17,  0,DOTS      ,    9, FALSE, FALSE},
							 {NULLH,  9,  0,DOTS      ,    1, FALSE, FALSE},
							 {NULLH, 10,  0,DOTS      ,    2, FALSE, FALSE}, //  65
							 {NULLH, 11,  0,DOTS      ,    3, FALSE, FALSE},
							 {NULLH, 12,  0,DOTS      ,    4, FALSE, FALSE},
							 {NULLH, 13,  0,DOTS      ,    5, FALSE, FALSE},
							 {NULLH, 14,  0,DOTS      ,    6, FALSE, FALSE},
							 {NULLH, 15,  0,DOTS      ,    7, FALSE, FALSE}, //  70
							 {NULLH, 16,  0,DOTS      ,    8, FALSE, FALSE},
							 {NULLH, 17,  0,DOTS      ,    9, FALSE, FALSE},
							 {NULLH, 18,  0,BAMBOO    ,    1, FALSE, FALSE},
							 {NULLH, 19,  0,BAMBOO    ,    2, FALSE, FALSE},
							 {NULLH, 20,  0,BAMBOO    ,    3, FALSE, FALSE}, //  75
							 {NULLH, 21,  0,BAMBOO    ,    4, FALSE, FALSE},
							 {NULLH, 22,  0,BAMBOO    ,    5, FALSE, FALSE},
							 {NULLH, 23,  0,BAMBOO    ,    6, FALSE, FALSE},
							 {NULLH, 24,  0,BAMBOO    ,    7, FALSE, FALSE},
							 {NULLH, 25,  0,BAMBOO    ,    8, FALSE, FALSE}, //  80
							 {NULLH, 26,  0,BAMBOO    ,    9, FALSE, FALSE},
							 {NULLH, 18,  0,BAMBOO    ,    1, FALSE, FALSE},
							 {NULLH, 19,  0,BAMBOO    ,    2, FALSE, FALSE},
							 {NULLH, 20,  0,BAMBOO    ,    3, FALSE, FALSE},
							 {NULLH, 21,  0,BAMBOO    ,    4, FALSE, FALSE}, //  85
							 {NULLH, 22,  0,BAMBOO    ,    5, FALSE, FALSE},
							 {NULLH, 23,  0,BAMBOO    ,    6, FALSE, FALSE},
							 {NULLH, 24,  0,BAMBOO    ,    7, FALSE, FALSE},
							 {NULLH, 25,  0,BAMBOO    ,    8, FALSE, FALSE},
							 {NULLH, 26,  0,BAMBOO    ,    9, FALSE, FALSE}, //  90
							 {NULLH, 18,  0,BAMBOO    ,    1, FALSE, FALSE},
							 {NULLH, 19,  0,BAMBOO    ,    2, FALSE, FALSE},
							 {NULLH, 20,  0,BAMBOO    ,    3, FALSE, FALSE},
							 {NULLH, 21,  0,BAMBOO    ,    4, FALSE, FALSE},
							 {NULLH, 22,  0,BAMBOO    ,    5, FALSE, FALSE}, //  95
							 {NULLH, 23,  0,BAMBOO    ,    6, FALSE, FALSE},
							 {NULLH, 24,  0,BAMBOO    ,    7, FALSE, FALSE},
							 {NULLH, 25,  0,BAMBOO    ,    8, FALSE, FALSE},
							 {NULLH, 26,  0,BAMBOO    ,    9, FALSE, FALSE},
							 {NULLH, 18,  0,BAMBOO    ,    1, FALSE, FALSE}, // 100
							 {NULLH, 19,  0,BAMBOO    ,    2, FALSE, FALSE},
							 {NULLH, 20,  0,BAMBOO    ,    3, FALSE, FALSE},
							 {NULLH, 21,  0,BAMBOO    ,    4, FALSE, FALSE},
							 {NULLH, 22,  0,BAMBOO    ,    5, FALSE, FALSE},
							 {NULLH, 23,  0,BAMBOO    ,    6, FALSE, FALSE}, // 105
							 {NULLH, 24,  0,BAMBOO    ,    7, FALSE, FALSE},
							 {NULLH, 25,  0,BAMBOO    ,    8, FALSE, FALSE},
							 {NULLH, 26,  0,BAMBOO    ,    9, FALSE, FALSE},
							 {NULLH, 27,  0,DRAGONS   ,    1, FALSE, FALSE},
							 {NULLH, 28,  0,DRAGONS   ,    2, FALSE, FALSE}, // 110
							 {NULLH, 29,  0,DRAGONS   ,    3, FALSE, FALSE},
							 {NULLH, 27,  0,DRAGONS   ,    1, FALSE, FALSE},
							 {NULLH, 28,  0,DRAGONS   ,    2, FALSE, FALSE},
							 {NULLH, 29,  0,DRAGONS   ,    3, FALSE, FALSE},
							 {NULLH, 27,  0,DRAGONS   ,    1, FALSE, FALSE}, // 115
							 {NULLH, 28,  0,DRAGONS   ,    2, FALSE, FALSE},
							 {NULLH, 29,  0,DRAGONS   ,    3, FALSE, FALSE},
							 {NULLH, 27,  0,DRAGONS   ,    1, FALSE, FALSE},
							 {NULLH, 28,  0,DRAGONS   ,    2, FALSE, FALSE},
							 {NULLH, 29,  0,DRAGONS   ,    3, FALSE, FALSE}, // 120
							 {NULLH, 30,  0,WINDS     ,    1, FALSE, FALSE},
							 {NULLH, 31,  0,WINDS     ,    2, FALSE, FALSE},
							 {NULLH, 32,  0,WINDS     ,    3, FALSE, FALSE},
							 {NULLH, 33,  0,WINDS     ,    4, FALSE, FALSE},
							 {NULLH, 30,  0,WINDS     ,    1, FALSE, FALSE}, // 125
							 {NULLH, 31,  0,WINDS     ,    2, FALSE, FALSE},
							 {NULLH, 32,  0,WINDS     ,    3, FALSE, FALSE},
							 {NULLH, 33,  0,WINDS     ,    4, FALSE, FALSE},
							 {NULLH, 30,  0,WINDS     ,    1, FALSE, FALSE},
							 {NULLH, 31,  0,WINDS     ,    2, FALSE, FALSE}, // 130
							 {NULLH, 32,  0,WINDS     ,    3, FALSE, FALSE},
							 {NULLH, 33,  0,WINDS     ,    4, FALSE, FALSE},
							 {NULLH, 30,  0,WINDS     ,    1, FALSE, FALSE},
							 {NULLH, 31,  0,WINDS     ,    2, FALSE, FALSE},
							 {NULLH, 32,  0,WINDS     ,    3, FALSE, FALSE}, // 135
							 {NULLH, 33,  0,WINDS     ,    4, FALSE, FALSE},
							 {NULLH, 34,  0,FLOWERS   ,    1, FALSE, FALSE},
							 {NULLH, 35,  0,FLOWERS   ,    1, FALSE, FALSE},
							 {NULLH, 36,  0,FLOWERS   ,    1, FALSE, FALSE},
							 {NULLH, 37,  0,FLOWERS   ,    1, FALSE, FALSE}, // 140
							 {NULLH, 38,  0,SEASONS   ,    1, FALSE, FALSE},
							 {NULLH, 39,  0,SEASONS   ,    1, FALSE, FALSE},
							 {NULLH, 40,  0,SEASONS   ,    1, FALSE, FALSE},
							 {NULLH, 41,  0,SEASONS   ,    1, FALSE, FALSE}  // 144
  };
#else
  extern int  Neighbors[NBR_OF_TILES][3];
  extern int  TilePos[NBR_OF_TILES][2];
  extern TILE DefTiles[NBR_OF_TILES];
#endif

#undef xSCOPE
#undef iGLOBAL


//----------------------------------------------------------------------------
//- Macro definitions
//----------------------------------------------------------------------------
//#define LONGFromRGB(R,G,B) (LONG)(((LONG)R<<16)+((LONG)G<<8)+(LONG)B)

//----------------------------------------------------------------------------
//- Function Prototypes
//----------------------------------------------------------------------------
void *MemAlloc(unsigned short size);
BOOL  ClearMsgQueue(void);
//void  CreationAdjustment(void);

//--- Game Functions ---------------------------------------------------------
//void ShuffleTiles(void);
//void DealTiles(void);
BOOL IsTileSelectable(int id);

#endif