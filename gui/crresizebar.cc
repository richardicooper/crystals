////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CrResizeBar

////////////////////////////////////////////////////////////////////////

//   Filename:  CrResizeBar.cc
//   Author:    Richard Cooper
//   $Log: not supported by cvs2svn $

#include    "crystalsinterface.h"
#include    "ccstring.h"
#include    "crconstants.h"
#include    "ccrect.h"
#include    "crresizebar.h"
#include    "crgrid.h"
#include    "crwindow.h"
#include    "cccontroller.h"
#include    "cxresizebar.h"



CrResizeBar::CrResizeBar( CrGUIElement * mParentPtr )
 : CrGUIElement( mParentPtr )
{
  ptr_to_cxObject = CxResizeBar::CreateCxResizeBar( this, (CxGrid *)(mParentPtr->GetWidget()) );
  m_offset = -1;
  m_type = kTVertical;
  m_firstitem = nil;
  m_seconditem = nil;
  m_firstNonSize = false;
  m_secondNonSize = false;
  m_NonSizePresent = false;
  m_BothNonSize = false;
}


CrResizeBar::~CrResizeBar()
{

  (CcController::theController)->StoreKey( mName, CcString ( m_offset ) );
  if ( ptr_to_cxObject )
  {
    ((CxResizeBar*)ptr_to_cxObject)->DestroyWindow(); delete (CxResizeBar*)ptr_to_cxObject;
    ptr_to_cxObject = nil;
  }
  if ( m_firstitem ) delete m_firstitem;
  if ( m_seconditem ) delete m_seconditem;
}

CRGETGEOMETRY(CrResizeBar,CxResizeBar)

void CrResizeBar::SetGeometry( const CcRect * rect )
{
  int nHeight = rect->mBottom - rect->mTop;
  int nWidth  = rect->mRight - rect->mLeft;
  CcRect firstrect, secondrect, thirdrect;

  if ( !m_NonSizePresent)
  {
    if ( m_type == kTHorizontal ) //   (NB. items arranged vertically)
    {
      firstrect.Set(0,0,(int)(((nHeight-SIZE_BAR)*m_offset)/1000.0f),nWidth);
      secondrect.Set((int)(((nHeight-SIZE_BAR)*m_offset)/1000.0f)+SIZE_BAR,0,nHeight,nWidth);
      thirdrect.Set((int)(((nHeight-SIZE_BAR)*m_offset)/1000.0f),0,(int)(((nHeight-SIZE_BAR)*m_offset)/1000.0f)+SIZE_BAR,nWidth);
    }
    else // (items arranged horizontally)
    {
      firstrect.Set(0,0,nHeight,(int)(((nWidth-SIZE_BAR)*m_offset)/1000.0f));
      secondrect.Set(0,(int)(((nWidth-SIZE_BAR)*m_offset)/1000.0f)+SIZE_BAR,nHeight,nWidth);
      thirdrect.Set(0,(int)(((nWidth-SIZE_BAR)*m_offset)/1000.0f),nHeight,(int)(((nWidth-SIZE_BAR)*m_offset)/1000.0f)+SIZE_BAR);
    }
  }
  else if ( !m_BothNonSize )
  {
    if ( m_type == kTHorizontal ) //   (NB. items arranged vertically)
    {
      if ( m_firstNonSize )
      {
        int fixedHeight = (int)(( m_InitHeight * m_InitOffset ) / 1000.0f );
        if ( m_offset == 0 ) fixedHeight = 0;
        firstrect.Set(0,0,fixedHeight,nWidth);
        secondrect.Set(fixedHeight+SIZE_BAR,0,nHeight,nWidth);
        thirdrect.Set(fixedHeight,0,fixedHeight+SIZE_BAR,nWidth);
      }
      else
      {
        int fixedHeight = (int)(( m_InitHeight * (1000-m_InitOffset) ) / 1000.0f );
        if ( m_offset == 1000 ) fixedHeight = 0;
        firstrect.Set(0,0,nHeight-fixedHeight-SIZE_BAR,nWidth);
        secondrect.Set(nHeight-fixedHeight,0,nHeight,nWidth);
        thirdrect.Set(nHeight-fixedHeight-SIZE_BAR,0,nHeight-fixedHeight,nWidth);
       }
    }
    else // (items arranged horizontally)
    {
      if ( m_firstNonSize )
      {
        int fixedWidth = (int)(( m_InitWidth * m_InitOffset ) / 1000.0f );
        if ( m_offset == 0 ) fixedWidth = 0;
        firstrect.Set(0,0,nHeight,fixedWidth);
        secondrect.Set(0,fixedWidth+SIZE_BAR,nHeight,nWidth);
        thirdrect.Set(0,fixedWidth,nHeight,fixedWidth+SIZE_BAR);
      }
      else
      {
        int fixedWidth = (int)(( m_InitWidth * (1000-m_InitOffset) ) / 1000.0f );
        if ( m_offset == 1000 ) fixedWidth = 0;
        firstrect.Set(0,0,nHeight,nWidth-fixedWidth-SIZE_BAR);
        secondrect.Set(0,nWidth-fixedWidth,nHeight,nWidth);
        thirdrect.Set(0,nWidth-fixedWidth-SIZE_BAR,nHeight,nWidth-fixedWidth);
      }
    }
  }

  if ( m_firstitem ) m_firstitem->SetGeometry(&firstrect);
  if ( m_seconditem ) m_seconditem->SetGeometry(&secondrect);
  ((CxResizeBar*)ptr_to_cxObject)->SetHotRect(&thirdrect);
  ((CxResizeBar*)ptr_to_cxObject)->SetGeometry( rect->mTop,    rect->mLeft,
                                           rect->mBottom, rect->mRight );
}




