////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CcStatus

////////////////////////////////////////////////////////////////////////

//   Filename:  CcStatus.h
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   26.2.1998 9:36 Uhr
//   $Log: not supported by cvs2svn $
//   Revision 1.3  2001/03/08 15:22:11  richard
//   New flag signalling that the model window is in a ZOOMED in state.
//   Call to UpdateToolbars, when status changes, updates toolbar buttons, normal
//   buttons and windows with the DISABLEIF, ENABLEIF flags.
//

#ifndef     __CcStatus_H__
#define     __CcStatus_H__
//Insert your own code here.

//End of user code.

//Updated by crystals thread.
#define bS0     "L1"
#define bS1     "L2"
#define bS2     "L3"
#define bS3     "L5"
#define bS4     "L6"
#define bS5     "IN"
#define bS6     "QS"
#define bS7
#define bS8
#define bS9
#define bS10
#define bS11
#define bS12
#define bS13
#define bS14
#define bS15
//Reserved for interface.
#define bS16    "SEL0"
#define bS17    "SEL1"
#define bS18    "SEL2"
#define bS19    "SEL3"
#define bS20    "SEL>=3"
#define bS21    "ZOOMED"
#define bS22
#define bS23
#define bS24
#define bS25
#define bS26
#define bS27
#define bS28
#define bS29
#define bS30
#define bS31

class CcTokenList;

//There is only one CcStatus object, it belongs to CcController.

class   CcStatus
{
  public:

// methods

    CcStatus();
    ~CcStatus();

// sets and unsets flags as notified by CRYSTALS.

    void ParseInput(CcTokenList* tokenList);


// sets and unsets flags as notified by the MODEL VIEW.

    void SetNumSelectedAtoms(int n);
    void SetZoomedFlag(bool zoomed);

// Creates a bit flag for menu items/toolbars based on the
// ENABLEIF and DISABLEIF strings they are passed.

    int CreateFlag(CcString theFlags);

// Checks a menu/toolbar item against the current status to determine
// whether it should be enabled.

    bool ShouldBeEnabled(int enableFlags, int disableFlags);

  private:

//methods
    int GetBitByToken(CcString token);
    void UnSetBit(int i, int* theFlags);
    void SetBit(int i, int* theFlag);
    void UpdateToolBars();
    void ScriptsExited();

//attributes
    int statusFlags;

};

#define kSSetStatus     "STATSET"
#define kSUnSetStatus       "STATUNSET"

enum
{
 kTSetStatus = 500,
 kTUnSetStatus
};


#endif
