////////////////////////////////////////////////////////////////////////
//   CRYSTALS Interface      Class CxToolBar
////////////////////////////////////////////////////////////////////////
//   Filename:  CxToolBar.cc
//   Authors:   Richard Cooper
//   Created:   27.1.2001 09:48
//   $Log: not supported by cvs2svn $
//   Revision 1.16  2004/10/12 12:11:45  rich
//   Remove extra slashes from paths.
//
//   Revision 1.15  2004/10/06 13:57:26  rich
//   Fixes for WXS version.
//
//   Revision 1.14  2004/06/24 09:12:02  rich
//   Replaced home-made strings and lists with Standard
//   Template Library versions.
//
//   Revision 1.13  2003/11/28 10:29:11  rich
//   Replace min and max macros with CRMIN and CRMAX. These names are
//   less likely to confuse gcc.
//
//   Revision 1.12  2003/09/16 16:40:48  rich
//   Always return a value in AddTool
//
//   Revision 1.11  2003/09/11 17:50:50  rich
//   AddTool now returns a value so we can tell if it fails.
//
//   Revision 1.10  2003/05/07 12:18:58  rich
//
//   RIC: Make a new platform target "WXS" for building CRYSTALS under Windows
//   using only free compilers and libraries. Hurrah, but it isn't very stable
//   yet (CRYSTALS, not the compilers...)
//
//   Revision 1.9  2003/01/14 10:27:19  rich
//   Bring all sources up to date on Linux. Still not working: Plots, ModList, ListCtrl
//
//   Revision 1.8  2002/07/15 12:19:13  richard
//   Reorder headers to improve ease of linking.
//   Update program to use new standard C++ io libraries.
//   Update to use new version of MFC (5.0 with .NET.)
//
//   Revision 1.7  2002/07/08 11:37:36  richard
//   Remove text from toolbars to save screen space, instead added "tooltips"
//   to say what each button does.
//
//   Revision 1.6  2002/07/03 14:23:21  richard
//   Replace as many old-style stream class header references with new style
//   e.g. <iostream.h> -> <iostream>. Couldn't change the ones in string however, yet.
//
//   Removed OnStuffToProcess message from WinApp, it doesn't compile under the new
//   stricter C++7.0 compiler. (CWinApp isn't a CWnd, so can't recieve messages?)
//
//   Removed some bits from Steve's Plot classes that were generating (harmless) compiler
//   warning messages.
//
//   Revision 1.5  2001/11/14 10:30:41  ckp2
//   Various changes to the painting of the background of Windows as some of the
//   dialogs suddenly went white under XP.
//
//   Revision 1.4  2001/09/07 14:37:22  ckp2
//   Bug under un-updated versions of Win95 causes the toolbars to be created
//   with ridiculous dimensions. This fix limits the maximum toolbar size
//   to 200x1600 - still ridiculous, but at least you'll be able to see what's
//   happening, and perhaps just hide the toolbars away.
//
//   Revision 1.3  2001/07/16 07:37:19  ckp2
//   wx: Get better guess at ideal toolbar size. Sub-class native toolbar class in
//   order to process ON_CHAR messages.
//
//   Revision 1.2  2001/06/17 14:27:40  richard
//   wx Support.
//   Catch bad bitmaps.
//   Destroy window function.
//
//   Revision 1.1  2001/02/26 12:02:15  richard
//   New toolbar classes.
//

#include    "crystalsinterface.h"
#include    "cxwindow.h"

#include    "crtoolbar.h"
#include    "cxtoolbar.h"
#include    "cxgrid.h"
#include    "cccontroller.h"

#ifdef __BOTHWX__
#include <wx/settings.h>
#include <iostream>
#endif


#ifdef __BOTHWX__
BEGIN_EVENT_TABLE(mywxToolBar, wxToolBar)
      EVT_CHAR( mywxToolBar::OnChar )
END_EVENT_TABLE()

void mywxToolBar::OnChar(wxKeyEvent &event){CcController::theController->FocusToInput((char)event.GetKeyCode());}
#endif


int CxToolBar::mToolBarCount = kToolBarBase;

