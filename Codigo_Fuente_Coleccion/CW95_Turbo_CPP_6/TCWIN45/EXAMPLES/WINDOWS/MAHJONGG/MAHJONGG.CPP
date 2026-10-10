//-----------------------------------------------------------------------------
// (C) Copyright 1995 by Borland International
//
// Mahjongg.cpp
// This Game is ported from OS/2 to windows.
// The OS/2 version of the game can be found in IBM C/2 wkframe samples
// It is a good example of how to port OS/2 PM programs to windows.

#include <windowsx.h>
#pragma hdrstop
#include <dos.h>
#define DEFINE_VARIABLES 1

// Contains the necessary headers and definitions for this program
#include "mahjongg.h"
#include "common.h"       // all data struct defination.

// Given a pointer to a DIB header, return TRUE if is a Windows 3.0 style
//  DIB, false if otherwise (PM style DIB).

#define IS_WIN30_DIB(lpbi)  ((*(LPDWORD) (lpbi)) == sizeof (BITMAPINFOHEADER))

VOID CreationAdjustment(HWND hWnd);
VOID CreateTiles(HWND hWnd);
VOID InitializeDefaultTiles(VOID);
VOID InitializeDefaultGame(VOID);
VOID DealTiles(HWND hWnd);
VOID ShuffleTiles(VOID);
WasteTime(int millisec);
DrawBitmap(HDC hdc, int Id);
LRESULT  CALLBACK _export AboutDlgProc (HWND hDlg,
													 UINT message,
													 UINT wParam, LONG lParam);

// Global Variables
char szName[256];

// local variables
static int   sMaxAdjx       = 0; // center adjustement for maximized window
static int   sMaxAdjy       = 0; // center adjustement for maximized window 
static char idb_back[128];

static DLGPROC lpfnAboutDlgProc ; // About dialog box call back function.

#define UNDO_SIZE       (NBR_OF_TILES/2)+1
static struct {
	 long Tile1;
	 long Tile2;
  } UndoBuffer[UNDO_SIZE];

static int UndoTop     = 0;
static int UndoCurrent = 0;
static int UndoBottom  = 0;

// ------------------------ InitInstance() ---------------------------------
// Creates the Main window.

#pragma argsused
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
  HWND  hWnd; // Main window handle.

  // Save the instance handle in static variable, which will be used in 
  // many subsequence calls from this application to Windows.

  ghInst = hInstance;

  // Create a main window for this application instance.

  hWnd = CreateWindow(
	 "MAHJONGG",                 	// See RegisterClass() call.
	 "Mahjongg",  						// Text for window title bar.
	 WS_OVERLAPPED|WS_SYSMENU|
	 WS_CAPTION|WS_MINIMIZEBOX|
	 WS_MAXIMIZEBOX|
	 WS_CLIPCHILDREN,        		// Window style.
	 CW_USEDEFAULT,         		// Default horizontal position.
	 CW_USEDEFAULT,          		// Default vertical position.
	 CW_USEDEFAULT,            	// Default width.
	 CW_USEDEFAULT,        			// Default height.
	 NULL,                  		// Overlapped windows have no parent.
	 NULL,                  		// Use the window class menu.
	 hInstance,              		// This instance owns this window.
	 NULL                   		// Pointer not needed.
  );

  // If window could not be created, return "failure"

  if (!hWnd)
	 return (FALSE);

  // Make the window visible; update its client area; and return "success"

  //ShowWindow(hWnd, nCmdShow); 	// Show the window
  //UpdateWindow(hWnd);     		// Sends WM_PAINT message
  return (TRUE);

}
//---------------------------- DIBNumColors() -----------------------------
//  Given a pointer to a DIB, returns a number of colors in
//  the DIB's color table.
//
// Parms:      lpbi == pointer to DIB header (either BITMAPINFOHEADER
//                       or BITMAPCOREHEADER)
//

WORD DIBNumColors (LPSTR lpbi)
{
	WORD wBitCount;


	// If this is a Windows style DIB, the number of colors in the
	//  color table can be less than the number of bits per pixel
	//  allows for (i.e. lpbi->biClrUsed can be set to some value).
	//  If this is the case, return the appropriate value.

	if (IS_WIN30_DIB (lpbi))
	{
		DWORD dwClrUsed;

		dwClrUsed = ((LPBITMAPINFOHEADER) lpbi)->biClrUsed;

		if (dwClrUsed)
			return (WORD) dwClrUsed;
	}

	// Calculate the number of colors in the color table based on
	//  the number of bits per pixel for the DIB.

	if (IS_WIN30_DIB (lpbi))
		wBitCount = ((LPBITMAPINFOHEADER) lpbi)->biBitCount;
	else
		wBitCount = ((LPBITMAPCOREHEADER) lpbi)->bcBitCount;

	switch (wBitCount)
	{
		case 1:
			return 2;

		case 4:
			return 16;

		case 8:
			return 256;

		default:
			return 0;
	}
}

//----------------------------- CreateDIBPalette() ---------------------
//
//  Given a handle to a DIB, constructs a logical palette,
//           and returns a handle to this palette else NULL.
//

