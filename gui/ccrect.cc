////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CcRect

////////////////////////////////////////////////////////////////////////

//   Filename:  CcRect.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   26.2.1998 9:36 Uhr
//   $Log: not supported by cvs2svn $

#include    "crystalsinterface.h"
#include    "ccstring.h"
#include        "ccrect.h"


CcRect::CcRect()
{
    Set( 0, 0, 100, 100 );
}

CcRect::CcRect( const CcRect &inRect )
{
      mTop  = inRect.mTop;
      mLeft = inRect.mLeft;
      mBottom     = inRect.mBottom;
      mRight      = inRect.mRight;
}

CcRect::CcRect( CcString geomString )
{
      int len = geomString.Len();
      char str[] = "                                                                                ";
      strcpy(&str[0], geomString.ToCString());
      char delim[] = " ";
      char * top = strtok( str , delim);
      char * lef = strtok( NULL, delim);
      char * bot = strtok( NULL, delim);
      char * rig = strtok( NULL, delim);

      if ( top && lef && bot && rig )
      {
        mTop    = atoi ( top ) ;
        mLeft   = atoi ( lef ) ;
        mBottom = atoi ( bot ) ;
        mRight  = atoi ( rig ) ;
      }
      else
      {
            mTop   = mLeft = 0;
            mRight = mBottom = 6;
      }
}

CcString CcRect::AsString()
{
      CcString cgeom = CcString ( mTop )    + " "
                     + CcString ( mLeft )   + " "
                     + CcString ( mBottom ) + " "
                     + CcString ( mRight );

      return cgeom;
}


CcRect::CcRect( const int top, const int left, const int bottom, const int right )
{
    Set( top, left, bottom, right );
}

CcRect::~CcRect()
{
}

void    CcRect::Set( const int top, const int left, const int bottom, const int right )
{
    mTop    = top;
    mLeft   = left;
    mBottom = bottom;
    mRight  = right;
}

const int   CcRect::Top()
{
    return mTop;
}

const int   CcRect::Left()
{
    return mLeft;
}

const int   CcRect::Bottom()
{
    return mBottom;
}

const int   CcRect::Right()
{
    return mRight;
}

const int   CcRect::Height()
{
    return mBottom - mTop;
}

const int   CcRect::Width()
{
    return mRight - mLeft;
}

CcRect& CcRect::operator=( const CcRect &inRect )
{
    if ( this != &inRect )
    {
        mTop    = inRect.mTop;
        mLeft   = inRect.mLeft;
        mBottom = inRect.mBottom;
        mRight  = inRect.mRight;
    }

    return *this;
}

bool CcRect::Contains(int x, int y)
{
  return ( 
               (  ((x<=mRight)&&(x>=mLeft))  ||  ((x>=mRight)&&(x<=mLeft))  )
           &&  (  ((y<=mBottom)&&(y>=mTop))  ||  ((y>=mBottom)&&(y<=mTop))  )
         );
}


#ifdef __CR_WIN__
CRect CcRect::Native()
{
  return CRect( mLeft, mTop, mRight, mBottom );
}
#endif

CcRect CcRect::Sort()
{
 return CcRect( min(mTop,mBottom), min(mLeft,mRight),
                max(mTop,mBottom), max(mLeft,mRight) );

}