CxToolBar * CxToolBar::CreateCxToolBar( CrToolBar * container, CxGrid * guiParent )
{
// You won't see many examples like this. The CxToolBar is just a plain
// CWnd or wxWindow ( a base class general purpose window ). After it's
// creation we create an actual toolbar and make the CxToolBar its parent.
// MFC likes to move the toolbar to the top or bottom of the parent window,
// so this gets around that by letting us control the position of the
// parent window.

    CxToolBar *theCxToolBar = new CxToolBar( container );


#ifdef __CR_WIN__
    theCxToolBar->EnableToolTips(TRUE);
    theCxToolBar->Create(NULL, NULL, WS_CHILD| WS_VISIBLE, CRect(0,0,5,5), guiParent, ++mToolBarCount);
    theCxToolBar->SetFont(CcController::mp_font);

    theCxToolBar->m_ToolBar->Create(WS_CHILD| WS_VISIBLE|TBSTYLE_FLAT|CCS_NODIVIDER|TBSTYLE_TOOLTIPS, CRect(0,0,5,5), theCxToolBar, mToolBarCount);
    theCxToolBar->m_ToolBar->SetFont(CcController::mp_font);
#endif
#ifdef __BOTHWX__
    theCxToolBar->Create(guiParent,-1);
    theCxToolBar->m_ToolBar->Create(theCxToolBar, ++mToolBarCount);
#endif
    return theCxToolBar;

}

CxToolBar::CxToolBar( CrToolBar * container )
      : BASETOOLBAR()
{
    ptr_to_crObject = container;
#ifdef __CR_WIN__
    m_ImageList = new CImageList();
    m_ImageList->Create(16,15,ILC_COLOR24|ILC_MASK,0,2);
    m_ToolBar = new CToolBarCtrl();
#endif
#ifdef __BOTHWX__
    m_ToolBar = new mywxToolBar();
    m_totWidth = 5;
#endif
    m_ImageIndex = 0;
}

CxToolBar::~CxToolBar()
{
  mToolBarCount--;
#ifdef __CR_WIN__
  delete m_ImageList;
  m_ToolBar->DestroyWindow();
  delete m_ToolBar;
#endif
#ifdef __BOTHWX__
  m_ToolBar->Destroy();
#endif
}

void CxToolBar::CxDestroyWindow()
{
  #ifdef __CR_WIN__
DestroyWindow();
#endif
#ifdef __BOTHWX__
Destroy();
#endif
}

bool    CxToolBar::AddTool( CcTool* newTool )
{
// Check if this is a separator.

  if ( newTool->toolType == CT_SEP )
  {
#ifdef __CR_WIN__
    TBBUTTON sepButton;
    sepButton.idCommand = 0;
    sepButton.fsStyle = TBSTYLE_SEP;
    sepButton.fsState = TBSTATE_ENABLED;
    sepButton.iString = 0;
    sepButton.iBitmap = 0;
    sepButton.dwData = 0;
    m_ToolBar->AddButtons(1,&sepButton);
#endif
#ifdef __BOTHWX__
    m_ToolBar->AddSeparator();
    m_totWidth += 8;
#endif                    
    newTool->CxID = 0;
    return true;
  }

//Find bitmap and add to list
//Check bitmap type

  int bitmapIndex=-1;
  newTool->CxID = CrToolBar::FindFreeToolId();

  if ( newTool->toolType == CT_APPICON )
  {
    string file = newTool->tImage;
#ifdef __CR_WIN__
    HICON hIcon = ExtractIcon( AfxGetInstanceHandle( ), file.c_str(), 0 );
    if( hIcon )
    {
      m_ImageList->Add( hIcon );
      bitmapIndex = m_ImageIndex++;
      DestroyIcon(hIcon);
    }
#endif
#ifdef __BOTHWX__
    wxIcon mycon( file.c_str(), wxBITMAP_TYPE_ICO_RESOURCE, -1, -1 );
    if ( mycon.Ok() )
    {
      m_ToolBar->AddTool(newTool->CxID, mycon, newTool->tText.c_str());
      m_ToolBar->Realize();
      m_ImageIndex++;
      m_totWidth += 23;
    }
    else
    {
       //Something wrong
       return false;
    }
#endif
  }
  else
  {
#ifdef __CR_WIN__
    CBitmap* abitmap = new CBitmap();
    HBITMAP hBmp;
#endif
    string crysdir ( getenv("CRYSDIR") );
    if ( crysdir.length() == 0 )
    {
#if defined(__WXGTK__) || defined(__WXMAC__)
	std::cerr << "You must set CRYSDIR before running crystals.\n";
#endif
      return false;
    }
    int nEnv = (CcController::theController)->EnvVarCount( crysdir );
    int i = 0;
    bool noLuck = true;
    while ( noLuck )
    {
      string dir = (CcController::theController)->EnvVarExtract( crysdir, i );
      i++;
#if defined(__WXGTK__) || defined(__WXMAC__)
      string file = dir + "script/" + newTool->tImage;
#endif
#ifdef __BOTHWIN__
      string file = dir + "script\\" + newTool->tImage;
#endif

#ifdef __BOTHWX__
      wxBitmap mymap ( file.c_str(), wxBITMAP_TYPE_BMP );
      if( mymap.Ok() )
      {
        noLuck = false;
        m_ToolBar->AddTool(newTool->CxID, mymap, newTool->tText.c_str(), "" );
        m_ToolBar->Realize();
        m_ImageIndex++;
        m_totWidth += 23;
      }
      else if ( i >= nEnv )
      {
        LOGERR ( "Bitmap not found " + newTool->tImage );
        return false;
      }
    }
#endif
#ifdef __CR_WIN__
      hBmp = (HBITMAP)::LoadImage( NULL, file.c_str(), IMAGE_BITMAP, 0,0, LR_LOADFROMFILE|LR_CREATEDIBSECTION);
      if( hBmp )
      {
        noLuck = false;
      }
      else if ( i >= nEnv )
      {
        LOGERR ( "Bitmap not found " + newTool->tImage );
        return false;
      }
    }
    abitmap->Attach( hBmp );

    BITMAP bm;
    abitmap->GetBitmap(&bm);
    if ( bm.bmWidth == 16 && bm.bmHeight == 15)
    {
      ReplaceBackgroundColor ( *abitmap );
//      m_bitmapList.push_back( abitmap );
      m_ImageList->Add( abitmap,  ::GetSysColor (COLOR_3DFACE));
      bitmapIndex = m_ImageIndex++;
    }
    else
    {
       LOGERR ("Bitmap, "+newTool->tImage+" is wrong height or width, must be 16 wide and 15 high.");
       return false;
    }
    delete abitmap;
#endif
  }

