
#include "crystalsinterface.h"
#include	"crconstants.h"
#include "cccharttext.h"
#include "cctokenlist.h"
#include "crchart.h"

CcChartText::CcChartText()
{
	x=0;
	y=0;
	xm = 0;
	ym = 0;
	text = " ";
}

CcChartText::~CcChartText()
{
}

Boolean CcChartText::ParseInput(CcTokenList* tokenList)
{
	CcString theString;

	theString = tokenList->GetToken();
	x = atoi( theString.ToCString() );
	theString = tokenList->GetToken();
	y = atoi( theString.ToCString() );
	text = tokenList->GetToken();
	return true;
}

void CcChartText::Draw(CrChart* chartToDrawOn)
{
	if(xm == 0)
		chartToDrawOn->DrawText(x,y,text);
	else
		chartToDrawOn->FitText(x,y,xm,ym,text);
}


void CcChartText::Init(int xp, int yp, CcString theText)
{
	x    = xp;
	y    = yp;
	text = theText;
}

void CcChartText::Init(int x1, int y1, int x2, int y2, CcString theText)
{
// Must fit the text inside the box.
	x = x1;
	y = y1;
	xm = x2;
	ym = y2;
	text = theText;
}
