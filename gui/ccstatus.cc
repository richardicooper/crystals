////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CcStatus

////////////////////////////////////////////////////////////////////////

//   Filename:  CcStatus.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   26.2.1998 9:36 Uhr
//   $Log: not supported by cvs2svn $
//   Revision 1.10  2004/06/24 09:12:01  rich
//   Replaced home-made strings and lists with Standard
//   Template Library versions.
//
//   Revision 1.9  2003/05/07 12:18:56  rich
//
//   RIC: Make a new platform target "WXS" for building CRYSTALS under Windows
//   using only free compilers and libraries. Hurrah, but it isn't very stable
//   yet (CRYSTALS, not the compilers...)
//
//   Revision 1.8  2002/01/31 14:39:36  ckp2
//   RIC: SetBondType function for ccstatus. Allows popup-menus to vary depending on
//   the bond type that has been clicked on.
//
//   Revision 1.7  2001/12/13 20:45:30  ckp2
//   RIC: (Bug) CcStatus was going out of it's way to ignore script exit signals
//   and failing to instruct cccontroller to remove any modal windows left open by
//   bad scripts. (It used to work, until the MENUUP messages were rationalised last
//   month).
//
//   Revision 1.6  2001/06/17 15:18:26  richard
//   Notice when scripts exit (status bit 5 changes) and call ScriptsExited to
//   close any modal windows that have been accidentally left open. Windows with
//   the STAYOPEN property (notably the MAIN window) are exempt.
//
//   Revision 1.5  2001/03/08 15:22:11  richard
//   New flag signalling that the model window is in a ZOOMED in state.
//   Call to UpdateToolbars, when status changes, updates toolbar buttons, normal
//   buttons and windows with the DISABLEIF, ENABLEIF flags.
//

#include    "crystalsinterface.h"
#include <string>
#include <deque>
using namespace std;

#include "cccontroller.h"
#include        "crconstants.h"
#include    "ccstatus.h"

CcStatus::CcStatus()
{
    statusFlags = 0;
}

CcStatus::~CcStatus()
{
}

void CcStatus::SetNumSelectedAtoms(int nSelected)
{
    //nSelected;
    UnSetBit(16,&statusFlags);
    UnSetBit(17,&statusFlags);
    UnSetBit(18,&statusFlags);
    UnSetBit(19,&statusFlags);
    UnSetBit(20,&statusFlags);
    if (nSelected == 0)
        SetBit(16,&statusFlags);
    else if(nSelected == 1)
        SetBit(17,&statusFlags);
    else if(nSelected == 2)
        SetBit(18,&statusFlags);
    else if(nSelected == 3)
        SetBit(19,&statusFlags);

    if(nSelected >= 3)
        SetBit(20,&statusFlags);

    UpdateToolBars();
}

void CcStatus::SetZoomedFlag(bool zoomed)
{
  if (zoomed)  SetBit(21,&statusFlags);
  else       UnSetBit(21,&statusFlags);

  UpdateToolBars();
}


void CcStatus::SetBondType(int bt)
{
  UnSetBit(22,&statusFlags);
  UnSetBit(23,&statusFlags);
  UnSetBit(24,&statusFlags);

  switch ( bt ) {
    case BOND_NORM:
      SetBit(22,&statusFlags);
      break;
    case BOND_SYMM:
      SetBit(23,&statusFlags);
      break;
    case BOND_AROMATIC:
      SetBit(24,&statusFlags);
      break;
    default:
      break;
  }
}

bool CcStatus::ShouldBeEnabled(int enableFlags, int disableFlags)
{
    if( disableFlags & statusFlags )           //If any bits match, then should be disabled.
            return false;
    if ( enableFlags & ( ~statusFlags) ) //If any 0's in the statusFlag match any 1's in the enableFlags, then should be disabled.
            return false;

      return true;   //Otherwise, enable.
}


void CcStatus::SetBit(int i, int* theFlag)
{
    int addbit = 1;
    for (int j = 0; j < i; j++) addbit *= 2;

    *theFlag |= addbit;
}

void CcStatus::UnSetBit(int i, int * theFlag)
{
    int addbit = 1;
    for (int j = 0; j < i; j++) addbit *= 2;

    *theFlag &= (~addbit);
}