CcParse CrResizeBar::ParseInput( CcTokenList * tokenList )
{
  CcParse retVal(true, mXCanResize, mYCanResize);
  Boolean hasTokenForMe = true;

// Initialization for the first time
  if( ! mSelfInitialised )
  {
    retVal = CrGUIElement::ParseInputNoText( tokenList );
    mSelfInitialised = true;
    LOGSTAT( "Created ResizeBar " + mName );
    CcString coffset = (CcController::theController)->GetKey( mName );
    if ( coffset.Len() )
    {
      m_offset = atoi( coffset.ToCString() );
      m_offset = min ( m_offset, 1000 );
      m_offset = max ( m_offset, 0 );
      if ( ( m_offset == 0 ) || ( m_offset == 1000) ) ((CxResizeBar*)ptr_to_cxObject)->AlreadyCollapsed();
    }
    else
    {
      m_offset = -1; //Set later in calclayout.
    }

    switch ( tokenList->GetDescriptor(kAttributeClass) )
    {
      case kTHorizontal:
      {
        tokenList->GetToken(); // Remove that token!
        ((CxResizeBar*)ptr_to_cxObject)->SetType( kTHorizontal );
        m_type = kTHorizontal;
        LOGSTAT( "Setting ResizeBar type: Horizontal" );
        break;
      }
      case kTVertical:
      {
        tokenList->GetToken(); // Remove that token!
                               // Run on into default case...
      }
      default:
      {
        ((CxResizeBar*)ptr_to_cxObject)->SetType( kTVertical );
        m_type = kTVertical;
        LOGSTAT( "Setting ResizeBar type: Vertical" );
        break; // We leave the token in the list and exit the loop
      }
    }

// Optional startgrid token used to line up syntax in scripts nicely.
    if (tokenList->GetDescriptor(kAttributeClass) == kTOpenGrid)
                            tokenList->GetToken();
    CcParse* parseVal = new CcParse[2];

    for ( int i = 0; i<2; i++ )
    {
     switch ( tokenList->GetDescriptor(kAttributeClass) )
     {
      case kTItem:
      {
        tokenList->GetToken(); // Remove that token!

        LOGSTAT("Adding Item to resize control. ");
        CrGrid* gridPtr = new CrGrid( this );
        if ( gridPtr != nil )
        {
          tokenList->GetToken();      // remove that token
          parseVal[i] = gridPtr->ParseInput( tokenList );
          if ( i==0 ) m_firstitem = gridPtr;
          else        m_seconditem= gridPtr;
        }
        break;
      }
      default:
      {
        LOGERR ( "Resizebar "+mName+" ITEM instruction not found");
      }
     }
    }
    if ( m_type == kTHorizontal )
    {
      m_firstNonSize  = !(parseVal[0].CanYResize());
      m_secondNonSize = !(parseVal[1].CanYResize());
      m_BothNonSize    = m_firstNonSize && m_secondNonSize;
      m_NonSizePresent = m_firstNonSize || m_secondNonSize;
      ((CxResizeBar*)ptr_to_cxObject)->WillNotResize(m_firstNonSize,m_secondNonSize);
    }
    else
    {
      m_firstNonSize  = !(parseVal[0].CanXResize());
      m_secondNonSize = !(parseVal[1].CanXResize());
      m_BothNonSize    = m_firstNonSize && m_secondNonSize;
      m_NonSizePresent = m_firstNonSize || m_secondNonSize;
      ((CxResizeBar*)ptr_to_cxObject)->WillNotResize(m_firstNonSize,m_secondNonSize);
    }
    retVal= CcParse(parseVal[0].OK() && parseVal[1].OK(),
                 parseVal[0].CanXResize()||parseVal[1].CanXResize(),
                 parseVal[0].CanYResize()||parseVal[1].CanYResize());
    delete [] parseVal;

  }
  else
  {
    LOGERR ( "Resizebar may not be updated after it is created");
  }

// Optional endgrid token used to line up syntax in scripts nicely.
  if (tokenList->GetDescriptor(kAttributeClass) == kTEndGrid)
                            tokenList->GetToken();

  return retVal;
}

