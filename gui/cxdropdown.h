////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CxDropDown

////////////////////////////////////////////////////////////////////////

//   Filename:  CxDropDown.h
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   $Log: not supported by cvs2svn $

#ifndef     __CxDropDown_H__
#define     __CxDropDown_H__
//Insert your own code here.
#include    "crguielement.h"

#ifdef __POWERPC__
class LStdPopupMenu;
#endif

#ifdef __MOTO__
#include    <LStdControl.h>
#endif

#ifdef __BOTHWX__
#include <wx/choice.h>
#define BASEDROPDOWN wxChoice
#endif

#ifdef __CR_WIN__
#include <afxwin.h>
#define BASEDROPDOWN CComboBox
#endif

class CrDropDown;
class CxGrid;
//End of user code.

class CxDropDown : public BASEDROPDOWN
{
    public:
        CcString GetDropDownText(int index);
        int mItems;
        void Focus();
        static CxDropDown * CreateCxDropDown( CrDropDown * container, CxGrid * guiParent );
            CxDropDown( CrDropDown * container );
            ~CxDropDown();
        void    AddItem( char * text );
            void  CxSetSelection ( int select );
        void    SetGeometry( const int top, const int left, const int bottom, const int right );
        int GetTop();
        int GetLeft();
        int GetWidth();
        int GetHeight();
        int GetIdealWidth();
        int GetIdealHeight();
        int GetDroppedHeight();
        static int  AddDropDown( void ) { mDropDownCount++; return mDropDownCount; };
        static void RemoveDropDown( void ) { mDropDownCount--; };
        void BroadcastValueMessage( void );
        int GetDropDownValue();

        // attributes
        CrGUIElement *  ptr_to_crObject;
        static int  mDropDownCount;

#ifdef __CR_WIN__
        void    Selected();
        afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
        DECLARE_MESSAGE_MAP()
#endif
#ifdef __BOTHWX__
            void Selected();
            void OnChar(wxKeyEvent & event );
            DECLARE_EVENT_TABLE()
#endif


};
#endif
