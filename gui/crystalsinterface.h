////////////////////////////////////////////////////////////////////////
//   Filename:  CrystalsInterface.h
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   27.2.1998 14:11 Uhr
// $Log: not supported by cvs2svn $
// Revision 1.24  2003/01/14 10:27:18  rich
// Bring all sources up to date on Linux. Still not working: Plots, ModList, ListCtrl
//
// Revision 1.23  2002/12/16 18:26:40  rich
// Fix breaking Cameron menus. Add some debugging for debug version.
//
// Revision 1.22  2002/09/27 14:49:04  rich
// New marker for modlistbase.
//
// Revision 1.21  2002/07/23 08:27:02  richard
//
// Extra parameter during GRID creation: "ISOLATE" - grid won't expand when the
// window resizes, even if it contains objects which might like to expand.
//
// Revision 1.20  2002/07/03 14:23:21  richard
// Replace as many old-style stream class header references with new style
// e.g. <iostream.h> -> <iostream>. Couldn't change the ones in ccstring however, yet.
//
// Removed OnStuffToProcess message from WinApp, it doesn't compile under the new
// stricter C++7.0 compiler. (CWinApp isn't a CWnd, so can't recieve messages?)
//
// Removed some bits from Steve's Plot classes that were generating (harmless) compiler
// warning messages.
//
// Revision 1.19  2001/10/10 12:44:50  ckp2
// The PLOT classes!
//
// Revision 1.18  2001/07/16 07:27:52  ckp2
// Just fiddling.
//
// Revision 1.17  2001/06/18 12:42:55  richard
// Remove definition of __WXGTK__ as it is defined on the compiler command line.
//
// Revision 1.16  2001/06/17 14:50:00  richard
// Bug in wx version of onchar macro.
//
// Revision 1.15  2001/03/27 15:15:00  richard
// Added a timer to the main window that is activated as the main window is
// created.
// The timer fires every half a second and causes any messages in the
// CRYSTALS message queue to be processed. This is not the main way that messages
// are found and processed, but sometimes the program just seemed to freeze and
// would stay that way until you moved the mouse. This should (and in fact, does
// seem to) remedy that problem.
// Good good good.
//
// Revision 1.14  2001/03/15 11:05:41  richard
// Error checking. Ensure that if ptr_to_cxObject is NULL then we don't call
// any of the Cx object's functions. (This allows CxModel to fail gracefully, and
// the application to continue working). NB. BECAUSE OF CHANGE TO CRYSTALSINTERFACE.H
// I'D RECOMMEND AT LEAST A 'code gui', IF NOT A 'code' or 'buildall'.
//
// Revision 1.13  2001/03/08 15:48:56  richard
// A lot of code was repeated across the Cr and Cx classes. I've moved it here
// in the form of #define macros. Mainly geometry getting and setting stuff.
//
// Revision 1.12  2001/01/25 17:13:32  richard
// kTabBase added. Tidied.
//
// Revision 1.11  2001/01/16 15:35:00  richard
// wxWindows support.
// Revamped some of CxTextout, Cr/Cx Menu and MenuBar. These changes must be
// checked out in conjunction with changes to \bin\
//
// Revision 1.10  2000/12/13 18:03:08  richard
// Linux(wxWindows) and Windows(wxWindows) support added.
//
#ifndef     __CrystalsInterface_H__
#define     __CrystalsInterface_H__

#ifdef __LINUX__
#define __BOTHWX__ 1
#endif

#ifdef __CR_WIN__
#define __BOTHWIN__ 1
#endif


//#include    "ccstring.h"
//void errorlog( CcString outStr );
// Instructions

//NB Try to keep Windows ID's below 65535, I think
//   some bits of the API use short ints.
enum {
    kToolBarBase        =   25000,
    kToolButtonBase     =   30000,
    kMenuBase           =   35000,

