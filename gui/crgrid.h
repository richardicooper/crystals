////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CrGrid

////////////////////////////////////////////////////////////////////////

//   Filename:  CrGrid.h
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 13:59 Uhr
//   $Log: not supported by cvs2svn $
//   Revision 1.9  2001/10/10 12:44:50  ckp2
//   The PLOT classes!
//
//   Revision 1.8  2001/03/08 15:36:04  richard
//   Completely re-written the window sizing and layout code. Now much simpler.
//   Calclayout works out and returns the size of a GUI object, so that the
//   calling window knows what size to make itself initially. The setgeom call then
//   actaully sets the sizes. During resize the difference between
//   the available size and the original size is used to calculate how much
//   to expand or shrink each object.
//

#ifndef     __CrGrid_H__
#define     __CrGrid_H__
#include    "crguielement.h"
#include    "cclist.h"

class CxGroupBox;
class CcTokenList;

class   CrGrid : public CrGUIElement
{
  public:
    CrGrid( CrGUIElement * mParentPtr );
    ~CrGrid();

    CcParse ParseInput( CcTokenList * tokenList );
    void CrFocus();
    int GetIdealHeight();
    int GetIdealWidth();
    void    SetGeometry( const CcRect * rect );
    CcRect  GetGeometry();
    CcRect CalcLayout(bool recalculate=false);

    void    SetText( CcString item );
    bool    GridComplete() {  return m_GridComplete; } ;
    CcParse InitElement( CrGUIElement * element, CcTokenList * tokenList, int xpos, int ypos );
    void    Align();
    int     GetHeightOfRow( int row );
    int     GetWidthOfColumn( int col );
    CrGUIElement *  FindObject( CcString Name );
    void    SendCommand(CcString theText, Boolean jumpQueue);
    void    SetCommandText(CcString theText);
    void    CrShowGrid(bool state);
    CrGUIElement *  GetPointer( int xpos, int ypos );

    int     m_Columns;
    int     m_Rows;


  protected:
    bool SetPointer( int xpos, int ypos, CrGUIElement * ptr );

    CcList  m_ItemList;
    Boolean m_GridComplete;
    CrGrid *        m_ActiveSubGrid;
    CrGUIElement ** m_TheGrid;
    CxGroupBox *    m_OutlineWidget;
    Boolean m_CommandSet;
    CcString m_CommandText;
    int * m_InitialColWidths;
    int * m_InitialRowHeights;
    bool * m_ColCanResize;
    bool * m_RowCanResize;

    int m_InitContentWidth;
    int m_ContentWidth;
    int m_InitContentHeight;
    int m_ContentHeight;
    float m_resizeableWidth;
    float m_resizeableHeight;


};

#define kSCreateButton      "BUTTON"
#define kSAt            "@"
#define kSCreateListBox     "LISTBOX"
#define kSCreateListCtrl    "LISTCTRL"
#define kSCreateDropDown    "DROPDOWN"
#define kSCreateEditBox     "EDITBOX"
#define kSCreateMultiEdit   "MULTIEDIT"
#define kSCreateTextOut         "TEXTOUT"
#define kSCreateText        "STATIC"
#define kSCreateIcon          "ICON"
#define kSCreateProgress    "PROGRESS"
#define kSCreateRadioButton "RADIOBUTTON"
#define kSCreateCheckBox    "CHECKBOX"
#define kSCreateChart       "CHARTWINDOW"
#define kSCreatePlot       "PLOTWINDOW"
#define kSCreateModel       "MODELWINDOW"
#define kSOutline       "OUTLINE"
#define kSAlignExpand       "EXPAND"
#define kSAlignRight        "RIGHT"
#define kSAlignBottom       "BOTTOM"
#define kSCreateBitmap          "BITMAP"
#define kSCreateTabCtrl         "TABCTRL"
#define kSCreateToolBar         "TOOLBAR"
#define kSCreateResize          "RESIZE"
#define kSCreateStretch          "STRETCH"
#define kSCreateHidden          "HIDDENSTRING"

enum
{
 kTCreateButton = 1100,
 kTAt,
 kTCreateListBox,
 kTCreateListCtrl,
 kTCreateDropDown,
 kTCreateEditBox,
 kTCreateMultiEdit,
 kTCreateTextOut,
 kTCreateText,
 kTCreateIcon,
 kTCreateProgress,
 kTCreateRadioButton,
 kTCreateCheckBox,
 kTCreateChart,
 kTCreateModel,
 kTOutline,
 kTAlignExpand,
 kTAlignRight,
 kTAlignBottom,
 kTCreateBitmap,
 kTCreateTabCtrl,
 kTCreateToolBar,
 kTCreateResize,
 kTCreateStretch,
 kTCreatePlot,
 kTCreateHidden

};



#endif
