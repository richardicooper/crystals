
#ifndef     __CcModelAtom_H__
#define     __CcModelAtom_H__

class CrModel;
class CcTokenList;
class CcModelDoc;
#include "ccmodelobject.h"

class CcModelStyle;


class CcModelAtom : public CcModelObject
{
  public:
    CcModelAtom(CcModelDoc* parentptr);
    CcModelAtom(CcString label,int x1,int y1,int z1, 
                    int r, int g, int b, int occ,float cov, int vdw,
                    int spare, int flag,
                    float u1,float u2,float u3,float u4,float u5,
                    float u6,float u7,float u8,float u9,
                    float fx, float fy, float fz,
                    CcString elem, int serial, int refflag,
                    int part, float ueq, float fspare,
                    CcModelDoc* parentptr);

    void Init();
    ~CcModelAtom();

    void Render(CcModelStyle *style, bool feedback=false);
    void SendAtom(int style, bool output=false); 

    int X();
    int Y();
    int Z();
    float R();
    void ParseInput(CcTokenList* tokenList);

  public:
    int x, y, z;
    float frac_x, frac_y, frac_z;
    int r, g, b;
    int id;
    int occ;
    int vdwrad, sparerad;
    float covrad;
    float x11, x12, x13, x21, x22, x23, x31, x32, x33;
    bool m_IsADP;
    float localmatrix[16];
    float m_ueq;
    float m_spare;
    int m_serial;
    int m_refflag;
    int m_part;
    CcString m_elem;
};

#endif
