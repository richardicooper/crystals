////////////////////////////////////////////////////////////////////////

//   CRYSALS Interface      Class CcModelDoc

////////////////////////////////////////////////////////////////////////

//   Filename:  CcModelDoc.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr

//BIG NOTICE: ModelDoc is not a CrGUIElement, it's more like a list
//            of drawing commands.
//            You can attach a CrModel to it and it will then draw
//            itself on that CrModel's drawing area.
//            It does contain a ParseInput routine for parsing the
//            drawing commands. Note again - it is not a CrGUIElement,
//            it has no graphical presence, nor a complimentary Cx- class

// $Log: not supported by cvs2svn $
// Revision 1.11  2001/03/08 15:12:17  richard
// Added functions for excluding atoms and bonds, and excluding fragments based on
// known bonding.
//
// Revision 1.10  2001/01/25 17:04:23  richard
// Commented out unused lists of model objects. Triangles and Cells, actually.
//
// Revision 1.9  2000/10/31 15:42:14  ckp2
// Link to atom disabling code.
//
// Revision 1.8  1999/08/25 17:57:41  ckp2
// RIC: Updates from before Glasgow
//
// Revision 1.7  1999/08/03 09:19:18  richard
// RIC: Keep track of number of selected atoms more carefully.
//
// Revision 1.6  1999/06/22 12:57:18  dosuser
// RIC: RenderModel returns a boolean indicating whether anything was drawn.
//
// Revision 1.5  1999/06/13 16:40:32  dosuser
// RIC: No need to keep track of the centre as objects are added. Atoms
// are now centred in XGDBUP. DrawViews and Centre() removed.
// RedrawHighlights() removed. This is done automatically in the atoms
// Render() function. New function RenderModel() is called when
// a Paint event is recieved by CxModel. It calls Render() for each
// of the modelobjects stored in its lists. The argument view lets
// the modelobjects access global settings from the CrModel such as
// RadiusType and Scale. The Boolean detailed tells the model object
// whether to draw at high or low resolution depending on whether the
// view is currently rotating.
//
// Revision 1.4  1999/04/30 17:09:45  dosuser
// RIC: Changed the ClearHighlights() call before the HighlightAtoms loop
//      to a StartHighlights() before and a FinishHighlights() after.
//
// Revision 1.3  1999/04/26 11:12:39  dosuser
// RIC: Added a bit of code to call Reset() on all views attached to
//      the modeldoc in order that they don't keep pointers to atoms
//      in the modeldoc once it is updated by CRYSTALS.
//



#include    "crystalsinterface.h"
#include    "crconstants.h"
#include    "ccmodeldoc.h"
#include    "ccmodelobject.h"
//insert your own code here.
#include    "crmodel.h"
//#include  "ccrect.h"
#include    "cccoord.h"
#include    "cccontroller.h"    // for sending commands
#include    "cxmodel.h"

CcModelDoc::CcModelDoc( )
{
    mAtomList = new CcList();
    mBondList = new CcList();
//        mCellList = new CcList();
//        mTriList = new CcList();
    m_nAtoms = 0;
    nSelected = 0;
}

CcModelDoc::~CcModelDoc()
{
    mAtomList->Reset();
    mBondList->Reset();
//        mCellList->Reset();
//        mTriList->Reset();
    CcModelObject* theItem ;
    while ( ( theItem = (CcModelObject *)mAtomList->GetItem() ) != nil )
    {
        mAtomList->RemoveItem();
        delete theItem;
    }
    while ( ( theItem = (CcModelObject *)mBondList->GetItem() ) != nil )
    {
        mBondList->RemoveItem();
        delete theItem;
    }
//        while ( ( theItem = (CcModelObject *)mCellList->GetItem() ) != nil )
//        {
//                mCellList->RemoveItem();
//                delete theItem;
//        }
//        while ( ( theItem = (CcModelObject *)mTriList->GetItem() ) != nil )
//        {
//                mTriList->RemoveItem();
//                delete theItem;
//        }

    delete mAtomList;
    delete mBondList;
//        delete mCellList;
//        delete mTriList;

    attachedViews.Reset();
    CrModel* aView;
    while( ( aView = (CrModel*)attachedViews.GetItemAndMove() ) != nil)
    {
        aView->DocRemoved();
    }

}

