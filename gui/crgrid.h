////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CrGrid

////////////////////////////////////////////////////////////////////////

//   Filename:  CrGrid.h
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 13:59 Uhr
//   Modified:  30.3.1998 11:49 Uhr

#ifndef		__CrGrid_H__
#define		__CrGrid_H__
#include	"crguielement.h"
//insert your own code here.
#include	"cclist.h"
class CxGroupBox;
class CcTokenList;
//End of user code.         
 
class	CrGrid : public CrGUIElement
{
	public:
		void CrFocus();
		int GetIdealHeight();
		int GetIdealWidth();
		void Resize(int newWidth, int newHeight, int origWidth, int origHeight);
		// methods
			CrGrid( CrGUIElement * mParentPtr );
			~CrGrid();
		Boolean	ParseInput( CcTokenList * tokenList );
		void	SetGeometry( const CcRect * rect );
		CcRect	GetGeometry();
		void	CalcLayout();
		void	SetText( CcString item );
		Boolean	GridComplete();
		Boolean	InitElement( CrGUIElement * element, CcTokenList * tokenList );
		void	Align();
		int	GetHeightOfRow( int row );
		int	GetWidthOfColumn( int col );
		CrGUIElement *	FindObject( CcString Name );
		
		// attributes
		int	mColumns;
		int	mRows;
		
	protected:
		// methods
		Boolean	SetPointer( int xpos, int ypos, CrGUIElement * ptr );
		CrGUIElement *	GetPointer( int xpos, int ypos );
		
		// attributes
		CcList	mItemList;
		Boolean	mGridComplete;
		CrGrid *	mActiveSubGrid;
		CrGUIElement **	mTheGrid;
		CxGroupBox *	mOutlineWidget;
		
};
#endif
