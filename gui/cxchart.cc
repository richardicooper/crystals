////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CxChart

////////////////////////////////////////////////////////////////////////

//   Filename:  CxChart.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   $Log: not supported by cvs2svn $
//   Revision 1.10  2001/03/08 16:44:07  richard
//   General changes - replaced common functions in all GUI classes by macros.
//   Generally tidied up, added logs to top of all source files.
//

#include    "crystalsinterface.h"
#include    "ccstring.h"
#include    "cxchart.h"
#include    "cxgrid.h"
#include    "cccontroller.h"
#include    "cxwindow.h"
#include    "crchart.h"
#include    "ccpoint.h"
#include    "ccrect.h"
#ifdef __CR_WIN__
#include    <afxwin.h>
#endif
#ifdef __BOTHWX__
#include <wx/font.h>
#endif

int CxChart::mChartCount = kChartBase;
//End of user code.

// OPSignature: CxChart * CxChart:CreateCxChart( CrChart *:container  CxGrid *:guiParent )
CxChart *   CxChart::CreateCxChart( CrChart * container, CxGrid * guiParent )
{
#ifdef __CR_WIN__
    const char* wndClass = AfxRegisterWndClass(
                                    CS_HREDRAW|CS_VREDRAW,
                                    NULL,
                                    (HBRUSH)(COLOR_MENU+1),
                                    NULL
                                    );

    CxChart *theStdChart = new CxChart(container);
    theStdChart->Create(wndClass,"Chart",WS_CHILD| WS_VISIBLE, CRect(0,0,26,28), guiParent, mChartCount++);
    theStdChart->ModifyStyleEx(NULL,WS_EX_CLIENTEDGE,0);
    theStdChart->SetFont(CcController::mp_font);

    CClientDC   dc(theStdChart);
    theStdChart->memDC.CreateCompatibleDC(&dc);
    theStdChart->newMemDCBitmap = new CBitmap;
    CRect rect;
    theStdChart->GetClientRect (&rect);
    theStdChart->newMemDCBitmap->CreateCompatibleBitmap(&dc,rect.Width(),rect.Height());
    theStdChart->oldMemDCBitmap = theStdChart->memDC.SelectObject(theStdChart->newMemDCBitmap);
    theStdChart->memDC.PatBlt(0,0,rect.Width(),rect.Height(),WHITENESS);
    theStdChart->memDC.SelectObject(theStdChart->oldMemDCBitmap);
#endif
#ifdef __BOTHWX__
      CxChart  *theStdChart = new CxChart(container);
      theStdChart->Create(guiParent,-1,wxPoint(0,0),wxSize(10,10));
      theStdChart->newMemDCBitmap = new wxBitmap;
#endif
    return theStdChart;
}

CxChart::CxChart(CrChart* container)
#ifdef __CR_WIN__
    :CWnd()
#endif
#ifdef __BOTHWX__
      :wxControl()
#endif
{
    ptr_to_crObject = container;
#ifdef __CR_WIN__
    mfgcolour = PALETTERGB(0,0,0);
#endif
#ifdef __BOTHWX__
    mfgcolour = wxColour(0,0,0);
    m_pen = new wxPen(mfgcolour,1,wxSOLID);
    m_brush = new wxBrush(mfgcolour,wxSOLID);
#endif
    mPolyMode = 0;
    m_IsoCoords = true;
    m_inverted = false;
    m_SendCursorKeys = false;
}

CxChart::~CxChart()
{
    mChartCount--;
    delete newMemDCBitmap;
#ifdef __BOTHWX__
    delete m_pen;
    delete m_brush;
#endif
}

void CxChart::CxDestroyWindow()
{
  #ifdef __CR_WIN__
DestroyWindow();
#endif
#ifdef __BOTHWX__
Destroy();
#endif
}

void    CxChart::SetText( char * text )
{

#ifdef __POWERPC__
    Str255 descriptor;

    strcpy( reinterpret_cast<char *>(descriptor), text );
    c2pstr( reinterpret_cast<char *>(descriptor) );
    SetDescriptor( descriptor );
#endif
#ifdef __BOTHWX__
      SetLabel(text);
#endif
#ifdef __CR_WIN__
    SetWindowText(text);
#endif

}