Boolean CcModelDoc::ParseInput( CcTokenList * tokenList )
{
    Boolean retVal = true;
    Boolean hasTokenForMe = true;

    while ( hasTokenForMe )
    {
        switch ( tokenList->GetDescriptor(kModelClass) )
        {
            case kTModelShow:
            {
                tokenList->GetToken(); // Remove that token!
                DrawViews();
                break;
            }
            case kTModelAtom:
            {
                tokenList->GetToken(); // Remove that token!
                CcModelAtom* item = new CcModelAtom(this);
                        item->ParseInput(tokenList);
                mAtomList->AddItem(item);
                m_nAtoms++;
                break;
            }
            case kTModelBond:
            {
                tokenList->GetToken(); // Remove that token!
                CcModelBond* item = new CcModelBond(this);
                item->ParseInput(tokenList);
                mBondList->AddItem(item);
                break;
            }
//                        case kTModelCell:
//                        {
//                                tokenList->GetToken(); // Remove that token!
//                                CcModelCell* item = new CcModelCell();
//                                item->ParseInput(tokenList);
//                                mCellList->AddItem(item);
//                                break;
//                        }
//                        case kTModelTri:    //Triangles for those 3D fourier surfaces.
//                        {
//                                tokenList->GetToken(); // Remove that token!
//                                CcModelTri* item = new CcModelTri();
//                                item->ParseInput(tokenList);
//                                mTriList->AddItem(item);
//                                break;
//                        }
            case kTModelClear:
            {
                tokenList->GetToken(); // Remove that token!
                Clear();
                break;
            }
            default:
            {
                hasTokenForMe = false;
                break; // We leave the token in the list and exit the loop
            }
        }
    }

    return retVal;
}


void CcModelDoc::Clear()
{
    mAtomList->Reset();
    mBondList->Reset();
//        mCellList->Reset();
//        mTriList->Reset();


    CcModelObject* theItem ;
    while ( ( theItem = (CcModelObject *)mAtomList->GetItem() ) != nil )
    {
        mAtomList->RemoveItem();
        delete theItem;
    }
    while ( ( theItem = (CcModelObject *)mBondList->GetItem() ) != nil )
    {
        mBondList->RemoveItem();
        delete theItem;
    }
//      while ( ( theItem = (CcModelObject *)mCellList->GetItem() ) != nil )
//      {
//            mCellList->RemoveItem();
//            delete theItem;
//      }
//        while ( ( theItem = (CcModelObject *)mTriList->GetItem() ) != nil )
//        {
//                mTriList->RemoveItem();
//                delete theItem;
//        }

    m_nAtoms = 0;

      nSelected = 0;

      (CcController::theController)->status.SetNumSelectedAtoms( 0 );

      DrawViews();

}

void CcModelDoc::AddModelView(CrModel * aView)
{
    attachedViews.AddItem(aView);
      aView->Update();
}

void CcModelDoc::DrawViews()
{
    attachedViews.Reset();
    CrModel* aView;
    while( ( aView = (CrModel*)attachedViews.GetItemAndMove() ) != nil)
    {
            aView->Update();
    }
}

void CcModelDoc::RemoveView(CrModel * aView)
{
    while ( attachedViews.FindItem( aView ) )
    {
        attachedViews.RemoveItem();
    }
}

void CcModelDoc::Select(Boolean selected)
{
    if (selected)
        nSelected++;
    else
        nSelected--;
//Update the status flag.
    (CcController::theController)->status.SetNumSelectedAtoms( nSelected );
}


void CcModelDoc::SelectAtomByLabel(CcString atomname, Boolean select)
{
    CcModelAtom* item = FindAtomByLabel(atomname);
    if(item)
        item->Select(select);
//      ReDrawHighlights(true);
      DrawViews();

}

void CcModelDoc::DisableAtomByLabel(CcString atomname, Boolean select)
{
    CcModelAtom* item = FindAtomByLabel(atomname);
    if(item)
                item->Disable(select);
      DrawViews();

}

CcModelAtom* CcModelDoc::FindAtomByLabel(CcString atomname)
{
    CcString nAtomname = Compress(atomname);
    mAtomList->Reset();
    CcModelAtom* item;
    while ( (item = (CcModelAtom*)mAtomList->GetItemAndMove()) != nil )
    {
        if(item->Label() == nAtomname)
            return item;
    }
    return nil;
}



void CcModelDoc::SelectAllAtoms(Boolean select)
{
    mAtomList->Reset();
    CcModelAtom* item;
      int i=0;
    while ( (item = (CcModelAtom*)mAtomList->GetItemAndMove()) != nil )
    {
            i++;
        item->Select(select);
    }
      DrawViews();
      if ( select )
      {
            nSelected = i;
      }
      else
      {
            nSelected = 0;
      }
      (CcController::theController)->status.SetNumSelectedAtoms( nSelected );

}

