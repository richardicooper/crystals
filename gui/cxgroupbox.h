////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CxGroupBox

////////////////////////////////////////////////////////////////////////

//   Filename:  CxGroupBox.h
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   $Log: not supported by cvs2svn $
//   Revision 1.7  2001/11/14 10:30:41  ckp2
//   Various changes to the painting of the background of Windows as some of the
//   dialogs suddenly went white under XP.
//
//   Revision 1.6  2001/03/08 16:44:09  richard
//   General changes - replaced common functions in all GUI classes by macros.
//   Generally tidied up, added logs to top of all source files.
//

#ifndef     __CxGroupBox_H__
#define     __CxGroupBox_H__
#include    "crguielement.h"

#ifdef __CR_WIN__
#include <afxwin.h>
#define BASEGROUPBOX CButton
#endif

#ifdef __BOTHWX__
#include <wx/statbox.h>
#define BASEGROUPBOX wxStaticBox
#endif

class CrGrid;
class CxGrid;
class CxGroupBox;

class CxGroupBox : public BASEGROUPBOX
{
    public:
        // methods
        static CxGroupBox * CreateCxGroupBox( CrGrid * container, CxGrid * guiParent );
            CxGroupBox( CrGrid * container );
            ~CxGroupBox();
        void    SetText( char * text );
        void    SetGeometry( int top, int left, int bottom,  int right );
        static int AddGroupBox( void) { mGroupBoxCount++; return mGroupBoxCount; };
        static void RemoveGroupBox( void) { mGroupBoxCount--; };

        // attributes
        static int mGroupBoxCount;

#ifdef __CR_WIN__
    protected:
        afx_msg BOOL OnEraseBkgnd(CDC* pDC);
        DECLARE_MESSAGE_MAP()
#endif
};
#endif
