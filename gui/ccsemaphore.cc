/*
 *  CcSemaphore.cpp
 *  
 *
 *  Created by Stefan Pantos on 28/01/2005.
 *
 */
 
 // $Log: not supported by cvs2svn $
#include "crystalsinterface.h"
#include "ccsemaphore.h"

/* Creates a semaphore which will allow you to 
limit the number of threads which can be running 
on a resourse concurrently*/
#if defined(__CR_WIN__)
CcSemaphore::CcSemaphore(const int pInitValue, const int pMaxCount):iSemaphore(CreateSemaphore(NULL, pInitValue, pMaxCount, NULL))
#else
CcSemaphore::CcSemaphore(const int pInitValue, const int pMaxCount):iSemaphore(pInitValue, pMaxCount)
#endif
{
}

void CcSemaphore::wait(const unsigned int pTime) throw(semaphore_timeout, semaphore_error)
{
	error_type tResult;
	#if defined(__CR_WIN__)
	tResult = WaitForSingleObject( iSemaphore, pTime)
	#warning This my not be correct for the windows version. Please check. Might need to check for other errors.
	if (tResult == WAIT_TIMEOUT)
	{
		throw semaphore_timeout();
	}
	else if (tResult == WAIT_OBJECT_0)
	{
		return;
	}
	#else
	if (pTime != kSemaphoreWaitInfinatly)
	{
		tResult = iSemaphore.WaitTimeout(pTime);
	}
	else
	{
		tResult = iSemaphore.Wait();
	}
	if (tResult == wxSEMA_TIMEOUT)
	{
		throw semaphore_timeout();
	}
	else if (tResult == wxSEMA_NO_ERROR)
	{
		return;
	}
	#endif
	throw semaphore_error(tResult);
}

void CcSemaphore::signal() throw(semaphore_error)
{
	#if defined(__CR_WIN__)
		if (ReleaseSemaphore( iSemaphore, 1, NULL ) == 0)
		{
			throw semaphore_error(GetLastError());
		}
	#else
		error_type tResult;
		if ((tResult = iSemaphore.Post()) != wxSEMA_NO_ERROR)
			throw semaphore_error(tResult);
	#endif
}