CcString CcModelDoc::Compress(CcString atomname)
{
    int leng = atomname.Length();
    int index = 0;
    int charstart = 1, charend = 1;
    int numbstart = 1, numbend = 1;
    int i;
//Find first non-space
    for ( i = 1 ; i <= leng; i++)
    {
        if (!(atomname.Sub(i,i) == " "))
        {
            charstart = i;
            i = leng + 1;
        }
    }

//Find next space or number.
    for ( i = charstart ; i <= leng; i++)
    {
        if (   (atomname.Sub(i,i) == " ")
            || (atomname.Sub(i,i) == "(")
            || (atoi(atomname.Sub(i,i).ToCString())!=0)
           )
        {
            charend = i - 1;
            i = leng + 1;
        }
    }

//Find first number.
    for ( i = charend + 1; i <= leng; i++)
    {
        if (atoi(atomname.Sub(i,i).ToCString())!=0)
        {
            numbstart = i;
            i = leng + 1;
        }
    }

//Find next non-number.
    for ( i = numbstart + 1; i <= leng; i++)
    {
        if (    (atoi(atomname.Sub(i,i).ToCString())==0)
             && !(atomname.Sub(i,i) == "0")
           )
        {
            numbend = i - 1;
            i = leng + 1;
        }
    }

//Build string in CRYSTALS format.
    CcString result;
    result = atomname.Sub(charstart,charend);
    result += "(";
    result += atomname.Sub(numbstart,numbend);
    result += ")";

    return result;
}

void CcModelDoc::InvertSelection()
{
    mAtomList->Reset();
    CcModelAtom* item;
    while ( (item = (CcModelAtom*)mAtomList->GetItemAndMove()) != nil )
    {
        item->Select();
    }
    DrawViews();
}



