////////////////////////////////////////////////////////////////////////
//   CRYSTALS Interface      Class CxMultiEdit
////////////////////////////////////////////////////////////////////////
//   Filename:  CxMultiEdit.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   $Log: cxmultiedit.cc,v $
//   Revision 1.27  2011/03/04 05:58:30  rich
//   Fix font storage on wx
//
//   Revision 1.26  2008/09/22 12:31:37  rich
//   Upgrade GUI code to work with latest wxWindows 2.8.8
//   Fix startup crash in OpenGL (cxmodel)
//   Fix atom selection infinite recursion in cxmodlist
//
//   Revision 1.25  2005/01/23 10:20:24  rich
//   Reinstate CVS log history for C++ files and header files. Recent changes
//   are lost from the log, but not from the files!
//
//   Revision 1.2  2005/01/12 13:15:56  rich
//   Fix storage and retrieval of font name and size on WXS platform.
//   Get rid of warning messages about missing bitmaps and toolbar buttons on WXS version.
//
//   Revision 1.1.1.1  2004/12/13 11:16:18  rich
//   New CRYSTALS repository
//
//   Revision 1.24  2004/09/17 14:03:54  rich
//   Better support for accessing text in Multiline edit control from scripts.
//
//   Revision 1.23  2004/06/24 09:12:02  rich
//   Replaced home-made strings and lists with Standard
//   Template Library versions.
//
//   Revision 1.22  2004/05/17 13:44:56  rich
//   Fixed Linux build.
//
//   Revision 1.21  2004/05/13 17:21:43  rich
//   Fix build problem following today's checkins.
//
//   Revision 1.20  2004/05/13 09:14:49  rich
//   Re-invigorate the MULTIEDIT control. Currently not used, but I have
//   something in mind for it.
//
//   Revision 1.19  2003/11/28 10:29:11  rich
//   Replace min and max macros with CRMIN and CRMAX. These names are
//   less likely to confuse gcc.
//
//   Revision 1.18  2003/05/07 12:18:58  rich
//
//   RIC: Make a new platform target "WXS" for building CRYSTALS under Windows
//   using only free compilers and libraries. Hurrah, but it isn't very stable
//   yet (CRYSTALS, not the compilers...)
//
//   Revision 1.17  2001/06/17 14:34:05  richard
//
//   CxDestroyWindow function.
//
//   Revision 1.16  2001/03/08 16:44:10  richard
//   General changes - replaced common functions in all GUI classes by macros.
//   Generally tidied up, added logs to top of all source files.
//

#include    "crystalsinterface.h"
#include    <string>
using namespace std;

#include    "cxmultiedit.h"
#include    "cxgrid.h"
#include    "cccontroller.h"
#include    "crmultiedit.h"
#include    "crgrid.h"

#ifdef CRY_USEWX
// These macros are being defined somewhere. They shouldn't be.

 #ifdef GetCharWidth
  #undef GetCharWidth
 #endif
 #ifdef DrawText
  #undef DrawText
 #endif
#endif


int CxMultiEdit::mMultiEditCount = kMultiEditBase;

CxMultiEdit *   CxMultiEdit::CreateCxMultiEdit( CrMultiEdit * container, CxGrid * guiParent )
{
        CxMultiEdit *theMEdit = new CxMultiEdit (container);
#ifdef CRY_USEMFC
        theMEdit->Create(ES_LEFT| ES_AUTOHSCROLL| ES_AUTOVSCROLL| WS_VSCROLL| WS_HSCROLL| WS_VISIBLE| WS_CHILD| ES_MULTILINE, CRect(0,0,10,10), guiParent, mMultiEditCount++);
        theMEdit->ModifyStyleEx(NULL,WS_EX_CLIENTEDGE,0);
        theMEdit->Init();
#else
        theMEdit->Create(guiParent, -1, "EditBox", wxPoint(0,0), wxSize(10,10), wxTE_MULTILINE);
#endif
        return theMEdit;
}

CxMultiEdit::CxMultiEdit( CrMultiEdit * container )
: BASEMULTIEDIT ()
{
      ptr_to_crObject = container;
      mIdealHeight = 30;
      mIdealWidth  = 70;
      mHeight = 40;
}

CxMultiEdit::~CxMultiEdit()
{
      RemoveMultiEdit();
}

