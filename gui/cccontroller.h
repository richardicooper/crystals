////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CcController

////////////////////////////////////////////////////////////////////////

//   Filename:  CcController.h
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   22.2.1998 15:02 Uhr
//   $Log: not supported by cvs2svn $

#ifndef     __CcController_H__
#define     __CcController_H__

#include    "cclist.h"
#include    "cccommandqueue.h"
#include    "ccstatus.h"
#include    "ccrect.h"
#include    <stdio.h> //For FILE definition


#ifdef __CR_WIN__
#include <afxwin.h>
#endif

#ifdef __BOTHWX__
#include <wx/thread.h>
#include <wx/app.h>
#include "crystals.h"
#include "ccthread.h"
 DECLARE_APP(CCrystalsApp)
#endif


class CcChartDoc;
class CcModelDoc;
class CrWindow;
class CcTokenList;
class CrGUIElement;
class CcQuickData;
class CcMenuItem;
class CcTool;
class CrButton;

class   CcController
{
  public:
    CcController( CcString directory, CcString dscfile );
    ~CcController();

    void GetValue (CcTokenList * tokenlist);

    CcRect GetScreenArea();

    CcModelDoc* CreateModelDoc(CcString name);
    CcModelDoc* FindModelDoc(CcString name);

    int FindFreeMenuId();
    void AddMenuItem( CcMenuItem * menuitem );
    void RemoveMenuItem( CcMenuItem * menuitem );
    void RemoveMenuItem ( CcString menuitemname );
    CcMenuItem* FindMenuItem( int id );
    CcMenuItem* FindMenuItem( CcString name );

    int FindFreeToolId();
    void AddTool( CcTool * tool );
    void RemoveTool( CcTool * tool );
    void RemoveTool ( CcString toolname );
    CcTool* FindTool( int id );
    CcTool* FindTool( CcString name );

    void AddDisableableWindow( CrWindow * aWindow );
    void RemoveDisableableWindow ( CrWindow * aWindow );

    void AddDisableableButton( CrButton * aButton );
    void RemoveDisableableButton ( CrButton * aButton );


    CrGUIElement* GetTextOutputPlace();
    CrGUIElement* GetBaseTextOutputPlace();
    void SetTextOutputPlace(CrGUIElement* outputPane);
    void RemoveTextOutputPlace(CrGUIElement* output);

    CrGUIElement* GetProgressOutputPlace();
    void RemoveProgressOutputPlace(CrGUIElement* output);
    void SetProgressOutputPlace(CrGUIElement* outputPane);
    void SetProgressText(CcString * theText);

    CrGUIElement* GetInputPlace();
    void RemoveInputPlace(CrGUIElement* input);
    void SetInputPlace(CrGUIElement* inputPane);

    void RemoveWindowFromList(CrWindow* window);

    CrGUIElement* FindObject( CcString Name );

    void AddHistory( CcString theText );

    void ReLayout();
    void History(Boolean up);
    void FocusToInput(char theChar);

    Boolean ParseInput( CcTokenList * tokenList );
    Boolean ParseLine( CcString text );
    void    SendCommand( CcString command , Boolean jumpQueue = false);
    void    Tokenize( CcString text );
    Boolean IsSpace( char c );
    Boolean IsDelimiter( char c );
    void  AppendToken( CcString text );

    void  AddCrystalsCommand( CcString line , Boolean jumpQueue = false);
    Boolean GetCrystalsCommand( char * line );
    void  AddInterfaceCommand( CcString line );
    Boolean GetInterfaceCommand( char * line );
    Boolean GetInterfaceCommand( CcString * line );

    void LogError( CcString errString , int level);
    void CompleteProcessing();
    void ProcessingComplete();
    void UpdateToolBars();

    void StoreKey( CcString key, CcString value );
    CcString GetKey( CcString key );


    void OpenFileDialog(CcString* filename, CcString extensionFilter, CcString extensionDescription, Boolean titleOnly);
    void SaveFileDialog(CcString* filename, CcString defaultName, CcString extensionFilter, CcString extensionDescription);
    void OpenDirDialog(CcString* result);
    void ChooseFont();

    void StartCrystalsThread();
    void  ProcessOutput(CcString theLine);

    void     ChangeDir (CcString newDir);

    int      EnvVarCount( CcString dir );
    CcString EnvVarExtract ( CcString dir, int i );

// attributes

