
#include "crystalsinterface.h"
#include    "crconstants.h"
#include "ccchartline.h"
#include "cctokenlist.h"
#include "crchart.h"

CcChartLine::CcChartLine()
{
    x1=0;
    x2=0;
    y1=0;
    y2=0;
}

CcChartLine::CcChartLine(int ix1, int iy1, int ix2, int iy2)
{
      x1=ix1;
      x2=ix2;
      y1=iy1;
      y2=iy2;
}

CcChartLine::~CcChartLine()
{
}

bool CcChartLine::ParseInput(CcTokenList* tokenList)
{
    CcString theString;
//Just read four integers.
    theString = tokenList->GetToken();
    int xa = atoi( theString.ToCString() );
    theString = tokenList->GetToken();
    int ya = atoi( theString.ToCString() );
    theString = tokenList->GetToken();
    int xb = atoi( theString.ToCString() );
    theString = tokenList->GetToken();
    int yb = atoi( theString.ToCString() );
    Init(xa,ya, xb,yb);
    return true;
}




void CcChartLine::Draw(CrChart* chartToDrawOn)
{
    chartToDrawOn->DrawLine(x1,y1,x2,y2);
}


void CcChartLine::Init(int xa, int ya, int xb, int yb)
{
    x1 = xa;
    x2 = xb;
    y1 = ya;
    y2 = yb;
}
