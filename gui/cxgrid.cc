////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CxGrid

////////////////////////////////////////////////////////////////////////

//   Filename:  CxGrid.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   Modified:  5.3.1998 16:18 Uhr

#include	"crystalsinterface.h"
#include	"cxgrid.h"
#include	"crgrid.h"

int		CxGrid::mGridCount = kGridBase;
#ifdef __WINDOWS__
      CFont*      CxGrid::mp_font = nil;
#endif



CxGrid *	CxGrid::CreateCxGrid( CrGrid * container, CxGrid * guiParent )
{
	CxGrid  *theGrid = new CxGrid( container );
#ifdef __WINDOWS__
	theGrid->Create(NULL, "Window", WS_CHILD|WS_VISIBLE,
				    CRect(0,0,200,200), guiParent,mGridCount++,NULL);
	
	if (mp_font == nil)
	{
		LOGFONT lf;
		::GetObject(GetStockObject(DEFAULT_GUI_FONT), sizeof(LOGFONT), &lf);
		mp_font = new CFont();
		if (mp_font->CreateFontIndirect(&lf))
			theGrid->SetFont(mp_font);
		else
			ASSERT(0);
	}
	else
	{
		theGrid->SetFont(mp_font);
	}	
#endif
#ifdef __LINUX__
      theGrid->Create(guiParent,-1,wxPoint(0,0),wxSize(10,10));
#endif
	return theGrid;

}

CxGrid::CxGrid( CrGrid * container )
      : BASEGRID( ) 
{
	mWidget = container;
}

CxGrid::~CxGrid()
{
	mGridCount--;
}

void	CxGrid::SetText( char * text )
{
	NOTUSED(text);
#ifdef __POWERPC__
	Str255 descriptor;
	strcpy( reinterpret_cast<char *>(descriptor), text );
	c2pstr( reinterpret_cast<char *>(descriptor) );
	SetDescriptor( descriptor );
#endif
}

void	CxGrid::SetGeometry( int top, int left, int bottom, int right )
{
#ifdef __WINDOWS__
      MoveWindow(left,top,right-left,bottom-top,true);
#endif
#ifdef __LINUX__
      SetSize(left,top,right-left,bottom-top);
#endif
}

int   CxGrid::GetTop()
{
#ifdef __WINDOWS__
      RECT windowRect, parentRect;
	GetWindowRect(&windowRect);
	CWnd* parent = GetParent();
	if(parent != nil)
	{
		parent->GetWindowRect(&parentRect);
		windowRect.top -= parentRect.top;
	}
	return ( windowRect.top );
#endif
#ifdef __LINUX__
      wxRect windowRect, parentRect;
      windowRect = GetRect();
      wxWindow* parent = GetParent();
	if(parent != nil)
	{
            parentRect = parent->GetRect();
            windowRect.y -= parentRect.y;
	}
      return ( windowRect.y );
#endif
}
int   CxGrid::GetLeft()
{
#ifdef __WINDOWS__
      RECT windowRect, parentRect;
	GetWindowRect(&windowRect);
	CWnd* parent = GetParent();
	if(parent != nil)
	{
		parent->GetWindowRect(&parentRect);
		windowRect.left -= parentRect.left;
	}
	return ( windowRect.left );
#endif
#ifdef __LINUX__
      wxRect windowRect, parentRect;
      windowRect = GetRect();
      wxWindow* parent = GetParent();
	if(parent != nil)
	{
            parentRect = parent->GetRect();
            windowRect.x -= parentRect.x;
	}
      return ( windowRect.x );
#endif

}
int   CxGrid::GetWidth()
{
#ifdef __WINDOWS__
	CRect windowRect;
	GetWindowRect(&windowRect);
	return ( windowRect.Width() );
#endif
#ifdef __LINUX__
      wxRect windowRect;
      windowRect = GetRect();
      return ( windowRect.GetWidth() );
#endif
}
int   CxGrid::GetHeight()
{
#ifdef __WINDOWS__
	CRect windowRect;
	GetWindowRect(&windowRect);
      return ( windowRect.Height() );
#endif
#ifdef __LINUX__
      wxRect windowRect;
      windowRect = GetRect();
      return ( windowRect.GetHeight() );
#endif
}

int	CxGrid::GetIdealWidth()
{
	return (100);
}

int	CxGrid::GetIdealHeight()
{
	return (100);
}

