////////////////////////////////////////////////////////////////////////
//   CRYSTALS Interface      Class CxCheckBox
////////////////////////////////////////////////////////////////////////
//   Filename:  CxCheckBox.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   $Log: not supported by cvs2svn $
//   Revision 1.11  2003/05/07 12:18:58  rich
//
//   RIC: Make a new platform target "WXS" for building CRYSTALS under Windows
//   using only free compilers and libraries. Hurrah, but it isn't very stable
//   yet (CRYSTALS, not the compilers...)
//
//   Revision 1.10  2001/11/16 15:12:01  ckp2
//   Updated GetIdealWidth routine to be more accurate (use correct DC for calculations).
//
//   Revision 1.9  2001/06/17 14:45:02  richard
//   CxDestroyWindow function.
//
//   Revision 1.8  2001/03/08 16:44:08  richard
//   General changes - replaced common functions in all GUI classes by macros.
//   Generally tidied up, added logs to top of all source files.
//

#include    "crystalsinterface.h"
#include    "ccstring.h"
#include    "cxcheckbox.h"
#include    "cccontroller.h"
#include    "cxgrid.h"
#include    "crcheckbox.h"

int CxCheckBox::mCheckBoxCount = kCheckBoxBase;
CxCheckBox *    CxCheckBox::CreateCxCheckBox( CrCheckBox * container, CxGrid * guiParent )
{

    char * defaultName = (char *)"StdButton" ;
    CxCheckBox  *theStdButton = new CxCheckBox(container);

#ifdef __CR_WIN__
        theStdButton->Create("CheckBox",WS_CHILD| WS_VISIBLE| BS_AUTOCHECKBOX, CRect(0,0,10,10), guiParent, mCheckBoxCount++);
    theStdButton->SetFont(CcController::mp_font);
#endif
#ifdef __BOTHWX__
      theStdButton->Create(guiParent,-1,"CheckBox",wxPoint(0,0),wxSize(0,0));
#endif

    return theStdButton;
}

CxCheckBox::CxCheckBox( CrCheckBox * container)
      :BASECHECKBOX()
{
    ptr_to_crObject = container;
}

CxCheckBox::~CxCheckBox()
{
    mCheckBoxCount--;
}

void CxCheckBox::CxDestroyWindow()
{
  #ifdef __CR_WIN__
DestroyWindow();
#endif
#ifdef __BOTHWX__
Destroy();
#endif
}

void    CxCheckBox::BoxClicked()
{
#ifdef __CR_WIN__
      bool state = GetBoxState() == 1 ? true : false;
#endif
#ifdef __BOTHWX__
      bool state = GetValue();
#endif

    ( (CrCheckBox *)ptr_to_crObject)->BoxChanged( state );
}

void    CxCheckBox::SetText( char * text )
{
//Insert your own code here.
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

CXSETGEOMETRY(CxCheckBox)

CXGETGEOMETRIES(CxCheckBox)

int   CxCheckBox::GetIdealWidth()
{
#ifdef __CR_WIN__
    CString text;
    SIZE size;
//    HDC hdc= (HDC) (GetDC()->m_hAttribDC);
//    GetWindowText(text);
//    GetTextExtentPoint32(hdc, text, text.GetLength(), &size);
//    return (size.cx+20); // optimum width for Windows buttons (only joking)

    CClientDC dc(this);
    CFont* oldFont = dc.SelectObject(CcController::mp_font);
    GetWindowText(text);
    size = dc.GetOutputTextExtent(text);
    dc.SelectObject(oldFont);
    return ( size.cx + 20); //Allow space for checkbox

#endif
#ifdef __BOTHWX__
      int cx,cy;
      GetTextExtent( GetLabel(), &cx, &cy );
      return (cx+20); // nice width for buttons
#endif

}

int   CxCheckBox::GetIdealHeight()
{
#ifdef __CR_WIN__
    CString text;
    SIZE size;
    CDC* cdc = GetDC();
    HDC hdc= (HDC) (cdc->m_hAttribDC);
    GetWindowText(text);
    GetTextExtentPoint32(hdc, text, text.GetLength(), &size);
    ReleaseDC(cdc);
    return (size.cy+5); // *** optimum height for MacOS Buttons (depends on users font size?)
#endif
#ifdef __BOTHWX__
      int cx,cy;
      GetTextExtent( GetLabel(), &cx, &cy );
      return (cy+5); // nice height for buttons
#endif

}

void    CxCheckBox::SetBoxState( bool inValue )
{
#ifdef __CR_WIN__
    int value;
    if ( inValue == true )
        value = 1;
    else
        value = 0;
    SetCheck( value );
#endif
#ifdef __BOTHWX__
      SetValue (inValue);
#endif

}

bool CxCheckBox::GetBoxState()
{
#ifdef __CR_WIN__
    int value = GetCheck();
    if ( value == 1 )
        return (true);
    else
        return (false);
#endif
#ifdef __BOTHWX__
      return GetValue();
#endif
}

#ifdef __CR_WIN__
//Windows Message Map
BEGIN_MESSAGE_MAP(CxCheckBox, BASECHECKBOX)
    ON_CONTROL_REFLECT(BN_CLICKED, BoxClicked)
    ON_WM_CHAR()
END_MESSAGE_MAP()
#endif

#ifdef __BOTHWX__
//wxWindows Event Table
BEGIN_EVENT_TABLE(CxCheckBox, BASECHECKBOX)
      EVT_CHECKBOX( -1, CxCheckBox::BoxClicked )
      EVT_CHAR( CxCheckBox::OnChar )
END_EVENT_TABLE()
#endif


#ifdef __CR_WIN__
void CxCheckBox::OnChar( UINT nChar, UINT nRepCnt, UINT nFlags )
{
    NOTUSED(nRepCnt);
    NOTUSED(nFlags);
    switch(nChar)
    {
        case 9:
        {
            bool shifted = ( HIWORD(GetKeyState(VK_SHIFT)) != 0) ? true : false;
            ptr_to_crObject->NextFocus(shifted);
            break;
        }
        case 32:    //SPACE. Activate Button.
        {
            BoxClicked();
            break;
        }

        default:
        {
            ptr_to_crObject->FocusToInput((char)nChar);
        }
    }
}
#endif
#ifdef __BOTHWX__
void CxCheckBox::OnChar( wxKeyEvent & event )
{
      switch(event.KeyCode())
    {
        case 9:     //TAB. Shift focus back or forwards.
        {
                  bool shifted = event.m_shiftDown;
            ptr_to_crObject->NextFocus(shifted);
            break;
        }
        case 32:    //SPACE. Activates button. Don't focus to the input line.
        {
                  BoxClicked();
            break;
        }
        default:
        {
                  ptr_to_crObject->FocusToInput((char)event.KeyCode());
            break;
        }
    }
}
#endif

void CxCheckBox::Focus()
{
    SetFocus();
}

void CxCheckBox::Disable(bool disabled)
{
#ifdef __CR_WIN__
    if(disabled)
            EnableWindow(false);
    else
            EnableWindow(true);
#endif
#ifdef __BOTHWX__
    if(disabled)
            Enable(false);
    else
            Enable(true);
#endif
}
