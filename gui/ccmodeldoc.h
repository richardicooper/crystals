////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CcModelDoc

////////////////////////////////////////////////////////////////////////

//   Filename:  CcModelDoc.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   $Log: not supported by cvs2svn $
//   Revision 1.20  2003/11/07 10:43:06  rich
//   Split the 'part' column in the atom list into 'assembly' and 'group'.
//
//   Revision 1.19  2003/10/31 10:44:16  rich
//   When an atom is selected in the model window, it is scrolled
//   into view in the atom list, if not already in view.
//
//   Revision 1.18  2003/08/13 16:01:41  rich
//   Comment out windows header on Linux ver.
//
//   Revision 1.17  2003/05/07 12:18:56  rich
//
//   RIC: Make a new platform target "WXS" for building CRYSTALS under Windows
//   using only free compilers and libraries. Hurrah, but it isn't very stable
//   yet (CRYSTALS, not the compilers...)
//
//   Revision 1.16  2002/10/02 13:42:00  rich
//   Support for more info from GUIBIT (e.g. UEQUIV).
//   Ability to act as a source of data for either a MODELWINDOW
//   or a MODLIST.
//
//   Revision 1.15  2002/07/23 08:25:43  richard
//
//   Moved selected, disabled and excluded variables and functions into the base class.
//   Added ALL option to DISABLEATOM to enable/disable all atoms.
//
//   Revision 1.14  2002/07/18 16:44:34  richard
//   Changes to ensure two CrModels can share the same CcModelDoc happily.
//
//   Revision 1.13  2002/07/04 13:04:44  richard
//
//   glPassThrough was causing probs on Latitude notebook. Can only be called in feedback
//   mode, which means that it can't be stuck into the display lists which are used
//   for drawing aswell. Instead, added feedback logical parameter into all Render calls, when
//   true it does a "feedback" render rather than a display list render. Will slow down polygon
//   selection a negligble amount.
//
//   Revision 1.12  2002/06/28 10:09:53  richard
//   Minor gui update enabling vague display of special shapes: ring and sphere.
//
//   Revision 1.11  2002/06/25 11:58:09  richard
//   Use _F in popup-menu commands to substitute in all atoms in fragment connected
//   to clicked-on atom.
//
//   Revision 1.10  2002/03/13 12:25:45  richard
//   Update variable names. Added FASTBOND and FASTATOM routines which can be called
//   from the Fortran instead of passing data through the text channel.
//
//   Revision 1.9  2001/06/17 15:24:20  richard
//
//
//   Lot of functions which used to be called from CxModel and CrModel removed and
//   now CcModelDoc does these for itself (lists of selected atoms etc.)
//
//   Render groups atoms by drawing style and sends GL attributes only once at beginning
//   of each set (e.g. disabled atoms, selected atoms, normal atoms, excluded atoms.)
//
//   Revision 1.8  2001/03/08 15:12:17  richard
//   Added functions for excluding atoms and bonds, and excluding fragments based on
//   known bonding.
//

//BIG NOTICE: ModelDoc is not a CrGUIElement, it's more like a list
//            of drawing commands.
//            You can attach a CrModel to it and it will then draw
//            itself on that CrModel's drawing area.
//            It does contain a ParseInput routine for parsing the
//            drawing commands. Note again - it is not a CrGUIElement,
//            it has no graphical presence, nor a complimentary Cx- class

#ifndef     __CcModelDoc_H__
#define     __CcModelDoc_H__

#ifdef __CR_WIN__
#include <GL/glu.h>
#include <GL/gl.h>
#endif
#ifdef __BOTHWX__
#include <wx/glcanvas.h>
//#include <windows.h>
#include <GL/glu.h>
#endif

#include <string>
#include <list>
using namespace std;

#include "ccmodelatom.h"
#include "ccmodelbond.h"
#include "ccmodelsphere.h"
#include "ccmodeldonut.h"

class CrModel;
class CrModList;
class CcModelStyle;
class CcModelDoc;

class CcModelDoc
{
    public:

        bool RenderModel( CcModelStyle *style, bool feedback=false );   // Called by CrModel
        void DocToList( CrModList* ml );                                // Called by CrModList
        void InvertSelection();                                         // Called by CrModel
        void SelectAllAtoms(bool select);                               // Called by CrModel
        void SelectAtomByLabel(string atomname, bool select);           // Called by CrModel
        void DisableAllAtoms(bool select);                              // Called by CrModel
        void DisableAtomByLabel(string atomname, bool select);          // Called by CrModel
        CcModelObject* FindAtomByLabel(string atomname);            // Called by CrModel & CcModelBond
        CcModelAtom* FindAtomByPosn(int posn);          // Called by CrModList & CcModelBond

        void FastBond(int x1,int y1,int z1, int x2, int y2, int z2,
                          int r, int g, int b,  int rad,int btype,
                          int np, int * ptrs, string label, string cslabl);

        void FastAtom(string label,int x1,int y1,int z1, 
                          int r, int g, int b, int occ,float cov, int vdw,
                          int spare, int flag,
                          float u1,float u2,float u3,float u4,float u5,
                          float u6,float u7,float u8,float u9,
                          float fx, float fy, float fz,
                          string elem, int serial, int refflag,
                          int assembly, int group, float ueq, float fspare);

        void FastSphere(string label,int x1,int y1,int z1, 
                          int r, int g, int b, int occ,int cov, int vdw,
                          int spare, int flag,
                          int iso, int irad);

        void FastDonut(string label,int x1,int y1,int z1,
                          int r, int g, int b, int occ,int cov, int vdw,
                          int spare, int flag,
                          int iso, int irad, int idec, int iaz);


        CcModelObject * FindObjectByGLName(GLuint name);            // Called by CrModel

        void Clear();                                               // Called by CrModel
        string SelectedAsString( string delimiter = " " );          // Called by CrMenu
        string FragAsString    ( string atomname, string delimiter = " "); // Called by CrMenu
        void SendAtoms( int style, bool sendonly=false );           // Called by CrModel
        void ZoomAtoms( bool doZoom );                              // Called by CrModel
        void SelectFrag(string atomname, bool select);              // Called by CrModel
        void RemoveView(CrModel* aView);                            // Called by CrModel
        void DrawViews(bool rescaled = false);                      // Called by CrModList, ModelAtom, ModelBond etc.
        void AddModelView(CrModel* aView);                          // Called by CrModel
        void AddModelView(CrModList* aView);                        // Called by CrModList
        CcModelDoc();
        ~CcModelDoc();
        bool ParseInput( deque<string> & tokenList );                 // Called by CcController

        friend bool operator==(CcModelDoc* doc, const string& st0); // Called by CcController

        int NumSelected();                                          // Called by CrModList
        void EnsureVisible(CcModelAtom* va);                        // Called by CcModelAtom, Bond etc.
        void Select(bool selected);                                 // Called by CcModelAtom, Donut etc.

        list <CrModel*> attachedViews;          
        list <CrModList*> attachedLists;
        static list<CcModelDoc*> sm_ModelDocList;
        static CcModelDoc* sm_CurrentModelDoc;
        string mName;

    protected:

    private:
        void     FlagFrag ( string atomname );
        string Compress(string atomname);
        
        int nSelected;
        int m_nAtoms;
        int m_TotX;
        int m_TotY;
        int m_TotZ;
        bool m_glIDsok;
  
        list<CcModelAtom> mAtomList;
        list<CcModelBond> mBondList;
        list<CcModelSphere> mSphereList;
        list<CcModelDonut> mDonutList;
};

#endif
