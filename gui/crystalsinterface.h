////////////////////////////////////////////////////////////////////////
//   Filename:  CrystalsInterface.h
//   Authors:   Richard Cooper and Ludwig Macko
//   Created:   27.2.1998 14:11 Uhr
// $Log: not supported by cvs2svn $
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
#define __WXGTK__
#endif
#ifdef __CR_WIN__
#define __BOTHWIN__ 1
#endif
#ifdef __WINMSW__
#define __BOTHWX__ 1
#define __BOTHWIN__ 1
#define __WXMSW__ 1
#define __WIN95__
#define __WIN32__
#define STRICT
#define __WINDOWS__
#endif

//#include    "ccstring.h"
//void errorlog( CcString outStr );
// Instructions

enum {
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
    kToolBarBase        =   59000,
    kToolButtonBase     =     60000,
    kMenuBase           =     65000,
    kResizeBarBase      =   70000,
    kStretchBase      =   71000
};
#define kNoAlignment        0
#define kExpand             1
#define kRightAlign         2
#define kBottomAlign        4
#define kModal              1
#define kZoom               2
#define kClose              4
#define kSize               8
#define EMPTY_CELL          10
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define min(a, b)  (((a) < (b)) ? (a) : (b))
#define NOTUSED(a) //Compares a to itself, optimiser will remove this.(?)

#ifdef __POWERPC__
typedef void AppContext;
#endif

#ifdef __MOTO__
#include <Types.h>
typedef void AppContext;
#endif

#ifdef __BOTHWX__
typedef bool Boolean;
#define nil 0
//#define TRUE true
//#define FALSE false
typedef unsigned int UINT;
#include <wx/file.h>
#include <wx/memory.h>
#include <stdio.h>
#include <iostream.h>
#include <iomanip.h>
//#define TRACE WXTRACE
#endif

#ifdef __CR_WIN__
#include "stdafx.h"
#include "crystals.h"
typedef bool Boolean;
#define nil NULL
#define WM_STUFFTOPROCESS 6351
#endif

#ifdef _DEBUG
  #ifdef __CR_WIN__
    #include <afxwin.h> //Needed for TRACE debugger macro.
    #define new DEBUG_NEW //Needed for debugger to track heap allocations.
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
  if ( ptr_to_cxObject )                             \
  return CcRect(0,0,(int)(m_InitHeight=((##b*)ptr_to_cxObject)->GetIdealHeight()),  \
                          m_InitWidth =((##b*)ptr_to_cxObject)->GetIdealWidth());   \
  return CcRect(0,0,0,0); \
};


#define CRGETGEOMETRY(a,b)                         \
CcRect a##::GetGeometry()                          \
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
if(event.KeyCode()==9){ptr_to_crObject->NextFocus(event.m_shiftDown);return;}\
else {ptr_to_crObject->FocusToInput((char)event.KeyCode());}}


#endif



#ifdef __LINUX__
#define FORCALL(a) a##_
#endif
#ifdef __BOTHWIN__
#define FORCALL(a) a
#endif


#endif
