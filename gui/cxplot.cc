////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CxPlot

////////////////////////////////////////////////////////////////////////

//   Filename:  CxPlot.cc
//   Authors:   Steven Humphreys and Richard Cooper
//   Created:   09.11.2001 22:48
//
//   $Log: not supported by cvs2svn $
//   Revision 1.23  2002/10/16 09:07:31  rich
//   Make the graphs a bit trendier.
//
//   Revision 1.22  2002/07/18 16:57:52  richard
//   Upgrade to use standard c++ library, rather than old C libraries.
//
//   Revision 1.21  2002/07/03 14:23:21  richard
//   Replace as many old-style stream class header references with new style
//   e.g. <iostream.h> -> <iostream>. Couldn't change the ones in ccstring however, yet.
//
//   Removed OnStuffToProcess message from WinApp, it doesn't compile under the new
//   stricter C++7.0 compiler. (CWinApp isn't a CWnd, so can't recieve messages?)
//
//   Removed some bits from Steve's Plot classes that were generating (harmless) compiler
//   warning messages.
//
//   Revision 1.20  2002/03/07 14:00:41  DJWgroup
//   SH: fix menus for inverted graphs.
//
//   Revision 1.19  2002/03/07 10:46:45  DJWgroup
//   SH: Change to fix reversed y axes; realign text labels.
//
//   Revision 1.18  2002/02/21 15:23:13  DJWgroup
//   SH: 1) Allocate memory for series individually (saves wasted memory if eg. straight line on Fo/Fc plot has only 2 points). 2) Fiddled with axis labels. Hopefully neater now.
//
//   Revision 1.17  2002/02/20 12:05:21  DJWgroup
//   SH: Added class to allow easier passing of mouseover information from plot classes.
//
//   Revision 1.16  2002/02/19 16:34:52  ckp2
//   Menus for plots.
//
//   Revision 1.15  2002/02/18 11:21:14  DJWgroup
//   SH: Update to plot code.
//
//   Revision 1.14  2002/01/16 10:33:13  ckp2
//   More meddling. Improved window behaviour by using default CWnd attributes
//   rather than making own WNDCLASS structure.
//
//   Revision 1.13  2002/01/16 10:03:13  ckp2
//   RC: Just meddling. Made the title bar of the key smaller.
//
//   Revision 1.12  2002/01/14 12:19:55  ckpgroup
//   SH: Various changes. Fixed scatter graph memory allocation.
//   Fixed mouse-over for scatter graphs. Updated graph key.
//
//   Revision 1.11  2002/01/08 12:40:35  ckpgroup
//   SH: Fixed memory leaks, fiddled with key text alignment.
//
//   Revision 1.10  2001/12/13 19:55:19  ckp2
//   Fix: You can't use CClientDC inside an OnPaint handler - symptom continous
//   flickering window. Use a CPaintDC instead...
//
//   Revision 1.9  2001/12/13 16:20:33  ckpgroup
//   SH: Cleaned up the key code. Now redraws correctly, although far too often.
//   Some problems with mouse-move when key is enabled. Fine when disabled.
//
//   Revision 1.8  2001/12/12 16:02:26  ckpgroup
//   SH: Reorganised script to allow right-hand y axes.
//   Added floating key if required, some redraw problems.
//
//   Revision 1.7  2001/12/03 14:25:49  ckp2
//   RIC: Bug fixes. Release version no longer crashes on mouse leave.
//
//   Revision 1.6  2001/11/26 16:47:36  ckpgroup
//   SH: More MouseOver changes. Scatterplots display the graph coordinates of the mouse pointer.
//   Remove labels when mouse leaves window.
//
//   Revision 1.5  2001/11/26 14:02:50  ckpgroup
//   SH: Added mouse-over message support - display label and data value for the bar
//   under the pointer.
//
//   Revision 1.4  2001/11/22 15:33:21  ckpgroup
//   SH: Added different draw-styles (line / area / bar / scatter).
//   Changed graph layout. Changed second series to blue for better contrast.
//
//   Revision 1.3  2001/11/19 16:32:21  ckpgroup
//   SH: General update, bug-fixes, better text alignment. Removed a lot of duplicate code.
//
//   Revision 1.2  2001/11/12 16:24:31  ckpgroup
//   SH: Graphical agreement analysis
//
//   Revision 1.1  2001/10/10 12:44:51  ckp2
//   The PLOT classes!
//

#include    "crystalsinterface.h"
#include    "ccstring.h"
#include    "cxplot.h"
#include    "cxgrid.h"
#include    "cccontroller.h"
#include    "cxwindow.h"
#include    "crplot.h"
#include    "ccpoint.h"
#include    "ccrect.h"
#include	<math.h>
#include <cstdlib>
#include <cstdio>

#ifdef __CR_WIN__
#include <direct.h>
 #include    <afxwin.h>
#endif
#ifdef __BOTHWX__
 #include <wx/font.h>
 #include <wx/thread.h>
#endif

int CxPlot::mPlotCount = kPlotBase;

