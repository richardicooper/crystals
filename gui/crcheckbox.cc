////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CrCheckBox

////////////////////////////////////////////////////////////////////////

//   Filename:  CrCheckBox.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   $Log: not supported by cvs2svn $
//   Revision 1.5  2001/06/17 15:14:12  richard
//   Addition of CxDestroy function call in destructor to do away with their Cx counterpart properly.
//
//   Revision 1.4  2001/03/08 16:44:04  richard
//   General changes - replaced common functions in all GUI classes by macros.
//   Generally tidied up, added logs to top of all source files.
//

#include    "crystalsinterface.h"
#include    "crconstants.h"
#include    "crcheckbox.h"

#include    "crgrid.h"
#include    "cxcheckbox.h"
#include    "ccrect.h"
#include    "cctokenlist.h"
#include    "cccontroller.h"    // for sending commands

CrCheckBox::CrCheckBox( CrGUIElement * mParentPtr )
    :   CrGUIElement( mParentPtr )
{
    ptr_to_cxObject = CxCheckBox::CreateCxCheckBox( this, (CxGrid *)(mParentPtr->GetWidget()) );
    mTabStop = true;
    mCallbackState = false;
}

CrCheckBox::~CrCheckBox()
{
    if ( ptr_to_cxObject != nil )
    {
        ((CxCheckBox*)ptr_to_cxObject)->CxDestroyWindow();
#ifdef __CR_WIN__
        delete (CxCheckBox*)ptr_to_cxObject;
#endif
        ptr_to_cxObject = nil;
    }
}

CRSETGEOMETRY(CrCheckBox,CxCheckBox)
CRGETGEOMETRY(CrCheckBox,CxCheckBox)
CRCALCLAYOUT(CrCheckBox,CxCheckBox)

CcParse CrCheckBox::ParseInput( CcTokenList * tokenList )
{
    CcParse retVal(true, mXCanResize, mYCanResize);
    bool hasTokenForMe = true;

    // Initialization for the first time
    if( ! mSelfInitialised )
    {
        LOGSTAT("*** CheckBox *** Initing...");

        retVal = CrGUIElement::ParseInput( tokenList );
        mSelfInitialised = true;

        LOGSTAT( "*** Created CheckBox    " + mName );
    }
    // End of Init, now comes the general parser
    while ( hasTokenForMe )
    {
        switch ( tokenList->GetDescriptor(kAttributeClass) )
        {
            case kTTextSelector:
            {
                tokenList->GetToken(); // Remove that token!
                mText = tokenList->GetToken();
                SetText( mText );
                LOGSTAT( "Setting CheckBox Text: " + mText );
                break;
            }
            case kTInform:
            {
                tokenList->GetToken(); // Remove that token!
                bool inform = (tokenList->GetDescriptor(kLogicalClass) == kTYes) ? true : false;
                tokenList->GetToken(); // Remove that token!
                if(inform)
                    LOGSTAT( "CrCheckBox:ParseInput Checkbox INFORM on ");
                else
                    LOGSTAT( "CrCheckBox:ParseInput Checkbox INFORM off ");
                mCallbackState = inform;
                break;
            }
            case kTDisabled:
            {
                tokenList->GetToken(); // Remove that token!
                bool disabled = (tokenList->GetDescriptor(kLogicalClass) == kTYes) ? true : false;
                tokenList->GetToken(); // Remove that token!
                if(disabled)
                    LOGSTAT( "CrCheckBox:ParseInput Checkbox disabled ");
                else
                    LOGSTAT( "CrCheckBox:ParseInput Checkbox enabled ");
                ((CxCheckBox*)ptr_to_cxObject)->Disable( disabled );
                break;
            }
            case kTState:
            {
                tokenList->GetToken(); // Remove that token!
                bool state = (tokenList->GetDescriptor(kLogicalClass) == kTOn) ? true : false;
                tokenList->GetToken(); // Remove that token!
                if(state)
                    LOGSTAT( "CrCheckBox:ParseInput Checkbox STATE on ");
                else
                    LOGSTAT( "CrCheckBox:ParseInput Checkbox STATE off ");
                SetState(state);
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
void    CrCheckBox::SetText( CcString text )
{
    char theText[256];
    strcpy( theText, text.ToCString() );

    ( (CxCheckBox *)ptr_to_cxObject)->SetText( theText );
}

void    CrCheckBox::GetValue()
{

    CcString stateString;
    if ( ((CxCheckBox*)ptr_to_cxObject)->GetBoxState() )
        stateString = kSOn;
    else
        stateString = kSOff;
    SendCommand( stateString );

}

void    CrCheckBox::GetValue(CcTokenList * tokenList)
{
    CcString stateString;
    if( tokenList->GetDescriptor(kQueryClass) == kTQState )
    {
        tokenList->GetToken();
        if ( ((CxCheckBox*)ptr_to_cxObject)->GetBoxState() )
            stateString = kSOn;
        else
            stateString = kSOff;
        SendCommand( stateString,true);
    }
    else
    {
        SendCommand( "ERROR",true );
        stateString = tokenList->GetToken();
        LOGWARN( "CrCheckBox:GetValue Error unrecognised token." + stateString);
    }
}

void    CrCheckBox::BoxChanged( bool state )
{
    if(mCallbackState)
    {
        CcString stateString;
        if ( state )
            stateString = kSOn;
        else
            stateString = kSOff;
        SendCommand(mName + "_N" + stateString);
    }
}

void    CrCheckBox::SetState( bool state )
{
    ((CxCheckBox*)ptr_to_cxObject)->SetBoxState(state);
}

void CrCheckBox::CrFocus()
{
    ((CxCheckBox*)ptr_to_cxObject)->Focus();
}