void    CxChart::SetGeometry( int top, int left, int bottom, int right )
{
#ifdef __CR_WIN__
  MoveWindow(left,top,right-left,bottom-top,true);
  if(memDC != NULL)
  {
     delete newMemDCBitmap;
     CClientDC   dc(this);
     newMemDCBitmap = new CBitmap;
     newMemDCBitmap->CreateCompatibleBitmap(&dc, right-left, bottom-top);
     oldMemDCBitmap = memDC.SelectObject(newMemDCBitmap);
     memDC.PatBlt(0, 0, right-left, bottom-top, WHITENESS);
     memDC.SelectObject(oldMemDCBitmap);
  }
  ((CrChart*)ptr_to_crObject)->ReDrawView();
#endif
#ifdef __BOTHWX__
      SetSize(left,top,right-left,bottom-top);
      delete newMemDCBitmap;
      wxClientDC   dc(this);
      newMemDCBitmap = new wxBitmap(right-left, bottom-top);
      memDC.SelectObject(*newMemDCBitmap);
      memDC.Clear();
      memDC.SelectObject(wxNullBitmap);
      ((CrChart*)ptr_to_crObject)->ReDrawView();
#endif

}

CXGETGEOMETRIES(CxChart)


int CxChart::GetIdealWidth()
{
    return mIdealWidth;
}
int CxChart::GetIdealHeight()
{
    return mIdealHeight;
}

#ifdef __CR_WIN__
//Windows Message Map
BEGIN_MESSAGE_MAP(CxChart, CWnd)
    ON_WM_CHAR()
    ON_WM_PAINT()
    ON_WM_LBUTTONUP()
    ON_WM_RBUTTONUP()
    ON_WM_MOUSEMOVE()
      ON_WM_KEYDOWN()
END_MESSAGE_MAP()
#endif
#ifdef __BOTHWX__
//wx Message Table
BEGIN_EVENT_TABLE(CxChart, wxControl)
      EVT_CHAR( CxChart::OnChar )
      EVT_KEY_DOWN( CxChart::OnKeyDown )
      EVT_PAINT( CxChart::OnPaint )
      EVT_LEFT_UP( CxChart::OnLButtonUp )
      EVT_RIGHT_UP( CxChart::OnRButtonUp )
      EVT_MOTION( CxChart::OnMouseMove )
END_EVENT_TABLE()
#endif


void CxChart::Focus()
{
    SetFocus();
}


CXONCHAR(CxChart)

void CxChart::DrawLine(int x1, int y1, int x2, int y2)
{
      CcPoint cpoint1, cpoint2;
      cpoint1 = DeviceToLogical(x1,y1);
      cpoint2 = DeviceToLogical(x2,y2);

#ifdef __CR_WIN__
    CPen pen(PS_SOLID,1,mfgcolour), *oldpen;
    oldpen = memDC.SelectObject(&pen);
    oldMemDCBitmap = memDC.SelectObject(newMemDCBitmap);

    memDC.MoveTo(CPoint(cpoint1.x,cpoint1.y));
    memDC.LineTo(CPoint(cpoint2.x,cpoint2.y));
    memDC.SelectObject(oldMemDCBitmap);
    memDC.SelectObject(oldpen);
#endif

#ifdef __BOTHWX__
    memDC.SetPen( *m_pen );
    memDC.SelectObject( *newMemDCBitmap );
    memDC.DrawLine(cpoint1.x,cpoint1.y,cpoint2.x,cpoint2.y);
    memDC.SetPen( wxNullPen );
    memDC.SelectObject( wxNullBitmap );
#endif

}


