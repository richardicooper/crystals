////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CrPlot

////////////////////////////////////////////////////////////////////////

//   Filename:  CrPlot.h
//   Authors:   Richard Cooper and Steve Humphreys
//   Created:   09.11.2001 23:28
//
//   $Log: not supported by cvs2svn $
//   Revision 1.6  2002/02/18 11:21:13  DJWgroup
//   SH: Update to plot code.
//
//   Revision 1.5  2001/12/13 16:20:33  ckpgroup
//   SH: Cleaned up the key code. Now redraws correctly, although far too often.
//   Some problems with mouse-move when key is enabled. Fine when disabled.
//
//   Revision 1.4  2001/12/12 16:02:26  ckpgroup
//   SH: Reorganised script to allow right-hand y axes.
//   Added floating key if required, some redraw problems.
//
//   Revision 1.3  2001/11/26 14:02:50  ckpgroup
//   SH: Added mouse-over message support - display label and data value for the bar
//   under the pointer.
//
//   Revision 1.2  2001/11/12 16:24:31  ckpgroup
//   SH: Graphical agreement analysis
//
//   Revision 1.1  2001/10/10 12:44:50  ckp2
//   The PLOT classes!
//
//

#ifndef     __CrPlot_H__
#define     __CrPlot_H__
#include    "crguielement.h"

class CcPlotData;
class CcTokenList;
class CcPoint;
class CrMenu;

#define TEXT_VCENTRE	1
#define TEXT_HCENTRE	2
#define TEXT_RIGHT		4
#define TEXT_TOP		8
#define TEXT_VERTICAL   16
#define TEXT_BOLD		32
#define TEXT_ANGLE		64
#define TEXT_BOTTOM		128
#define TEXT_VERTICALDOWN 256

class   CrPlot : public CrGUIElement
{
    public:
//Functions for drawing on the window:
        void DrawLine(int thickness, int x1, int y1, int x2, int y2); // STEVE added thickness parameter
        void DrawText(int x, int y, CcString text, int param, int fontsize);// STEVE added justification parameter
        void DrawRect(int x1, int y1, int x2, int y2, Boolean fill);
        void DrawPoly(int nVertices, int* vertices, Boolean fill);
        void DrawEllipse(int x, int y, int w, int h, Boolean fill);
		void SetColour(int r, int g, int b);							// STEVE added this - set colour in cxplot class
        void Clear();
		int GetMaxFontSize(int width, int height, CcString text, int param);
		CcPoint GetTextArea(int size, CcString text, int param);
		CcString GetDataFromPoint(CcPoint *point);					// get a description of the data under the mouse
		void CreateKey(int numser, CcString* names, int** col);

//Creation and adding data:
        void Attach(CcPlotData* doc);
        CrPlot( CrGUIElement * mParentPtr );
        ~CrPlot();

        void ContextMenu(CcPoint * xy, int x1, int y1);
        void ReDrawView(bool print);
        void Display();
        void CrFocus();
        CcParse ParseInput( CcTokenList * tokenList );
        void    SetGeometry( const CcRect * rect );
        void    MenuSelected(int id);
        CcRect  GetGeometry();
        CcRect  CalcLayout(bool recalculate=false);
        void    SetText( CcString text );
        int GetIdealWidth();
        int GetIdealHeight();

//attributes
        CcPlotData* attachedPlotData;
        CrMenu* m_cmenu;
        
};


#endif
