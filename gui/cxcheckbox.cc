////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CxCheckBox

////////////////////////////////////////////////////////////////////////

//   Filename:  CxCheckBox.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   Modified:  12.3.1998 10:38 Uhr

#include	"crystalsinterface.h"
#include	"cxcheckbox.h"

#include	"cxgrid.h"
#include	"crcheckbox.h"

int	CxCheckBox::mCheckBoxCount = kCheckBoxBase;
CxCheckBox *	CxCheckBox::CreateCxCheckBox( CrCheckBox * container, CxGrid * guiParent )
{

	char * defaultName = (char *)"StdButton" ;
	CxCheckBox	*theStdButton = new CxCheckBox(container);

#ifdef __WINDOWS__
	theStdButton->Create("CheckBox",WS_CHILD|WS_VISIBLE|BS_AUTOCHECKBOX,CRect(0,0,10,10),guiParent,mCheckBoxCount++);
	theStdButton->SetFont(CxGrid::mp_font);
#endif
#ifdef __LINUX__
      theStdButton->Create(guiParent,-1,"CheckBox",wxPoint(0,0),wxSize(0,0));
#endif

	return theStdButton;
}

CxCheckBox::CxCheckBox( CrCheckBox * container)
      :BASECHECKBOX()
{
	mWidget = container;
}

CxCheckBox::~CxCheckBox()
{
	mCheckBoxCount--;
}

void	CxCheckBox::BoxClicked()
{
#ifdef __WINDOWS__
      Boolean state = GetBoxState() == 1 ? true : false;
#endif
#ifdef __LINUX__
      Boolean state = GetValue();
#endif

	( (CrCheckBox *)mWidget)->BoxChanged( state );
}

void	CxCheckBox::SetText( char * text )
{
//Insert your own code here.
#ifdef __POWERPC__
	Str255 descriptor;
	
	strcpy( reinterpret_cast<char *>(descriptor), text );
	c2pstr( reinterpret_cast<char *>(descriptor) );
	SetDescriptor( descriptor );
#endif
#ifdef __LINUX__
      SetLabel(text);
#endif
#ifdef __WINDOWS__
	SetWindowText(text);
#endif
}


void  CxCheckBox::SetGeometry( int top, int left, int bottom, int right )
{
#ifdef __WINDOWS__
	MoveWindow(left,top,right-left,bottom-top,true);
#endif
#ifdef __LINUX__
      SetSize(left,top,right-left,bottom-top);
#endif

}
int   CxCheckBox::GetTop()
{
#ifdef __WINDOWS__
      RECT windowRect, parentRect;
	GetWindowRect(&windowRect);
	CWnd* parent = GetParent();
	if(parent != nil)
	{
		parent->GetWindowRect(&parentRect);
		windowRect.top -= parentRect.top;
	}
	return ( windowRect.top );
#endif
#ifdef __LINUX__
      wxRect windowRect, parentRect;
      windowRect = GetRect();
      wxWindow* parent = GetParent();
	if(parent != nil)
	{
            parentRect = parent->GetRect();
            windowRect.y -= parentRect.y;
	}
      return ( windowRect.y );
#endif
}
int   CxCheckBox::GetLeft()
{
#ifdef __WINDOWS__
      RECT windowRect, parentRect;
	GetWindowRect(&windowRect);
	CWnd* parent = GetParent();
	if(parent != nil)
	{
		parent->GetWindowRect(&parentRect);
		windowRect.left -= parentRect.left;
	}
	return ( windowRect.left );
#endif
#ifdef __LINUX__
      wxRect windowRect, parentRect;
      windowRect = GetRect();
      wxWindow* parent = GetParent();
	if(parent != nil)
	{
            parentRect = parent->GetRect();
            windowRect.x -= parentRect.x;
	}
      return ( windowRect.x );
#endif

}
int   CxCheckBox::GetWidth()
{
#ifdef __WINDOWS__
	CRect windowRect;
	GetWindowRect(&windowRect);
	return ( windowRect.Width() );
#endif
#ifdef __LINUX__
      wxRect windowRect;
      windowRect = GetRect();
      return ( windowRect.GetWidth() );
#endif
}
int   CxCheckBox::GetHeight()
{
#ifdef __WINDOWS__
	CRect windowRect;
	GetWindowRect(&windowRect);
      return ( windowRect.Height() );
#endif
#ifdef __LINUX__
      wxRect windowRect;
      windowRect = GetRect();
      return ( windowRect.GetHeight() );
#endif
}