CxPlot *   CxPlot::CreateCxPlot( CrPlot * container, CxGrid * guiParent )
{
#ifdef __CR_WIN__
/*    const char* wndClass = AfxRegisterWndClass(
                                    CS_HREDRAW|CS_VREDRAW,
                                    IDC_ARROW,
                                    (HBRUSH)(COLOR_MENU+1),
                                    NULL
                                    );*/

    CxPlot *theStdPlot = new CxPlot(container);
//    theStdPlot->Create(wndClass,"Plot",WS_CHILD|WS_VISIBLE|WS_CLIPCHILDREN, CRect(0,0,26,28), guiParent, mPlotCount++);
    theStdPlot->Create(NULL,"Plot",WS_CHILD|WS_VISIBLE|WS_CLIPCHILDREN, CRect(0,0,26,28), guiParent, mPlotCount++);
//    theStdPlot->ModifyStyleEx(NULL,WS_EX_CLIENTEDGE,0);
    theStdPlot->SetFont(CcController::mp_font);

    CClientDC   dc(theStdPlot);
    theStdPlot->m_memDC->CreateCompatibleDC(&dc);
    theStdPlot->m_newMemDCBitmap = new CBitmap;
    CRect rect;
    theStdPlot->GetClientRect (&rect);
    theStdPlot->m_newMemDCBitmap->CreateCompatibleBitmap(&dc,rect.Width(),rect.Height());
    theStdPlot->m_oldMemDCBitmap = theStdPlot->m_memDC->SelectObject(theStdPlot->m_newMemDCBitmap);
//    theStdPlot->m_memDC->PatBlt(0,0,rect.Width(),rect.Height(),WHITENESS);
    CBrush brush;
    brush.CreateSolidBrush(GetSysColor(COLOR_3DFACE));
    CBrush *oldBrush = theStdPlot->m_memDC->SelectObject(&brush);
    theStdPlot->m_memDC->FillRect(CRect(0,0,rect.Width(),rect.Height()),&brush);
    theStdPlot->m_memDC->SelectObject(oldBrush);
    theStdPlot->m_memDC->SelectObject(theStdPlot->m_oldMemDCBitmap);
#endif
#ifdef __BOTHWX__
    CxPlot  *theStdPlot = new CxPlot(container);
    theStdPlot->Create(guiParent,-1,wxPoint(0,0),wxSize(10,10));
    theStdPlot->m_newMemDCBitmap = new wxBitmap(10,10);
    theStdPlot->m_memDC->SelectObject(*(theStdPlot->m_newMemDCBitmap));
    theStdPlot->m_memDC->SetBrush( *wxWHITE_BRUSH );
    theStdPlot->m_memDC->Clear();
#endif
    return theStdPlot;
}

CxPlot::CxPlot(CrPlot* container)
#ifdef __CR_WIN__
    :CWnd()
#endif
#ifdef __BOTHWX__
    :wxControl()
#endif
{
	m_TextPopup = 0;
	m_Key = 0;
	m_FlippedPlot = false;
	mMouseCaptured = false;
    ptr_to_crObject = container;
#ifdef __CR_WIN__
    mfgcolour = PALETTERGB(0,0,0);
    m_memDC = new CDC();
#endif
#ifdef __BOTHWX__
    mfgcolour = wxColour(0,0,0);
    m_pen = new wxPen(mfgcolour,1,wxSOLID);
    m_brush = new wxBrush(mfgcolour,wxSOLID);
    m_memDC = new wxMemoryDC();
#endif
}

CxPlot::~CxPlot()
{
	DeletePopup();
	DeleteKey();
	mPlotCount--;
    delete m_newMemDCBitmap;
#ifdef __CR_WIN__
    delete m_memDC;
#endif
#ifdef __BOTHWX__
    delete m_memDC;
    delete m_pen;
    delete m_brush;
#endif
}

void CxPlot::CxDestroyWindow()
{
#ifdef __CR_WIN__
  DestroyWindow();
#endif
#ifdef __BOTHWX__
  Destroy();
#endif
}

void CxPlot::SetText( char * text )
{

#ifdef __BOTHWX__
      SetLabel(text);
#endif
#ifdef __CR_WIN__
    SetWindowText(text);
#endif

}

void CxPlot::FlipGraph(bool flip)
{
	m_FlippedPlot = flip;
}

CcPoint CxPlot::DeviceToLogical(int x, int y)
{
     CcPoint      newpoint;

#ifdef __CR_WIN__
//     CRect       swindowext;
//     GetClientRect(&swindowext);
     CcRect       windowext( m_client.mTop, m_client.mLeft, m_client.mBottom, m_client.mRight);
#endif
#ifdef __BOTHWX__
     wxRect wwindowext = GetRect();
     CcRect windowext( wwindowext.y, wwindowext.x, wwindowext.GetBottom(), wwindowext.GetRight());
#endif

     newpoint.x = (int)(((windowext.mRight - windowext.mLeft) * x)/2400);
     newpoint.y = ((windowext.mBottom - windowext.mTop)* y)/2400;

     return newpoint;
}

// convert to a 0-2400 scale on both axes
CcPoint CxPlot::LogicalToDevice(int x, int y)
{
	CcPoint newpoint;

#ifdef __CR_WIN__
//	CRect		windowext;
//	GetClientRect(&windowext);
	CcRect       windowext( m_client.mTop, m_client.mLeft, m_client.mBottom, m_client.mRight);
#endif
#ifdef __BOTHWX__
	wxRect wwindowext = GetRect();
	CcRect windowext(wwindowext.y, wwindowext.x, wwindowext.GetBottom(), wwindowext.GetRight());
#endif

	newpoint.x = (int)(2400*x / (windowext.mRight - windowext.mLeft));
	newpoint.y = (int)(2400*y / (windowext.mBottom - windowext.mTop));

	return newpoint;
}

void CxPlot::Display()
{
#ifdef __CR_WIN__
      InvalidateRect(NULL,false);
#endif
#ifdef __BOTHWX__
      Refresh();
#endif
}

#ifdef __CR_WIN__
void CxPlot::OnPaint()
{
	RECT winsize;
	if(m_Key) m_Key->GetWindowRect(&winsize);
	
	CPaintDC dc(this); // device context for painting
   CRect rect;
   GetClientRect (&rect);

	// remove key area from drawing...
	ValidateRect(&winsize);

    m_oldMemDCBitmap = m_memDC->SelectObject(m_newMemDCBitmap);
 //dc.BitBlt(0,0,m_client.Width(),m_client.Height(),m_memDC,0,0,SRCCOPY);
	dc.BitBlt(0,0,rect.Width(), rect.Height(),m_memDC,0,0,SRCCOPY);
    m_memDC->SelectObject(m_oldMemDCBitmap);
	if(m_Key)
	{
		m_Key->BringWindowToTop();
	}
}
#endif