HPALETTE LoadPaletteFromDIB(LPCSTR resName)
{
HANDLE hRes;
HANDLE hPal;
int nColorData;
HPALETTE hPalette;
LPBITMAPCOREINFO lpbmc;
BITMAPINFO FAR *lpBitmapInfo;
BOOL             bWinStyleDIB;

	// Load DIB and get handle to it's locked memory block.

	hRes = LoadResource(ghInst,
								 FindResource(ghInst, resName, RT_BITMAP ));

	lpBitmapInfo = (LPBITMAPINFO)LockResource(hRes);
	lpbmc        = (LPBITMAPCOREINFO) lpBitmapInfo;
	bWinStyleDIB = IS_WIN30_DIB (lpBitmapInfo);

	// Calculate the number of color data entries in DIB.
	nColorData = DIBNumColors ((LPSTR)lpBitmapInfo);

	// allocate memory to hold palette.
	hPal = GlobalAlloc(GHND, sizeof(LOGPALETTE)+
									  (nColorData * sizeof(PALETTEENTRY)));
	LPLOGPALETTE lpLogPalette = (LPLOGPALETTE)GlobalLock(hPal);

	// Create a logical palette.
	lpLogPalette->palVersion = 0x300;
	lpLogPalette->palNumEntries = nColorData;

	// Load each color into palette fields
	for(int i = 0; i < nColorData; i++)
	{
				if (bWinStyleDIB)
				{
				lpLogPalette->palPalEntry[i].peRed
							= lpBitmapInfo->bmiColors[i].rgbRed;
				lpLogPalette->palPalEntry[i].peGreen
							= lpBitmapInfo->bmiColors[i].rgbGreen;
				lpLogPalette->palPalEntry[i].peBlue
							= lpBitmapInfo->bmiColors[i].rgbBlue;
				lpLogPalette->palPalEntry[i].peFlags = 0;
				}
			else
				{
				lpLogPalette->palPalEntry[i].peRed
							= lpbmc->bmciColors[i].rgbtRed;
				lpLogPalette->palPalEntry[i].peGreen
							= lpbmc->bmciColors[i].rgbtGreen;
				lpLogPalette->palPalEntry[i].peBlue
							= lpbmc->bmciColors[i].rgbtBlue;
				lpLogPalette->palPalEntry[i].peFlags = 0;
				}

	}
	hPalette = CreatePalette (lpLogPalette);
	if(!hPalette)
			MessageBox(HWND_DESKTOP,"Cannot Create Palette","Error",MB_OK);

	GlobalUnlock(hRes);
	GlobalUnlock(hPal);
	GlobalFree(hPal);
	FreeResource(hRes);
	return hPalette;
}

//--------------------- DibBlt() ------------------------------------------
//
// Draws a bitmap in CF_DIB format, using SetDIBitsToDevice().
// Returns TRUE on Success else False
// numScans actually is found out from the bitmap height.

BOOL DibBlt  (HDC hdc, int x0, int y0, HANDLE hdib,
	int x1, int y1, int dx, int dy, int startScan, UINT numScans)
{
	 LPBITMAPINFOHEADER   lpbi;
	 LPSTR                pBuf;

	 if (!hdib)
		  return FALSE;

	 lpbi = (LPBITMAPINFOHEADER )GlobalLock(hdib);

	 if (!lpbi)
		  return FALSE;
	 WORD nColorData = DIBNumColors ((LPSTR)lpbi);

	 // RLE DIBs, I think not taken care of, forget it

	 pBuf = (LPSTR)lpbi +
			  (WORD)lpbi->biSize +
				//PaletteSize
				(WORD)lpbi->biSize +
				(WORD)(nColorData * sizeof(RGBQUAD)) +
			  +(WORD)(startScan * ((lpbi->biWidth * lpbi->biBitCount) / 8));

	 numScans = (UINT) lpbi->biHeight;
	 SetDIBitsToDevice (hdc,
							  x0, y0,
							  dx, dy,
							  x1,y1,
							  startScan,
							  numScans,
							  pBuf, (LPBITMAPINFO) lpbi,
							  DIB_RGB_COLORS );

	 GlobalUnlock(hdib);
	 return TRUE;
}

//------------------------------ DrawBackBitmap() ---------------------------
// Redraws the background bitmaps.
//

DrawBackBitmap(HDC hDC, HPALETTE hPalette, LPCSTR resName ,RECT rect)
{
HANDLE hRes;
HPALETTE  hOldPal;

	hOldPal = SelectPalette(hDC, hPalette, FALSE);
	RealizePalette(hDC);
	//if(!RealizePalette(hDC))
	//		MessageBox(HWND_DESKTOP,"DrawBackBitmap: RealizePalette() fail",
	//               "Error",MB_OK);

	// Load DIB and get handle to it's locked memory block.
	hRes = LoadResource(ghInst,
								 FindResource(ghInst, resName, RT_BITMAP ));
	if(!hRes)
			MessageBox(HWND_DESKTOP,"DrawBackBitmap: LoadResource() fail","Error",
			           MB_OK);

			DibBlt( hDC,
					  (WORD)rect.left,               // Dest X
					  (WORD)rect.top,                // Dest Y
					  hRes,                          // Current DIB
					  0,                             // Cur DIB X
					  0,                             // Cur DIB Y
					  (WORD)(rect.right - rect.left),// Cur DIB dx
					  (WORD)(rect.bottom - rect.top),// Cur DIB dy
					  0,                             // Start Scan
					  0                              // Number of scan.
					  );


	GlobalUnlock(hRes);
	FreeResource(hRes);
	hOldPal; // Get rid of the warning.

//	SelectPalette(hDC, hOldPal , FALSE);
//	if(!RealizePalette(hDC))
//			MessageBox(HWND_DESKTOP,"DrawBackBitmap: RealizePalette() fail",
//                  "Error",MB_OK);

	return 0;
}

//------------------------ MainWndProc() ------------------------------------
//
// Main Event handling window.