    CcChartDoc* mCurrentChartDoc;
    CcModelDoc* mCurrentModelDoc;
    Boolean mThisThreadisDead;
    Boolean m_Completing;
    CcStatus status;

    static CcController* theController;
    static int debugIndent;

    CrWindow *      mCurrentWindow;
    CrGUIElement *  mInputWindow;
    CrGUIElement *  mTextWindow;
    CrGUIElement *  mProgressWindow;
    CcString m_newdir;
    Boolean m_restart;
    Boolean m_Wait;
    CcList  mGraphList;
    CcList  mChartList;

#ifdef __CR_WIN__
    static CWinThread *mCrystalsThread;
#endif
#ifdef __BOTHWX__
    static CcThread *mCrystalsThread;
#endif


#ifdef __CR_WIN__
    static CFont* mp_font;
    static CFont* mp_inputfont;
#endif

  protected:
    CcTokenList *   mQuickTokenList;
    CcTokenList *   mWindowTokenList;
    CcTokenList *   mChartTokenList;
    CcTokenList *   mModelTokenList;
    CcTokenList *   mStatusTokenList;
    CcTokenList *   mTempTokenList;
    CcTokenList *   mCurTokenList;

    CrWindow *      mModelWindow;
    FILE *  mErrorLog;

    CcList  mWindowList;
    CcList  mTextOutputWindowList;
    CcList  mProgressOutputWindowList;
    CcList  mInputWindowList;
    CcList  mModelDocList;

    CcList  mMenuItemList;
    int     m_next_id_to_try;

    CcList  mToolList;
    int     m_next_tool_id_to_try;

    CcList  mDisableableWindowsList;
    CcList  mDisableableButtonsList;

    CcList mCommandHistoryList;
    int mCommandHistoryPosition;

    CcCommandQueue  mCrystalsCommandQueue;
    CcCommandQueue  mInterfaceCommandQueue;
};


extern "C" {

  // new style API for FORTRAN
  // FORCALL() macro adds on _ to end of word for linux version.

  void  ciflushbuffer  (    long *theLength,    char * theLine  );
  void  endthread      (  long theExitcode                  );

  void  FORCALL(cinextcommand)  (    long *theStatus,    char theLine[80]);
  void  FORCALL(ciendthread)    (  long theExitcode                  );
  void  FORCALL(newdata)        (    int isize,      int* id         );
  void  FORCALL(datain)         ( int id, int *data, int offset, int nwords );
  void  FORCALL(callccode)      (  char *theLine                     );
  void  FORCALL(guexec)         (  char *theLine                     );

  void crystals( void );

}




#define kSSysOpenFile      "SYSOPENFILE"
#define kSSysSaveFile      "SYSSAVEFILE"
#define kSSysGetDir        "SYSGETDIR"
#define kSSysRestart       "RESTART"
#define kSRestartFile      "NEWFILE"
#define kSRedirectText     "SENDTEXTTO"
#define kSRedirectProgress "SENDPROGRESSTO"
#define kSRedirectInput    "GETINPUTFROM"
#define kSCreateWindow     "WINDOW"
#define kSDisposeWindow    "DISPOSE"
#define kSSet          "SET"
#define kSRenameObject     "RENAME"
#define kSGetValue     "GETVALUE"
#define kSTitleOnly    "TITLEONLY"
#define kSGetKeyValue      "GETKEY"
#define kSSetKeyValue      "SETKEY"

#define kSWindowSelector    "WI"
#define kSChartSelector     "CH"
#define kSOneCommand        "CO"
#define kSControlSelector   "CR"
#define kSModelSelector     "GR"
#define kSStatusSelector    "ST"
#define kSQuerySelector     "??"

#define kSFocus               "FOCUS"
#define kSFontSet             "FONT"

enum
{
 kTSysOpenFile = 400,
 kTSysSaveFile,
 kTSysGetDir,
 kTSysRestart,
 kTRestartFile,
 kTRedirectText,
 kTRedirectProgress,
 kTRedirectInput,
 kTCreateWindow,
 kTDisposeWindow,
 kTSet,
 kTRenameObject,
 kTGetValue,
 kTTitleOnly,
 kTWindowSelector,
 kTChartSelector,
 kTOneCommand,
 kTControlSelector,
 kTModelSelector,
 kTStatusSelector,
 kTQuerySelector,
 kTGetKeyValue,
 kTSetKeyValue,
 kTFocus,
 kTFontSet

};




#endif
