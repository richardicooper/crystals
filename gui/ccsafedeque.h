/*
 *  ccsafedeque.h
 *  
 *
 *  Created by Stefan Pantos on 27/01/2005.
 *  This is a thread safe version of the deque template.
 *  reduces the work which is needed to prevent dead locks.
 *  Can be used safely in the knowledge that two threads
 *  cannot write to it at the same time.
 */
 
 // $Log: not supported by cvs2svn $
 // Revision 1.1  2005/02/02 15:27:23  stefan
 // 1. Initial addition to crystals. A group of classes for threading.
 //
#if !defined(ccsafedeque_H__)
#define ccsafedeque_H__

#include <deque>
#include "ccsafesequences.h"

template <typename _Tp>
class  CcSafeDeque:public CcSafeSequence<_Tp, deque >
{
	public:
		CcSafeDeque() : CcSafeSequence<_Tp, deque >()
		{}
		
		CcSafeDeque(const deque<_Tp>& a): CcSafeSequence<_Tp, deque >(a)
		{}
};
#endif