LRESULT FAR PASCAL _export MainWndProc(HWND hWnd, UINT message,
						WPARAM wParam, LPARAM lParam)
{
  static HDC hDC;        // HDC for Window
  static PAINTSTRUCT ps; // Paint Struct for BeginPaint call

  static HPALETTE hPalette;

  switch (message) {
		case WM_ERASEBKGND:
		 // if this is not present, the default action is
		 // to repaint the window with white and send a WM_PAINT
		 // message. So initially you get more flickering.

		 //return(FALSE);
		break;

		case WM_CREATE: // Initialize Global vars
		{
			RECT rect;

			hptrWait  = LoadCursor(NULL,IDC_WAIT);
			if(!hptrWait)
				MessageBox(hWnd,"Cannot load Wait cursor","Error",MB_OK);

			hptrArrow = LoadCursor(NULL,IDC_ARROW);
			if(!hptrArrow)
				MessageBox(hWnd,"Cannot load Arrow cursor","Error",MB_OK);

			strcpy( szName, "" );           // Empty the file name string
			lpfnAboutDlgProc = (DLGPROC)MakeProcInstance ((FARPROC) AboutDlgProc,
			                                               ghInst) ;

			for (int i=0; i<NBR_OF_TILES; i++)
			{
				Shuffled[i] = i;
				Tiles[i].iPos = i;
			}

			CreationAdjustment(hWnd);
			hPalette = LoadPaletteFromDIB(idb_back);
			if(!hPalette)
				MessageBox(hWnd,
							  "LoadPaletteFromDIB: No palette created","Error",MB_OK);

			hDC = GetDC(hWnd);
			GetClientRect(hWnd, &rect);
			DrawBackBitmap( hDC, hPalette, idb_back, rect);
			ReleaseDC   (hWnd, hDC);

			// Creates all the tile windows on the board.
			CreateTiles(hWnd);

			// Send this message to draw the score on the upper right.
			NbrOfTilesRemaining = NBR_OF_TILES;
			SelectedTile = NO_TILE;
			SendMessage(hWnd,MJ_DRAW_STATUS, 0, 0);

			return NULL;
	  }
	  case WM_PAINT:
	  {
		 RECT rect;

		 HDC hDC=BeginPaint(hWnd,&ps);
		 if(hDC)
		 {
			GetClientRect( hWnd, &rect );
			DrawBackBitmap( hDC, hPalette, idb_back, /*ps.rcPaint*/  rect );
			EndPaint(hWnd,&ps);
			hDC = NULL;
		 }
		 else
		 {
			MessageBox(hWnd,"WM_PAINT: BeginPaint() returns NULL","Error",MB_OK);
			EndPaint(hWnd,&ps);
		 }
	  }
		 SendMessage(hWnd,MJ_DRAW_STATUS, 0, 0);
		 break;
	  // no break here! it falls through MJ_DRAW_STATUS !
	 case MJ_DRAW_STATUS:
	 {   RECT    rectl;
		  char     szNbr[12];
		  BITMAP  bm;
		  HBITMAP hbmpOld, hTileBmp;
		  int      i,j;
		  HDC hMemoryDC;

		  static   LastLength=3;
		  GetClientRect(hWnd, &rectl);

		  // Calculates the position where to put status.

		  rectl.right -= BOARD_FR_CX*deltaX;
		  rectl.left   = rectl.right - (6*TILE_CX*deltaX)/3;
		  rectl.top   += BOARD_FR_CY + (9*(TILE_CY-TILE_BW)*deltaX)/4;
		  rectl.bottom = (rectl.top+(2*TILE_CY*deltaX)/3);

		if (NbrOfTilesRemaining > 0)
		{
				 itoa(NbrOfTilesRemaining, szNbr, 10);
				 j = strlen(szNbr)-1;

				 hDC = GetDC(hWnd);
				 hMemoryDC = CreateCompatibleDC(hDC);


				 for (i=j; i>=0; i--)
				 {
					hTileBmp = LoadBitmap(ghInst,
					             MAKEINTRESOURCE(IDB_TILE_N_0+szNbr[i]-'0'));
					GetObject(hTileBmp, sizeof(BITMAP), (LPSTR) &bm);
					hbmpOld =  (HBITMAP) SelectObject(hMemoryDC, hTileBmp);

					BitBlt	(hDC,
						 rectl.left, rectl.top,
						 bm.bmWidth,
						 bm.bmHeight,
						 hMemoryDC, 0, 0,
						 SRCCOPY);

					rectl.left  -= (2*TILE_CX*deltaX)/3+5;
					SelectObject(hMemoryDC, hbmpOld);
					DeleteObject(hTileBmp);
				 }
				DeleteDC   (hMemoryDC);
				ReleaseDC  (hWnd, hDC);
		 }
		 else
		 {
				 j = -1;
		 } // endif 

		 if (j<LastLength)
		 {
				 GetClientRect(hWnd, &rectl);
				 InvalidateRect(hWnd, &rectl, FALSE);
				 LastLength = j;
		 }

	 }
  break;


  case WM_COMMAND:
	 switch(GET_WM_COMMAND_ID(wParam, lParam))
	 {
      // message: Commands from application menu
		case CM_EXIT:
			 DestroyWindow(hWnd);
		  break;

		case IDA_GAME:
			MessageBox(hWnd,"TBD","Message",MB_OK);
			break;

		case MJ_SUCCESS:
			MessageBox(hWnd,"Congratulations, you have won.","Message",MB_OK);
			break;

		case MJ_PUSH_UNDOCMD:
			UndoBuffer[UndoCurrent].Tile1 =
						 (long)GET_WM_COMMAND_HWND(wParam, lParam);
			UndoBuffer[UndoCurrent].Tile2 = GET_WM_COMMAND_CMD(wParam, lParam);
			UndoCurrent++;
			UndoTop = UndoCurrent;
		break;

		case IDM_NEW_G:
			 if (!bDealing)
			 {
			   // don't allow reentrant new games
				bDealing = TRUE;
				SetCursor(hptrWait);
				ShuffleTiles();
				DealTiles(hWnd);
				//Reset the counter.
				SendMessage(hWnd,MJ_DRAW_STATUS, 0, 0);
				SetCursor(hptrArrow);
				bDealing = FALSE;
			 }
			 else
				MessageBox(hWnd,"Multiple Instance not allowed","Message",MB_OK);
			break;

		case IDA_MOVES:
			MessageBox(hWnd,"TBD","Message",MB_OK);
			break;

		case IDM_UNDO:
			 if (UndoCurrent != UndoBottom) {
				SHORT   cx,cy;
				long t1, t2;

				cx = Board.cxt*(SHORT)deltaX;
				cy = Board.cyt*(SHORT)deltaX;

				UndoCurrent--;
				t1 = UndoBuffer[UndoCurrent].Tile1;
				t2 = UndoBuffer[UndoCurrent].Tile2;
				Tiles[(int)t1].bRemoved   = FALSE;
				Tiles[(int)t2].bRemoved   = FALSE;
				NbrOfTilesRemaining += 2;

				SetWindowPos(Tiles[(int)t1].hwnd, HWND_TOP,
						sMaxAdjx + TilePos[Tiles[(int)t1].iPos][0]*(SHORT)deltaX,
						sMaxAdjy + TilePos[Tiles[(int)t1].iPos][1]*(SHORT)deltaX,
						cx,
						cy,
						SWP_SHOWWINDOW|SWP_NOZORDER);
				SetWindowPos(Tiles[(int)t2].hwnd, HWND_TOP,
						sMaxAdjx + TilePos[Tiles[(int)t2].iPos][0]*(SHORT)deltaX,
						sMaxAdjy + TilePos[Tiles[(int)t2].iPos][1]*(SHORT)deltaX,
						cx,
						cy,
						SWP_SHOWWINDOW|SWP_NOZORDER);


				if (SelectedTile != NO_TILE)
				{
				  SendMessage(Tiles[SelectedTile].hwnd,WM_COMMAND,
								  GET_WM_COMMAND_MPS(MJ_DESELECT, 0, 0));
				}
				SelectedTile = NO_TILE;
				RECT rectl; // Update the counter.
				GetClientRect(hWnd, &rectl);
				InvalidateRect(hWnd, &rectl, FALSE);
			 } // endif
			break;

		case IDM_REDO:
			 if (UndoCurrent != UndoTop) {
				long t1,t2;
				t1 = UndoBuffer[UndoCurrent].Tile1;
				t2 = UndoBuffer[UndoCurrent].Tile2;

				SendMessage(Tiles[(int)t1].hwnd,WM_COMMAND,
								GET_WM_COMMAND_MPS(MJ_REMOVE, 0, 0));
				SendMessage(Tiles[(int)t2].hwnd,WM_COMMAND,
				            GET_WM_COMMAND_MPS(MJ_REMOVE, 0, 0));

				if (SelectedTile != NO_TILE)
				{
				  SendMessage(Tiles[SelectedTile].hwnd,WM_COMMAND,
								  GET_WM_COMMAND_MPS(MJ_DESELECT, 0, 0));
				}
				SelectedTile = NO_TILE;

				RECT rectl; // Update the counter.
				GetClientRect(hWnd, &rectl);
				InvalidateRect(hWnd, &rectl, FALSE);

				UndoCurrent++;
			 } // endif
			break;

		case IDM_SHOW:
			 // show all possible moves
			 { short oldTile,i,j,f;

				oldTile = SelectedTile;
				if (SelectedTile != NO_TILE) {
				  // deselect this tile first
				  SendMessage(Tiles[SelectedTile].hwnd,
								  WM_COMMAND,GET_WM_COMMAND_MPS(MJ_DESELECT, 0, 0));
				}

				f = 0;
				for (i=0; i<NBR_OF_TILES; i++) {
				  if (IsTileSelectable(i)) {
					 for (j=i+1; j<NBR_OF_TILES; j++) {
						if (IsTileSelectable(j)) {
						  if ((Tiles[i].suit == Tiles[j].suit) &&
								(Tiles[i].value == Tiles[j].value)) {
							 // flash the tiles
							 SendMessage(Tiles[i].hwnd, WM_COMMAND,
											 GET_WM_COMMAND_MPS(MJ_SELECT, 0, 0));
							 SendMessage(Tiles[j].hwnd, WM_COMMAND,
											 GET_WM_COMMAND_MPS(MJ_SELECT, 0, 0));
							 WasteTime(500);
							 SendMessage(Tiles[i].hwnd, WM_COMMAND,
											 GET_WM_COMMAND_MPS(MJ_DESELECT, 0, 0));
							 SendMessage(Tiles[j].hwnd, WM_COMMAND,
							             GET_WM_COMMAND_MPS(MJ_DESELECT, 0, 0));

							 f++;
						  } else {
						  } // endif
						} // endif
					 } // endfor
				  } // endif
				} // endfor

				SelectedTile = oldTile;
				if (SelectedTile != NO_TILE)
				{
				  // reselect this tile
				  SendMessage(Tiles[SelectedTile].hwnd,
								  WM_COMMAND,GET_WM_COMMAND_MPS(MJ_SELECT, 0, 0));
				}

				if (f == 0)
				{
					/* no more moves possible */
					MessageBox(hWnd,
					"Sorry no more moves possible, Undo and try.","Message",MB_OK);
				}
			 }
			 break;
		case IDA_OPTIONS:
			MessageBox(hWnd,"TBD","Message",MB_OK);
			break;
		case IDM_SOUND:
			 bSound = !bSound;
			break;
		case IDM_SAVEOPT:
			MessageBox(hWnd,"TBD","Message",MB_OK);
			break;
		case IDA_HELP:
			MessageBox(hWnd,"TBD","Message",MB_OK);
			break;
		case CM_HELPABOUT:
			 DialogBox (ghInst, "AboutBox", hWnd, lpfnAboutDlgProc);
		  break;

		default:
		  break;
	 }
	 break;

  case WM_QUIT:
  case WM_DESTROY:  // message: window being destroyed
	 if(Game.pszTitle)
	 {
		free(Game.pszTitle);
		Game.pszTitle = NULL;
	 }

	 if(Game.pszHelpFile)
	 {
		free(Game.pszHelpFile);
		Game.pszHelpFile = NULL;
	 }

		DeleteObject(hPalette);
		PostQuitMessage(0);
	 break;

  default:      // Passes it on if unproccessed
	 return (DefWindowProc(hWnd, message, wParam, lParam));
  }
  return (NULL);
}

