
#include "crystalsinterface.h"
#include	"crconstants.h"
#include "ccmodelbond.h"
#include "cctokenlist.h"
#include <math.h>
#include "crmodel.h"

CcModelBond::CcModelBond()
{
	ox1 = oy1 = oz1 = x1 = y1 = z1 = 0;
	ox2 = oy2 = oz2 = x2 = y2 = z2 = 0;
	r = g = b = 0;
	rad = 0;
}

CcModelBond::~CcModelBond()
{
}

void CcModelBond::ParseInput(CcTokenList* tokenList)
{
	CcString theString;
//Just read four integers.
	theString = tokenList->GetToken();
	x1 = ox1 = atoi( theString.ToCString() );
	theString = tokenList->GetToken();
	y1 = oy1 = atoi( theString.ToCString() );
	theString = tokenList->GetToken();
	z1 = oz1 = atoi( theString.ToCString() );
	theString = tokenList->GetToken();
	x2 = ox2 = atoi( theString.ToCString() );
	theString = tokenList->GetToken();
	y2 = oy2 = atoi( theString.ToCString() );
	theString = tokenList->GetToken();
	z2 = oz2 = atoi( theString.ToCString() );
	theString = tokenList->GetToken();
	r = atoi( theString.ToCString() );
	theString = tokenList->GetToken();
	g = atoi( theString.ToCString() );
	theString = tokenList->GetToken();
	b = atoi( theString.ToCString() );
	theString = tokenList->GetToken();
	rad = atoi( theString.ToCString() );
}

void CcModelBond::Render(CrModel * view, Boolean detailed)
{
	double degToRad = 3.1415926535 / 180.0;
      int detail = (detailed)? view->m_NormalRes : view->m_QuickRes ;
	glPushMatrix();
            GLUquadricObj* cylinder;
            int bondrad = (int)((float)rad* view->RadiusScale());
		float xlen = (float)(x2-x1), ylen = (float)(y2-y1), zlen = (float)(z2-z1);
		float length = (float)sqrt ( xlen*xlen + ylen*ylen + zlen*zlen );
		float centerX = (x1 + x2)/2.0f , centerY = (y1 + y2)/2.0f, centerZ = (z1 + z2)/2.0f;
		float xrot = (float)asin ( -ylen / length );
		float yrot = (float)acos ( zlen / (length*cos(xrot)) );
		if ( (length*cos(xrot)*sin(yrot))/xlen < 0 )
			yrot = -yrot;
		xrot = xrot/(float)degToRad;
		yrot = yrot/(float)degToRad;
		glTranslated(centerX, centerY, centerZ);   //Translate view origin to the center of the bond
		glRotatef(yrot,0,1,0);
		glRotatef(xrot,1,0,0);
		glTranslated(0, 0, -length / 2);           //shift the cylinder so it is centered at 0,0,0;
		GLfloat Surface[] = { (float)r/255.0f,(float)g/255.0f,(float)b/255.0f, 1.0f };
		glMaterialfv(GL_FRONT, GL_AMBIENT, Surface);
		GLfloat Diffuse[] = { 0.2f,0.2f,0.2f,1.0f };
		GLfloat Specula[] = { 0.8f,0.8f,0.8f,1.0f };
		GLfloat Shinine[] = {89.6f};
		glMaterialfv(GL_FRONT, GL_DIFFUSE,  Diffuse);
		glMaterialfv(GL_FRONT, GL_SPECULAR, Specula);
		glMaterialfv(GL_FRONT, GL_SHININESS,Shinine);
		cylinder = gluNewQuadric();
		gluQuadricDrawStyle(cylinder,GLU_FILL);
            gluCylinder(cylinder,(float)bondrad,(float)bondrad,length, detail, detail);
            gluDeleteQuadric(cylinder);
	glPopMatrix();
}

