// rMenuItem.cpp: implementation of the CcMenuItem class.
//
//////////////////////////////////////////////////////////////////////

#include "crystalsinterface.h"
#include	"crconstants.h"
#include "crystals.h"
#include "ccmenuitem.h"
#include "crmenu.h"
#include "cxmenu.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CcMenuItem::CcMenuItem(CrMenu* parentmenu)
{
	type = 100;
	id = 0;
	name = "defaultName";
	originaltext = text = "defaultText";
	originalcommand = command = "defaultCommand";
	ptr = nil;
	disable = 0;
	enable = 0;
	parent = parentmenu;

}

CcMenuItem::~CcMenuItem()
{

}

void CcMenuItem::SetText(CcString theText)
{
	if( parent != nil)
		((CxMenu*)parent->mWidgetPtr)->SetText(theText,id);
	text = theText;
}