#ifdef __BOTHWX__
void CxPlot::OnPaint(wxPaintEvent & event)
{
      wxPaintDC dc(this); // device context for painting
      wxRect rect = GetRect();
      dc.Blit( 0,0,rect.GetWidth(),rect.GetHeight(),m_memDC,0,0,wxCOPY,false);
}
#endif


void CxPlot::Clear()
{
#ifdef __CR_WIN__
    CRect rect;
    GetClientRect (&rect);

    m_oldMemDCBitmap = m_memDC->SelectObject(m_newMemDCBitmap);
//    m_memDC->PatBlt(0, 0, m_client.Width(), m_client.Height(), WHITENESS);
//    m_memDC->PatBlt(0, 0, rect.Width(), rect.Height(), WHITENESS);
    CBrush brush;
    brush.CreateSolidBrush(GetSysColor(COLOR_3DFACE));
    CBrush *oldBrush = m_memDC->SelectObject(&brush);
    m_memDC->FillRect(CRect(0,0,m_client.Width(),m_client.Height()),&brush);
    m_memDC->SelectObject(oldBrush);
    m_memDC->SelectObject(m_oldMemDCBitmap);
#endif
#ifdef __BOTHWX__
      m_memDC->SetBrush( *wxWHITE_BRUSH );
      m_memDC->Clear();
#endif
}

// STEVE added this function
// sets the colour to be used for drawing.
void CxPlot::SetColour(int r, int g, int b)
{
#ifdef __CR_WIN__
    mfgcolour = PALETTERGB(r,g,b);
#endif
#ifdef __BOTHWX__
    mfgcolour = wxColour(r,g,b);
#endif
}

// STEVE added a line thickness parameter
void CxPlot::DrawLine(int thickness, int x1, int y1, int x2, int y2)
{
    CcPoint cpoint1, cpoint2;

	if(m_FlippedPlot) 
	{
		y1 = 2400-y1;
		y2 = 2400-y2;
	}

    cpoint1 = DeviceToLogical(x1,y1);
    cpoint2 = DeviceToLogical(x2,y2);

#ifdef __CR_WIN__
    CPen pen(PS_SOLID,thickness,mfgcolour), *oldpen;		// changed 1 to thickness
    oldpen = m_memDC->SelectObject(&pen);
    m_oldMemDCBitmap = m_memDC->SelectObject(m_newMemDCBitmap);

    m_memDC->MoveTo(CPoint(cpoint1.x,cpoint1.y));
    m_memDC->LineTo(CPoint(cpoint2.x,cpoint2.y));
    m_memDC->SelectObject(m_oldMemDCBitmap);
    m_memDC->SelectObject(oldpen);
	pen.DeleteObject();										// added by steve - clean up resources
#endif
#ifdef __BOTHWX__
    m_memDC->SetPen( *m_pen );
    m_memDC->DrawLine(cpoint1.x,cpoint1.y,cpoint2.x,cpoint2.y);
#endif

}

void CxPlot::DrawEllipse(int x, int y, int w, int h, Boolean fill)
{
    //NB w and h are half diameters. (i.e. radii).

	if(m_FlippedPlot) 
	{
		y = 2400-y;
	}

    int x1 = x - w;
    int y1 = y - h;
    int x2 = x + w;
    int y2 = y + h;

    CcPoint topleft = DeviceToLogical(x1,y1);
    CcPoint bottomright = DeviceToLogical(x2,y2);

#ifdef __CR_WIN__
    CRgn        rgn;
    CBrush      brush, *oldbrush;
    m_oldMemDCBitmap = m_memDC->SelectObject(m_newMemDCBitmap);
    rgn.CreateEllipticRgn(topleft.x,topleft.y,bottomright.x,bottomright.y);
    brush.CreateSolidBrush(mfgcolour);
	oldbrush = (CBrush*)m_memDC->SelectObject(brush);
    if(fill)
        m_memDC->FillRgn(&rgn,&brush);
    else
        m_memDC->FrameRgn(&rgn,&brush,1,1);
    m_memDC->SelectObject(m_oldMemDCBitmap);
	m_memDC->SelectObject(oldbrush);
	brush.DeleteObject();			
#endif
#ifdef __BOTHWX__
      m_memDC->SetPen( *m_pen );
      if ( fill )
            m_memDC->SetBrush( *m_brush );
      else
            m_memDC->SetBrush( *wxTRANSPARENT_BRUSH );
      m_memDC->DrawEllipse(topleft.x,topleft.y,bottomright.x-topleft.x,bottomright.y-topleft.y);
      m_memDC->SetBrush( wxNullBrush );
#endif
}

