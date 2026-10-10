// (C) Copyright 1995 by Borland International
// Tile.cpp

#include "tile.h"
//------------------------------- IsTileSelectable() -------------------------
// Is a tile selectable ?
//  Returns True if selectable else false.
//

IsTileSelectable(int id)
{
  // The tile window is not removed only made invisible.
  // that is why we will be called even if we click on the
  // invisible part.
  if (Tiles[id].bRemoved) return(FALSE);

  // No tile above the current tile ?

  if (Neighbors[Tiles[id].iPos][2] != NO_TILE) {
	 // there might be a tile above
	 if (!Tiles[Shuffled[Neighbors[Tiles[id].iPos][2]]].bRemoved) {
		// there is a tile above
		return(FALSE);
	 }
  }

  // is the place to the right or left free ?

  if (Neighbors[Tiles[id].iPos][0] == NO_TILE) {
	 return(TRUE);
  } else {
	 if (Tiles[Shuffled[Neighbors[Tiles[id].iPos][0]]].bRemoved)
	 {
		return(TRUE);
	 }
  }

  if (Neighbors[Tiles[id].iPos][1] == NO_TILE) {
	 return(TRUE);
  } else {
	 if (Tiles[Shuffled[Neighbors[Tiles[id].iPos][1]]].bRemoved) {
		return(TRUE);
	 }
  }
  return(FALSE);
}

//---------------------------- CaseWMLButtonDown() --------------------------
//
// This is the WM_LBUTTONDOWN case handler for Tile window Proc.
// "SelectedTile" is a global variable which holds the value of the selected
// tile.

static void CaseWMLButtonDown(HWND hWnd)
{
int id,ids;
id = GetWindowWord(hWnd,GWW_ID);

ids = SelectedTile;
if (ids == NO_TILE)
{
	// select this tile if possible 
	if (IsTileSelectable(id))
	{
		Tiles[id].bSelected = TRUE;
		SelectedTile = id;
		SendMessage(hWnd, WM_COMMAND, GET_WM_COMMAND_MPS(MJ_SELECT, 0, 0));
	}
	else
	{
		if(bSound) MessageBeep(-1);
	}
}
else
	if (ids == id)
	{
		// this tile is already selected -> toggle and deselect 
		SendMessage(Tiles[ids].hwnd, WM_COMMAND,
						GET_WM_COMMAND_MPS(MJ_DESELECT, 0, 0));
		SelectedTile = NO_TILE;
	}
	else
	{
		// remove the tiles if possible 
		if (IsTileSelectable(id))
		{
			// do the tiles match ? 
			if ((Tiles[ids].suit == Tiles[id].suit) &&
				(Tiles[ids].value == Tiles[id].value))
			{
				// remove the tiles 
				SendMessage(Tiles[ids].hwnd, WM_COMMAND,
								GET_WM_COMMAND_MPS(MJ_REMOVE, 0, 0));
				SendMessage(hWnd, WM_COMMAND, GET_WM_COMMAND_MPS(MJ_REMOVE, 0, 0));

				SelectedTile = NO_TILE;

				SendMessage(GetParent(hWnd), MJ_DRAW_STATUS, 0, 0);
				SendMessage(GetParent(hWnd), WM_COMMAND,
								GET_WM_COMMAND_MPS(MJ_PUSH_UNDOCMD, id, ids));
				if(bSound)
				{
												//Play Happy tune

					MessageBeep(-1);    	//Beep(100, 100);
					WasteTime(100);     	//Beep(300, 100);
					MessageBeep(-1);    	//Beep(500, 100);
					WasteTime(100);     	//Beep(700, 100);
					WasteTime(100);     	//Beep(900, 100);
					MessageBeep(-1);    	//Beep(1100,100);
					MessageBeep(-1);    	//Beep(1300,100);
					WasteTime(100);     	//Beep(1500,100);
					MessageBeep(-1);
					MessageBeep(-1);
					MessageBeep(-1);

				}
			}
			else
			{
				// the tiles did not match, deselect
				SendMessage(Tiles[ids].hwnd, WM_COMMAND,
								GET_WM_COMMAND_MPS(MJ_DESELECT, 0, 0));
				SelectedTile = NO_TILE;

			} // endif
		}
		else
		{
				if(bSound)
					MessageBeep(-1);
		} /* endif */
	} /* endif */
}

//--------------------------- TileWndProc() -----------------------------------
// Tile window procedure.