CcPoint CxChart::DeviceToLogical(int x, int y)
{
      CcPoint      newpoint;
      float        aspectratio, windowratio;

#ifdef __CR_WIN__
      CRect       wwindowext;
      GetClientRect(&wwindowext);
      CcRect       windowext( wwindowext.top, wwindowext.left, wwindowext.bottom, wwindowext.right);
#endif
#ifdef __BOTHWX__
      wxRect wwindowext = GetRect();
      CcRect windowext( wwindowext.y, wwindowext.x, wwindowext.GetBottom(), wwindowext.GetRight());
#endif

    aspectratio = 1;

      windowratio = (float)windowext.mRight / (float)windowext.mBottom;

    if(m_IsoCoords)
    {
        if (aspectratio > windowratio)    //The x coords are okay, ycoords must be
        {                                 //centered and scaled.
                  newpoint.x = (int)((windowext.mRight * x)/(2400*aspectratio));
                  newpoint.y = (int)((windowext.mRight * y)/(2400*aspectratio));
                  newpoint.y = (int)(newpoint.y + ((windowext.mBottom-windowext.mRight)/2*aspectratio));
        }
        else if (aspectratio < windowratio)    //The y coords are okay, xcoords must be
        {                                     //centered and scaled.
                  newpoint.y = (windowext.mBottom * y) / 2400;
                  newpoint.x = (windowext.mBottom * x) / 2400;
                  newpoint.x = (int)(newpoint.x + ((windowext.mRight- aspectratio*windowext.mBottom)/2));
        }
        else
        {
                  newpoint.x = (int)((windowext.mRight * x)/(2400*aspectratio));
                  newpoint.y = (windowext.mBottom * y)/2400;
        }
    }
    else
    {
                  newpoint.x = (int)((windowext.mRight * x)/2400);
                  newpoint.y = (windowext.mBottom * y)/2400;
    }

    return newpoint;
}

CcPoint CxChart::LogicalToDevice(CcPoint point)
{
      CcPoint     newpoint;
    float       aspectratio, windowratio;

#ifdef __CR_WIN__
      CRect       wwindowext;
      GetClientRect(&wwindowext);
      CcRect       windowext( wwindowext.top, wwindowext.left, wwindowext.bottom, wwindowext.right);
#endif
#ifdef __BOTHWX__
      wxRect wwindowext = GetRect();
      CcRect windowext( wwindowext.y, wwindowext.x, wwindowext.GetBottom(), wwindowext.GetRight());
#endif

    aspectratio = 1;

      windowratio = (float)windowext.mRight / (float)windowext.mBottom;

    if (aspectratio > windowratio)    //The x coords are okay, ycoords must be
    {                                 //centered and scaled.
            newpoint.x = (int) ( (point.x*2400*aspectratio) / windowext.mRight );
            point.y -= (int)((windowext.mBottom-windowext.mRight)/2*aspectratio);
            newpoint.y = (int) ( (point.y*2400*aspectratio) / windowext.mRight );
    }
    else if (aspectratio < windowratio)    //The y coords are okay, xcoords must be
    {                                     //centered and scaled.
            newpoint.y = (int) ( (point.y*2400) / windowext.mBottom );
            point.x -= (int)((windowext.mRight- aspectratio*windowext.mBottom)/2);
            newpoint.x = (int) ( (point.x*2400) / windowext.mBottom );
    }
    else
    {
            newpoint.x = (int) ( (point.x*2400*aspectratio) / windowext.mRight );
            newpoint.y = (int) ( (point.y*2400) / windowext.mBottom );
    }

    return newpoint;
}

void CxChart::Display()
{
#ifdef __CR_WIN__
      InvalidateRect(NULL,false);
#endif
#ifdef __BOTHWX__
      Refresh();
#endif
}

#ifdef __CR_WIN__
void CxChart::OnPaint()
{
    CPaintDC dc(this); // device context for painting

    CRect rect;
    GetClientRect (&rect);

    oldMemDCBitmap = memDC.SelectObject(newMemDCBitmap);

    dc.BitBlt(0,0,rect.Width(),rect.Height(),&memDC,0,0,SRCCOPY);

    memDC.SelectObject(oldMemDCBitmap);

    if(m_inverted)
    {
        CRect rect;
        GetClientRect(&rect);
        dc.InvertRect(rect);
    }
// Do not call CFrameWnd::OnPaint() for painting messages
}
#endif

#ifdef __BOTHWX__
void CxChart::OnPaint(wxPaintEvent & event)
{
      wxPaintDC dc(this); // device context for painting

      wxRect rect = GetRect();

      memDC.SelectObject(*newMemDCBitmap);

      dc.Blit( 0,0,rect.GetWidth(),rect.GetHeight(),&memDC,0,0,wxCOPY,false);

      memDC.SelectObject(wxNullBitmap);

    if(m_inverted)
    {
            wxRect rect = GetRect();
            dc.Blit( 0,0,rect.GetWidth(),rect.GetHeight(),NULL,0,0,wxINVERT,false);
    }
}
#endif