// STEVE added the fourth parameter, to allow for justification of text
// param can be:	TEXT_VCENTRE	y is the coordinate of the CENTRE of the text
//					TEXT_HCENTRE	x is the centre coordinate
//					TEXT_RIGHT		y is the right hand side (RH justified)
//					TEXT_TOP		x is the top of the text
//					TEXT_BOTTOM		x is the bottom of the text
//					TEXT_VERTICAL   string is written one character above the next (for y axis label)
//					TEXT_VERTICALDOWN and the other way up (rh axis title)
//					TEXT_BOLD		text drawn in black (else grey)
//					TEXT_ANGLE		text is drawn at an angle (for crowded axes...)
//	All coordinates in the range 0 - 2400
void CxPlot::DrawText(int x, int y, CcString text, int param, int fontsize)
{
	if(m_FlippedPlot)
	{
		y = 2400-y;
	}

	CcPoint      coord = DeviceToLogical(x,y);

#ifdef __CR_WIN__
   CPen        pen(PS_SOLID,1,mfgcolour);
    m_oldMemDCBitmap = m_memDC->SelectObject(m_newMemDCBitmap);
    CPen        *oldpen = m_memDC->SelectObject(&pen);

    CFont  theFont;
	CFont* oldFont;
	int thickness = 400;

    char face[32] = "Times New Roman";

	if(param & TEXT_BOLD) thickness = 600;

	if(param & TEXT_ANGLE)
	{
		theFont.CreateFont(fontsize, 0, 450, 450, thickness, false, false,false, ANSI_CHARSET, OUT_DEFAULT_PRECIS,CLIP_LH_ANGLES, PROOF_QUALITY, DEFAULT_PITCH, face);
		oldFont = m_memDC->SelectObject(&theFont);
		CSize temp = m_memDC->GetTextExtent(text.ToCString(), text.Len());
		CSize move;

		move.cx = (long)(temp.cx/sqrt(2));			// must calculate effect of rotation manually. 45 deg -> 1/sqrt(2)
		move.cy = (long)(temp.cx/sqrt(2));			//		for both sin and cos.

		coord.x -= move.cx + temp.cy/2;
		coord.y += move.cy + temp.cy/2; 
	}
	else
	{
		int down = 1;

		if(param & TEXT_VERTICALDOWN)
			down = -1;	// rotate the other way if text is to be facing left

		if(param & TEXT_VERTICAL || param & TEXT_VERTICALDOWN)
		{
			theFont.CreateFont(fontsize, 0, down*900,down*900, thickness, false, false,false, ANSI_CHARSET, OUT_DEFAULT_PRECIS,CLIP_LH_ANGLES, PROOF_QUALITY, DEFAULT_PITCH, face);
			oldFont = m_memDC->SelectObject(&theFont);
			int len = text.Len();
			CSize temp = m_memDC->GetTextExtent(text.ToCString(), len);
			coord.y = coord.y + down*temp.cx/2;		// nb swapping of cx and cy - GetTextEntent doesn't handle rotations
			coord.x = coord.x - down*temp.cy/2;
		}
		else
		{
			theFont.CreateFont(fontsize, 0, 0,0, thickness, false, false,false, ANSI_CHARSET, OUT_DEFAULT_PRECIS,CLIP_LH_ANGLES, PROOF_QUALITY, DEFAULT_PITCH, face);
			oldFont = m_memDC->SelectObject(&theFont);
		}
	}

    CSize size = m_memDC->GetTextExtent(text.ToCString(), strlen(text.ToCString()));

	if(param & TEXT_VCENTRE)
	{
		  coord.y -= size.cy/2;                                                   // centre the text
	}
	if(param & TEXT_HCENTRE)
	{
		  coord.x -= size.cx/2;    
	}
	if(param & TEXT_RIGHT)
	{ 
			coord.x -= size.cx;
	}
	if(param & TEXT_TOP)
	{
			coord.y += size.cy/2;
	}
	if(param & TEXT_BOTTOM)
	{
		coord.y -= size.cy;
	}

	m_memDC->SetBkMode(TRANSPARENT);
	m_memDC->TextOut(coord.x,coord.y,text.ToCString());

    m_memDC->SelectObject(oldpen);
	pen.DeleteObject();
    m_memDC->SelectObject(oldFont);
	theFont.DeleteObject();
    m_memDC->SelectObject(m_oldMemDCBitmap);

#endif
#ifdef __BOTHWX__
      wxString wtext = wxString(text.ToCString());
      m_memDC->SetBrush( *m_brush );
      m_memDC->SetPen( *m_pen );
      m_memDC->SetBackgroundMode( wxTRANSPARENT );
      m_memDC->DrawText(wtext, coord.x, coord.y );
      m_memDC->SetBrush( wxNullBrush );
#endif
}


// get the size of a text string on screen
// NB param is same as above - only TEXT_ANGLE, TEXT_VERTICAL currently dealt with / needed
#ifdef __CR_WIN__
CcPoint CxPlot::GetTextArea(int fontsize, CcString text, int param)
{
	CcPoint tsize;
	CSize size;
	CFont theFont;
	CFont* oldFont;
    char face[32] = "Times New Roman";

	if(param & TEXT_ANGLE)
	{
		theFont.CreateFont(fontsize,0,450,450, 400,false,false,false, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_LH_ANGLES,	PROOF_QUALITY, DEFAULT_PITCH, face);
		oldFont = m_memDC->SelectObject(&theFont);

		size = m_memDC->GetOutputTextExtent(text.ToCString(), text.Len());

		tsize.x = (int)(size.cx/sqrt(2));
		tsize.y = (int)(size.cx/sqrt(2));
	}
	else if(param & TEXT_VERTICAL)
	{
		theFont.CreateFont(fontsize,0,900,900, 400,false,false,false, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_LH_ANGLES,	PROOF_QUALITY, DEFAULT_PITCH, face);
		oldFont = m_memDC->SelectObject(&theFont);

		size = m_memDC->GetOutputTextExtent(text.ToCString(), text.Len());
		tsize.x = size.cy;			// swap axes cos of the 90 degree rotation
		tsize.y = size.cx;
	}
	else
	{
		theFont.CreateFont(fontsize,0,0,0, 400,false,false,false, ANSI_CHARSET, OUT_DEFAULT_PRECIS, CLIP_LH_ANGLES,	PROOF_QUALITY, DEFAULT_PITCH, face);
		oldFont = m_memDC->SelectObject(&theFont);

		size = m_memDC->GetOutputTextExtent(text.ToCString(), text.Len());
		tsize.x = size.cx;
		tsize.y = size.cy;
	}

	m_memDC->SelectObject(oldFont);
	theFont.DeleteObject();

	return (LogicalToDevice(tsize.x, tsize.y));
}
#endif
#ifdef __BOTHWX__
CcPoint CxPlot::GetTextArea(int fontsize, CcString text, int param)
{

        int cx,cy,cs;
        GetTextExtent( text.ToCString(), &cx, &cy );

	if(param & TEXT_ANGLE)
	{
		cx = (int)(cx/sqrt(2));
		cx = (int)(cx/sqrt(2));
	}
	else if(param & TEXT_VERTICAL)
	{
		cs=cx; cx=cy; cy=cs;
	}
	return (LogicalToDevice(cx, cy));
}
#endif

