// crystals.cpp : Defines the class behaviors for the application.
//

#ifdef __WINDOWS__
#include "stdafx.h"
#endif
#ifdef __LINUX__
#include <wx/event.h>
#include <wx/app.h>
#endif

#include "crystals.h"
#include "crystalsinterface.h"
#include "crapp.h"
#include "cccontroller.h"

#ifdef __WINDOWS__
#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif
#endif
/////////////////////////////////////////////////////////////////////////////
// CCrystalsApp
#ifdef __WINDOWS__
BEGIN_MESSAGE_MAP(CCrystalsApp, CWinApp)
	//{{AFX_MSG_MAP(CCrystalsApp)
	//}}AFX_MSG_MAP
	// Standard file based document commands
	ON_COMMAND(ID_FILE_NEW, CWinApp::OnFileNew)
	ON_COMMAND(ID_FILE_OPEN, CWinApp::OnFileOpen)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCrystalsApp construction

CCrystalsApp::CCrystalsApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CCrystalsApp object

CCrystalsApp theApplication;


/////////////////////////////////////////////////////////////////////////////
// CCrystalsApp initialization

BOOL CCrystalsApp::InitInstance()
{
	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif

	// Change the registry key under which our settings are stored.
	// You should modify this string to be something appropriate
	// such as the name of your company or organization.
	SetRegistryKey(_T("Local AppWizard-Generated Applications"));

	LoadStdProfileSettings(0);  // Load standard INI file options (including MRU)

	// Register the application's document templates.  Document templates
	//  serve as the connection between documents, frame windows and views.

//
	// Parse command line for standard shell commands, DDE, file open
//	CCommandLineInfo cmdInfo;
//	ParseCommandLine(cmdInfo);

	// Dispatch commands specified on the command line
//	if (!ProcessShellCommand(cmdInfo))
//          return false;


	theCrApp = new CrApp(NULL,NULL);


	
	
//	CFrameWnd* theMainWindow = new CFrameWnd;
//	theMainWindow->Create(NULL,"CrystalsII",WS_OVERLAPPEDWINDOW);
//	m_pMainWnd = (CWnd*)theMainWindow;
//	m_pMainWnd->ShowWindow(SW_SHOW);
//	m_pMainWnd->UpdateWindow();

      return true;
}



BOOL CCrystalsApp::OnIdle(LONG lCount) 
{
	// TODO: Add your specialized code here and/or call the base class
	BOOL sysret = CWinApp::OnIdle(lCount);
	BOOL appret = false;

	char theLine[255];

	if (lCount > 10)
	{
		if(theCrApp->mController->GetInterfaceCommand(theLine))
		{
			appret = true;
			int theLength = 0;

			if(theLength = strlen( theLine )) //Assignment within conditional (OK)
			{
				theLine[theLength+1]='\0';
				theCrApp->mController->Tokenize(theLine);
			}
		}
	}

	//Only stop idle processing if:
	// 1. lCount is high.
	// 2. appret is false (no more interface commands)
	// 3. sysret is false (no more idle processing needed by framework).
	if((lCount > 1000) && (!appret) && (!sysret)) 
		return false;
	else
		return true;
}


int CCrystalsApp::ExitInstance() 
{

	delete theCrApp;
	delete (CFrameWnd*)m_pMainWnd;

	return CWinApp::ExitInstance();
}
#endif

#ifdef __LINUX__

CCrystalsApp::CCrystalsApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CCrystalsApp object

IMPLEMENT_APP(CCrystalsApp)

/////////////////////////////////////////////////////////////////////////////
// CCrystalsApp initialization

BEGIN_EVENT_TABLE( CCrystalsApp, wxApp )
      EVT_IDLE ( CCrystalsApp::OnIdle )
END_EVENT_TABLE()

bool CCrystalsApp::OnInit()
{

      theCrApp = new CrApp(0,(char**)nil);
      return true;
}



void CCrystalsApp::OnIdle(wxIdleEvent & event) 
{
	// TODO: Add your specialized code here and/or call the base class
      wxApp::OnIdle(event);
	bool sysret = event.MoreRequested();
	bool appret = false;

      cerr << "idling... \n";

	char theLine[255];

	if(theCrApp->mController->GetInterfaceCommand(theLine))
	{
            cerr << "idling, but what's this, a line " << theLine << "\n";
		appret = true;

		int theLength = 0;

		if(theLength = strlen( theLine )) //Assignment within conditional (OK)
		{
			theLine[theLength+1]='\0';
			theCrApp->mController->Tokenize(theLine);
		}
	}

	//Only stop idle processing if:
	// 1. appret is false (no more interface commands)
	// 2. sysret is false (no more idle processing needed by framework).
	if((!appret) && (!sysret)) 
      {
            cerr << "Fed up idling... \n";
            cerr << "but let me idle more anyway. \n";
		event.RequestMore();
		return;
      }
      else
      {
            cerr << "Let me idle more... \n";
		event.RequestMore();
      }
	return;
}


int CCrystalsApp::OnExit() 
{

	delete theCrApp;
//	delete (CFrameWnd*)m_pMainWnd;

	return wxApp::OnExit();
}
#endif