#ifdef __CR_WIN__
  m_ToolBar->SetImageList(m_ImageList);
  TBBUTTON tbbutton;
  tbbutton.iBitmap = bitmapIndex;
//  tbbutton.iString = m_ToolBar->AddStrings(newTool->tText.c_str());
  tbbutton.iString = 0;
  tbbutton.dwData = 0;
  tbbutton.fsState = TBSTATE_ENABLED;
  tbbutton.fsStyle = TBSTYLE_BUTTON;
  tbbutton.idCommand = newTool->CxID;
  if ( newTool->toggleable ) tbbutton.fsStyle = TBSTYLE_BUTTON|TBSTYLE_CHECK   ;
  m_ToolBar->AddButtons(1,&tbbutton);
#endif

  return true;

}

void    CxToolBar::SetGeometry( int top, int left, int bottom, int right )
{
#ifdef __CR_WIN__
      MoveWindow(left,top,right-left,bottom-top);
      m_ToolBar->MoveWindow(0,0,right-left,bottom-top);
#endif
#ifdef __BOTHWX__
      SetSize(left,top,right-left,bottom-top);
      m_ToolBar->SetSize(0,0,right-left,bottom-top);
// LOGSTAT ("CxToolbar: Setting width: " + string(right-left) );

#endif

}


CXGETGEOMETRIES(CxToolBar)


int CxToolBar::GetIdealWidth()
{
#ifdef __CR_WIN__
   SIZE tbs;
   m_ToolBar->GetMaxSize(&tbs);
   return CRMIN(1600,tbs.cx);
#endif
#ifdef __BOTHWX__
//   LOGSTAT ( "Toolsize = " + string ( m_ToolBar->GetToolBitmapSize().GetWidth() ) );
//   LOGSTAT ( "Toolsep = " + string ( m_ToolBar->GetToolSeparation() ) );
//   LOGSTAT ( "m_ImageIndex = " + string ( m_ImageIndex ) );
//   return (( 18 + 5 ) * m_ImageIndex ) ;
//   LOGSTAT ("CxToolbar: Returning ideal width: " + string(m_totWidth) );
   return ( m_totWidth ) ;
#endif
}

int CxToolBar::GetIdealHeight()
{
#ifdef __CR_WIN__
   SIZE tbs;
   m_ToolBar->GetMaxSize(&tbs);
   return CRMIN(200,tbs.cy+2);
#endif
#ifdef __BOTHWX__
   return 15 + 10;
#endif
}

#ifdef __CR_WIN__
BEGIN_MESSAGE_MAP(CxToolBar, BASETOOLBAR)
    ON_COMMAND_RANGE (kToolButtonBase, kToolButtonBase+5000, OnToolSelected)
    ON_NOTIFY_EX( TTN_NEEDTEXT, 0, OnToolTipNotify )
    ON_WM_CHAR()
