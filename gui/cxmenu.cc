////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CxMenu

////////////////////////////////////////////////////////////////////////

#include    "crystalsinterface.h"
#include    <string>
#include    <sstream>
using namespace std;
#include    "cccontroller.h"
#include    "crmenu.h"
#include    "cxmenu.h"


int CxMenu::mMenuCount = kMenuBase;
CxMenu *    CxMenu::CreateCxMenu( CrMenu * container, CxMenu * guiParent, bool popup )
{
    CxMenu  *theMenu = new CxMenu( container );
#ifdef __CR_WIN__
    if(popup)
        theMenu->CreatePopupMenu();
    else
        theMenu->CreateMenu();
#endif
      return theMenu;
}

CxMenu::CxMenu( CrMenu * container )
:BASEMENU()
{
    ptr_to_crObject = container;
}

CxMenu::~CxMenu()
{
}

//To do: Add by position

int CxMenu::AddMenu(CxMenu * menuToAdd, const string & text, int position)
{
      int id = CrMenu::FindFreeMenuId();
#ifdef __CR_WIN__
      InsertMenu( (UINT)-1, MF_BYPOSITION|MF_STRING|MF_POPUP, (UINT)menuToAdd->m_hMenu, text.c_str());
#endif
#ifdef __BOTHWX__
      Append( id, text.c_str(), menuToAdd);
      ostringstream strm;
      strm <<  "cxmenu " << (long)this << " adding submenu called " << 
text;
      LOGSTAT ( strm.str() );
#endif
      return id;
}

int CxMenu::AddItem(const string & text, int position)
{
      int id = CrMenu::FindFreeMenuId();
#ifdef __CR_WIN__
      InsertMenu( (UINT)-1, MF_BYPOSITION|MF_STRING, (UINT)id, text.c_str());
#endif
#ifdef __BOTHWX__
      Append( id, wxString(text.c_str()), wxString("") );
      ostringstream strm;
      strm << "cxmenu " << (long)this << " adding item called " << text ;
      LOGSTAT (strm.str());
#endif
    return id;
}

int CxMenu::AddItem(int position)
{
      int id = CrMenu::FindFreeMenuId();
#ifdef __CR_WIN__
      InsertMenu( (UINT)-1, MF_BYPOSITION|MF_SEPARATOR, (UINT)id);
#endif
#ifdef __BOTHWX__
      AppendSeparator();
#endif
    return id;
}


void CxMenu::SetText(const string & theText, int id)
{
#ifdef __CR_WIN__
    ModifyMenu(id, MF_BYCOMMAND|MF_STRING, id, theText.c_str());
#endif
#ifdef __BOTHWX__
      SetLabel( id, theText.c_str() );
#endif
}

void CxMenu::SetTitle(const string & theText, CxMenu* ptr)
{
#ifdef __CR_WIN__
    for ( int i = 0; i < (int)GetMenuItemCount() ; i++ )
    {
       CxMenu* subm = (CxMenu*)GetSubMenu(i);
       if (!subm) continue;
       if (!subm->m_hMenu) continue;

       if ( subm == ptr ) {
          ModifyMenu(i, MF_BYPOSITION|MF_STRING, i, theText.c_str());
          break;
       }
    }
#endif
#ifdef __BOTHWX__
      wxMenu::SetTitle( theText.c_str() );
#endif
}

void CxMenu::PopupMenuHere(int x, int y, void *window)
{
#ifdef __CR_WIN__
      TrackPopupMenu(
                 TPM_LEFTALIGN | TPM_LEFTBUTTON | TPM_RIGHTBUTTON,
                  x, y, (CWnd*)window);
#endif
#ifdef __BOTHWX__
// This is handled by the window class. But that's easy:
      ((wxWindow*)window)->PopupMenu(this, x, y);
#endif
}

void CxMenu::EnableItem( int id, bool enable )
{
#ifdef __CR_WIN__
      if (enable)
         EnableMenuItem( id, MF_ENABLED|MF_BYCOMMAND);
      else
         EnableMenuItem( id, MF_GRAYED|MF_BYCOMMAND);
#endif
#ifdef __BOTHWX__
         Enable( id, enable );
#endif
}
