////////////////////////////////////////////////////////////////////////
//   CRYSTALS Interface      Class CrText
////////////////////////////////////////////////////////////////////////

//   Filename:  CrText.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   $Log: not supported by cvs2svn $

#include    "crystalsinterface.h"
#include    "crconstants.h"
#include    "crtext.h"
#include    "crgrid.h"
#include    "cxtext.h"
#include    "ccrect.h"
#include    "cccontroller.h"    // for sending commands


CrText::CrText( CrGUIElement * mParentPtr )
    :   CrGUIElement( mParentPtr )
{
    ptr_to_cxObject = CxText::CreateCxText( this, (CxGrid *)(mParentPtr->GetWidget()) );
    mTabStop = false;
}

CrText::~CrText()
{
    if ( ptr_to_cxObject )
    {
        ((CxText*) ptr_to_cxObject)->DestroyWindow(); delete (CxText*) ptr_to_cxObject;
        ptr_to_cxObject = nil;
    }
}

CRSETGEOMETRY(CrText,CxText)
CRGETGEOMETRY(CrText,CxText)
CRCALCLAYOUT(CrText,CxText)

CcParse CrText::ParseInput( CcTokenList * tokenList )
{
    CcParse retVal(true, mXCanResize, mYCanResize);
    Boolean hasTokenForMe = true;

    // Initialization for the first time
    if( ! mSelfInitialised )
    {
        retVal = CrGUIElement::ParseInput( tokenList );
        mSelfInitialised = true;
        LOGSTAT( "Created Static Text " + mName );
    }

    while ( hasTokenForMe )
    {
        switch ( tokenList->GetDescriptor(kAttributeClass) )
        {
            case kTTextSelector:
            {
                tokenList->GetToken(); // Remove that token!
                mText = tokenList->GetToken();
                SetText( mText );
                LOGSTAT( "Setting Text to '" + mText );
                break;
            }
            case kTChars:
            {
                tokenList->GetToken(); // Remove that token!
                CcString theString = tokenList->GetToken();
                int chars = atoi( theString.ToCString() );
                ((CxText*)ptr_to_cxObject)->SetVisibleChars( chars );
                LOGSTAT( "Setting Text Chars Width: " + theString );
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

void CrText::GetValue(CcTokenList * tokenList)
{
    int desc = tokenList->GetDescriptor(kQueryClass);
    if( desc == kTQText )
    {
        tokenList->GetToken();
        SendCommand( mText, true );
    }
    else
    {
        SendCommand( "ERROR",true );
        CcString error = tokenList->GetToken();
        LOGWARN( "CrEditBox:GetValue Error unrecognised token." + error);
    }
}




void CrText::SetText( CcString text )
{
    ( (CxText *)ptr_to_cxObject)->SetText( text );
}

void CrText::CrFocus()
{

}
