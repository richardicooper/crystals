////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CcPoint

////////////////////////////////////////////////////////////////////////

//   Filename:  CcPoint.h
//   Authors:   Richard Cooper 
//   Created:   26.5.1999 01:41 Hours

#ifndef           __CcPoint_H__
#define           __CcPoint_H__
 
class CcPoint
{
	public:
		// methods
            CcPoint();
            CcPoint( const CcPoint &inPoint );
            CcPoint( const int x, const int y );
            ~CcPoint();
            void  Set( const int x, const int y );
            const int   X();
            const int   Y();
            CcPoint&     operator=( const CcPoint &inPoint );
		
		// attributes
            int   x;
            int   y;
};
#endif
