////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CxGrid

////////////////////////////////////////////////////////////////////////

//   Filename:  CxGrid.h
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   $Log: not supported by cvs2svn $
//   Revision 1.9  2001/06/17 14:42:00  richard
//   CxDestroyWindow function.
//
//   Revision 1.8  2001/03/08 16:44:08  richard
//   General changes - replaced common functions in all GUI classes by macros.
//   Generally tidied up, added logs to top of all source files.
//

#ifndef     __CxGrid_H__
#define     __CxGrid_H__
//Insert your own code here.
#include    "crguielement.h"

#ifdef __CR_WIN__
#include    <afxwin.h>
#define BASEGRID CWnd
#endif

#ifdef __BOTHWX__
#include <wx/window.h>
#include <wx/control.h>
#include <wx/font.h>
#define BASEGRID wxWindow
#endif

#include    "cxradiobutton.h"

class CrGrid;
class CxGrid;

//End of user code.

class CxGrid : public BASEGRID
{

// The interface exposed to the CrClass:

      public:
        static CxGrid * CreateCxGrid( CrGrid * container, CxGrid * guiParent );
            CxGrid( CrGrid * container );
            ~CxGrid();
        void    SetText( char * text );
        void    SetGeometry( const int top, const int left, const int bottom, const int right );
        void CxDestroyWindow();
        int GetTop();
        int GetLeft();
        int GetWidth();
        int GetHeight();
        int GetIdealWidth();
        int GetIdealHeight();
        void CxShowWindow(bool state=true);

        CrGUIElement *  ptr_to_crObject;
        static int mGridCount;

#ifdef __BOTHWX__
            static wxFont* mp_font;
#endif

#ifdef __CR_WIN__
  protected:
    afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
    DECLARE_MESSAGE_MAP()
#endif
#ifdef __BOTHWX__
  public:
    void OnChar(wxKeyEvent & event );
    DECLARE_EVENT_TABLE()
#endif
    


};
#endif