void CxChart::SetIdealHeight(int nCharsHigh)
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

void CxChart::SetIdealWidth(int nCharsWide)
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





void CxChart::Clear()
{
#ifdef __CR_WIN__
    CRect rect;
    GetClientRect (&rect);
    oldMemDCBitmap = memDC.SelectObject(newMemDCBitmap);
    memDC.PatBlt(0, 0, rect.Width(), rect.Height(), WHITENESS);
    memDC.SelectObject(oldMemDCBitmap);
#endif
#ifdef __BOTHWX__
      memDC.SelectObject(*newMemDCBitmap);
      memDC.Clear();
      memDC.SelectObject(wxNullBitmap);
#endif
}

void CxChart::DrawEllipse(int x, int y, int w, int h, Boolean fill)
{

    //NB w and h are half diameters. (i.e. radii).

    int x1 = x - w;
    int y1 = y - h;
    int x2 = x + w;
    int y2 = y + h;

    CcPoint topleft = DeviceToLogical(x1,y1);
    CcPoint bottomright = DeviceToLogical(x2,y2);


#ifdef __CR_WIN__
    CRgn        rgn;
    CBrush      brush;
    oldMemDCBitmap = memDC.SelectObject(newMemDCBitmap);
    rgn.CreateEllipticRgn(topleft.x,topleft.y,bottomright.x,bottomright.y);
    brush.CreateSolidBrush(mfgcolour);
    if(fill)
        memDC.FillRgn(&rgn,&brush);
    else
        memDC.FrameRgn(&rgn,&brush,1,1);
    memDC.SelectObject(oldMemDCBitmap);
#endif
#ifdef __BOTHWX__

      memDC.SelectObject(*newMemDCBitmap);
      memDC.SetPen( *m_pen );
      if ( fill )
            memDC.SetBrush( *m_brush );
      else
            memDC.SetBrush( *wxTRANSPARENT_BRUSH );
      memDC.DrawEllipse(topleft.x,topleft.y,bottomright.x-topleft.x,bottomright.y-topleft.y);
      memDC.SetPen( wxNullPen );
      memDC.SetBrush( wxNullBrush );
      memDC.SelectObject(wxNullBitmap);
#endif
}


void CxChart::DrawText(int x, int y, CcString text)
{
      CcPoint      coord = DeviceToLogical(x,y);
#ifdef __CR_WIN__
    CPen        pen(PS_SOLID,1,mfgcolour);
    oldMemDCBitmap = memDC.SelectObject(newMemDCBitmap);
    CPen        *oldpen = memDC.SelectObject(&pen);
    CFont       *oldFont = memDC.SelectObject(CcController::mp_font);
    memDC.SetBkMode(TRANSPARENT);
    memDC.TextOut(coord.x,coord.y,text.ToCString());
    memDC.SelectObject(oldpen);
    memDC.SelectObject(oldFont);
    memDC.SelectObject(oldMemDCBitmap);
#endif
#ifdef __BOTHWX__
      wxString wtext = wxString(text.ToCString());
      memDC.SelectObject(*newMemDCBitmap);
      memDC.SetBackgroundMode( wxTRANSPARENT );
      memDC.SetPen( *m_pen );
      memDC.DrawText(wtext, coord.x, coord.y );
      memDC.SetPen( wxNullPen );
      memDC.SelectObject(wxNullBitmap);
#endif
}