END_MESSAGE_MAP()
#endif
#ifdef __BOTHWX__
//wx Message Map
BEGIN_EVENT_TABLE(CxToolBar, BASETOOLBAR)
      EVT_CHAR( CxToolBar::OnChar )
END_EVENT_TABLE()
#endif



#ifdef __CR_WIN__
BOOL CxToolBar::OnToolTipNotify( UINT id, NMHDR * pNMHDR, LRESULT * pResult )
{
 // need to handle both ANSI and UNICODE versions of the message
   TOOLTIPTEXTA* pTTTA = (TOOLTIPTEXTA*)pNMHDR;
   TOOLTIPTEXTW* pTTTW = (TOOLTIPTEXTW*)pNMHDR;
   CString strTipText;
   UINT nID = pNMHDR->idFrom;
   if (pNMHDR->code == TTN_NEEDTEXTA && (pTTTA->uFlags & TTF_IDISHWND) ||
      pNMHDR->code == TTN_NEEDTEXTW && (pTTTW->uFlags & TTF_IDISHWND))
   {
      // idFrom is actually the HWND of the tool
      nID = ::GetDlgCtrlID((HWND)nID);
   }

   if (nID != 0) // will be zero on a separator
   {
      CcTool* tool = CrToolBar::FindAnyTool(nID);
      if ( tool )
        strTipText = tool->tText.c_str();

   }
   lstrcpyn(pTTTA->szText, strTipText, sizeof(pTTTA->szText));
   *pResult = 0;

   return TRUE;    // message was handled
}
#endif

void CxToolBar::Focus()
{
   m_ToolBar->SetFocus();
}


CXONCHAR(CxToolBar)


#ifdef __CR_WIN__
void CxToolBar::ReplaceBackgroundColor (CBitmap& ioBM)
{
// figure out how many pixels there are in the bitmap

  BITMAP                bmInfo;
  ioBM.GetBitmap (&bmInfo);

// add support for additional bit depths if you choose
  const UINT numPixels (bmInfo.bmHeight * bmInfo.bmWidth);

// get a pointer to the pixels
  DIBSECTION  ds;
  ioBM.GetObject (sizeof (DIBSECTION), &ds);

  RGBTRIPLE* pixels = reinterpret_cast<RGBTRIPLE*>(ds.dsBm.bmBits);

// get the user's preferred button color from the system
  const COLORREF            buttonColor (::GetSysColor (COLOR_3DFACE));
  const RGBTRIPLE          kBackgroundColor = {
  pixels [0].rgbtBlue, pixels [0].rgbtGreen, pixels [0].rgbtRed};
  const RGBTRIPLE          userBackgroundColor = {
  GetBValue (buttonColor), GetGValue (buttonColor), GetRValue (buttonColor)};


// search through the pixels, substituting the button
// color for any pixel that has the magic background color
  for (UINT i = 0; i < numPixels; ++i)
  {
    if (pixels [i].rgbtBlue == kBackgroundColor.rgbtBlue
     && pixels [i].rgbtGreen == kBackgroundColor.rgbtGreen
     && pixels [i].rgbtRed == kBackgroundColor.rgbtRed)
    {
      pixels [i] = userBackgroundColor;
    }
  }
}
#endif


void CxToolBar::CxEnable(bool enable, int id)
{
#ifdef __CR_WIN__
  bool invcurrent = ( m_ToolBar->IsButtonEnabled(id) == 0 );
#endif
#ifdef __BOTHWX__
  bool invcurrent = ! (m_ToolBar->GetToolEnabled(id));
#endif

  if  ( invcurrent == enable )
  {
#ifdef __CR_WIN__
     m_ToolBar->EnableButton(id, enable);
#endif
#ifdef __BOTHWX__
     m_ToolBar->EnableTool(id, enable);
#endif
  }
}

void CxToolBar::CheckTool(bool check, int id)
{
#ifdef __CR_WIN__
 int cstate = m_ToolBar->GetState(id);
 if(check)
   m_ToolBar->SetState ( id, cstate | TBSTATE_CHECKED);
 else
   m_ToolBar->SetState ( id, cstate & ~TBSTATE_CHECKED);
#endif
#ifdef __BOTHWX__
 m_ToolBar->ToggleTool(id, check);
#endif


}


#ifdef __CR_WIN__
void CxToolBar::OnToolSelected(UINT nID)
{
#endif
#ifdef __BOTHWX__
void CxToolBar::OnToolSelected(wxCommandEvent & event)
{
      int nID = event.m_id;
#endif
    ((CrWindow*)(ptr_to_crObject->GetRootWidget()) )->ToolSelected( nID );
}
