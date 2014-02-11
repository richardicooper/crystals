#if !defined (CRY_USEMFC)

#include "crystalsinterface.h"
#include "crystals.h"
#include <wx/thread.h>
#include "ccthread.h"

UINT CrystalsThreadProc( void* arg );


void * CcThread::Entry()
{
      CrystalsThreadProc( nil );
      return nil;
}

#endif