//----------------------------- WasteTime() ---------------------------------
// Wastes time between showing possible moves.
//
WasteTime(int millisec)
{
DWORD t1=0, t2=0 ;
MSG msg;      // message
	 t1 = GetTickCount();
	 for(;;)
	 {
			 PeekMessage(&msg, // message structure
							NULL,  // handle of window receiving the message
							NULL,  // lowest message to examine
							NULL,
							PM_NOREMOVE|PM_NOYIELD);  	// highest message to examine

			 t2 = GetTickCount();
			 if((t2-t1)> millisec)
				  return(1);
	 }
}

//------------------------- RegisterWindows() -------------------------------
// Registers Main and tile windows.
//
BOOL RegisterWindows(HINSTANCE hInstance)
{
  WNDCLASS  wc;

  // Fill in window class structure with parameters that describe the
  // main window.

  wc.style = CS_HREDRAW | CS_VREDRAW;  // Class style(s).
  wc.lpfnWndProc = MainWndProc; 			// Function to retrieve messages for
													// windows of this class.
  wc.cbClsExtra = 0;        				// No per-class extra data.
  wc.cbWndExtra = 0;        				// No per-window extra data.
  wc.hInstance = hInstance; 				// Application that owns the class.
  wc.hIcon = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_SDIAPPLICATION));
  wc.hCursor = LoadCursor(NULL, IDC_ARROW);
  wc.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);
  wc.lpszMenuName = "SDI_MENU";  // Name of menu resource in .RC file.
  wc.lpszClassName = "MAHJONGG"; // Name used in call to CreateWindow.

  // Register the window class and return success/failure code.

  if(!RegisterClass(&wc))
  {
	 MessageBox(NULL, "Cannot Register Class MAHJONGG!","Error", MB_OK);
	 return (FALSE);
  }

  // Fill in window class structure with parameters that describe the
  // tile window.

  wc.style = 0;               // Class style(s).
  wc.lpfnWndProc =  TileWndProc; // Function to retrieve messages for
									  // windows of this class.
  wc.cbClsExtra = 0;         // No per-class extra data.
  wc.cbWndExtra = 0;         // No per-window extra data.
  wc.hInstance  = hInstance; // Application that owns the class.
  wc.hIcon      = NULL;
  wc.hCursor    = NULL;
  wc.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);
  wc.lpszMenuName  = NULL ;
  wc.lpszClassName = "TILE"; // Name used in call to CreateWindow.

  // Register the Tile window class and return success/failure code.

  if(!RegisterClass(&wc))
  {
	 MessageBox(NULL, "Cannot Register Class TILE!","Error", MB_OK);
	 return (FALSE);
  }
  else
	 return (TRUE);

}