void CxChart::DrawPoly(int nVertices, int * vertices, Boolean fill)
{
#ifdef __CR_WIN__
      oldMemDCBitmap = memDC.SelectObject(newMemDCBitmap);
    if(fill)
    {
        CBrush      brush;
        brush.CreateSolidBrush(mfgcolour);
            CPen   pen(PS_SOLID,1,mfgcolour);

            CBrush *oldBrush = memDC.SelectObject(&brush);
            CPen   *oldpen = memDC.SelectObject(&pen);

            CcPoint*           points = new CcPoint[nVertices];
        for ( int j = 0; j < nVertices*2 ; j+=2 )
        {
            points[j/2] = DeviceToLogical( *(vertices+j), *(vertices+j+1) );
        }
            memDC.Polygon( (LPPOINT) points, nVertices );
            memDC.SelectObject(oldBrush);
            memDC.SelectObject(oldpen);
            delete [] points;
    }
      else
      {
//NB: If the polygon isn't filled, then it shouldn't closed.
        CPen   pen(PS_SOLID,1,mfgcolour);
        CPen   *oldpen = memDC.SelectObject(&pen);
        CBrush *oldBrush = (CBrush*)memDC.SelectStockObject(NULL_BRUSH);

        CcPoint*           points = new CcPoint[nVertices];
        for ( int j = 0; j < nVertices*2 ; j+=2 )
        {
            points[j/2] = DeviceToLogical( *(vertices+j), *(vertices+j+1) );
        }

        memDC.Polyline( (LPPOINT) points, nVertices );

        memDC.SelectObject(oldBrush);
        memDC.SelectObject(oldpen);
        delete [] points;
      }

      memDC.SelectObject(oldMemDCBitmap);
#endif
#ifdef __BOTHWX__
      memDC.SelectObject(*newMemDCBitmap);
      memDC.SetPen( *m_pen );
      if ( fill )
            memDC.SetBrush( *m_brush );
      else
            memDC.SetBrush( *wxTRANSPARENT_BRUSH );
      CcPoint*           points = new CcPoint[nVertices];
      for ( int j = 0; j < nVertices*2 ; j+=2 )
      {
            points[j/2] = DeviceToLogical( *(vertices+j), *(vertices+j+1) );
      }
      memDC.DrawPolygon(nVertices, (wxPoint*) points );
      delete [] points;
      memDC.SetPen( wxNullPen );
      memDC.SetBrush( wxNullBrush );
      memDC.SelectObject(wxNullBitmap);
#endif

}

/* OLD CODE FROM ANOTHER PROJECT FOR REFERENCE
void CGraphWnd::drawpolygon(int i)
{
//  CClientDC   graphDC(this);
    CRgn        rgn;
    CBrush      brush;
      CcPoint            points[1000];
    int j;

    for ( j = 0; j < wgraphcommands[i+1] - 2 ; j=j+2)
            points[j/2] = deviceToLogical(wgraphcommands[i+j+2],wgraphcommands[i+j+3]);
    rgn.CreatePolygonRgn((LPPOINT) &points,(wgraphcommands[i+1]-2)/2,WINDING);
    brush.CreateSolidBrush(fgcolour);
    memDC.FillRgn(&rgn,&brush);

    //or    graphDC.Polygon(points, wgrap....);
}

void CGraphWnd::drawemptypolygon(int i) //NB Empty polygon is not closed (should be calld POLYLINE)
{
//  CClientDC   graphDC(this);
    CPen        pen(PS_SOLID,1,fgcolour);
    CPen        *oldpen;

    oldpen = memDC.SelectObject(&pen);
    memDC.MoveTo(deviceToLogical(wgraphcommands[i+2],wgraphcommands[i+3]));

    for (int j = 2; j < wgraphcommands[i+1] - 2 ; j=j+2)
        memDC.LineTo(deviceToLogical(wgraphcommands[i+j+2],wgraphcommands[i+j+3]));

    memDC.SelectObject(oldpen);

}

*/

void CxChart::SetColour(int r, int g, int b)
{
#ifdef __CR_WIN__
    mfgcolour = PALETTERGB(r,g,b);
//  TRACE("CxChart SetColour to: %d, %d, %d \n",r,g,b);
#endif
#ifdef __BOTHWX__
      mfgcolour = wxColour ( r,g,b );
      m_pen->SetColour ( mfgcolour );
      m_brush->SetColour ( mfgcolour );
#endif
}

