////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CxGrid

////////////////////////////////////////////////////////////////////////

//   Filename:  CxGrid.h
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   Modified:  5.3.1998 16:18 Uhr

#ifndef		__CxGrid_H__
#define		__CxGrid_H__
//Insert your own code here.
#include	"crguielement.h"

#ifdef __WINDOWS__
#include    <afxwin.h>
#define BASEGRID CWnd
#endif

#ifdef __LINUX__
#include <wx/control.h>
#include <wx/font.h>
#define BASEGRID wxWindow
#endif

#include	"cxradiobutton.h"

class CrGrid;
class CxGrid;

//End of user code.         
 
class CxGrid : public BASEGRID
{

// The interface exposed to the CrClass:

      public:
		static CxGrid *	CreateCxGrid( CrGrid * container, CxGrid * guiParent );
            CxGrid( CrGrid * container );
            ~CxGrid();
		void	SetText( char * text );
		void	SetGeometry( const int top, const int left, const int bottom, const int right );
		int	GetTop();
		int	GetLeft();
		int	GetWidth();
		int	GetHeight();
		int	GetIdealWidth();
		int	GetIdealHeight();

      	CrGUIElement *	mWidget;
		static int mGridCount;

#ifdef __WINDOWS__
		static CFont* mp_font;
#endif
#ifdef __LINUX__
            static wxFont* mp_font;
#endif
};
#endif