#pragma argsused
//------------------------WinMain()------------------------------------------
// Main windows function.
//
int PASCAL WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
			  LPSTR lpCmdLine, int nCmdShow)
{
  MSG msg;            // message
  if (!hPrevInstance) // Other instances of app running?
  if (!RegisterWindows(hInstance))  // Initialize shared things
	 return (FALSE);   // Exits if unable to initialize

  InitializeDefaultTiles();
  InitializeDefaultGame();

  // Perform initializations that apply to a specific instance
  if (!InitInstance(hInstance, nCmdShow))
	 return (FALSE);

  // Acquire and dispatch messages until a WM_QUIT message is received.
  while (GetMessage(&msg,  	// message structure
							NULL,   	// handle of window receiving the message
							NULL,   	// lowest message to examine
							NULL))  	// highest message to examine
  {
  TranslateMessage(&msg); 		// Translates virtual key codes
  DispatchMessage(&msg);  		// Dispatches message to window
  }
  return (msg.wParam);    		// Returns the value from PostQuitMessage
}

//-------------------------CreationAdjustment()------------------------------
// Adjust the frame window size on creation
//
VOID CreationAdjustment(HWND hWnd)
{
	RECT rectl;
	HDC hDC = GetDC(hWnd);
	int horRes = GetDeviceCaps(hDC, HORZRES);
	deltaX = DEFAULT_VGA_DX;
	rectl.left   = 0;
	rectl.top    = 0;
	rectl.right  = Board.cx*deltaX;
	rectl.bottom = Board.cy*deltaX;

	int cx = rectl.right  - rectl.left;
	int cy = rectl.bottom - rectl.top;

	// You need a bit larger frame for all these tiles
	// than above calculated values.

	if ( horRes > 640) {
		strcpy(idb_back, "IDB_BACKSVGA"); // Svga
		cx = 1071;
		cy = 653;

		//deltaX   = DEFAULT_BGA_DX;
	}
	else
	{
		strcpy(idb_back, "IDB_BACKVGA");
		//deltaX = DEFAULT_VGA_DX;
		cx += cx/4;
		cy += cy/4;

	} /* endif */
	ReleaseDC   (hWnd, hDC);
	SetWindowPos(hWnd, HWND_TOP, 0, 0, cx, cy,
							SWP_SHOWWINDOW);

}

