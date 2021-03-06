
#ifndef     __CcChartLine_H__
#define     __CcChartLine_H__

class CrChart;
#include "ccchartobject.h"

class CcChartLine : public CcChartObject
{
    public:
        void Init(int xa, int ya, int xb, int yb);
        CcChartLine();
            CcChartLine(int ix1, int iy1, int ix2, int iy2);
        ~CcChartLine();
        void Draw(CrChart* chartToDrawOn);
        bool ParseInput(deque<string> & tokenList);
    private:
        int x1, y1, x2, y2;
};

#endif
