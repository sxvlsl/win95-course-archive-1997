// (C) Copyright 1995 by Borland International
// Mahjongg.h

#ifndef __MAHJONGG_H
#define __MAHJONGG_H

#define STRICT

#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <commdlg.h>
#include "mahjongg.rh"

LRESULT FAR PASCAL _export MainWndProc(HWND, UINT, WPARAM, LPARAM);
BOOL InitApplication(HINSTANCE);
LRESULT FAR PASCAL _export TileWndProc(HWND hWnd, UINT message,
						WPARAM wParam, LPARAM lParam);

#endif