//----------------------------- InitializeDefaultGame() --------------------
//
// Initializes the Default Mahjongg Game.

VOID InitializeDefaultGame(VOID)
{
  int i,j,x,y;
  int totalYTiles = 8;
  Game.pszTitle    = strdup("Mahjongg Solitaire");
  Game.pszHelpFile = strdup("MAHJONGG.HLP");

  Board.cx         = 2*BOARD_FR_CX + 16*(TILE_CX-TILE_BW) + TILE_BW;
  Board.cy         = 2*BOARD_FR_CY +  8*(TILE_CY-TILE_BW) + TILE_BW;
  Board.cxt        = TILE_CX;
  Board.cyt        = TILE_CY;

  /* bottom level */
  x = BOARD_FR_CX + 12*(TILE_CX-TILE_BW);
  y = BOARD_FR_CY +  (totalYTiles - 7)*(TILE_CY-TILE_BW);
  for (i=0; i<12; i++) 
  {
	 TilePos[i][0] = x;
	 TilePos[i][1] = y;
	 x -= (TILE_CX-TILE_BW);
  } /* endfor */
  x = BOARD_FR_CX + 10*(TILE_CX-TILE_BW);
  y = BOARD_FR_CY +  (totalYTiles - 6)*(TILE_CY-TILE_BW);
  for (i=12; i<20; i++) 
  {
	 TilePos[i][0] = x;
	 TilePos[i][1] = y;
	 x -= (TILE_CX-TILE_BW);
  } /* endfor */
  x = BOARD_FR_CX + 11*(TILE_CX-TILE_BW);
  y = BOARD_FR_CY +  (totalYTiles - 5)*(TILE_CY-TILE_BW);
  for (i=20; i<30; i++) 
  {
	 TilePos[i][0] = x;
	 TilePos[i][1] = y;
	 x -= (TILE_CX-TILE_BW);
  } /* endfor */
  x = BOARD_FR_CX + 14*(TILE_CX-TILE_BW);
  y = BOARD_FR_CY +  (totalYTiles - 3)*(TILE_CY-TILE_BW) - TILE_CY/2;
  TilePos[30][0] = x;
  TilePos[30][1] = y;
  x -= (TILE_CX-TILE_BW);
  TilePos[31][0] = x;
  TilePos[31][1] = y;
  x -= (TILE_CX-TILE_BW);
  y = BOARD_FR_CY +  (totalYTiles - 4)*(TILE_CY-TILE_BW);
  for (i=32; i<44; i++) 
  {
	 TilePos[i][0] = x;
	 TilePos[i][1] = y;
	 x -= (TILE_CX-TILE_BW);
  } /* endfor */
  x = BOARD_FR_CX + 12*(TILE_CX-TILE_BW);
  y = BOARD_FR_CY +  (totalYTiles - 3)*(TILE_CY-TILE_BW);
  for (i=44; i<56; i++) 
  {
	 TilePos[i][0] = x;
	 TilePos[i][1] = y;
	 x -= (TILE_CX-TILE_BW);
  } /* endfor */
  y -= TILE_CY/2;
  TilePos[56][0] = x;
  TilePos[56][1] = y;
  x = BOARD_FR_CX + 11*(TILE_CX-TILE_BW);
  y = BOARD_FR_CY +  (totalYTiles - 2)*(TILE_CY-TILE_BW);
  for (i=57; i<67; i++) 
  {
	 TilePos[i][0] = x;
	 TilePos[i][1] = y;
	 x -= (TILE_CX-TILE_BW);
  } /* endfor */
  x = BOARD_FR_CX + 10*(TILE_CX-TILE_BW);
  y = BOARD_FR_CY +  (totalYTiles - 1)*(TILE_CY-TILE_BW);
  for (i=67; i<75; i++) 
  {
	 TilePos[i][0] = x;
	 TilePos[i][1] = y;
	 x -= (TILE_CX-TILE_BW);
  } /* endfor */
  x = BOARD_FR_CX + 12*(TILE_CX-TILE_BW);
  y = BOARD_FR_CY +  (totalYTiles - 0)*(TILE_CY-TILE_BW);
  for (i=75; i<87; i++) 
  {
	 TilePos[i][0] = x;
	 TilePos[i][1] = y;
	 x -= (TILE_CX-TILE_BW);
  } /* endfor */
  /* level 2 */
  y = BOARD_FR_CY +  (totalYTiles - 6)*(TILE_CY-TILE_BW) - TILE_LD;
  for (j=0; j<6; j++) 
  {
	 x = BOARD_FR_CX + 9*(TILE_CX-TILE_BW) + TILE_LD;
	 for (i=0; i<6; i++) 
	 {
		TilePos[87+j*6+i][0] = x;
		TilePos[87+j*6+i][1] = y;
		x -= (TILE_CX-TILE_BW);
	 } /* endfor */
	 y += (TILE_CY-TILE_BW);
  } /* endfor */
  /* level 3 */
  y = BOARD_FR_CY +  (totalYTiles - 5)*(TILE_CY-TILE_BW) - 2*TILE_LD;
  for (j=0; j<4; j++) 
  {
	 x = BOARD_FR_CX + 8*(TILE_CX-TILE_BW) + 2*TILE_LD;
	 for (i=0; i<4; i++)
	 {
		TilePos[123+j*4+i][0] = x;
		TilePos[123+j*4+i][1] = y;
		x -= (TILE_CX-TILE_BW);
	 } /* endfor */
	 y += (TILE_CY-TILE_BW);
  } /* endfor */
  /* level 4 */
  y = BOARD_FR_CY +  (totalYTiles - 4)*(TILE_CY-TILE_BW) - 3*TILE_LD;
  for (j=0; j<2; j++)
  {
	 x = BOARD_FR_CX + 7*(TILE_CX-TILE_BW) + 3*TILE_LD;
	 for (i=0; i<2; i++)
	 {
		TilePos[139+j*2+i][0] = x;
		TilePos[139+j*2+i][1] = y;
		x -= (TILE_CX-TILE_BW);
	 } /* endfor */
	 y += (TILE_CY-TILE_BW);
  } /* endfor */
  /* level 5 */
  TilePos[143][0] = BOARD_FR_CX + 6*(TILE_CX-TILE_BW) + TILE_CX/2 + 4*TILE_LD;
  TilePos[143][1] = BOARD_FR_CY +
						  (totalYTiles - 3)*(TILE_CY-TILE_BW) -
						  TILE_CY/2 -  4*TILE_LD;
}