void CxPlot::DrawPoly(int nVertices, int * vertices, Boolean fill)
{
#ifdef __CR_WIN__
    m_oldMemDCBitmap = m_memDC->SelectObject(m_newMemDCBitmap);
    if(fill)
    {
        CBrush      brush;
        brush.CreateSolidBrush(mfgcolour);
        CPen   pen(PS_SOLID,1,mfgcolour);

        CBrush *oldBrush = m_memDC->SelectObject(&brush);
        CPen   *oldpen = m_memDC->SelectObject(&pen);

        CcPoint*           points = new CcPoint[nVertices];
        for ( int j = 0; j < nVertices*2 ; j+=2 )
        {
			if(m_FlippedPlot)
			{
				*(vertices+j+1) = 2400 - *(vertices+j+1);
			}
            points[j/2] = DeviceToLogical( *(vertices+j), *(vertices+j+1) );
        }
        m_memDC->Polygon( (LPPOINT) points, nVertices );
        m_memDC->SelectObject(oldBrush);
		brush.DeleteObject();
        m_memDC->SelectObject(oldpen);
		pen.DeleteObject();
        delete [] points;
    }
    else
    {
//NB: If the polygon isn't filled, then it shouldn't closed.
        CPen   pen(PS_SOLID,1,mfgcolour);
        CPen   *oldpen = m_memDC->SelectObject(&pen);
        CBrush *oldBrush = (CBrush*)m_memDC->SelectStockObject(NULL_BRUSH);

        CcPoint*           points = new CcPoint[nVertices];
        for ( int j = 0; j < nVertices*2 ; j+=2 )
        {
			if(m_FlippedPlot)
			{
				*(vertices+j+1) = 2400 - *(vertices+j+1);
			}
			points[j/2] = DeviceToLogical( *(vertices+j), *(vertices+j+1) );
        }

        m_memDC->Polyline( (LPPOINT) points, nVertices );

        m_memDC->SelectObject(oldBrush);
        m_memDC->SelectObject(oldpen);
		pen.DeleteObject();
        delete [] points;
    }

    m_memDC->SelectObject(m_oldMemDCBitmap);
#endif
#ifdef __BOTHWX__
    m_memDC->SetPen( *m_pen );
    if ( fill )
         m_memDC->SetBrush( *m_brush );
    else
         m_memDC->SetBrush( *wxTRANSPARENT_BRUSH );

    CcPoint*           points = new CcPoint[nVertices];
    for ( int j = 0; j < nVertices*2 ; j+=2 )
    {
        points[j/2] = DeviceToLogical( *(vertices+j), *(vertices+j+1) );
    }
    m_memDC->DrawPolygon(nVertices, (wxPoint*) points );
    delete [] points;
    m_memDC->SetBrush( wxNullBrush );
#endif

}


CXONCHAR(CxPlot)

void CxPlot::SetIdealHeight(int nCharsHigh)
{
#ifdef __CR_WIN__
    CClientDC cdc(this);
    CFont* oldFont = cdc.SelectObject(CcController::mp_font);
    TEXTMETRIC textMetric;
    cdc.GetTextMetrics(&textMetric);
    cdc.SelectObject(oldFont);
    mIdealHeight = nCharsHigh * textMetric.tmHeight;
#endif
#ifdef __BOTHWX__
    mIdealHeight = nCharsHigh * GetCharHeight();
#endif
}

void CxPlot::SetIdealWidth(int nCharsWide)
{
#ifdef __CR_WIN__
    CClientDC cdc(this);
    CFont* oldFont = cdc.SelectObject(CcController::mp_font);
    TEXTMETRIC textMetric;
    cdc.GetTextMetrics(&textMetric);
    cdc.SelectObject(oldFont);
    mIdealWidth = nCharsWide * textMetric.tmAveCharWidth;
#endif
#ifdef __BOTHWX__
    mIdealWidth = nCharsWide * GetCharWidth();
#endif
}

void    CxPlot::SetGeometry( int top, int left, int bottom, int right )
{
#ifdef __CR_WIN__
  MoveWindow(left,top,right-left,bottom-top,true);
  m_client.Set(top,left,bottom,right);
  if(m_memDC)
  {
     delete m_newMemDCBitmap;
     CClientDC   dc(this);
     m_newMemDCBitmap = new CBitmap;
     m_newMemDCBitmap->CreateCompatibleBitmap(&dc, right-left, bottom-top);
     m_oldMemDCBitmap = m_memDC->SelectObject(m_newMemDCBitmap);
//     m_memDC->PatBlt(0, 0, right-left, bottom-top, WHITENESS);

     CBrush brush;
     brush.CreateSolidBrush(GetSysColor(COLOR_3DFACE));
     CBrush *oldBrush = m_memDC->SelectObject(&brush);
     m_memDC->FillRect(CRect(0,0,m_client.Width(),m_client.Height()),&brush);
     m_memDC->SelectObject(oldBrush);
     m_memDC->SelectObject(m_oldMemDCBitmap);

  }
  ((CrPlot*)ptr_to_crObject)->ReDrawView(false);
#endif
#ifdef __BOTHWX__

      wxClientDC   dc(this);
      
      m_memDC->SelectObject(wxNullBitmap);

      delete m_newMemDCBitmap;
      delete m_memDC;

      m_memDC = new wxMemoryDC();
      m_newMemDCBitmap = new wxBitmap(right-left, bottom-top);
      m_memDC->SelectObject(*m_newMemDCBitmap);

      m_memDC->SetBrush( *wxWHITE_BRUSH );
      m_memDC->SetPen( *wxBLACK_PEN );
      m_memDC->Clear();

      SetSize(left,top,right-left,bottom-top);

      ((CrPlot*)ptr_to_crObject)->ReDrawView(false);
	  m_client.Set(top,left,bottom,right);
#endif

}