#ifdef __CR_WIN__
void CxChart::OnLButtonUp( UINT nFlags, CPoint wpoint )
{
      CcPoint point(wpoint.x, wpoint.y);
#endif
#ifdef __BOTHWX__
void CxChart::OnLButtonUp( wxMouseEvent & event )
{
      CcPoint point ( event.m_x, event.m_y );
#endif

      CcPoint devPoint = LogicalToDevice(point);
    ((CrChart*)ptr_to_crObject)->LMouseClick(devPoint.x, devPoint.y);

    if (mPolyMode == 2)
    {
    //Add a point, set new last point coords
            mLastPolyModePoint = point;
    }
    else if (mPolyMode == 1)
    {
    //Add first point, set mode to 2, set last point coords.
            mLastPolyModePoint = point;
            mCurrentPolyModeLineEndPoint = point;
            mStartPolyModePoint = point;
        mPolyMode = 2;
    }
    else if (mPolyMode == 3)
    {
    //Add last point, set mode to 0, restore cursor.
            mLastPolyModePoint = point;
        mPolyMode = 0;

#ifdef __CR_WIN__
            HCURSOR arrow = LoadCursor(NULL,IDC_ARROW);
        SetCursor(arrow);
        ((CrChart*)ptr_to_crObject)->PolygonClosed();
//            OnPaint();
            InvalidateRect(NULL,false);
#endif
#ifdef __BOTHWX__
            wxCursor arrow ( wxCURSOR_ARROW );
        SetCursor(arrow);
        ((CrChart*)ptr_to_crObject)->PolygonClosed();
            Refresh();
#endif

    }

}


void CxChart::SetPolygonDrawMode(Boolean on)
{
    //If the user closes the polygon, the area is returned as an array
    //with the first element as the number of vertices, followed by all
    //the vertices.

    //If the user types a key, or clicks the right mouse button before the
    //polygon is closed, then NULL is returned.

    if(on)
    {
        mPolyMode = 1;
#ifdef __CR_WIN__
            HCURSOR cross = LoadCursor(NULL,IDC_CROSS);
#endif
#ifdef __BOTHWX__
            wxCursor cross ( wxCURSOR_CROSS );
#endif
        SetCursor(cross);
    }
    else
    {
        mPolyMode = 0;
#ifdef __CR_WIN__
        HCURSOR arrow = LoadCursor(NULL,IDC_ARROW);
#endif
#ifdef __BOTHWX__
            wxCursor arrow ( wxCURSOR_ARROW );
#endif
        SetCursor(arrow);
    }
}


#ifdef __CR_WIN__
void CxChart::OnMouseMove( UINT nFlags, CPoint wpoint )
{
      CcPoint point(wpoint.x, wpoint.y);
#endif
#ifdef __BOTHWX__
void CxChart::OnMouseMove( wxMouseEvent & event )
{
      CcPoint point ( event.m_x, event.m_y );
#endif

    //If mode is 2 then change to 3 if closing.
    //If not closing and mode is 3, then change to 2.
    if (mPolyMode >= 2)
    {
        if( ( abs(point.x - mStartPolyModePoint.x) < 10) && ( abs(point.y - mStartPolyModePoint.y) < 10) )
        {
#ifdef __CR_WIN__
            HCURSOR cross = LoadCursor(NULL,IDC_ARROW);
//                  HCURSOR cross = LoadCursor(AfxGetApp()->m_hInstance,MAKEINTRESOURCE( IDC_CURSOR2 ));
#endif
#ifdef __BOTHWX__
                  wxCursor cross ( wxCURSOR_BULLSEYE );
#endif
            SetCursor(cross);
            mPolyMode = 3;
        }
        else
        {
#ifdef __CR_WIN__
            HCURSOR arrow = LoadCursor(NULL,IDC_CROSS);
//                  HCURSOR arrow = LoadCursor(AfxGetApp()->m_hInstance,MAKEINTRESOURCE( IDC_CURSOR1));
#endif
#ifdef __BOTHWX__
                  wxCursor arrow ( wxCURSOR_CROSS );
#endif
                  SetCursor(arrow);
            mPolyMode = 2;
        }

        //Erase the old line.
#ifdef __CR_WIN__
        CClientDC dc(this); // device context for painting
        CRgn oldrgn, newrgn;
#endif
#ifdef __BOTHWX__
            wxClientDC dc(this); // device context for painting
#endif

            CcPoint points[4];
        points[0] = mLastPolyModePoint;
        points[1] = mCurrentPolyModeLineEndPoint;
        points[2].x = mCurrentPolyModeLineEndPoint.x + 2;
        points[2].y = mCurrentPolyModeLineEndPoint.y + 2;
        points[3].x = mLastPolyModePoint.x + 2;
        points[3].y = mLastPolyModePoint.y + 2;

#ifdef __CR_WIN__
            oldrgn.CreatePolygonRgn((LPPOINT) points, 4, ALTERNATE);
        dc.InvertRgn(&oldrgn);
#endif
#ifdef __BOTHWX__

#endif

            mCurrentPolyModeLineEndPoint = CcPoint(point.x,point.y);
        points[0] = mLastPolyModePoint;
        points[1] = mCurrentPolyModeLineEndPoint;
        points[2].x = mCurrentPolyModeLineEndPoint.x + 2;
        points[2].y = mCurrentPolyModeLineEndPoint.y + 2;
        points[3].x = mLastPolyModePoint.x + 2;
        points[3].y = mLastPolyModePoint.y + 2;

#ifdef __CR_WIN__
            newrgn.CreatePolygonRgn((LPPOINT) points, 4, ALTERNATE);
        dc.InvertRgn(&newrgn);
#endif
    }
    else if(mPolyMode == 1)
    {
#ifdef __CR_WIN__
            HCURSOR cross = LoadCursor(NULL,IDC_CROSS);
//            HCURSOR cross = LoadCursor(AfxGetApp()->m_hInstance,MAKEINTRESOURCE( IDC_CURSOR1));
#endif
#ifdef __BOTHWX__
            wxCursor cross ( wxCURSOR_CROSS );
#endif
        SetCursor(cross);
    }
    else
    {
#ifdef __CR_WIN__
        HCURSOR cross = LoadCursor(NULL, IDC_ARROW);
#endif
#ifdef __BOTHWX__
            wxCursor cross ( wxCURSOR_ARROW );
#endif
        SetCursor(cross);
    }
}


#ifdef __CR_WIN__
void CxChart::OnRButtonUp( UINT nFlags, CPoint wpoint )
#endif
#ifdef __BOTHWX__
void CxChart::OnRButtonUp( wxMouseEvent & event )
#endif
{
    if (mPolyMode != 0)
    {
        mPolyMode = 0;
#ifdef __CR_WIN__
        HCURSOR arrow = LoadCursor(NULL,IDC_ARROW);
#endif
#ifdef __BOTHWX__
            wxCursor arrow ( wxCURSOR_ARROW );
#endif
        SetCursor(arrow);
        ((CrChart*)ptr_to_crObject)->PolygonCancelled();
    }
}

void CxChart::UseIsotropicCoords(Boolean iso)
{
    m_IsoCoords = iso;
}

void CxChart::FitText(int x1, int y1, int x2, int y2, CcString theText, Boolean rotated)
{
#ifdef __CR_WIN__
    CPen        pen(PS_SOLID,1,mfgcolour);
    CPen*       oldpen = memDC.SelectObject(&pen);
    oldMemDCBitmap = memDC.SelectObject(newMemDCBitmap);
    LOGFONT     theLogfont;
    (CcController::mp_font)->GetLogFont(&theLogfont);
    theLogfont.lfHeight = 180;
    theLogfont.lfWidth = 0;
    theLogfont.lfWeight = 0;
    if(rotated)
        theLogfont.lfOrientation = 900;
    char face[32] = "Times New Roman";
    *(theLogfont.lfFaceName) = *face;

      CcPoint      coord = DeviceToLogical(x1,y1);
      CcPoint       coord2 =DeviceToLogical(x2,y2);
    Boolean fontIsTooBig = true;
    CSize size;
//  int sign = theLogfont.lfHeight / abs(theLogfont.lfHeight);
    while (fontIsTooBig)
    {
        CFont  theFont;
        theFont.CreatePointFontIndirect(&theLogfont, &memDC);
        CFont* oldFont = memDC.SelectObject(&theFont);

        size = memDC.GetOutputTextExtent(theText.ToCString(), theText.Len());

                if (((size.cx < coord2.x - coord.x)&&(size.cy < coord2.y - coord.y))||(theLogfont.lfHeight<=60))
        {
            //Output the text, and exit.
            fontIsTooBig = false;
            int xcrd = ( coord2.x + coord.x - size.cx ) / 2;
            int ycrd = ( coord2.y + coord.y - size.cy ) / 2;
            memDC.SetBkMode(TRANSPARENT);
            memDC.TextOut(xcrd,ycrd,theText.ToCString(),theText.Len());
            memDC.SelectObject(oldpen);
            memDC.SelectObject(oldFont);
        }
        else
        {
            //Reduced the logfont height, put the oldfont back into the DC and repeat.
            theLogfont.lfHeight -= 10;
            memDC.SelectObject(oldFont); //Our CFont goes out of scope, and is deleted automatically
        }
                theFont.DeleteObject(); //Free memory associated with font.
    }
    memDC.SelectObject(oldMemDCBitmap);
#endif
#ifdef __BOTHWX__
      memDC.SetPen( *m_pen );
      memDC.SelectObject( *newMemDCBitmap );
      wxFont theFont = memDC.GetFont();

      wxString wtext (theText.ToCString());

      theFont.SetPointSize(80);

      CcPoint      coord = DeviceToLogical(x1,y1);
      CcPoint       coord2 =DeviceToLogical(x2,y2);

      int cwide = coord2.x - coord.x;
      int chigh = coord2.y - coord.y;

    Boolean fontIsTooBig = true;

    while (fontIsTooBig)
    {
            memDC.SetFont(theFont);
            int cx,cy;
            GetTextExtent( wtext, &cx, &cy );

            if ((( cx < cwide )&&( cy < chigh ))||(theFont.GetPointSize()<=8))
        {
            //Output the text, and exit.
            fontIsTooBig = false;
//Centre the text.
                  int xcrd = ( coord2.x + coord.x - cx ) / 2;
                  int ycrd = ( coord2.y + coord.y - cy ) / 2;
                  memDC.SetBackgroundMode( wxTRANSPARENT );
                  memDC.DrawText(wtext, xcrd , ycrd );
        }
        else
        {
                  //Reduced the font height and repeat.
                  theFont.SetPointSize( theFont.GetPointSize()-1 );
                  memDC.SetFont( wxNullFont );
        }
    }
      memDC.SetFont( wxNullFont );
      memDC.SetPen( wxNullPen );
      memDC.SelectObject( wxNullBitmap );
#endif
}

void CxChart::Invert(Boolean inverted)
{
    m_inverted = inverted;
}

void CxChart::NoEdge()
{
#ifdef __CR_WIN__
    ModifyStyleEx(WS_EX_CLIENTEDGE,NULL,0);
#endif
//LINUX: It is not possible to modify window styles after creation.
}

#ifdef __CR_WIN__
void CxChart::OnKeyDown ( UINT nChar, UINT nRepCnt, UINT nFlags )
{
      int key = -1;
      switch (nChar) {
           case VK_LEFT:
                  key = CRLEFT;
                  break;
           case VK_RIGHT:
                  key = CRRIGHT;
                  break;
           case VK_UP:
                  key = CRUP;
                  break;
           case VK_DOWN:
                  key = CRDOWN;
                  break;
           case VK_INSERT:
                  key = CRINSERT;
                  break;
           case VK_DELETE:
                  key = CRDELETE;
                  break;
           case VK_END:
                  key = CREND;
                  break;
           case VK_ESCAPE:
                  key = CRESCAPE;
                  break;
           default:
                  //Do nothing
                  break;
      }

      if (key >= 0)
            ((CrChart*)ptr_to_crObject)->SysKey( key );

      CWnd::OnKeyDown( nChar, nRepCnt, nFlags );
}
#endif

#ifdef __BOTHWX__
void CxChart::OnKeyDown( wxKeyEvent & event )
{
      int key = -1;

      switch(event.KeyCode())
    {
           case WXK_LEFT:
                  key = CRLEFT;
                  break;
           case WXK_RIGHT:
                  key = CRRIGHT;
                  break;
           case WXK_UP:
                  key = CRUP;
                  break;
           case WXK_DOWN:
                  key = CRDOWN;
                  break;
           case WXK_INSERT:
                  key = CRINSERT;
                  break;
           case WXK_DELETE:
                  key = CRDELETE;
                  break;
           case WXK_END:
                  key = CREND;
                  break;
           case WXK_ESCAPE:
                  key = CRESCAPE;
                  break;
           default:
                  //Do nothing
                  break;
      }

      if (key >= 0)
            ((CrChart*)ptr_to_crObject)->SysKey( key );


// Carry on processing this event.
      event.Skip();

}
#endif
