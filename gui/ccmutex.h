/*
 *  CcMutex.h
 *  
 *
 *  Created by Stefan Pantos on 01/02/2005.
 *
 */
 
 // $Log: not supported by cvs2svn $
#if !defined(CcMutex_H__)
#define CcMutex_H__

#ifdef __BOTHWX__
#include <wx/thread.h>
#endif

#include "ccthreadingexceptions.h"

using namespace std;

class CcMutex
{
	private:
		#if defined(__CR_WIN__)
		HANDLE iMutex;
		#else
		wxMutex iMutex;
		#endif
	public:
		CcMutex();
		~CcMutex();
		void Lock()throw(mutex_error);
		bool TryLock()throw(mutex_error);
		void Unlock()throw(mutex_error);
};


/*
 *  This class locks when it is created and then releases when deleted.
 *  Very nifty locking mechanisem. The idea was stolen from Boost.
 */
class CcLifeTimeLock
{
	private:
		CcMutex* iLock;
	public:
		CcLifeTimeLock(CcMutex& pLock) throw(logic_error);
		~CcLifeTimeLock();
};
#endif