////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CrGUIElement

////////////////////////////////////////////////////////////////////////

//   Filename:  CrGUIElement.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 13:19 Uhr
//   $Log: not supported by cvs2svn $

#include    "crystalsinterface.h"
#include    "crconstants.h"
#include    "crguielement.h"
#include    "cclist.h"
#include    "ccrect.h"
#include    "cccontroller.h"
#include    "cctokenlist.h"
#include    "crwindow.h"

CcController *  CrGUIElement::mControllerPtr;

CrGUIElement::CrGUIElement( CrGUIElement * mParentPtr )
{
    mParentElementPtr = mParentPtr;
    ptr_to_cxObject = nil;
    mSelfInitialised = false;
    mCallbackState = false;
    mAlignment = kNoAlignment;
    mXCanResize = false;
    mYCanResize = false;
    mTabStop = true;
    mDisabled = true;
    m_InitWidth = 0;
    m_InitHeight = 0;
}

CrGUIElement::~CrGUIElement()
{
}

CrGUIElement *  CrGUIElement::FindObject( CcString Name )
{
    if ( Name == mName )
        return this;
    else
        return nil;
}

void *  CrGUIElement::GetWidget()
{
    if ( ptr_to_cxObject == nil )
        return mParentElementPtr->GetWidget();
    else
        return ptr_to_cxObject;
}

CrGUIElement *  CrGUIElement::GetRootWidget()
{
    return mParentElementPtr->GetRootWidget();
}


void    CrGUIElement::Show( Boolean show )
{
    NOTUSED(show);
}

void    CrGUIElement::Align()
{

}
void    CrGUIElement::GetValue()
{
//For all elements that don't return a value, return the text TRUE,
//so the programmer can test their existence.
    (CcController::theController)->SendCommand("TRUE",true);
//(If the element can't be found, FALSE is returned from CcController)
}

void    CrGUIElement::GetValue(CcTokenList * tokenList)
{
//For all elements that don't return a value, return the text ERROR,
//The only valid query for an object that doesn't override this function
//is EXISTS, and that is handled in the CcController::GetValue routine.
    (CcController::theController)->SendCommand("ERROR",true);
}

CcParse CrGUIElement::ParseInput( CcTokenList * tokenList )
{
    CcParse retVal(false, mXCanResize, mYCanResize);

    mName = tokenList->GetToken();
    mText = tokenList->GetToken();

    SetText(mText);

    if ( mText.Length() != 0 || mName.Length() != 0 )
        retVal = CcParse( true, mXCanResize, mYCanResize ) ;

    LOGSTAT( "Identifier = " + mName +
             ", text = "      + mText  );

    return retVal;
}

CcParse CrGUIElement::ParseInputNoText( CcTokenList * tokenList )
{
    CcParse retVal (false, mXCanResize, mYCanResize);

    mName = tokenList->GetToken();

    if ( mName.Length() != 0 )
        retVal = CcParse(true, mXCanResize, mYCanResize);

    LOGSTAT( "Identifier = " + mName );

    return retVal;
}




void    CrGUIElement::SetController( CcController * controller )
{
    mControllerPtr = controller;
}


int CrGUIElement::GetIdealWidth()
{
//This just returns zero. It is overridden for elements which can resize.
    return 0;
}

int CrGUIElement::GetIdealHeight()
{
//This just returns zero. It is overridden for elements which can resize.
    return 0;
}

void CrGUIElement::NextFocus(Boolean bPrevious)
{
    CrGUIElement* nextWindow;
    CrWindow* rootWindow = (CrWindow*)GetRootWidget();

    if(bPrevious)
        nextWindow = (CrGUIElement*)rootWindow->GetPrevTabItem(this);
    else
        nextWindow = (CrGUIElement*)rootWindow->GetNextTabItem(this);

    if(nextWindow)
        nextWindow->CrFocus();
}


void CrGUIElement::FocusToInput(char theChar)
{
    GetRootWidget()->FocusToInput(theChar); //Give the window a chance to handle the
                                          //input first.
}


void CrGUIElement::SendCommand(CcString theText, Boolean jumpQueue)
{
    if(jumpQueue)
        CcController::theController->SendCommand(theText,true);
    else
            mParentElementPtr->SendCommand(theText); //Give the parent objects a chance to handle the
                                               //output first.
//NB For Grid and Window, this function is overridden, to allow commands
//to be prefixed to the output.
//If a command is prefixed, the CcController implementation is called and
//the text is not passed any further up the heirarchy.

}


void CrGUIElement::SysKey( UINT nChar )
{
// This should never be called. It means that a Cr object has requested
// system key messages, but doesn't have an over-riding SysKey routine
// to handle them!
}

void CrGUIElement::SysKeyUp( UINT nChar )
{
// This may be called if the requesting window only want KEYDOWN messages.
// This should never be called. It means that a Cr object has requested
// system key messages, but doesn't have an over-riding SysKey routine
// to handle them!
}

void CrGUIElement::Rename( CcString newName )
{
      LOGSTAT("Renameing object: " + mName + " to " + newName );
      mName = newName;
}