Boolean CcModelDoc::RenderModel( CcModelStyle * style )
{
   if ( mAtomList->ListSize() || mBondList->ListSize() )
   {
      CcModelAtom* aitem;
      CcModelBond* bitem;
      GLuint glIDCount = 0;


      if ( style->high_res )
      {
//High res normal atoms:
        mAtomList->Reset();
        glNewList( ATOMLIST, GL_COMPILE);
        {
          GLfloat Specula[] = { 0.0f,0.0f,0.0f,1.0f };
          glMaterialfv(GL_FRONT, GL_SPECULAR, Specula);
        }
        while ( (aitem = (CcModelAtom*)mAtomList->GetItemAndMove()) )
        {
//not excluded, not selected, not disabled:
          if ( !(aitem->m_excluded) && !(aitem->IsSelected()) && !(aitem->m_disabled) )
          {
            glLoadName ( ++ glIDCount );
            aitem->Render(style);
            aitem->glID = glIDCount;
          }
        }
        mAtomList->Reset();
        {
          GLfloat Diffuse[] = { 0.6f,0.6f,0.6f,1.0f };
          GLfloat Specula[] = { 0.9f,0.9f,0.9f,1.0f };
          glMaterialfv(GL_FRONT, GL_DIFFUSE,  Diffuse);
          glMaterialfv(GL_FRONT, GL_SPECULAR, Specula);
        }
        while ( (aitem = (CcModelAtom*)mAtomList->GetItemAndMove()) )
        {
//not excluded, selected:
          if ( !(aitem->m_excluded) && (aitem->IsSelected()) )
          {
            glLoadName ( ++ glIDCount );
            aitem->Render(style);
            aitem->glID = glIDCount;
          }
        }
        mAtomList->Reset();
        {
          GLfloat Surface[] = { 0.0f,0.0f,0.0f,1.0f };
          GLfloat Specula[] = { 0.0f,0.0f,0.0f,1.0f };
          glMaterialfv(GL_FRONT, GL_AMBIENT,  Surface);
          glMaterialfv(GL_FRONT, GL_SPECULAR, Specula);
        }
        while ( (aitem = (CcModelAtom*)mAtomList->GetItemAndMove()) )
        {
//not excluded, not selected, disabled
          if ( !(aitem->m_excluded) && !(aitem->IsSelected()) && (aitem->m_disabled) )
          {
            glLoadName ( ++ glIDCount );
            aitem->Render(style);
            aitem->glID = glIDCount;
          }
        }
        glEndList();
//High res normal bonds:
        glNewList( BONDLIST, GL_COMPILE);
        {
          GLfloat Diffuse[] = { 0.2f,0.2f,0.2f,1.0f };
          GLfloat Specula[] = { 0.8f,0.8f,0.8f,1.0f };
          GLfloat Shinine[] = {89.6f};
          glMaterialfv(GL_FRONT, GL_DIFFUSE,  Diffuse);
          glMaterialfv(GL_FRONT, GL_SPECULAR, Specula);
          glMaterialfv(GL_FRONT, GL_SHININESS,Shinine);
        }
        mBondList->Reset();
        while ( (bitem = (CcModelBond*)mBondList->GetItemAndMove()) )
        {
          if ( !(bitem->m_excluded) )
          {
            glLoadName ( ++ glIDCount );
            bitem->Render(style);
            bitem->glID = glIDCount;
          }
        }
        glEndList();

//High res excluded atoms and bonds:
        glNewList( XOBJECTLIST, GL_COMPILE);
        mAtomList->Reset();
        while ( (aitem = (CcModelAtom*)mAtomList->GetItemAndMove()) )
        {
          if ( aitem->m_excluded )
          {
            glPolygonMode(GL_FRONT, GL_POINT);
            glPolygonMode(GL_BACK, GL_POINT);
            aitem->Render(style);
            aitem->glID = 0;
          }
        }
        mBondList->Reset();
        while ( (bitem = (CcModelBond*)mBondList->GetItemAndMove()) )
        {
          if ( bitem->m_excluded )
          {
            glPolygonMode(GL_FRONT, GL_POINT);
            glPolygonMode(GL_BACK, GL_POINT);
            bitem->Render(style);
            bitem->glID = 0;
          }
        }
        glEndList();
      }
      else
      {
//Low res (non-excluded) atoms
        glNewList( QATOMLIST, GL_COMPILE);
        mAtomList->Reset();
        {
          GLfloat Specula[] = { 0.0f,0.0f,0.0f,1.0f };
          glMaterialfv(GL_FRONT, GL_SPECULAR, Specula);
        }
        while ( (aitem = (CcModelAtom*)mAtomList->GetItemAndMove()) )
        {
//not excluded, not selected, not disabled:
          if ( !(aitem->m_excluded) && !(aitem->IsSelected()) && !(aitem->m_disabled) )
          {
            glLoadName ( ++ glIDCount );
            aitem->Render(style);
            aitem->glID = glIDCount;
          }
        }
        mAtomList->Reset();
        {
          GLfloat Diffuse[] = { 0.6f,0.6f,0.6f,1.0f };
          GLfloat Specula[] = { 0.9f,0.9f,0.9f,1.0f };
          glMaterialfv(GL_FRONT, GL_DIFFUSE,  Diffuse);
          glMaterialfv(GL_FRONT, GL_SPECULAR, Specula);
        }
        while ( (aitem = (CcModelAtom*)mAtomList->GetItemAndMove()) )
        {
//not excluded, selected:
          if ( !(aitem->m_excluded) && (aitem->IsSelected()) )
          {
            glLoadName ( ++ glIDCount );
            aitem->Render(style);
            aitem->glID = glIDCount;
          }
        }
        mAtomList->Reset();
        {
          GLfloat Surface[] = { 0.0f,0.0f,0.0f,1.0f };
          GLfloat Specula[] = { 0.0f,0.0f,0.0f,1.0f };
          glMaterialfv(GL_FRONT, GL_AMBIENT,  Surface);
          glMaterialfv(GL_FRONT, GL_SPECULAR, Specula);
        }
        while ( (aitem = (CcModelAtom*)mAtomList->GetItemAndMove()) )
        {
//not excluded, not selected, disabled
          if ( !(aitem->m_excluded) && !(aitem->IsSelected()) && (aitem->m_disabled) )
          {
            glLoadName ( ++ glIDCount );
            aitem->Render(style);
            aitem->glID = glIDCount;
          }
        }
        glEndList();

//Low res (non-excluded) bonds
        glNewList( QBONDLIST, GL_COMPILE);
        {
          GLfloat Diffuse[] = { 0.2f,0.2f,0.2f,1.0f };
          GLfloat Specula[] = { 0.8f,0.8f,0.8f,1.0f };
          GLfloat Shinine[] = {89.6f};
          glMaterialfv(GL_FRONT, GL_DIFFUSE,  Diffuse);
          glMaterialfv(GL_FRONT, GL_SPECULAR, Specula);
          glMaterialfv(GL_FRONT, GL_SHININESS,Shinine);
        }
        mBondList->Reset();
        while ( (bitem = (CcModelBond*)mBondList->GetItemAndMove()) )
        {
          if ( !(bitem->m_excluded) )
          {
            glLoadName ( ++ glIDCount );
            bitem->Render(style);
            bitem->glID = glIDCount;
          }
        }
        glEndList();
      }

      return true;
   }
   return false;
}