//--------------------------- InitializeDefaultTiles() ----------------------
//
// Initialize the default tiles
//
VOID InitializeDefaultTiles(VOID)
{
  int i;

  for (i=0; i<NBR_OF_TILES; i++)
  {
	 Tiles[i].iTxt      = DefTiles[i].iTxt;
	 Tiles[i].suit      = DefTiles[i].suit;
	 Tiles[i].value     = DefTiles[i].value;
	 Tiles[i].bSelected = DefTiles[i].bSelected;
	 Tiles[i].bRemoved  = DefTiles[i].bRemoved;

  }
  SelectedTile = NO_TILE;
}

//-------------------------- CreateTiles() ----------------------------------
// Create all the tile windows.

VOID CreateTiles(HWND hWnd)
{
  SHORT   cx,cy;
  int     i;

  cx = Board.cxt*(SHORT)deltaX;
  cy = Board.cyt*(SHORT)deltaX;
  for (i=0; i<NBR_OF_TILES; i++) {

	 // Tile windows are all child of main window.
	 // Store the id(i) of each child window in window data area.
	 // Each child window has predefined area to store these
	 // ids. You do not have to allocate extra space for these
	 // ids, while registering this window. Id area has -ve
	 // index, eg: GWW_ID.
	 // If WS_CLIPSIBLINGS is put then only the first level
	 // of tiles are visible. 2nd, 3rd level of tiles are
	 // drawn but not visible.

	 Tiles[i].hwnd =  CreateWindow(
		"TILE",                 	   // See RegisterClass() call.
		NULL,  								// Text for window title bar.
		WS_CHILDWINDOW|WS_CLIPSIBLINGS/*|WS_VISIBLE*/,    // Window style.
		TilePos[i][0]*(SHORT)deltaX,  // Default horizontal position.
		TilePos[i][1]*(SHORT)deltaX,  // Default vertical position.
		cx,            					// Default width.
		cy,        							// Default height.
		hWnd,                  			// Overlapped windows have parent.
		(HMENU)i,                    	// Child window id or menu handle
                                    // This instance owns this window.
		(HINSTANCE)GetWindowWord(hWnd, GWW_HINSTANCE),
		NULL
		);

	  //ShowWindow(Tiles[i].hwnd,SW_SHOWNORMAL);
	  //UpdateWindow(Tiles[i].hwnd);

	 if (Tiles[i].hwnd == NULLH)
	 {
		MessageBox(hWnd, "Cannot create the tile window !","Error", MB_OK);
		break;
	 } /* endif */
  } /* endfor */

  // You Must do this to change the Z-order of the tile windows.
  // When the tile windows are created, first the bottom most layer
  // is created, then next layer, etc. That is why the bottom most
  // tile windows will get the mouse click first, even if the upper
  // layers are displayed on top of it. To allow the top most windows
  // to get the mouse click, the top most tile windows are
  // moved ahead in the child link list of the parent using
  // SetWindowPos() funtion.

  SetWindowPos(Tiles[NBR_OF_TILES-1].hwnd,HWND_TOP,
					0,0,0,0,SWP_NOMOVE|SWP_NOSIZE|SWP_SHOWWINDOW);
  for (i=NBR_OF_TILES-1; i>0; i--)
  {
	 SetWindowPos(Tiles[i-1].hwnd,Tiles[i].hwnd,
	              0,0,0,0,SWP_NOMOVE|SWP_NOSIZE|SWP_SHOWWINDOW);
	}
}

//------------------------ShuffleTiles()------------------------------------
// Shuffle Tile Indices

VOID ShuffleTiles(VOID)
{
  short     i,j,r,cellcount,hold,save,cyclestart;
  int       k;
  unsigned multiplier;

  /* intialize to sorted order */
  for (i=0; i<NBR_OF_TILES; i++) {
	 Shuffled[i] = i;
  } /* endfor */

  { LONG    ulTime;
	 time(&ulTime);
	 srand((unsigned short)ulTime);
  }

  cellcount = NBR_OF_TILES;
  cyclestart = -1;
  while (1) {
	  do {
		 ++cyclestart;
		 if (cyclestart >= NBR_OF_TILES)
			break;;
	  } while (Shuffled[cyclestart]<0); /* enddo */
	  if (cyclestart >= NBR_OF_TILES)
		  break;
	  j = cyclestart;
	  save = Shuffled[j];
	  do {
		 hold = save;
		 frexp((double)cellcount, &k);  /* which power of 2 is cellcount? */
		 multiplier = 0x0001 << (15-k); /* form the multiplier */
		 while (multiplier * cellcount - 1 <= (r=rand()));
		 if (cellcount)
			r %= cellcount;
		 for (++r; r>0; r--) {  /* the number of cells to skip */
			do {

			  (j==(NBR_OF_TILES-1))?(j=0):(j++); /* seek an uncanceled cell */

			} while (Shuffled[j]<0); /* enddo */
		 } /* endfor */
		 save = Shuffled[j];
		 Shuffled[j] = hold | 0x8000; /* mark the cell with the sign bit */
		 cellcount--;
	  }
	  while (j!=cyclestart);
  }

  for (i=0; i<NBR_OF_TILES; i++)
	 Shuffled[i] = Shuffled[i] & 0x7fff;
}