CXGETGEOMETRIES(CxPlot)


int CxPlot::GetIdealWidth()
{
    return mIdealWidth;
}
int CxPlot::GetIdealHeight()
{
    return mIdealHeight;
}

#ifdef __CR_WIN__
//Windows Message Map
BEGIN_MESSAGE_MAP(CxPlot, CWnd)
    ON_WM_CHAR()
    ON_WM_PAINT()
    ON_WM_LBUTTONUP()
    ON_WM_RBUTTONUP()
    ON_WM_MOUSEMOVE()
   ON_COMMAND_RANGE(kMenuBase, kMenuBase+1000, OnMenuSelected)
   ON_WM_RBUTTONUP()
	ON_MESSAGE(WM_MOUSELEAVE,   OnMouseLeave)
      ON_WM_KEYDOWN()
	ON_WM_LBUTTONDOWN()
END_MESSAGE_MAP()
#endif

#ifdef __BOTHWX__
//wx Message Table
BEGIN_EVENT_TABLE(CxPlot, wxControl)
      EVT_CHAR( CxPlot::OnChar )
      EVT_PAINT( CxPlot::OnPaint )
      EVT_RIGHT_UP( CxPlot::OnRButtonUp )
      EVT_MOTION( CxPlot::OnMouseMove )
      EVT_COMMAND_RANGE(kMenuBase, kMenuBase+1000, wxEVT_COMMAND_MENU_SELECTED, CxPlot::OnMenuSelected )
END_EVENT_TABLE()
#endif


void CxPlot::Focus()
{
    SetFocus();
}

#ifdef __CR_WIN__
LRESULT CxPlot::OnMouseLeave(WPARAM wParam, LPARAM lParam)
{
	DeletePopup();
	mMouseCaptured = false;
    return TRUE;
}
#endif