LRESULT FAR PASCAL _export TileWndProc(HWND hWnd, UINT message,
						WPARAM wParam, LPARAM lParam)
{
  PAINTSTRUCT ps; // Paint Struct for BeginPaint call

  switch (message) {
  case WM_CREATE:
  {
	  break;
	 //return NULL;
  }
  case WM_ERASEBKGND:
	// This is present to avoid painting the white
	// background, when a tile is erased or repainted.
	return(TRUE);
  case WM_PAINT:
  {
		BITMAP  bm;
		HBITMAP hbmpOld, hTileBmp;
		RECT rectl;
		int id = GetWindowWord(hWnd,GWW_ID);

		HDC hDC = BeginPaint(hWnd,&ps);
		GetClientRect(hWnd, &rectl);

		hTileBmp = LoadBitmap(ghInst,
									 MAKEINTRESOURCE(Tiles[id].iTxt+IDB_TILE_C_1));
		GetObject(hTileBmp, sizeof(BITMAP), (LPSTR) &bm);
		HDC hMemoryDC = CreateCompatibleDC(hDC);

		hbmpOld =  (HBITMAP) SelectObject(hMemoryDC, hTileBmp);

		// This paint is clipsiblings type. Which means
		// if some other bitmap is on top of you, do not
		// repaint that portion if you get a repaint message.
		// It will only ask you
		// to paint only that area which is visible to user.
		// Here you do not have to find the area.

		BitBlt     (hDC, ps.rcPaint.left,ps.rcPaint.top,
					 ps.rcPaint.right - ps.rcPaint.left,
					 ps.rcPaint.bottom - ps.rcPaint.top,
					 hMemoryDC,
					 ps.rcPaint.left , ps.rcPaint.top,
					 SRCCOPY);

		if (Tiles[id].bSelected)
		{
			 rectl.left   += 4*deltaX;
			 rectl.bottom -= 4*deltaX;
			 rectl.right  -= deltaX;
			 rectl.top    += deltaX;
			 HBRUSH hBrush = CreateHatchBrush(HS_DIAGCROSS, RGB(255,0,255));

			 for(int i = 0; i < 5; i++)
			 {
				FrameRect(hDC, &rectl, hBrush );
				InflateRect(&rectl, 1, 1);
			 }
			 DeleteObject(hBrush);
		}

		SelectObject(hMemoryDC, hbmpOld);
		DeleteDC   (hMemoryDC);
		EndPaint(hWnd,&ps);
		DeleteObject(hTileBmp);
	 }
	 break;
	 case WM_LBUTTONDOWN:
		 CaseWMLButtonDown(hWnd);
		break;

	case WM_COMMAND:
	 switch(GET_WM_COMMAND_ID(wParam, lParam))
	 {
	  case MJ_SELECT:
		{
		  int id;
		  id = GetWindowWord(hWnd,GWW_ID);
		  Tiles[id].bSelected = TRUE;
		  // You Must have 2 refresh Update and Invalidate.
		  // Other wise show moves does not work.
		  InvalidateRect(hWnd, NULL, FALSE);
		  UpdateWindow(hWnd);
		} break;
	 case MJ_DESELECT:
		{ int id;
		  id = GetWindowWord(hWnd,GWW_ID);
		  Tiles[id].bSelected = FALSE;
		  // You Must have 2 refresh Update and Invalidate.
		  // Other wise show moves does not work.

		  InvalidateRect(hWnd, NULL, FALSE);
		  UpdateWindow(hWnd);
		} break;
	 case MJ_REMOVE:
		{ int id;
		  id = GetWindowWord(hWnd,GWW_ID);
		  Tiles[id].bSelected = FALSE;
		  Tiles[id].bRemoved  = TRUE;
		  NbrOfTilesRemaining--;
		  if (NbrOfTilesRemaining == 0)
		  {
			 SendMessage(GetParent(hWnd), WM_COMMAND,
													GET_WM_COMMAND_MPS(MJ_SUCCESS, 0, 0));
		  }
		  SetWindowPos(hWnd, HWND_BOTTOM, 0,0,0,0,
							SWP_HIDEWINDOW|SWP_NOZORDER|SWP_NOACTIVATE);
		} break;
		default:
		  break;
	 }
	 break;
#if 0
  case WM_QUIT:
  case WM_DESTROY:  // message: window being destroyed
		PostQuitMessage(0);
	 break;
#endif
  default:      // Passes it on if unproccessed
	 return (DefWindowProc(hWnd, message, wParam, lParam));
  }
  return (NULL);
}