void CxMultiEdit::CxDestroyWindow()
{
#ifdef CRY_USEMFC
    DestroyWindow();
#else
    Destroy();
#endif
}


void  CxMultiEdit::SetText( const string & cText )
{
// Add the text.
#ifdef CRY_USEMFC
      int oldend = GetWindowTextLength();
      SetSel( oldend, oldend );
      ReplaceSel(cText.c_str());
#else
      AppendText(cText.c_str());
#endif

//Now scroll the text so that the last line is at the bottom of the screen.
//i.e. so that the line at lastline-firstvisline is the first visible line.
#ifdef CRY_USEMFC
/*      int charheight = mHeight;
      LineScroll ( GetLineCount() - GetFirstVisibleLine() - (int)( (float)GetHeight() / (float)charheight ) );
*/
      SetRedraw(false);
      SCROLLINFO si = { sizeof(si) };
      GetScrollInfo(SB_VERT, &si, SIF_ALL);
      int nTotalLines = GetLineCount();
      int nUpLine = 0;

      if (nTotalLines > 0  &&  si.nMax > 0  &&  si.nMax / nTotalLines > 0) {      
    nUpLine = (si.nMax - si.nPos - (si.nPage - 1)) / (si.nMax / nTotalLines);
      }

      if (nUpLine > 0) {
           LineScroll(nUpLine);
      }
      SetRedraw(true);
      Invalidate();
#else
      ShowPosition ( GetLastPosition () );
#endif
}


int CxMultiEdit::GetNLines()
{
 #ifdef CRY_USEMFC
    return GetLineCount();
 #endif          
 #ifdef CRY_USEWX
    return GetNumberOfLines();
 #endif
}

int CxMultiEdit::GetIdealWidth()
{
    return mIdealWidth;
}
int CxMultiEdit::GetIdealHeight()
{
    return mIdealHeight;
}

void CxMultiEdit::SetIdealHeight(int nCharsHigh)
{
#ifdef CRY_USEMFC
      mIdealHeight = nCharsHigh * mHeight;
#endif
#ifdef CRY_USEWX
      mIdealHeight = nCharsHigh * GetCharHeight();
#endif
}

void CxMultiEdit::SetIdealWidth(int nCharsWide)
{
#ifdef CRY_USEMFC
    CClientDC cdc(this);
    TEXTMETRIC textMetric;
    cdc.GetTextMetrics(&textMetric);
      int owidth = textMetric.tmAveCharWidth;
      mIdealWidth = nCharsWide * owidth;
#endif
#ifdef CRY_USEWX
      mIdealWidth = nCharsWide * GetCharWidth();
#endif
}


CXSETGEOMETRY(CxMultiEdit)

CXGETGEOMETRIES(CxMultiEdit)



void CxMultiEdit::Focus()
{
    SetFocus();
}

#ifdef CRY_USEMFC
BEGIN_MESSAGE_MAP(CxMultiEdit, CRichEditCtrl)
    ON_WM_CHAR()
END_MESSAGE_MAP()
#endif
#ifdef CRY_USEWX
//wx Message Table
BEGIN_EVENT_TABLE(CxMultiEdit, wxTextCtrl)
      EVT_CHAR( CxMultiEdit::OnChar )
END_EVENT_TABLE()
#endif

#ifdef CRY_USEMFC
void CxMultiEdit::OnChar( UINT nChar, UINT nRepCnt, UINT nFlags )
{
    NOTUSED(nRepCnt);
    NOTUSED(nFlags);
    switch(nChar)
    {
        case 9:     //TAB. Shift focus back or forwards.
        {
            bool shifted = ( HIWORD(GetKeyState(VK_SHIFT)) != 0) ? true : false;
            ptr_to_crObject->NextFocus(shifted);
            break;
        }
        default:
        {
            if(ptr_to_crObject->mDisabled)
                ptr_to_crObject->FocusToInput((char)nChar);
            else
                CRichEditCtrl::OnChar( nChar, nRepCnt, nFlags );
        }
    }
}
#endif
#ifdef CRY_USEWX
void CxMultiEdit::OnChar( wxKeyEvent & event )
{
      switch(event.GetKeyCode())
    {
        case 9:     //TAB. Shift focus back or forwards.
        {
                  bool shifted = event.m_shiftDown;
            ptr_to_crObject->NextFocus(shifted);
            break;
        }
        default:
        {
            if(ptr_to_crObject->mDisabled)
                        ptr_to_crObject->FocusToInput((char)event.GetKeyCode());
            else
                        event.Skip();
                  break;
        }
    }
}
#endif