int   CxCheckBox::GetIdealWidth()
{
#ifdef __WINDOWS__
	CString text;
	SIZE size;
	HDC hdc= (HDC) (GetDC()->m_hAttribDC);
	GetWindowText(text);
	GetTextExtentPoint32(hdc, text, text.GetLength(), &size);
      return (size.cx+20); // optimum width for Windows buttons (only joking)
#endif
#ifdef __LINUX__
      int cx,cy;
      GetTextExtent( GetLabel(), &cx, &cy );
      return (cx+20); // nice width for buttons
#endif

}

int   CxCheckBox::GetIdealHeight()
{
#ifdef __WINDOWS__
	CString text;
	SIZE size;
	HDC hdc= (HDC) (GetDC()->m_hAttribDC);
	GetWindowText(text);
	GetTextExtentPoint32(hdc, text, text.GetLength(), &size);
	return (size.cy+5); // *** optimum height for MacOS Buttons (depends on users font size?)
#endif
#ifdef __LINUX__
      int cx,cy;
      GetTextExtent( GetLabel(), &cx, &cy );
      return (cy+5); // nice height for buttons
#endif

}

void	CxCheckBox::SetBoxState( Boolean inValue )
{
#ifdef __WINDOWS__
	int value;
	if ( inValue == true )
		value = 1;
	else
		value = 0;
	SetCheck( value );
#endif
#ifdef __LINUX__
      SetValue (inValue);
#endif

}

Boolean	CxCheckBox::GetBoxState()
{
#ifdef __WINDOWS__
	int value = GetCheck();
	if ( value == 1 )
		return (true);
	else
		return (false);
#endif
#ifdef __LINUX__
      return GetValue();
#endif
}

#ifdef __WINDOWS__
//Windows Message Map
BEGIN_MESSAGE_MAP(CxCheckBox, BASECHECKBOX)
	ON_CONTROL_REFLECT(BN_CLICKED, BoxClicked)
	ON_WM_CHAR()
END_MESSAGE_MAP()
#endif

#ifdef __LINUX__
//wxWindows Event Table
BEGIN_EVENT_TABLE(CxCheckBox, BASECHECKBOX)
      EVT_CHECKBOX( -1, CxCheckBox::BoxClicked ) 
      EVT_CHAR( CxCheckBox::OnChar )
END_EVENT_TABLE()
#endif


#ifdef __WINDOWS__
void CxCheckBox::OnChar( UINT nChar, UINT nRepCnt, UINT nFlags )
{
	NOTUSED(nRepCnt);
	NOTUSED(nFlags);
	switch(nChar)
	{
		case 9:
		{
			Boolean shifted = ( HIWORD(GetKeyState(VK_SHIFT)) != 0) ? true : false;
			mWidget->NextFocus(shifted);
			break;
		}
		case 32:    //SPACE. Activate Button.
		{
			BoxClicked();
			break;
		}

		default:
		{
			mWidget->FocusToInput((char)nChar);
		}
	}
}
#endif
#ifdef __LINUX__
void CxCheckBox::OnChar( wxKeyEvent & event )
{
      switch(event.KeyCode())
	{
		case 9:     //TAB. Shift focus back or forwards.
		{
                  Boolean shifted = event.m_shiftDown;
			mWidget->NextFocus(shifted);
			break;
		}
		case 32:    //SPACE. Activates button. Don't focus to the input line.
		{
                  BoxClicked();
			break;
		}
		default:
		{
                  mWidget->FocusToInput((char)event.KeyCode());
			break;
		}
	}
}
#endif

void CxCheckBox::Focus()
{
	SetFocus();
}

void CxCheckBox::Disable(Boolean disabled)
{
#ifdef __WINDOWS__
	if(disabled)
            EnableWindow(false);
	else
            EnableWindow(true);
#endif
#ifdef __LINUX__
	if(disabled)
            Enable(false);
	else
            Enable(true);
#endif
}