CcRect CrResizeBar::CalcLayout(bool recalc)
{
  CcController::debugIndent++;
  LOGSTAT("CrResizeBar: " + mName + " CalcLayout Step 1: Calculating size of both children");

//STEP1 Call calclayout for child elements. Store their sizes.


  int totWidth, totHeight;
  int firstitemWidth, firstitemHeight;
  int seconditemWidth, seconditemHeight;
  int offset;

  if ( m_firstitem == nil )
  {
    firstitemWidth = EMPTY_CELL;
    firstitemHeight = EMPTY_CELL;
  }
  else
  {
    CcController::debugIndent++;
    CcRect rect;
    rect = m_firstitem->CalcLayout(recalc);
    firstitemWidth = rect.Width();
    firstitemHeight = rect.Height();
    CcController::debugIndent--;
  }

  if ( m_seconditem == nil )
  {
    seconditemWidth = EMPTY_CELL;
    seconditemHeight = EMPTY_CELL;
  }
  else
  {
    CcController::debugIndent++;
    CcRect rect;
    rect = m_seconditem->CalcLayout(recalc);
    seconditemWidth = rect.Width();
    seconditemHeight = rect.Height();
    CcController::debugIndent--;
  }

  LOGSTAT("CrResizeBar: " + mName + " CalcLayout Step 2: Setting positions of all children");

  if ( m_type == kTHorizontal ) //   (NB. items arranged vertically)
  {
     totWidth = max ( firstitemWidth, seconditemWidth );
     firstitemWidth = totWidth;
     seconditemWidth = totWidth;
     totHeight = firstitemHeight + seconditemHeight + SIZE_BAR;
     offset = (int)( 1000.0f * (float) firstitemHeight / (float)totHeight );
  }
  else // (items arranged horizontally)
  {
     totHeight = max ( firstitemHeight, seconditemHeight );
     firstitemHeight = totHeight;
     seconditemHeight = totHeight;
     totWidth  = firstitemWidth + seconditemWidth + SIZE_BAR;
     offset = (int)(1000.0f *  (float) firstitemWidth / (float)totWidth );
  }

  CcController::debugIndent--;

  if ( recalc )
  {
    m_InitWidth =  totWidth;
    m_InitHeight = totHeight;
    m_InitOffset = offset;
    if ( m_offset < 0 ) m_offset = offset;
  }

  return CcRect( 0,0, totHeight, totWidth );

}


void CrResizeBar::SetText ( CcString cText )
{
  LOGERR ( "Resizebar doesn't have TEXT in it: " + cText);
}


int CrResizeBar::GetIdealWidth()
{
    return (int) ( EMPTY_CELL );
}
int CrResizeBar::GetIdealHeight()
{
    return (int) ( EMPTY_CELL );
}

void CrResizeBar::CrFocus()
{
}


void CrResizeBar::MoveResizeBar(int offset)
{
// The variable m_offset should run from 0 to +1000.
   m_offset = min ( offset, 1000 );
   m_offset = max ( m_offset, 0 );

// Set new sizes
   CcRect initial = GetGeometry();
   initial.Set(0,0,initial.Height(),initial.Width());
   SetGeometry(&initial);

// Force repaint of entire window.
   ((CrWindow*)GetRootWidget())->Redraw();
}


CrGUIElement *  CrResizeBar::FindObject( CcString Name )
{
  CrGUIElement * theElement = nil;

  if ( m_firstitem ) theElement = m_firstitem->FindObject( Name );
  if ( !theElement && m_seconditem ) theElement = m_seconditem->FindObject( Name );
  return ( theElement );
}

void CrResizeBar::Collapse(bool collapse)
{
   if ( m_firstNonSize ) MoveResizeBar ( collapse ? 0    : m_InitOffset );
   else                  MoveResizeBar ( collapse ? 1000 : m_InitOffset );
}