void CxMultiEdit::Spew()
{
//Send all text to crystals a line at a time.
    char theLine[80];
    int line = 0;
#ifdef CRY_USEMFC
    while ( LineIndex(line) >= 0 )
    {
       int cp = GetLine(line, theLine, 79);
#endif
#ifdef CRY_USEWX
    for (int i=0; i<GetNumberOfLines(); i++)
    {
       wxString aline = GetLineText(i);
       int cp = CRMIN ( aline.length(), 80 );
       strcpy ( (char*)&theLine, aline.c_str() );
#endif
       theLine[cp]='\0';
       string sline = string( theLine );
       string::size_type cut;
       string delimiters = "\r\n\0";
       while ( ( cut = sline.find_first_of(delimiters) ) < sline.length() )
       {
          sline = sline.substr(0,cut);
       }
       ((CrMultiEdit*)ptr_to_crObject)->SendCommand( sline );
       line++;
    }
}


void CxMultiEdit::Empty()
{
#ifdef CRY_USEMFC
      SetSel( 0, GetWindowTextLength() );
      Clear();
#endif
#ifdef CRY_USEWX
      Clear();
#endif
}

void CxMultiEdit::SetFontHeight( int height )
{

#ifdef CRY_USEMFC
      CHARFORMAT cf;
      cf.dwMask = ( CFM_SIZE ) ; //Use the CFM_SIZE attribute
      mHeight = (int)((height + 20) / 10.0);
      cf.yHeight = height;

      SetSel(0, -1);
      SetSelectionCharFormat( cf );
      SetSel(GetTextLength(),-1);
#endif

}

void CxMultiEdit::Init()
{
#ifdef CRY_USEMFC
    CHARFORMAT cf;
    GetDefaultCharFormat( cf );
    string face = (CcController::theController)->GetKey( "FontFace" );
    for (string::size_type i=0;i<LF_FACESIZE;i++)
    {
      if ( i < face.length() )
          cf.szFaceName[i] = face[i];
      else
          cf.szFaceName[i] = 0;
    }
    cf.dwMask = ( cf.dwMask | CFM_FACE ) ; //Add the CFM_FACE attribute
    cf.bPitchAndFamily = (FIXED_PITCH|FF_MODERN);
    SetDefaultCharFormat( cf );
#endif


#ifdef CRY_USEWX
    wxFont* pFont = new wxFont(12,wxMODERN,wxNORMAL,wxNORMAL);
#ifndef _WINNT
    *pFont = wxSystemSettings::GetFont( wxSYS_ANSI_FIXED_FONT );
#else
   *pFont = wxSystemSettings::GetFont( wxDEVICE_DEFAULT_FONT );
#endif  // !_WINNT

    string temp;
    temp = (CcController::theController)->GetKey( "FontInfo" );
    if ( temp.length() ) pFont->SetNativeFontInfo( temp.c_str() );

	/*temp = (CcController::theController)->GetKey( "FontHeight" );
    if ( temp.length() )  pFont->SetPointSize( CRMAX( 2, atoi( temp.c_str() ) ) );
    temp = (CcController::theController)->GetKey( "FontFace" );
    if ( temp.length() )  pFont->SetFaceName( temp.c_str() );*/
    SetFont ( *pFont );
#endif

}

#ifdef CRY_USEWX
void CxMultiEdit::SaveAs(string filename)
{
    SaveFile( filename.c_str() );
}
#endif

#ifdef CRY_USEMFC
void CxMultiEdit::SaveAs(string filename)
{
    CFile file;
    file.Open(filename.c_str(), CFile::modeCreate | CFile::modeWrite);
    
    EDITSTREAM es;
    es.dwCookie = (DWORD) &file;
    es.pfnCallback = CxMultiEdit::MyStreamOutCallback; 

    StreamOut(SF_TEXT, es);
    file.Close();
}

DWORD CALLBACK CxMultiEdit::MyStreamOutCallback(DWORD dwCookie, LPBYTE pbBuff, LONG cb, LONG *pcb)
{
   CFile* pFile = (CFile*) dwCookie;

   pFile->Write(pbBuff, cb);
   *pcb = cb;

   return 0;
}
#endif

/*
void CxMultiEdit::Open(string filename)
{

}
*/
