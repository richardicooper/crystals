////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CrListCtrl

////////////////////////////////////////////////////////////////////////

//   Filename:  CrListCtrl.h
//   Authors:   Richard Cooper

#ifndef		__CrListCtrl_H__
#define		__CrListCtrl_H__
#include	"crguielement.h"
#include	"cctokenlist.h"
 
class	CrListCtrl : public CrGUIElement
{
	public:
		void SendValue(CcString message);
		int GetIdealHeight();
		int GetIdealWidth();
		int m_cols;
		CrListCtrl( CrGUIElement * mParentPtr );
		~CrListCtrl();
		Boolean	ParseInput( CcTokenList * tokenList );
		void	SetGeometry( const CcRect * rect );
		CcRect	GetGeometry();
		void	CalcLayout();
		void	SetText( CcString item );
		void	GetValue();
		void	GetValue( CcTokenList * tokenList );
		void CrFocus();
};
#endif
