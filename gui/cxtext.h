////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CxText

////////////////////////////////////////////////////////////////////////

//   Filename:  CxText.h
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   $Log: not supported by cvs2svn $

#ifndef     __CxText_H__
#define     __CxText_H__
#include    "crguielement.h"

#ifdef __BOTHWX__
#include <wx/stattext.h>
#define BASETEXT wxStaticText
#endif

#ifdef __CR_WIN__
#include <afxwin.h>
#define BASETEXT CStatic
#endif

class CrText;
class CxGrid;
//End of user code.

class CxText : public BASETEXT
{
    public:
        // methods
        static CxText * CreateCxText( CrText * container, CxGrid * guiParent );
            CxText( CrText * container );
            ~CxText();
        void    SetText( CcString text );
        void    SetGeometry( const int top, const int left, const int bottom, const int right );
        int GetTop();
        int GetLeft();
        int GetWidth();
        int GetHeight();
        int GetIdealWidth();
        int GetIdealHeight();
        static int  AddText();
        static void RemoveText();
        void    SetVisibleChars( int count );

        // attributes
        CrGUIElement *  ptr_to_crObject;

    protected:
        // methods

        // attributes
        static int  mTextCount;
        int mCharsWidth;
};
#endif