void CcModelDoc::ExcludeBonds()
{
  if ( mBondList->ListSize() )
  {
    mBondList->Reset();
    CcModelBond* bitem;

    while ( (bitem = (CcModelBond*)mBondList->GetItemAndMove()) )
    {
      bitem->SelfExclude();
    }
   }
}


void CcModelDoc::SelectFrag(CcString atomname, bool select)
{
   CcModelAtom *aitem;
   CcModelBond *bitem;

// Set spare to false for all atoms

   if ( mAtomList->ListSize() )
   {
      mAtomList->Reset();
      while ((aitem = (CcModelAtom*)mAtomList->GetItemAndMove()))
      {
        aitem->spare = false;
      }
   }

// Set spare to true for the passed in atom.

   aitem = FindAtomByLabel(atomname);
   if ( aitem ) aitem->spare = true;
   int nChanged = 1;

// Loop setting spare to true for any atoms bonded to other atoms
// that also have spare true, until no more changes.

   while ( nChanged )
   {
     nChanged = 0;

     if ( mBondList->ListSize() )
     {
       mBondList->Reset();
       while ((bitem = (CcModelBond*)mBondList->GetItemAndMove()) )
       {
         if (( bitem->atom1 ) && ( bitem->atom2 ))
         {
           if (( bitem->atom1->spare ) && ( ! bitem->atom2->spare ))
           {
              bitem->atom2->spare = true;
              nChanged++;
           }
           else if (( bitem->atom2->spare ) && ( ! bitem->atom1->spare ))
           {
              bitem->atom1->spare = true;
              nChanged++;
           }
         }
       }
     }
   }

// Select or unselect all spare-flagged atoms.

   if ( mAtomList->ListSize() )
   {
      mAtomList->Reset();
      while ((aitem = (CcModelAtom*)mAtomList->GetItemAndMove()))
      {
         if ( aitem->spare ) aitem->Select(select);
      }
   }
   DrawViews();
}

CcString CcModelDoc::SelectedAsString( CcString delimiter )
{
  CcString result;
  CcModelAtom * anAtom;

  mAtomList->Reset();
  while ( anAtom = (CcModelAtom*)mAtomList->GetItemAndMove() ) 
  {
     if( anAtom->IsSelected() ) result += anAtom->Label() + delimiter;
  }
  return result;

}



void CcModelDoc::SendAtoms( int style, Boolean sendonly )
{
   if ( mAtomList->ListSize() )
   {
      mAtomList->Reset();
      CcModelAtom* aitem;
      while ( (aitem = (CcModelAtom*)mAtomList->GetItemAndMove()) )
      {
        if ( aitem->IsSelected() ) aitem->SendAtom (style, sendonly);
      }
   }
}

void CcModelDoc::ZoomAtoms( Boolean doZoom )
{
  if ( mAtomList->ListSize() )
  {
     mAtomList->Reset();
     CcModelAtom* aitem;
     while ( (aitem = (CcModelAtom*)mAtomList->GetItemAndMove()) )
     {
        if ( aitem->IsSelected() )
        {
          aitem->m_excluded = false;
        }
        else
        {
          aitem->m_excluded = doZoom;
        }
     }
  }
  if ( mBondList->ListSize() )
  {
     mBondList->Reset();
     CcModelBond* bitem; 
     while ( (bitem = (CcModelBond*)mBondList->GetItemAndMove()) )
     {
       bitem->SelfExclude();
     }
  }
}

CcModelObject * CcModelDoc::FindObjectByGLName(GLuint name)
{
  CcModelObject* aitem;
  if ( mAtomList->ListSize() )
  {
     mAtomList->Reset();
     while ( (aitem = (CcModelObject*)mAtomList->GetItemAndMove()) )
     {
        if ( aitem->glID == name )  return aitem;
     }
  }
  if ( mBondList->ListSize() )
  {
     mBondList->Reset();
     while ( (aitem = (CcModelObject*)mBondList->GetItemAndMove()) )
     {
        if ( aitem->glID == name )  return aitem;
     }
  }
  return nil;
}