    kButtonBase         =   40000,
    kListBoxBase        =   41000,
    kDropDownBase       =   42000,
    kEditBoxBase        =   43000,
    kGridBase           =   44000,
    kGroupBoxBase       =   45000,
    kMultiEditBase      =   46000,
    kTextBase           =   47000,
    kCheckBoxBase       =   48000,
    kRadioButtonBase    =   49000,
    kWindowBase         =   50000,
    kChartBase          =   52000,
    kModelBase          =   53000,
    kProgressBase       =   54000,
    kListCtrlBase       =   55000,
    kTextOutBase        =   56000,
    kBitmapBase         =   57000,
    kTabBase            =   58000,
    kResizeBarBase      =   59000,
    kStretchBase        =   60000,
    kPlotBase           =   61000,
    kModListBase        =   62000
};
#define kNoAlignment        0
#define kIsolate            1
#define kRightAlign         2
#define kBottomAlign        4
#define kModal              1
#define kZoom               2
#define kClose              4
#define kSize               8
#define EMPTY_CELL          10


#define NOTUSED(a) //Compares a to itself, optimiser will remove this.(?)

#ifdef __POWERPC__
typedef void AppContext;
#endif

#ifdef __MOTO__
#include <Types.h>
typedef void AppContext;
#endif



#ifdef __BOTHWX__
#define nil 0
#include <wx/wx.h>
//typedef false GFSHJKLSHGJK;
//typedef true FHDLJDSGS;
typedef unsigned int UINT;
//#include <stdio.h>
//#include <iostream>
//#include <wx/file.h>
//#include <wx/memory.h>
// #include <wx/fontdlg.h>
//#include <iomanip>
//#define TRACE WXTRACE
#endif


#ifdef __CR_WIN__
#include "stdafx.h"
#include "crystals.h"
#define nil NULL
#define WM_STUFFTOPROCESS 6351
#endif



#ifdef _DEBUG
  #ifdef __CR_WIN__
//    #include <afxwin.h> //Needed for TRACE debugger macro.
//    #define new DEBUG_NEW //Needed for debugger to track heap allocations.
  #endif
  #ifdef __BOTHWX__
    #include <wx/object.h>
  #endif
#endif

#define CRLEFT    0
#define CRRIGHT   1
#define CRUP      2
#define CRDOWN    3
#define CRINSERT  4
#define CRDELETE  5
#define CREND     6
#define CRESCAPE  7
#define CRCONTROL 8
#define CRSHIFT   9
#define COVALENT    1
#define VDW       2
#define THERMAL   3
#define SPARE     4



#ifdef _DEBUG
 #define LOGERRORS    //        Log errors         (LOGERR macro)
 #define LOGWARNINGS  //        Log warnings       (LOGWARN macro)
 #define LOGSTATUS    //Log lots of things (LOGSTAT macro)
#else
 #define LOGERRORS    //        Log errors         (LOGERR macro)
 #define LOGWARNINGS  //        Log warnings       (LOGWARN macro)
#ifdef __BOTHWX__   //For the time being on Linux
 #define LOGSTATUS    //Log lots of things (LOGSTAT macro)
#endif

#endif


#ifdef LOGERRORS
        #define LOGERR(a) ( (CcController::theController)->LogError(a,0) )
#else
        #define LOGERR(a)
#endif

#ifdef LOGWARNINGS
        #define LOGWARN(a) ( (CcController::theController)->LogError(a,1) )
#else
        #define LOGWARN(a)
#endif

#ifdef LOGSTATUS
        #define LOGSTAT(a) ( (CcController::theController)->LogError(a,2) )
        #define LOGGEOM(a) ( (CcController::theController)->LogError( CcString(a)+" "+ptr_to_crObject->mName+" SetGeom to t:"+CcString(top)+" l:"+CcString(left)+" h:"+CcString(bottom-top)+" w:"+CcString(right-left), 2) )
        #define TEXTOUT(a) ( (CcController::theController)->Tokenize(a) )