int CcStatus::CreateFlag(const string & text)
{
    int returnFlag = 0;
    int bit;
    deque<string> tokens;
    deque<string>::iterator stri, end;

    CcController::MakeTokens(text,tokens);

    end = tokens.end();
    for ( stri = tokens.begin(); stri < end; stri++ )
    {
       bit = GetBitByToken( *stri );
       if(bit >= 0)  SetBit(bit,&returnFlag);
    }
    return returnFlag;
}

int CcStatus::GetBitByToken(string & token)
{
//   newway           if(token==string(bS0))  return 0;
//   oldway           if(token==string(bS1))  {SetBit(1,flag);return;}
#define CHECKTOKEN(a) if(token.compare(bS##a)==0) return a;
#ifdef bs0
    CHECKTOKEN(0)
#endif
#ifdef bs1
    CHECKTOKEN(1)
#endif
#ifdef bs2
    CHECKTOKEN(2)
#endif
#ifdef bs3
    CHECKTOKEN(3)
#endif
#ifdef bs4
    CHECKTOKEN(4)
#endif
#ifdef bs5
    CHECKTOKEN(5)
#endif
#ifdef bs6
    CHECKTOKEN(6)
#endif
#ifdef bs7
    CHECKTOKEN(7)
#endif
#ifdef bs8
    CHECKTOKEN(8)
#endif
#ifdef bs9
    CHECKTOKEN(9)
#endif
#ifdef bs10
    CHECKTOKEN(10)
#endif
#ifdef bs11
    CHECKTOKEN(11)
#endif
#ifdef bs12
    CHECKTOKEN(12)
#endif
#ifdef bs13
    CHECKTOKEN(13)
#endif
#ifdef bs14
    CHECKTOKEN(14)
#endif
#ifdef bs15
    CHECKTOKEN(15)
#endif
#ifdef bs16
    CHECKTOKEN(16)
#endif
#ifdef bs17
    CHECKTOKEN(17)
#endif
#ifdef bs18
    CHECKTOKEN(18)
#endif
#ifdef bs19
    CHECKTOKEN(19)
#endif
#ifdef bs20
    CHECKTOKEN(20)
#endif
#ifdef bs21
    CHECKTOKEN(21)
#endif
#ifdef bs22
    CHECKTOKEN(22)
#endif
#ifdef bs23
    CHECKTOKEN(23)
#endif
#ifdef bs24
    CHECKTOKEN(24)
#endif
#ifdef bs26
    CHECKTOKEN(25)
#endif
#ifdef bs26
    CHECKTOKEN(26)
#endif
#ifdef bs27
    CHECKTOKEN(27)
#endif
#ifdef bs28
    CHECKTOKEN(28)
#endif
#ifdef bs29
    CHECKTOKEN(29)
#endif
#ifdef bs30
    CHECKTOKEN(30)
#endif
#ifdef bs31
    CHECKTOKEN(31)
#endif
    return -1; //Tokenn not matched.
}


void CcStatus::ParseInput(deque<string> &  tokenList)
{
    bool moreTokens = true;
    while (moreTokens && ! tokenList.empty())
    {
        switch(CcController::GetDescriptor( tokenList.front(), kStatusClass ))
        {
            case kTSetStatus:
            {
                tokenList.pop_front();
                int setFlags = CreateFlag(tokenList.front());
                tokenList.pop_front();
                statusFlags |= setFlags;
                break;
            }
            case kTUnSetStatus:
            {
                tokenList.pop_front();
                int unSetFlags = CreateFlag(tokenList.front());
                tokenList.pop_front();
                if (( unSetFlags & 32 ) && ( statusFlags & 32 )) ScriptsExited();
                statusFlags &= (~unSetFlags);
                break;
            }
            default:
            {
                moreTokens = false;
                break;
            }

        }
    }
    UpdateToolBars();
}

void CcStatus::UpdateToolBars()
{
  // Unlike menus, the toolbars don't recieve events telling them
  // to update during idle time.
  // So we'll do it from here.

  (CcController::theController)->UpdateToolBars();


}

void CcStatus::ScriptsExited()
{
  //Use this fact to close any modal windows that don't
  //have the STAYOPEN property. (This means that the script
  //has terminated incorrectly without closing the window).

  (CcController::theController)->ScriptsExited();

}