// the mouse-movement code
#ifdef __CR_WIN__
// windows stuff goes here
void CxPlot::OnMouseMove( UINT nFlags, CPoint wpoint )
{
	// bool leftDown = ( (nFlags & MK_LBUTTON) != 0 );
	// bool ctrlDown = ( (nFlags & MK_CONTROL) != 0 );
	
	// convert coord to 0-2400 range
	CcPoint point = LogicalToDevice(wpoint.x,wpoint.y);

	// now some stuff to find out when the mouse leaves the window (causes a WM_MOUSE_LEAVE message (?))
	if(!mMouseCaptured)
	{
		TRACKMOUSEEVENT tme;
		tme.cbSize = sizeof(tme);
		tme.hwndTrack = m_hWnd;
		tme.dwFlags = TME_LEAVE;
		_TrackMouseEvent(&tme);
		mMouseCaptured = true;
	}
#endif

#ifdef __BOTHWX__
// and now the Linux version
void CxPlot::OnMouseMove( wxMouseEvent & event )
{
	// convert to a coordinate from 0-2400 in both axes...
	  CcPoint point = LogicalToDevice( event.m_x, event.m_y );
#endif

	  if(m_FlippedPlot) point.y = 2400-point.y;

	if(moldMPos.x != point.x || moldMPos.y != point.y)
	{	
		moldMPos = point;
	  // now we have the mouse position, get the details of any bar / scatter point below it...
	  PlotDataPopup data = ((CrPlot*)ptr_to_crObject)->GetDataFromPoint(&point); //nb: point is changed now by GetData to align with top of graph
	  point = DeviceToLogical(point.x, point.y);

		if(data.m_Valid == true)
		{
			if((moldPPos.x != point.x || moldPPos.y != point.y) || !(data.m_PopupText == moldText ))
			{
				CreatePopup(data.m_PopupText, point);
				moldPPos = point;
				moldText = data.m_PopupText;
			}
		}
		// if mouse message is not valid, remove the popup (ie catch mouse leaving window...)
		else DeletePopup();
	}
}

// remove the previously created pop-up window
void CxPlot::DeletePopup()
{
  if ( m_TextPopup )
  {
#ifdef __CR_WIN__
    m_TextPopup->DestroyWindow();
    delete m_TextPopup;
#endif
#ifdef __BOTHWX__
    m_TextPopup->Destroy();
//    m_DoNotPaint = false;
#endif
    m_TextPopup=nil;
	moldPPos.x = 0;
	moldPPos.y = 0;
  }
}

// create a pop-up window (contains details of the data-item the mouse is over)
void CxPlot::CreatePopup(CcString text, CcPoint point)
{
#ifdef __BOTHWX__
//  m_DoNotPaint = true;
#endif
  if(m_TextPopup) 
	 DeletePopup();

#ifdef __CR_WIN__
  CClientDC dc(this);
  CFont* oldFont = dc.SelectObject(CcController::mp_font);
  SIZE size = dc.GetOutputTextExtent(text.ToCString());
  dc.SelectObject(oldFont);

  m_TextPopup = new CStatic();
  m_TextPopup->Create(text.ToCString(), SS_CENTER|WS_BORDER|WS_CLIPSIBLINGS, CRect(CPoint(-size.cx-10,-size.cy-10),CSize(size.cx+4,size.cy+2)), this);
  m_TextPopup->SetFont(CcController::mp_font);
  m_TextPopup->ModifyStyleEx(NULL,WS_EX_TOPMOST,0);
  m_TextPopup->ShowWindow(SW_SHOW);
  m_TextPopup->MoveWindow(max(0,point.x-size.cx-4),max(0,point.y-size.cy-4),size.cx+4,size.cy+2, FALSE);
  m_TextPopup->InvalidateRect(NULL,false);
#endif
#ifdef __BOTHWX__
  int cx,cy;
  GetTextExtent( text.ToCString(), &cx, &cy ); //using cxmodel's DC to work out text extent before creation.
                                                   //then can create in one step.
  m_TextPopup = new mywxStaticText(this, -1, text.ToCString(),
                                 wxPoint(max(0,point.x-cx-4),max(0,point.y-cy-4)),
                                 wxSize(cx+4,cy+4),
                                 wxALIGN_CENTER|wxSIMPLE_BORDER) ;
//  m_TextPopup->SetEvtHandlerEnabled(true);

#endif

}

// create a popup window containing a key for this graph.
// numser : number of series
// names:	the series names (array of numser elements)
// col:		the series colours...
void CxPlot::CreateKey(int numser, CcString* names, int** col)
{
	if(!m_Key)
	{
		m_Key = new CxPlotKey(this, numser, names, col);
	}
	else
	{
		if(m_Key->GetNumberOfSeries() != numser)
		{
			DeleteKey();
			m_Key = new CxPlotKey(this, numser, names, col);
		}
	}
}

void CxPlot::DeleteKey()
{
  if ( m_Key )
  {
#ifdef __CR_WIN__
    m_Key->DestroyWindow();
    delete m_Key;
#endif
    m_Key=nil;
  }
}

#ifdef __BOTHWX__
void CxPlot::PrintPicture() 
{
}
void CxPlot::MakeMetaFile(int w, int h)
{
}
#endif

#ifdef __CR_WIN__
// create a wmf of the graph
void CxPlot::MakeMetaFile(int w, int h)
{
    CDC * backup_memDC = m_memDC;
    CcRect backup_m_client = m_client;

    CcString result;
    CcString defName = "plot1.emf";
    CcString extension = "*.emf";
    CcString description = "Windows Enhanced MetaFile (*.emf)";
    CcController::theController->SaveFileDialog(&result, defName, extension, description);

    if ( ! ( result == "CANCEL" ) )
    {
        CMetaFileDC mdc;

        mdc.CreateEnhanced(m_memDC, (LPCTSTR)result.ToCString(), NULL, "Plot\0");

        mdc.SetAttribDC( m_memDC->m_hAttribDC );

        m_memDC = &mdc;
        m_client.Set(0,0,w,h);

        ((CrPlot*)ptr_to_crObject)->ReDrawView(false);

        if(mdc.CloseEnhanced())
		{
			CcController::theController->ProcessOutput( "File created: {&"+result+"{&");
		}
		else
		{
			CcController::theController->ProcessOutput("File creation failed.");
		}
    }
    else
    {
        CcController::theController->ProcessOutput( "Save file cancelled.");
    }
    m_memDC = backup_memDC;
    m_client = backup_m_client;
}


// allow the user to print this graph
void CxPlot::PrintPicture() 
{

    CDC * backup_memDC = m_memDC;
    CcRect backup_m_client = m_client;
	char buffer[_MAX_PATH];
    _getcwd( buffer, _MAX_PATH ); // Get the current working directory.

 
    CDC printDC;
    CPrintDialog printDlg(FALSE);

    if (printDlg.DoModal() == IDOK)
    {


      printDC.Attach(printDlg.GetPrinterDC());
      printDC.m_bPrinting = TRUE;

      CString appName;
      appName.LoadString(AFX_IDS_APP_TITLE);

      DOCINFO di;
      ::ZeroMemory (&di, sizeof (DOCINFO));
      di.cbSize = sizeof (DOCINFO);
      di.lpszDocName = appName;

      printDC.StartDoc(&di);        // Begin print job.
      printDC.StartPage();

// Get the printing extents
     m_client.Set(0,0, printDC.GetDeviceCaps(VERTRES),
                        printDC.GetDeviceCaps(HORZRES)); 

      m_memDC = &printDC;
      ((CrPlot*)ptr_to_crObject)->ReDrawView(true);
      m_memDC = backup_memDC;
      m_client = backup_m_client;

      printDC.EndPage();
      printDC.EndDoc();
      printDC.Detach();

      CcController::theController->ProcessOutput( "Image sent to printer.");

    }


//If the users saves to a file, it is possible for them to change
//the Windows working directory. This will confuse CRYSTALS badly.
//Therefore:

    _chdir(buffer);

    return;

}
#endif

#ifdef __BOTHWX__
void CxPlot::OnRButtonUp( wxMouseEvent & event )
{
    CcPoint point = LogicalToDevice(event.m_x,event.m_y);
	
    if(m_FlippedPlot) point.y = 2400-point.y;
    ((CrPlot*)ptr_to_crObject)->ContextMenu(&point,point.x,point.y);
}
#endif
#ifdef __CR_WIN__
void CxPlot::OnRButtonUp( UINT nFlags, CPoint wpoint )
{
    CcPoint point = LogicalToDevice(wpoint.x,wpoint.y);
	
	if(m_FlippedPlot) point.y = 2400-point.y;

    ClientToScreen(&wpoint); // change the coordinates of the click from window to screen coords so that the menu appears in the right place
    ((CrPlot*)ptr_to_crObject)->ContextMenu(&point,wpoint.x,wpoint.y);
}
#endif

#ifdef __CR_WIN__
void CxPlot::OnMenuSelected(UINT nID)
{
    ((CrPlot*)ptr_to_crObject)->MenuSelected( nID );
}
#endif
#ifdef __BOTHWX__
void CxPlot::OnMenuSelected(wxCommandEvent & event)
{
      int nID = event.m_id;
     ((CrPlot*)ptr_to_crObject)->MenuSelected( nID );
}
#endif

/////////////////////////////////////////////////////////////////////////////////////////////
//
//	The CxPlotKey stuff
//
/////////////////////////////////////////////////////////////////////////////////////////////

#ifdef __CR_WIN__
// Windows message map for the key
BEGIN_MESSAGE_MAP(CxPlotKey, CWnd)
	ON_WM_PAINT()
END_MESSAGE_MAP()
#endif

#ifdef __BOTHWX__
//wx Message Table
BEGIN_EVENT_TABLE(CxPlotKey, wxControl)
      EVT_PAINT( CxPlotKey::OnPaint )
END_EVENT_TABLE()
#endif


CxPlotKey::CxPlotKey(CxPlot* parent, int numser, CcString* names, int** col)
{
#ifdef __CR_WIN__
	m_Parent = parent;
	mDragPos.x = 0;
	mDragPos.y = 0;
	mDragging = false;

	m_NumberOfSeries = numser;
	m_Names = new CcString[numser];

	m_Colours = new int*[3];

	m_Colours[0] = new int[m_NumberOfSeries];
	m_Colours[1] = new int[m_NumberOfSeries];
	m_Colours[2] = new int[m_NumberOfSeries];

	for(int i=0; i<m_NumberOfSeries; i++)
	{
		m_Names[i] = names[i];
		m_Colours[0][i] = col[0][i];
		m_Colours[1][i] = col[1][i];
		m_Colours[2][i] = col[2][i];
	}

	CcPoint point = mDragPos;

  CWnd *parw = (CWnd*)m_Parent->ptr_to_crObject->GetRootWidget()->ptr_to_cxObject;

	const char* wClass = AfxRegisterWndClass(CS_HREDRAW|CS_VREDRAW,NULL,(HBRUSH)(COLOR_MENU+1),NULL);
	
  Create(wClass, "Key", WS_VISIBLE|WS_CLIPSIBLINGS|WS_BORDER|WS_CAPTION|WS_CHILD, CRect(0,0,200,200), m_Parent, 777);
  ModifyStyleEx(NULL,WS_EX_TOOLWINDOW,NULL); //Small title bar effect.


  SetFont(CcController::mp_font);
  ShowWindow(SW_SHOW);

  CClientDC newDC(this);
  CFont* oldFont = newDC.SelectObject(CcController::mp_font);  

  SIZE size;
  size.cx = 10; //Reasonable minimum size.
  size.cy = 10; //Reasonable minimum size.

	for(i=0; i<m_NumberOfSeries; i++)
	{
		SIZE ts = newDC.GetOutputTextExtent(m_Names[i].ToCString());
		size.cx = max(ts.cx, size.cx);
		size.cy = max(ts.cy, size.cy);
	}

	// get the client window size, and the total window size
	RECT clientsize;
	RECT windowsize;
	GetClientRect(&clientsize);
	GetWindowRect(&windowsize);

	SetWindowPos( &wndTopMost , 0,0,0,0, SWP_NOMOVE|SWP_NOSIZE);

	// now calculate the required size (including title bar)
	size.cy *= m_NumberOfSeries;
	size.cy += windowsize.bottom - windowsize.top - clientsize.bottom;
	size.cx += 20;
	size.cx += windowsize.right - windowsize.left - clientsize.right;

	// set the required size
	MoveWindow(0,0, size.cx, size.cy, TRUE);

	// get the new client area, and store this.
	GetClientRect(&clientsize);

	m_WinPosAndSize.mLeft = 0;
	m_WinPosAndSize.mRight = clientsize.right;//size.cx;
	m_WinPosAndSize.mTop = 0;
	m_WinPosAndSize.mBottom = clientsize.bottom;//size.cy;

  newDC.SelectObject(oldFont);

#endif
}

CxPlotKey::~CxPlotKey()
{
	delete [] m_Colours[0];
	delete [] m_Colours[1];
	delete [] m_Colours[2];

	delete [] m_Names;
	delete [] m_Colours;
}

#ifdef __BOTHWX__
void CxPlotKey::OnPaint(wxPaintEvent & event)
{ 
}
#endif

#ifdef __CR_WIN__
void CxPlotKey::OnPaint()
{

  SIZE size;
  size.cx = m_WinPosAndSize.mRight;
  size.cy = m_WinPosAndSize.mBottom;

  CPaintDC newDC(this);
  COLORREF col = newDC.GetBkColor();
  CFont* oldFont = newDC.SelectObject(CcController::mp_font); 
  newDC.SetBkColor(col);

  newDC.PatBlt(0,0,size.cx, size.cy, WHITENESS);
  
  CcPoint* temp = new CcPoint[5];

  for(int i=0; i<m_NumberOfSeries; i++)
  {
	  temp[0].x = 3;				temp[0].y = i*size.cy/m_NumberOfSeries + 3;
	  temp[1].x = 3;				temp[1].y = (i+1)*size.cy/m_NumberOfSeries - 3;
	  temp[2].x = 12;				temp[2].y = (i+1)*size.cy/m_NumberOfSeries- 3;
	  temp[3].x = 12;				temp[3].y = i*size.cy/m_NumberOfSeries + 3;
	  temp[4].x = 3;				temp[4].y = i*size.cy/m_NumberOfSeries + 3;

        CBrush      brush;
        brush.CreateSolidBrush(PALETTERGB(m_Colours[0][i],m_Colours[1][i],m_Colours[2][i]));
        CPen   pen(PS_SOLID,1,PALETTERGB(m_Colours[0][i],m_Colours[1][i],m_Colours[2][i]));

        CBrush *oldBrush = newDC.SelectObject(&brush);
        CPen   *oldpen = newDC.SelectObject(&pen);

        newDC.Polygon( (LPPOINT) temp, 5);
        newDC.SelectObject(oldBrush);
		brush.DeleteObject();
        newDC.SelectObject(oldpen);
		pen.DeleteObject();

	  newDC.TextOut(20, i*size.cy/m_NumberOfSeries, m_Names[i].ToCString());
  }

  delete [] temp;
  newDC.SelectObject(oldFont);

}
#endif