#else
        #define LOGSTAT(a)
        #define LOGGEOM(a)
       #define TEXTOUT(a)
#endif



// The following functions are common to many classes,
// so I've made them into macros.

#define CRCALCLAYOUT(a,b)                                              \
CcRect a##::CalcLayout(bool recalc)                                                            \
{                                                                          \
  if(!recalc) return CcRect(0,0,m_InitHeight,m_InitWidth);                 \
  if ( ptr_to_cxObject )  {                           \
  return CcRect(0,0,(int)(m_InitHeight=((##b*)ptr_to_cxObject)->GetIdealHeight()),  \
                          m_InitWidth =((##b*)ptr_to_cxObject)->GetIdealWidth()); }  \
  return CcRect(0,0,0,0); \
};


#define CRGETGEOMETRY(a,b)                         \
CcRect a##:: GetGeometry()                          \
{   \
if ( ptr_to_cxObject ) \
return CcRect(((##b*)ptr_to_cxObject)->GetTop(),   \
((##b*)ptr_to_cxObject)->GetLeft(),                \
((##b*)ptr_to_cxObject)->GetTop()+                 \
((##b*)ptr_to_cxObject)->GetHeight(),              \
((##b*)ptr_to_cxObject)->GetLeft()+                \
((##b*)ptr_to_cxObject)->GetWidth());              \
return CcRect(0,0,0,0);                            \
};

#define CRSETGEOMETRY(a,b)                         \
void a##::SetGeometry(const CcRect * rect){        \
if ( ptr_to_cxObject ) \
((##b*)ptr_to_cxObject)->SetGeometry(         \
rect->mTop,rect->mLeft,rect->mBottom,rect->mRight);\
}                                                  \


#ifdef __CR_WIN__

#define CXGETGEOMETRIES(a)    \
int a##::GetTop()  { RECT windowRect; GetWindowRect(&windowRect); return ( windowRect.top );}\
int a##::GetLeft() { RECT windowRect; GetWindowRect(&windowRect); return ( windowRect.left );}\
int a##::GetWidth() { CRect windowRect; GetWindowRect(&windowRect); return ( windowRect.Width());}\
int a##::GetHeight(){ CRect windowRect; GetWindowRect(&windowRect); return ( windowRect.Height());}

#define CXSETGEOMETRY(a)   \
void a##::SetGeometry(int t,int l,int b,int r){MoveWindow(l,t,r-l,b-t,true);}

#define CXONCHAR(a)  \
void a##::OnChar(UINT nChar,UINT nRepCnt,UINT nFlags){  \
NOTUSED(nRepCnt);NOTUSED(nFlags);   \
if(nChar==9){ptr_to_crObject->NextFocus( ( HIWORD(GetKeyState(VK_SHIFT))) ? true:false);return;}  \
else {ptr_to_crObject->FocusToInput((char)nChar);}}

#endif
#ifdef __BOTHWX__

#define CXGETGEOMETRIES(a)    \
int a##::GetTop()  { return ( GetRect().y );}\
int a##::GetLeft() { return ( GetRect().x );}\
int a##::GetWidth() { return ( GetRect().GetWidth());}\
int a##::GetHeight(){ return ( GetRect().GetHeight());}

#define CXSETGEOMETRY(a)   \
void a##::SetGeometry(int t,int l,int b,int r){SetSize(l,t,r-l,b-t);}

#define CXONCHAR(a)  \
void a##::OnChar(wxKeyEvent &event){ \
if(event.KeyCode()==9){ptr_to_crObject->NextFocus(event.m_shiftDown);return;}  \
else {ptr_to_crObject->FocusToInput((char)event.KeyCode());}}

#endif



#ifdef __BOTHWX__
#define FORCALL(a) a##_
#endif
#ifdef __CR_WIN__
#define FORCALL(a) a
#endif

#endif
