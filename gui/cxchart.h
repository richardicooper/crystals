////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CxChart

////////////////////////////////////////////////////////////////////////

//   Filename:  CxChart.h
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   $Log: not supported by cvs2svn $
//   Revision 1.11  2002/01/30 10:58:43  ckp2
//   RIC: Printing and WMF capability for CxChart object. - NB. Steve, this can easily
//   be copied to CxPlot to do same thing.
//
//   Revision 1.10  2001/10/10 12:44:51  ckp2
//   The PLOT classes!
//
//   Revision 1.9  2001/07/16 07:29:29  ckp2
//   Really messed around with the creation of the memory device context in the wx version.
//   Now it is deleted and recreated (along with it's bitmap) every time the window is
//   resized. This seems the best way to stop it randomly crashing with an invalid wxPen warning.
//
//   Revision 1.8  2001/06/17 14:46:04  richard
//   CxDestroyWindow function.
//   wx bug fixes.
//
//   Revision 1.7  2001/03/08 16:44:08  richard
//   General changes - replaced common functions in all GUI classes by macros.
//   Generally tidied up, added logs to top of all source files.
//

#ifndef     __CxChart_H__
#define     __CxChart_H__
#include    "crguielement.h"
#include    "ccpoint.h"

#ifdef __POWERPC__
class LStdChart;
#endif

#ifdef __MOTO__
#include    <LStdControl.h>
#endif

#ifdef __BOTHWX__
#include <wx/control.h>
#include <wx/colour.h>
#include <wx/bitmap.h>
#include <wx/dcmemory.h>
#define BASECHART wxControl
#endif

#ifdef __CR_WIN__
#include <afxwin.h>
#define BASECHART CWnd
#endif

#include "ccrect.h"

class CrChart;
class CxGrid;
class CcPoint;
//End of user code.

class CxChart : public BASECHART
{
// Public interface exposed to the CrClass:
    public:
        void NoEdge();
        void Invert(Boolean inverted);
        void FitText(int x1, int y1, int x2, int y2, CcString theText, Boolean rotated);
        void UseIsotropicCoords(Boolean iso);
        void SetPolygonDrawMode(Boolean on);
        void SetColour(int r, int g, int b);
        void CxDestroyWindow();
        void DrawPoly(int nVertices, int* vertices, Boolean fill);
        void DrawText(int x, int y, CcString text);
        void DrawEllipse(int x, int y, int w, int h, Boolean fill);
        void Clear();
        int mIdealHeight;
        int mIdealWidth;
        void SetIdealWidth(int nCharsWide);
        void SetIdealHeight(int nCharsHigh);
        void Display();
            CcPoint DeviceToLogical(int x, int y);
            CcPoint LogicalToDevice(CcPoint point);
        void DrawLine (int x1, int y1, int x2, int y2);
        void Focus();
        static CxChart *    CreateCxChart( CrChart * container, CxGrid * guiParent );
        CxChart(CrChart* container);
        ~CxChart();
        void    SetText( char * text );
        void    SetGeometry( int top, int left, int bottom, int right );
        int GetTop();
        int GetLeft();
        int GetWidth();
        int GetHeight();
        int GetIdealWidth();
        int GetIdealHeight();
        static int AddChart( void ) { mChartCount++; return mChartCount; };
        static void RemoveChart( void ) { mChartCount--; };
        void    BroadcastValueMessage( void );

        CrGUIElement *  ptr_to_crObject;
        static int mChartCount;
        int mPolyMode;

private:
            Boolean m_inverted;
            Boolean m_IsoCoords;
            Boolean m_SendCursorKeys;
            CcPoint mLastPolyModePoint;
            CcPoint mStartPolyModePoint;
            CcPoint mCurrentPolyModeLineEndPoint;

// Private machine specific parts:
#ifdef __CR_WIN__
      public:

        COLORREF mfgcolour;
        CBitmap *oldMemDCBitmap, *newMemDCBitmap;
        CDC * memDC;
        CcRect m_client;

        void MakeMetaFile(int w, int h, bool enhanced);
        void PrintPicture();

        afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
        afx_msg void OnPaint();
        afx_msg void OnLButtonUp( UINT nFlags, CPoint point );
        afx_msg void OnRButtonUp( UINT nFlags, CPoint point );
        afx_msg void OnMouseMove( UINT nFlags, CPoint point );
        afx_msg void OnKeyDown( UINT nChar, UINT nRepCnt, UINT nFlags );
        DECLARE_MESSAGE_MAP()
#endif
#ifdef __BOTHWX__
      public:

            wxColour mfgcolour;
            wxBitmap *oldMemDCBitmap, *newMemDCBitmap;
            wxMemoryDC *memDC;
            wxPen      * m_pen;
            wxBrush    * m_brush;

            void OnLButtonUp(wxMouseEvent & event);
            void OnRButtonUp(wxMouseEvent & event);
            void OnMouseMove(wxMouseEvent & event);
            void OnChar(wxKeyEvent & event );
            void OnKeyDown( wxKeyEvent & event );
            void OnPaint(wxPaintEvent & event );
            DECLARE_EVENT_TABLE()
#endif
};
#endif
