////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CrListBox

////////////////////////////////////////////////////////////////////////

//   Filename:  CrListBox.cc
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 14:43 Uhr
//   Modified:  30.3.1998 11:25 Uhr

//  $Log: not supported by cvs2svn $
//  Revision 1.7  2000/12/13 17:57:12  richard
//  Extra safety check for empty string tokens, to prevent infinite loop.
//  CxListBox::SetSelection changed to CxListBox::CxSetSelection to avoid name clash.
//
//  Revision 1.6  1999/06/01 12:48:39  dosuser
//  RIC: Failed to check in with the last bunch of files.
//
//  Revision 1.5  1999/04/28 13:59:48  dosuser
//  RIC: Fix: Added a break to a case statement.
//
//  Revision 1.4  1999/04/26 12:21:03  dosuser
//  RIC: Added a kTSetSelection section in ParseInput to allow the current
//       selection to be changed from SCRIPTS
//

#include    "crystalsinterface.h"
#include    "crconstants.h"
#include    "crlistbox.h"
//insert your own code here.
#include    "crwindow.h"
#include    "crgrid.h"
#include    "cxlistbox.h"
#include    "ccrect.h"
#include    "cccontroller.h"    // for sending commands


CrListBox::CrListBox( CrGUIElement * mParentPtr )
    :CrGUIElement( mParentPtr )
{
    ptr_to_cxObject = CxListBox::CreateCxListBox( this, (CxGrid *)(mParentPtr->GetWidget()) );
    mTabStop = true;
}

    CrListBox::~CrListBox()
{
    if ( ptr_to_cxObject != nil )
    {
        delete (CxListBox*)ptr_to_cxObject;
        ptr_to_cxObject = nil;
    }

}

Boolean CrListBox::ParseInput( CcTokenList * tokenList )
{

    Boolean retVal = true;
    Boolean hasTokenForMe = true;
    CcString theToken;
//t
    // Initialization for the first time
    if( ! mSelfInitialised )
    {
        LOGSTAT("*** ListBox *** Initing...");

        mName = tokenList->GetToken();
        mSelfInitialised = true;

        hasTokenForMe = true;
        while ( hasTokenForMe )
        {
            switch ( tokenList->GetDescriptor(kAttributeClass) )
            {
                case kTVisibleLines:
                {
                    tokenList->GetToken(); // Remove the keyword
                    int lines;
                    CcString theToken = tokenList->GetToken();
                    lines = atoi( theToken.ToCString() );
                    ( (CxListBox *)ptr_to_cxObject)->SetVisibleLines( lines );
                    LOGSTAT("Setting ListBox visible lines to " + theToken);
                    break;
                }
                default:
                {
                    hasTokenForMe = false;
                    break; // We leave the token in the list and exit the loop
                }
            }
        }

        LOGSTAT( "*** Created ListBox     " + mName );
    }
    // End of Init, now comes the general parser

    hasTokenForMe = true;
    while ( hasTokenForMe )
    {
        switch ( tokenList->GetDescriptor(kAttributeClass) )
        {
            case kTInform:
            {
                tokenList->GetToken(); // Remove that token!
                Boolean inform = (tokenList->GetDescriptor(kLogicalClass) == kTYes) ? true : false;
                tokenList->GetToken(); // Remove that token!
                mCallbackState = inform;
                if (mCallbackState)
                              LOGSTAT( "Enabling ListBox callback" );
                else
                              LOGSTAT( "Disabling ListBox callback" );
                break;
            }
            case kTAddToList:
            {
                tokenList->GetToken(); // Remove that token!
                Boolean stop = false;
                while ( ! stop )
                {
                    theToken = tokenList->GetToken();
                    if (    ( strcmp( kSNull, theToken.ToCString() ) == 0 )
                         || ( theToken.Length() == 0 ) )
                                                                      stop = true;
                    else
                    {
                        SetText( theToken );
                        LOGSTAT("Adding ListBox text '" + theToken + "'");
                    }
                }
                break;
            }
                  case kTSetSelection:
                  {
                        tokenList->GetToken(); //Remove that token!
                        int select = atoi ( tokenList->GetToken().ToCString() );
                        ((CxListBox*)ptr_to_cxObject)->CxSetSelection(select);
                        break;
                  }
            default:
            {
                hasTokenForMe = false;
                break; // We leave the token in the list and exit the loop
            }
        }
    }


    return ( retVal );

}

void    CrListBox::SetGeometry( const CcRect * rect )
{

    ((CxListBox*)ptr_to_cxObject)->SetGeometry(  rect->mTop,
                                            rect->mLeft,
                                            rect->mBottom,
                                            rect->mRight );

}

CcRect  CrListBox::GetGeometry()
{

    CcRect retVal(
            ((CxListBox*)ptr_to_cxObject)->GetTop(),
            ((CxListBox*)ptr_to_cxObject)->GetLeft(),
            ((CxListBox*)ptr_to_cxObject)->GetTop()+((CxListBox*)ptr_to_cxObject)->GetHeight(),
            ((CxListBox*)ptr_to_cxObject)->GetLeft()+((CxListBox*)ptr_to_cxObject)->GetWidth()   );
    return retVal;

}

void    CrListBox::CalcLayout()
{

    int w =  ((CxListBox*)ptr_to_cxObject)->GetIdealWidth();
    int h =  ((CxListBox*)ptr_to_cxObject)->GetIdealHeight();
    ((CxListBox*)ptr_to_cxObject)->SetGeometry(-1,-1,h,w);

}

void    CrListBox::SetText( CcString item )
{

    char theText[256];
    strcpy( theText, item.ToCString() );

    ( (CxListBox *)ptr_to_cxObject)->AddItem( theText );
    LOGSTAT( "Adding Item '" + item + "'");

}

void    CrListBox::GetValue()
{
    int value = ( (CxListBox *)ptr_to_cxObject)->GetBoxValue();
    SendCommand( CcString( value ) );
}


void CrListBox::GetValue(CcTokenList * tokenList)
{

    int desc = tokenList->GetDescriptor(kQueryClass);

    if( desc == kTQListtext )
    {
        tokenList->GetToken();
            int index = atoi ((tokenList->GetToken()).ToCString());
//            char theText[256];
//TODO. Wrap this call with a CxListBox function, rather that this base class.
//DONE.
//            int textLen = ((CxListBox*)ptr_to_cxObject)->GetText(index - 1,&theText[0]);
            CcString theText = ((CxListBox*)ptr_to_cxObject)->GetListBoxText(index);
            SendCommand( theText, true );
    }
    else if (desc == kTQSelected )
    {
        tokenList->GetToken();
        int value = ( (CxListBox *)ptr_to_cxObject)->GetBoxValue();
        SendCommand( CcString( value ) , true );
    }
    else
    {
        SendCommand( "ERROR",true );
        CcString error = tokenList->GetToken();
        LOGWARN( "CrEditBox:GetValue Error unrecognised token." + error);
    }


}



void    CrListBox::Selected( int item )
{

    if (mCallbackState)
    {
        CcString theCommand;
        theCommand = mName;
        SendCommand(theCommand);
        theCommand = CcString( item );
        SendCommand(theCommand);
    }
}

void    CrListBox::Committed( int item )
{
    if (mCallbackState)
    {
        CcString theCommand;
        theCommand = mName;
        SendCommand(theCommand);
        theCommand = CcString( item );
        SendCommand(theCommand);
        ((CrWindow*)GetRootWidget())->Committed();
    }
}

void CrListBox::CrFocus()
{
    ((CxListBox*)ptr_to_cxObject)->Focus();
}