//------------------------- TilePosIndexToIPosIndex() ----------------------
//
// This function takes the index of the TilePos array(which holds
// the tile positions (x, y), and finds the corresponding tile
// in the Tile array, it returns the index into the tile array.
//  Returns -1 if no tile is present for that value.

TilePosIndexToIPosIndex(int tIndex)
{
	for(int i= 0; i < NBR_OF_TILES; i++)
	{
	 if(Tiles[i].iPos == tIndex)
		return i;
	}
	MessageBox(HWND_DESKTOP,
	    "TilePosIndexToIPosIndex, Invalid input Index.","Error",MB_OK);
	return -1; // not found, This should not be reached.
}

//----------------------------- DealTiles() ----------------------------------
// Deal the tiles.

VOID DealTiles(HWND hWnd)
{
  int   i;
  int   cx,cy;

  cx = Board.cxt*(SHORT)deltaX;
  cy = Board.cyt*(SHORT)deltaX;

  for (i=0; i<NBR_OF_TILES; i++)
  {
	  SetWindowPos( Tiles[Shuffled[i]].hwnd, NULL,
							  0, 0, 0, 0, SWP_HIDEWINDOW);
  }

  UpdateWindow(hWnd);
  for (i=0; i<NBR_OF_TILES; i++)
  {
	 Tiles[Shuffled[i]].bSelected = FALSE;
	 Tiles[Shuffled[i]].bRemoved  = FALSE;
	 Tiles[Shuffled[i]].iPos = i;
	  if(!SetWindowPos( Tiles[Shuffled[i]].hwnd, HWND_TOP,
						sMaxAdjx + TilePos[i][0]*(SHORT)deltaX,
						sMaxAdjy + TilePos[i][1]*(SHORT)deltaX,
						cx, cy,
						SWP_SHOWWINDOW))
					 MessageBox(hWnd,"SetWindowPos()","Error",MB_OK);

  }

  SetWindowPos(Tiles[TilePosIndexToIPosIndex(NBR_OF_TILES-1)].hwnd,
					HWND_TOP,0,0,0,0,SWP_NOMOVE|SWP_NOSIZE|SWP_SHOWWINDOW);
  for (i=NBR_OF_TILES-1; i>0; i--)
  {
	 SetWindowPos(Tiles[TilePosIndexToIPosIndex(i-1)].hwnd,
					  Tiles[TilePosIndexToIPosIndex(i)].hwnd,
					  0,0,0,0,SWP_NOMOVE|SWP_NOSIZE|SWP_SHOWWINDOW);
  }

  UndoTop     = 0;
  UndoCurrent = 0;
  UndoBottom  = 0;

  NbrOfTilesRemaining = NBR_OF_TILES;
  SelectedTile = NO_TILE;
}


//-------------------------------- AboutDlgProc() ---------------------------
// About box dialog, event handling procedure.

#pragma argsused
LRESULT  CALLBACK _export AboutDlgProc (HWND hDlg,
						 UINT message, UINT wParam, LONG lParam)
{
PAINTSTRUCT ps; // Paint Struct for BeginPaint call
	  switch (message)
			 {
			 case WM_INITDIALOG:
			 {
					// Draw the bitmap.
					HDC hDC = GetDC(hDlg);
					DrawBitmap(hDC, IDB_ABOUT);
					ReleaseDC   (hDlg, hDC);

					return TRUE ;
			 }
			 case WM_PAINT:
			 {
					HDC hDC=BeginPaint(hDlg,&ps);
					DrawBitmap(hDC, IDB_ABOUT);
					EndPaint(hDlg,&ps);
					break ;
			 }
			 case WM_COMMAND:
					switch (wParam)
				  {
						case IDOK:
								 EndDialog (hDlg, IDOK) ;
								 break;
						case IDCANCEL:
								 EndDialog (hDlg, IDCANCEL) ;
								 break;
					}

					break ;
			 }
	  return FALSE ;
}

//--------------------------- DrawBitmap() ---------------------------------
//
// Draws the specified bitmap on the HDC.

DrawBitmap(HDC hDC, int Id)
{
		BITMAP  bm;
		HBITMAP hbmpOld, bitmap;

		bitmap = LoadBitmap(ghInst, MAKEINTRESOURCE(Id));
		GetObject(bitmap, sizeof(BITMAP), (LPSTR) &bm);
		//HDC hDC = GetDC(hWnd);
		HDC hMemoryDC = CreateCompatibleDC(hDC);

		hbmpOld = (HBITMAP) SelectObject(hMemoryDC, bitmap);
		BitBlt    (hDC, 0, 0, bm.bmWidth, bm.bmHeight,
					hMemoryDC, 0, 0, SRCCOPY);

		SelectObject(hMemoryDC, hbmpOld);
		DeleteDC    (hMemoryDC);
		DeleteObject(bitmap);
		return 0;
}

