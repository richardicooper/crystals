////////////////////////////////////////////////////////////////////////
// CRYSTALS Interface      Class CxModel
////////////////////////////////////////////////////////////////////////

#include    "crystalsinterface.h"
#include    <math.h>
#include    <string>
#include    <sstream>
#include    "cxgrid.h"
#include    "cxwindow.h"
#include    "ccrect.h"
#include    "cxmodel.h"
#include    "crmodel.h"
#include    "ccmodelatom.h"
#include    "creditbox.h"
#include    "cccontroller.h"
#include    "resource.h"
#include    <GL/glu.h>
#if defined(__WXGTK__) || defined(__WXMAC__)
#include "idb_splash.xpm"
#endif

#ifndef PFD_SUPPORT_COMPOSITION
#define PFD_SUPPORT_COMPOSITION 0x00008000
#endif


#ifdef __BOTHWX__
BEGIN_EVENT_TABLE( mywxStaticText, wxStaticText)
     EVT_LEFT_UP( mywxStaticText::OnLButtonUp )
     EVT_LEFT_DOWN( mywxStaticText::OnLButtonDown )
     EVT_RIGHT_UP( mywxStaticText::OnRButtonUp )
END_EVENT_TABLE()

mywxStaticText::mywxStaticText(wxWindow* w, int i, wxString s, wxPoint p, wxSize ss, int f):
                  wxStaticText(w,i,s,p,ss,f)
{
    m_parent = w; 
}
void mywxStaticText::OnLButtonUp( wxMouseEvent & event ) { event.m_x += GetRect().x; event.m_y += GetRect().y; m_parent->GetEventHandler()->ProcessEvent(event); }
void mywxStaticText::OnLButtonDown( wxMouseEvent & event){ event.m_x += GetRect().x; event.m_y += GetRect().y; m_parent->GetEventHandler()->ProcessEvent(event); }
void mywxStaticText::OnRButtonUp( wxMouseEvent & event ) { event.m_x += GetRect().x; event.m_y += GetRect().y; m_parent->GetEventHandler()->ProcessEvent(event); }
#endif





int CxModel::mModelCount = kModelBase;
HDC CxModel::last_hdc = NULL;

CxModel * CxModel::CreateCxModel( CrModel * container, CxGrid * guiParent )
{

#ifdef __CR_WIN__

  CxModel *theModel = new CxModel(container);
  const char* wndClass = AfxRegisterWndClass( CS_HREDRAW|CS_VREDRAW,NULL,(HBRUSH)(COLOR_MENU+1),NULL);

  if ( theModel -> Create(wndClass,"Model",WS_CHILD|WS_VISIBLE|WS_CLIPCHILDREN|WS_CLIPSIBLINGS,CRect(0,0,26,28),guiParent,mModelCount++) == 0 )
  {
    ::MessageBox (  NULL, "Create modelwindow failed", "Error", MB_OK) ;
    delete theModel;
    return nil;
  }

//  theModel -> ModifyStyleEx(NULL,WS_EX_CLIENTEDGE,0);
  theModel -> SetFont(CcController::mp_font);

  CRect rect;
//  CClientDC dc(theModel);

  theModel->m_hdc = ::GetDC(theModel->GetSafeHwnd());

  if( ( theModel->SetWindowPixelFormat() ) == false )
  {
    delete theModel;
    return nil;
  }
  if ( ( theModel->CreateViewGLContext() ) == false )
  {
    delete theModel;
    return nil;
  }


  theModel->Setup();

#endif
#ifdef __BOTHWX__

  CxModel *theModel = new CxModel((wxWindow*)guiParent,-1, wxPoint(0,0), wxSize(10,10), wxSUNKEN_BORDER);
  theModel->ptr_to_crObject = container;
  theModel->Setup();

#endif

  return theModel;
}

#ifdef __BOTHWX__

CxModel::CxModel(wxWindow *parent, wxWindowID id, const wxPoint& pos, const wxSize& size,
                 long style, const wxString& name): wxGLCanvas(parent, id, pos, size, style, name)
{

    m_DoNotPaint = false;
    m_NotSetupYet = true;
    m_MouseCaught = false;

#endif
#ifdef __CR_WIN__

CxModel::CxModel(CrModel* container)
      :BASEMODEL()
{
  ptr_to_crObject = container;
  m_hGLContext = NULL;
  m_hPalette = 0;
  m_bitmapbits = NULL;
  m_bitmapinfo = NULL;
#endif
  m_bMouseLeaveInitialised = false;
  m_bitmapok = false;
  m_bNeedReScale = true;
  m_bModelChanged = true;
  m_bFullListOk = false;
  m_bOkToDraw = false;
  m_fastrotate = false;
  m_LitObject = nil;
  m_xTrans = 0.0f ;
  m_yTrans = 0.0f ;
  m_zTrans = 0.0f ;
  m_stretchX = 1.0f ;
  m_stretchY = 1.0f ;
  m_fbsize = 2048;
  m_sbsize = 256;

  m_movingPoint.Set(-1,-1);

  mat = new float[16];

  mat[0] = mat[5] = mat[10] = mat[15] = 1.0f;

           mat[1] = mat[2] = mat[3] = 0.0f;
  mat[4] =          mat[6] = mat[7] = 0.0f;
  mat[8] = mat[9] =          mat[11]= 0.0f;
  mat[12]= mat[13]= mat[14]=          0.0f;

  m_xScale = 1.0f ;

  m_DrawStyle = MODELSMOOTH;
  m_Autosize  = true;
  m_Hover     = false;
  m_Shading   = true;
  m_TextPopup = nil;
  m_selectRect.Set(0,0,0,0);
  m_mouseMode = CXROTATE;

}


CxModel::~CxModel()
{
  mModelCount--;
  delete [] mat;
  DeletePopup();

#ifdef __CR_WIN__
  wglMakeCurrent(NULL,NULL);
  CxModel::last_hdc = NULL;
  wglDeleteContext(m_hGLContext);
  ::ReleaseDC(GetSafeHwnd(), m_hdc);
  if ( m_hPalette ) DeleteObject(m_hPalette);
#endif
}

void CxModel::CxDestroyWindow()
{
#ifdef __CR_WIN__
  DestroyWindow();
#endif
#ifdef __BOTHWX__
  Destroy();
#endif
}

#ifdef __CR_WIN__
BEGIN_MESSAGE_MAP(CxModel, CWnd)
   ON_WM_CHAR()
   ON_WM_PAINT()
   ON_WM_LBUTTONUP()
   ON_WM_LBUTTONDOWN()
   ON_WM_RBUTTONUP()
   ON_WM_MOUSEMOVE()
   ON_WM_ERASEBKGND()
   ON_COMMAND_RANGE(kMenuBase, kMenuBase+1000, OnMenuSelected)
   ON_MESSAGE(WM_MOUSELEAVE,   OnMouseLeave)
END_MESSAGE_MAP()
#endif

#ifdef __BOTHWX__

BEGIN_EVENT_TABLE(CxModel, wxGLCanvas)
     EVT_CHAR( CxModel::OnChar )
     EVT_PAINT( CxModel::OnPaint )
     EVT_LEFT_UP( CxModel::OnLButtonUp )
     EVT_LEFT_DOWN( CxModel::OnLButtonDown )
     EVT_RIGHT_UP( CxModel::OnRButtonUp )
     EVT_MOTION( CxModel::OnMouseMove )
     EVT_COMMAND_RANGE(kMenuBase, kMenuBase+1000, wxEVT_COMMAND_MENU_SELECTED, CxModel::OnMenuSelected )
     EVT_ERASE_BACKGROUND ( CxModel::OnEraseBackground )
END_EVENT_TABLE()

#endif


void CxModel::Focus()
{
    SetFocus();
}

CXONCHAR(CxModel)

#ifdef __CR_WIN__

void CxModel::OnPaint()
{
    CPaintDC dc(this); // device context for painting

    setCurrentGL();
#endif

#ifdef __BOTHWX__

void CxModel::OnPaint(wxPaintEvent &event)
{
//    wxPaintDC dc (this);
//    dc.SetUserScale( 1.0,1.0 );

    if ( m_NotSetupYet ) Setup();

    if ( m_NotSetupYet ) return;

    SetCurrent();
    if ( m_DoNotPaint )
    {
//      TEXTOUT ( string((int)this) + " OnPaint: Not painting" );
      m_DoNotPaint = false;
      return;
    }
#endif

//    TEXTOUT ( string((int)this) + " OnPaint" );
    bool ok_to_draw = true;

#ifndef __WXMAC__
    if (m_bModelChanged)
    {
// re-render the full detail model.
//      TEXTOUT ( "Redrawing model from scratch" );
      ok_to_draw = ((CrModel*)ptr_to_crObject)->RenderModel();
    }
#else
    ok_to_draw = true;
#endif

    if ( ok_to_draw )
    {
        m_bFullListOk = true;
        m_bModelChanged = false;
//      TEXTOUT ( string((int)this) + " Displaying model" );
      if ( m_Autosize && m_bNeedReScale )
      {
        AutoScale();
        m_bNeedReScale = false;
      }

      glRenderMode ( GL_RENDER ); //Switching to render mode.

      glViewport(0,0,GetWidth(),GetHeight());

#ifdef __CR_WIN__
      int col = GetSysColor(COLOR_3DFACE);
      glClearColor( GetRValue(col)/255.0f,
                    GetGValue(col)/255.0f,
                    GetBValue(col)/255.0f,  0.0f);
#endif
#ifdef __BOTHWX__
      wxColour col = wxSystemSettings::GetSystemColour( wxSYS_COLOUR_3DFACE );
      glClearColor( col.Red()/255.0f,
                    col.Green()/255.0f,
                    col.Blue()/255.0f,  0.0f);
#endif

//      glClearColor( 1.0f,1.0f,1.0f,0.0f);
      glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
      glMatrixMode ( GL_PROJECTION );
      glLoadIdentity();
      CameraSetup();

      GLDrawStyle();

      ModelSetup();
      ModelBackground();

#ifndef __WXMAC__
      glCallList( ATOMLIST );
      glCallList( BONDLIST );
      glCallList( XOBJECTLIST );
#else
      ok_to_draw = ((CrModel*)ptr_to_crObject)->RenderModel();
#endif

      glMatrixMode ( GL_PROJECTION );
      glPopMatrix();
      glMatrixMode ( GL_MODELVIEW );

// next lines suggested by Oleg, Jum 28-08
#ifdef __WIN32__
      GdiFlush();
#endif
//This is only needed while we draw directly onto the GDI
      glFinish();
// if we changed to GLUT fonts instead, we could just call glFlush(), 
// which doesn't block.

#ifdef __CR_WIN__
      SwapBuffers(m_hdc);
#endif
#ifdef __BOTHWX__
      SwapBuffers();
#endif

/*
      if ( ! m_selectionPoints.empty() )
      {
//Draw in polygon so far:
         list<CcPoint>::iterator ccpi = m_selectionPoints.begin();
#ifdef __CR_WIN__
         dc.SetROP2( R2_COPYPEN );
         dc.MoveTo((*ccpi).x, (*ccpi).y);
#endif         
#ifdef __BOTHWX__
          dc.SetLogicalFunction( wxCOPY );
          list<CcPoint>::iterator ccpi2 = ccpi;
#endif

         ccpi++;
         while ( ccpi != m_selectionPoints.end() )
         {
#ifdef __BOTHWX__
            dc.DrawLine((*ccpi2).x,(*ccpi2).y,(*ccpi).x,(*ccpi).y);
            ccpi2 = ccpi;
#endif
#ifdef __CR_WIN__
            dc.LineTo((*ccpi).x,(*ccpi).y);
#endif
            ccpi++;
         }
      }
      */
    }
    else
    {
//      TEXTOUT ( "No model. Displaying banner instead" );
//      PaintBannerInstead ( &dc );
      glRenderMode ( GL_RENDER ); //Switching to render mode.
      glViewport(0,0,GetWidth(),GetHeight());
#ifdef __CR_WIN__
      int col = GetSysColor(COLOR_3DFACE);
      glClearColor( GetRValue(col)/255.0f,
                    GetGValue(col)/255.0f,
                    GetBValue(col)/255.0f,  0.0f);
#endif
#ifdef __BOTHWX__
      wxColour col = wxSystemSettings::GetSystemColour( wxSYS_COLOUR_3DFACE );
      glClearColor( col.Red()/255.0f,
                    col.Green()/255.0f,
                    col.Blue()/255.0f,  0.0f);
#endif
      glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
      glMatrixMode ( GL_PROJECTION );
      glLoadIdentity();
      ModelBackground();
      glMatrixMode ( GL_PROJECTION );
      glPopMatrix();
      glMatrixMode ( GL_MODELVIEW );

#ifdef __CR_WIN__
      SwapBuffers(m_hdc);
#endif
#ifdef __BOTHWX__
      SwapBuffers();
#endif


    }

}


void CxModel::GLDrawStyle()
{
    if ( m_DrawStyle == MODELSMOOTH )
    {
          glPolygonMode(GL_FRONT, GL_FILL);
          glPolygonMode(GL_BACK, GL_FILL);
    }
    if ( m_DrawStyle == MODELLINE )
    {
          glPolygonMode(GL_FRONT, GL_LINE);
          glPolygonMode(GL_BACK, GL_LINE);
    }
    if ( m_DrawStyle == MODELPOINT )
    {
          glPolygonMode(GL_FRONT, GL_POINT);
          glPolygonMode(GL_BACK, GL_POINT);
    }

    glEnable(GL_DEPTH_TEST);
}


#ifdef __CR_WIN__

void CxModel::OnLButtonUp( UINT nFlags, CPoint wpoint )
{

#endif
#ifdef __BOTHWX__

void CxModel::OnLButtonUp( wxMouseEvent & event )
{

#endif

  switch ( m_mouseMode )
  {
    case CXROTATE:
    {
#ifdef __CR_WIN__
      ReleaseCapture();
#endif
#ifdef __BOTHWX__
      if ( m_MouseCaught ){ ReleaseMouse(); m_MouseCaught = false; }
#endif
      if(m_fastrotate)
      {
        m_fastrotate = false;
        NeedRedraw();
      }
      break;
    }
    case CXRECTSEL:
    {
#ifdef __CR_WIN__
      ReleaseCapture();
#endif
#ifdef __BOTHWX__
      if ( m_MouseCaught ) { ReleaseMouse(); m_MouseCaught = false; }
#endif
      SelectBoxedAtoms(m_selectRect, true);
      ModelChanged(false);
      break;
    }
    case CXPOLYSEL:
    {
//Do nothing
      break;
    }
    case CXZOOM:
    {
      m_mouseMode = CXROTATE;
#ifdef __CR_WIN__
      ReleaseCapture();
#endif
#ifdef __BOTHWX__
      if ( m_MouseCaught ) { ReleaseMouse(); m_MouseCaught = false; }
#endif
      NeedRedraw();
      break;
    }
  }

}

#ifdef __CR_WIN__

void CxModel::OnLButtonDown( UINT nFlags, CPoint wpoint )
{
  CcPoint point(wpoint.x,wpoint.y);

#endif

#if defined(__WXGTK__) || defined(__WXMAC__)

#define MK_CONTROL 1
#define MK_SHIFT 2

#endif

#ifdef __BOTHWX__

void CxModel::OnLButtonDown( wxMouseEvent & event )
{
  CcPoint point ( event.m_x, event.m_y );
  int nFlags = event.m_controlDown ? MK_CONTROL : 0 ;
  nFlags = event.m_shiftDown ? MK_SHIFT : 0 ;

#endif

  if ( nFlags & MK_CONTROL )
  {
    m_mouseMode = CXZOOM; //switch into zoom mode.
    SetAutoSize(false);
    ChooseCursor (CURSORZOOMIN);
  }

  switch ( m_mouseMode )
  {
    case CXROTATE:
    {
#ifdef __CR_WIN__
      SetCapture();
#endif
#ifdef __BOTHWX__
      if ( !m_MouseCaught ) { CaptureMouse(); m_MouseCaught = true; }
#endif
      string atomname;
      CcModelObject* object;
      int type = 0;
      if( type = IsAtomClicked(point.x, point.y, &atomname, &object, false))
      {
//        LOGERR( string(point.x) + ", " + string(point.y) + " " + atomname);
        if ( type == CC_ATOM )
         ((CcModelAtom*)object)->SendAtom( ((CrModel*)ptr_to_crObject)->GetSelectionAction() );
        else if ( type == CC_SPHERE )
         ((CcModelSphere*)object)->SendAtom( ((CrModel*)ptr_to_crObject)->GetSelectionAction() );
        else if ( type == CC_DONUT )
         ((CcModelDonut*)object)->SendAtom( ((CrModel*)ptr_to_crObject)->GetSelectionAction() );
        else if ( type == CC_BOND )
         ((CcModelBond*)object)->SendAtom( ((CrModel*)ptr_to_crObject)->GetSelectionAction() );
      }
      m_ptLDown = point;  //maybe start rotating from here.
      break;
    }
    case CXRECTSEL:
    {
#ifdef __CR_WIN__
      SetCapture();
#endif
#ifdef __BOTHWX__
      if ( !m_MouseCaught ) { CaptureMouse(); m_MouseCaught = true; }
#endif
      m_selectRect.Set(point.y,point.x,point.y,point.x); //start dragging box from here.
      break;
    }
    case CXPOLYSEL:
    {
      m_movingPoint.Set(point.x,point.y);

      if ( !m_selectionPoints.empty() )
      {

        if ( (  ( abs ( m_selectionPoints.front().x - point.x ) < 4  )  &&
                ( abs ( m_selectionPoints.front().y - point.y ) < 4  ) ) ||
             (  ( m_selectionPoints.back().x   == point.x )  &&
                ( m_selectionPoints.back().y   == point.y )     )     )
        {
// Click within 4 pixels of first point to close, or
// Click same point twice to auto-close.

          m_selectionPoints.push_back(m_selectionPoints.front()); // close loop
          CxModel::PolyCheck();   //Do selection
          ModelChanged(false);
          m_selectionPoints.clear();   // Empty container
        }
        else
        {

//Add point to list of selected points.
          m_selectionPoints.push_back(point);


#ifdef __CR_WIN__
//Erase previous line
          CClientDC dc(this);
          dc.SetROP2( R2_NOTXORPEN );
          dc.MoveTo(m_selectionPoints.back().x,m_selectionPoints.back().y);
          dc.LineTo(m_movingPoint.x,m_movingPoint.y);
#endif
#ifdef __BOTHWX__
          wxClientDC dc(this);
          dc.SetLogicalFunction( wxINVERT );
          dc.DrawLine(m_selectionPoints.back().x,m_selectionPoints.back().y,m_movingPoint.x,m_movingPoint.y);
#endif

//Draw in polygon so far:
          list<CcPoint>::iterator ccpi = m_selectionPoints.begin();

#ifdef __CR_WIN__
          dc.SetROP2( R2_COPYPEN );
          dc.MoveTo((*ccpi).x, (*ccpi).y);
#endif         
#ifdef __BOTHWX__
          dc.SetLogicalFunction( wxCOPY );
          list<CcPoint>::iterator ccpi2 = ccpi;
#endif
          ccpi++;
          while ( ccpi != m_selectionPoints.end() )
          {
#ifdef __BOTHWX__
            dc.DrawLine((*ccpi2).x,(*ccpi2).y,(*ccpi).x,(*ccpi).y);
            ccpi2 = ccpi;
#endif
#ifdef __CR_WIN__
            dc.LineTo((*ccpi).x,(*ccpi).y);
#endif
            ccpi++;
          }
        }
      }
      else
      {
//First point: Add point to list of selected points.
        m_selectionPoints.push_back(point);
      }


      break;
    }
    case CXZOOM:
    {
#ifdef __CR_WIN__
      SetCapture();
#endif
#ifdef __BOTHWX__
      if ( !m_MouseCaught ) { CaptureMouse(); m_MouseCaught = true; }
#endif
      m_ptLDown = point;  //zoom from here.
      break;
    }
  }

/*
      if ( nFlags & MK_CONTROL )    //Zoom out
      {
         if ( m_xScale > 1.0 )
         {
            int winx = GetWidth();
            int winy = GetHeight();
            m_xScale /= 1.2f;
            NewSize(winx,winy);
//            m_Autosize = false;
            NeedRedraw();
         }
      }
      else if ( nFlags & MK_SHIFT  )  //Zoom in
      {
      }
      else
      {

*/

}


#ifdef __CR_WIN__
LRESULT CxModel::OnMouseLeave(WPARAM wParam, LPARAM lParam)
{
    DeletePopup();
    m_bMouseLeaveInitialised = false;
        return TRUE;
}

void CxModel::OnMouseMove( UINT nFlags, CPoint wpoint )
{
  bool leftDown = ( (nFlags & MK_LBUTTON) != 0 );
  bool ctrlDown = ( (nFlags & MK_CONTROL) != 0 );
  CcPoint point(wpoint.x,wpoint.y);

#endif

#ifdef __BOTHWX__

void CxModel::OnMouseMove( wxMouseEvent & event )
{
  CcPoint point ( event.m_x, event.m_y );
  int nFlags = event.m_controlDown ? MK_CONTROL : 0 ;
  nFlags = event.m_shiftDown ? MK_SHIFT : 0 ;
  bool leftDown = event.m_leftDown;
  bool ctrlDown = event.m_controlDown;
#endif

#ifdef __CR_WIN__
    // now some stuff to find out when the mouse leaves the window (causes a WM_MOUSE_LEAVE message (?))
  if(!m_bMouseLeaveInitialised)
  {
    TRACKMOUSEEVENT tme;
    tme.cbSize = sizeof(tme);
    tme.hwndTrack = m_hWnd;
    tme.dwFlags = TME_LEAVE;
    _TrackMouseEvent(&tme);
    m_bMouseLeaveInitialised = true;
  }
#endif

  switch ( m_mouseMode )
  {
    case CXROTATE:
    {
      if ( leftDown )
      {
        if(m_fastrotate) // already rotating.
        {
          DeletePopup();
          ChooseCursor(CURSORNORMAL);
          if ( m_ptLDown.x - point.x )             // if non-zero
          {
            float rot = (float)(m_ptLDown.x - point.x ) * 0.5f * 3.14f / 180.0f;
            float * cMat = new float[16];
            for ( int i=0; i < 16; i++) cMat[i]=mat[i];
            float cosr = (float)cos(rot);
            float sinr = (float)sin(rot);
            mat[0] = cosr * cMat[0] - sinr * cMat[2]  ;
            mat[4] = cosr * cMat[4] - sinr * cMat[6]  ;
            mat[8] = cosr * cMat[8] - sinr * cMat[10] ;
            mat[2] = sinr * cMat[0] + cosr * cMat[2]  ;
            mat[6] = sinr * cMat[4] + cosr * cMat[6]  ;
            mat[10]= sinr * cMat[8] + cosr * cMat[10] ;
            delete [] cMat;
          }
          if ( m_ptLDown.y - point.y )
          {
            float rot = (float)(m_ptLDown.y - point.y ) * 0.5f * 3.14f / 180.0f;
            float * cMat = new float[16];
            for ( int i=0; i < 16; i++) cMat[i]=mat[i];
            float cosr = (float)cos(rot);
            float sinr = (float)sin(rot);
            mat[1] =  cosr * cMat[1] + sinr * cMat[2] ;
            mat[5] =  cosr * cMat[5] + sinr * cMat[6] ;
            mat[9] =  cosr * cMat[9] + sinr * cMat[10];
            mat[2] = -sinr * cMat[1] + cosr * cMat[2] ;
            mat[6] = -sinr * cMat[5] + cosr * cMat[6] ;
            mat[10]= -sinr * cMat[9] + cosr * cMat[10];
            delete [] cMat;
          }
          if ( ( m_ptLDown.x - point.x ) || ( m_ptLDown.y - point.y ) )
          {
            m_ptLDown = point;
            NeedRedraw(true);
          }
        }
        else   //LBUTTONDOWN, but not rotating yet.
        {
// Start rotating if the mouse moves after the l button goes down.
            if ( point != m_ptLDown ) m_fastrotate = true;
        }
      }
      else    //Lbutton not down, just mouse moving around.
      {
//        ChooseCursor(CURSORNORMAL);
        if( m_fastrotate ) //Was rotating, but now LBUTTON is up. Redraw. (MISSED LBUTTONUP message)
        {
          m_fastrotate = false;
          NeedRedraw(true);
        }
// This bit involves checking the atom list. We should avoid calling
// it if the mouse really hasn't moved. (I think OnMouseMove is called
// repeatedly when the ProgressBar is updated, for example.)
        if ( ( m_ptMMove.x - point.x ) || ( m_ptMMove.y - point.y ) )
        {
          string labelstring;
          ostringstream labelstrm;
          CcModelObject* object;
          int objectType = IsAtomClicked(point.x, point.y, &labelstring, &object);
          if(objectType)
          {
            if(m_LitObject != object) //avoid excesive redrawing, it flickers.
            {
              m_LitObject = object;
              if ( objectType == CC_ATOM && labelstring.length() && ( labelstring[0] == 'Q' ) )
              {
                labelstrm << " " << (float)((CcModelAtom*)object)->sparerad/1000.0;
              }
              if ( objectType == CC_ATOM )
              {
                if ( ((CcModelAtom*)object)->occ != 1000 )
                   labelstrm << " occ:" << (float)((CcModelAtom*)object)->occ/1000.0;
              }
              else if ( objectType == CC_SPHERE )
              {
                labelstrm << " shell occ:" << (float)((CcModelSphere*)object)->occ/1000.0;
              }
              else if ( objectType == CC_DONUT )
              {
                labelstrm << " annulus occ:" << (float)((CcModelDonut*)object)->occ/1000.0;
              }


              CreatePopup(labelstring + string(labelstrm.str()), point);
              if ( objectType != CC_BOND )
                 ChooseCursor(CURSORCOPY);
              else
                 ChooseCursor(CURSORNORMAL);

              (CcController::theController)->SetProgressText(labelstring);
              if ( m_Hover ) NeedRedraw();
            }
          }
          else if (m_LitObject) //Not over an atom anymore.
          {
            m_LitObject = nil;
            (CcController::theController)->SetProgressText("");
            ChooseCursor(CURSORNORMAL);
            DeletePopup();
            if ( m_Hover ) NeedRedraw();
          }
          else
          {
            DeletePopup();
            ChooseCursor(CURSORNORMAL);
          }
        }
      }
      break;
    }
    case CXRECTSEL:
    {
      ChooseCursor(CURSORCROSS);
      if (leftDown)
      {
#ifdef __CR_WIN__
        CClientDC dc(this);
        CcRect newRect = m_selectRect;
        newRect.mBottom = point.y;
        newRect.mRight  = point.x;
        dc.DrawDragRect(&newRect.Sort().Native(), CSize(1,1), &m_selectRect.Sort().Native(), CSize(1,1),NULL,NULL);
        m_selectRect = newRect;
#endif
#ifdef __BOTHWX__
        wxClientDC dc(this);
        CcRect newRect = m_selectRect;
        newRect.mBottom = point.y;
        newRect.mRight  = point.x;
        dc.SetLogicalFunction( wxINVERT );
        dc.DrawRectangle(newRect.mLeft, newRect.mTop, newRect.Width(), newRect.Height() );
        dc.DrawRectangle(m_selectRect.mLeft, m_selectRect.mTop, m_selectRect.Width(), m_selectRect.Height() );
        m_selectRect = newRect;
#endif
      }
      break;
    }
    case CXPOLYSEL:
    {
      if ( !m_selectionPoints.empty() && ( abs ( m_selectionPoints.front().x - point.x ) < 4  )  &&
            ( abs ( m_selectionPoints.front().y - point.y ) < 4  ) )
      {
          ChooseCursor(CURSORCROSS);
      }
      else
      {
          ChooseCursor(CURSORCOPY);
      }

      if ( !m_selectionPoints.empty() )
      {
//Erase previous line
#ifdef __CR_WIN__
        CClientDC dc(this);
        CPen pen(PS_SOLID,1,PALETTERGB(0,0,0)), *oldpen;  
        oldpen = dc.SelectObject(&pen);
        dc.SetROP2( R2_NOTXORPEN );
        dc.MoveTo(m_selectionPoints.back().x,m_selectionPoints.back().y);
        dc.LineTo(m_movingPoint.x,m_movingPoint.y);
#endif
#ifdef __BOTHWX__
        wxClientDC dc(this);
        dc.SetLogicalFunction( wxINVERT );
        dc.DrawLine(m_movingPoint.x,m_movingPoint.y,
                    m_selectionPoints.back().x,m_selectionPoints.back().y);
#endif
        m_movingPoint.Set(point.x,point.y);
//Draw new line
#ifdef __CR_WIN__
        dc.MoveTo(m_selectionPoints.back().x,m_selectionPoints.back().y);
        dc.LineTo(m_movingPoint.x,m_movingPoint.y);
        dc.SelectObject(oldpen);
        dc.SetROP2( R2_COPYPEN );
#endif
#ifdef __BOTHWX__
        dc.DrawLine(m_selectionPoints.back().x,m_selectionPoints.back().y,
                     m_movingPoint.x,m_movingPoint.y);
#endif
      }
      break;
    }
    case CXZOOM:
    {
      ChooseCursor(CURSORZOOMIN);
      int winx = GetWidth();
      int winy = GetHeight();
      float hDrag = (m_ptMMove.y - point.y)/(float)winy;
      m_xScale += hDrag;
      m_xScale = CRMAX(0.01f,m_xScale);
      m_xScale = CRMIN(100.0f,m_xScale);
//      m_xTrans = 8000.0f * ( (float)m_ptLDown.x / (float)winx ) - 4000.0f; // NB y axis is upside down for OpenGL.
//      m_yTrans = 8000.0f * ( (float)m_ptLDown.y / (float)winy ) - 4000.0f;

//      m_xTrans -= m_xTrans / m_xScale ;  //Head back towards the centre
//      m_yTrans -= m_yTrans / m_xScale ;

      NewSize(winx,winy);
//      m_Autosize = false;
      NeedRedraw();
      break;
    }
  }
  m_ptMMove = point;
}

#ifdef __CR_WIN__

void CxModel::OnRButtonUp( UINT nFlags, CPoint wpoint )
{
      CcPoint point(wpoint.x,wpoint.y);

#endif
#ifdef __BOTHWX__

void CxModel::OnRButtonUp( wxMouseEvent & event )
{
  CcPoint point ( event.m_x, event.m_y );

#endif


  if ( m_mouseMode == CXPOLYSEL )
  {
// Cancel polygon selection: Remove points, redraw model, reset mousemode.
     m_selectionPoints.clear();
     NeedRedraw();
     m_mouseMode = CXROTATE;
     return;
  }

  string atomname;

//Some pointers:
  CcModelObject* object;
  CcModelAtom* atom;
  CcModelBond* bond;
//  CrModel* crModel = (CrModel*)ptr_to_crObject;

//decide which menu to show
  int obtype;

  obtype = IsAtomClicked(point.x, point.y, &atomname, &object);

#ifdef __CR_WIN__
    ClientToScreen(&wpoint); // change the coordinates of the click from window to screen coords so that the menu appears in the right place
    point = CcPoint(wpoint.x,wpoint.y);
#endif

  if ( obtype == CC_ATOM || obtype == CC_SPHERE || obtype == CC_DONUT )
  {
    atom = (CcModelAtom*)object;
    if (atom->IsSelected()) // If it's selected pass the atom-clicked, and all the selected atoms.
    {
      ((CrModel*)ptr_to_crObject)->ContextMenu(point.x,point.y, atomname, 2);
    }
    else //the atom is not selected show a menu applicable to a single atom.
    {
      ((CrModel*)ptr_to_crObject)->ContextMenu(point.x,point.y, atomname, 3);
    }
  }
  else if ( obtype == CC_BOND )
  {
    bond = (CcModelBond*)object;
    if (bond->m_bondtype == 101) //Aromatic ring:
    {
       atomname = "";
       for (int i = 0; i < bond->m_np; i++ ) {
         atomname += bond->m_patms[i]->Label() + " ";
       }
      ((CrModel*)ptr_to_crObject)->ContextMenu(point.x,point.y,atomname,6);
    }
    else if (bond->m_bsym) //the bond crosses a symmetry element:
    {
      atomname = bond->m_patms[0]->Label() + " " + bond->m_slabel;
      string atom2 = bond->m_slabel;
      ((CrModel*)ptr_to_crObject)->ContextMenu(point.x,point.y, atomname, 5, atom2);
    }
    else //a normal bond:
    {
      atomname = bond->m_patms[0]->Label() + " " + bond->m_patms[1]->Label();
      ((CrModel*)ptr_to_crObject)->ContextMenu(point.x,point.y, atomname, 4);
    }
  }
  else
  {
    ((CrModel*)ptr_to_crObject)->ContextMenu(point.x,point.y,"",1);
  }
}


void CxModel::Setup()
{

   setCurrentGL();

#ifdef __BOTHWX__

   if( !GetContext() ) return;
   m_NotSetupYet = false;

#endif
   glEnable(GL_NORMALIZE);

   glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
   glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
   glHint(GL_POINT_SMOOTH_HINT, GL_NICEST);
   glHint(GL_POLYGON_SMOOTH_HINT, GL_NICEST);

   GLfloat matDiffuse[] = { 0.8f, 0.8f, 0.8f, 1.0f };
   GLfloat matSpecular[] ={ 0.8f, 0.8f, 0.8f, 1.0f };
   GLfloat matShine[] = { 70.0f };
   glMaterialfv(GL_FRONT, GL_DIFFUSE, matDiffuse);
   glMaterialfv(GL_FRONT, GL_SPECULAR, matSpecular);
   glMaterialfv(GL_FRONT, GL_SHININESS, matShine);

   GLfloat lightDiffuse[] = { 1.0f, 1.0f, 1.0f, 1.0f };
   GLfloat lightAmbient[] ={ 0.0f, 0.0f, 0.0f, 1.0f };
   GLfloat lightPos[] = { 5000.0f, 5000.0f, 20000.0f, 1.0f };
   glLightfv(GL_LIGHT0, GL_DIFFUSE, lightDiffuse);
   glLightfv(GL_LIGHT0, GL_AMBIENT, lightAmbient);
   glLightfv(GL_LIGHT0, GL_POSITION, lightPos);

   glColorMaterial ( GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE ) ;
   glEnable ( GL_COLOR_MATERIAL ) ;
   glEnable(GL_LIGHT0);
   glEnable(GL_LIGHTING);


// This is for the PaintBannerInstead() function.
#ifdef __BOTHWX__
        wxBitmap newbit(wxBITMAP(IDB_SPLASH));
        m_bitmap = newbit;
        m_bitmapok = m_bitmap.Ok();
#endif

#ifdef __CR_WIN__

/*        m_bitmapok = true;

        LPCTSTR lpszResourceName = (LPCTSTR)IDB_SPLASH;
        HBITMAP hBmp = (HBITMAP)::LoadImage( AfxGetInstanceHandle(),
                 lpszResourceName, IMAGE_BITMAP, 0,0, LR_CREATEDIBSECTION );

        if( hBmp == NULL )
        {
                m_bitmapok = false;
                return;
        }
        m_bitmap.Attach( hBmp );

        // Create a logical palette for the bitmap
        DIBSECTION ds;
        BITMAPINFOHEADER &bmInfo = ds.dsBmih;
        m_bitmap.GetObject( sizeof(ds), &ds );

        int nColors = bmInfo.biClrUsed ? bmInfo.biClrUsed : 1 << bmInfo.biBitCount;

        // Create a halftone palette if colors > 256.
        CClientDC dc(NULL);                     // Desktop DC
        if( nColors > 256 ) m_pal.CreateHalftonePalette( &dc );
        else
        {
                // Create the palette

                RGBQUAD *pRGB = new RGBQUAD[nColors];
                CDC memDC;
                memDC.CreateCompatibleDC(&dc);

                memDC.SelectObject( &m_bitmap );
                ::GetDIBColorTable( memDC, 0, nColors, pRGB );

                UINT nSize = sizeof(LOGPALETTE) + (sizeof(PALETTEENTRY) * nColors);
                LOGPALETTE *pLP = (LOGPALETTE *) new BYTE[nSize];

                pLP->palVersion = 0x300;
                pLP->palNumEntries = nColors;

                for( int i=0; i < nColors; i++)
                {
                        pLP->palPalEntry[i].peRed = pRGB[i].rgbRed;
                        pLP->palPalEntry[i].peGreen = pRGB[i].rgbGreen;
                        pLP->palPalEntry[i].peBlue = pRGB[i].rgbBlue;
                        pLP->palPalEntry[i].peFlags = 0;
                }

                m_pal.CreatePalette( pLP );

                delete[] pLP;
                delete[] pRGB;
        }
  */
#endif

//        m_bitmapinfo = NULL;
//        LoadDIBitmap("test.bmp");


}


void CxModel::NewSize(int cx, int cy)
{
    setCurrentGL();
    m_stretchX = 1.0f;
    m_stretchY = 1.0f;

    glViewport(0,0,cx,cy);

    if ( cy > cx ) m_stretchY = (float)cy / (float)cx;
    else           m_stretchX = (float)cx / (float)cy;


}

void CxModel::CameraSetup()
{
  int ic = 5000;
  glOrtho(-ic * m_stretchX ,ic * m_stretchX ,
          -ic * m_stretchY ,ic * m_stretchY ,
          -ic * m_xScale   ,ic * m_xScale );
}


void CxModel::ModelSetup()
{
   glMatrixMode ( GL_MODELVIEW );
   glLoadIdentity();
   glTranslated ( m_xTrans, m_yTrans, m_zTrans );
   glMultMatrixf ( mat );
   glScalef     ( m_xScale, m_xScale, m_xScale );
}


bool CxModel::setCurrentGL() {
#ifdef __CR_WIN__
      if ( m_hdc == NULL ) return false;
      if ( CxModel::last_hdc == m_hdc ) return true;
      CxModel::last_hdc = m_hdc;
      return wglMakeCurrent(m_hdc, m_hGLContext);
#endif
#ifdef __BOTHWX__
      SetCurrent();
      return true;
#endif
}

void CxModel::ModelBackground()
{
#ifdef __CR_WIN__
   int ic = 5000;
   if (m_bitmapinfo)
   {
     float xscale  = (float)GetWidth() / m_bitmapinfo->bmiHeader.biWidth;
     float yscale  = (float)GetHeight() / m_bitmapinfo->bmiHeader.biHeight;
     glRasterPos3f(-ic * m_stretchX, -ic*m_stretchY, ( -ic + 10 ) * m_xScale);
     glPixelZoom(xscale, yscale);
     glDrawPixels(m_bitmapinfo->bmiHeader.biWidth,
                  m_bitmapinfo->bmiHeader.biHeight,
                  GL_BGR_EXT, GL_UNSIGNED_BYTE, m_bitmapbits);
   }
#endif
}

#ifdef __CR_WIN__
BOOL CxModel::SetWindowPixelFormat()
{
    PIXELFORMATDESCRIPTOR pixelDesc;
    int n, GLPixelIndex;
    LOGPALETTE* lpPal;


    memset(&pixelDesc, 0, sizeof(pixelDesc));

    pixelDesc.nSize = sizeof(PIXELFORMATDESCRIPTOR);
    pixelDesc.nVersion = 1;

    pixelDesc.dwFlags = PFD_DRAW_TO_WINDOW |
                        PFD_SUPPORT_OPENGL |
                        PFD_STEREO_DONTCARE|
                        PFD_DOUBLEBUFFER|
			PFD_SUPPORT_COMPOSITION;

    pixelDesc.iPixelType = PFD_TYPE_RGBA;
    pixelDesc.cColorBits = 32;
    pixelDesc.cDepthBits = 32;
    pixelDesc.iLayerType = PFD_MAIN_PLANE;

    GLPixelIndex = ChoosePixelFormat (m_hdc, &pixelDesc);

    if (GLPixelIndex == 0 )
    {
      CHAR sz[80];
      DWORD dw = GetLastError();
      sprintf (sz, "ChoosePixelFormat failed: Get LastError returned %u\n", dw);
      MessageBox ( sz, "ERROR", MB_OK);
      return false;
    }

    if ( SetPixelFormat(m_hdc, GLPixelIndex, &pixelDesc) == FALSE)
    {
      CHAR sz[80];
      DWORD dw = GetLastError();
      sprintf (sz, "SetPixelFormat failed: Get LastError returned %u\n",
        dw);
      MessageBox ( sz, "ERROR", MB_OK);
      return false;
    }


    DescribePixelFormat(m_hdc, GLPixelIndex, sizeof(PIXELFORMATDESCRIPTOR), &pixelDesc);

    if (pixelDesc.dwFlags & PFD_NEED_PALETTE) {
    n = 1 << pixelDesc.cColorBits;
    if (n > 256) n = 256;

    lpPal = (LOGPALETTE*)malloc(sizeof(LOGPALETTE) +
                    sizeof(PALETTEENTRY) * n);
    memset(lpPal, 0, sizeof(LOGPALETTE) + sizeof(PALETTEENTRY) * n);
    lpPal->palVersion = 0x300;
    lpPal->palNumEntries = n;

    GetSystemPaletteEntries(m_hdc, 0, n, &lpPal->palPalEntry[0]);
    
    /* The pixel type is RGBA, so we want to make an RGB ramp */
        int redMask = (1 << pixelDesc.cRedBits) - 1;
    int greenMask = (1 << pixelDesc.cGreenBits) - 1;
    int blueMask = (1 << pixelDesc.cBlueBits) - 1;
    int i;

        /* fill in the entries with an RGB color ramp. */
    for (i = 0; i < n; ++i) {
      lpPal->palPalEntry[i].peRed = 
        (((i >> pixelDesc.cRedShift)   & redMask)   * 255) / redMask;
      lpPal->palPalEntry[i].peGreen = 
        (((i >> pixelDesc.cGreenShift) & greenMask) * 255) / greenMask;
      lpPal->palPalEntry[i].peBlue = 
        (((i >> pixelDesc.cBlueShift)  & blueMask)  * 255) / blueMask;
      lpPal->palPalEntry[i].peFlags = 0;
    }

    m_hPalette = CreatePalette(lpPal);
    if (m_hPalette) {
        SelectPalette(m_hdc, m_hPalette, FALSE);
        RealizePalette(m_hdc);
    }

    free(lpPal);
    }

    return true;
}

BOOL CxModel::CreateViewGLContext()
{
  m_hGLContext = wglCreateContext(m_hdc);
  if(m_hGLContext ==NULL)
  {
    CHAR sz[80];
    DWORD dw = GetLastError();
    sprintf (sz, "wglCreateContext failed: Get LastError returned %u\n",
      dw);
    MessageBox ( sz, "ERROR", MB_OK);
    return false;
  }

  if(setCurrentGL() == false)
  {
    CHAR sz[80];
    DWORD dw = GetLastError();
    sprintf (sz, "wglMakeCurrent failed: Get LastError returned %u\n",
      dw);
    MessageBox ( sz, "ERROR", MB_OK);
    return false;
  }

  return true;
}
#endif

int CxModel::IsAtomClicked(int xPos, int yPos, string *atomname, CcModelObject **outObject, bool atomsOnly)
{
   setCurrentGL();
   GLint viewport[4];
   glGetIntegerv ( GL_VIEWPORT, viewport ); //Get the current viewport.

   GLuint selectbuf[400]; //space for 100 hits.
   glSelectBuffer ( 400, selectbuf ); //Allocate space for 100 hit objects

// Correct for strange "3 pixels out in the vertical" effect.
// This effect seems to have fixed itself. Commented out correction.
//   yPos += 3;

/*   if (atomsOnly) {
      LOGERR( string((int)this) + "IAC? " + string(xPos) + " " + string (yPos)+
      string(viewport[0])+" "+string(viewport[1])+" "+string(viewport[2])+" "+string(viewport[3])+" " );
   }*/

   bool repeat = true;
   int tolerance = 0;
   int hits = 0;
  
   while ( repeat )
   {
       
//For debugging comment out next line and uncomment the SwapBuffers line below.
     glRenderMode ( GL_SELECT ); //Instead of rendering, tell OpenGL to put stuff in the SelectBuffer.

     glInitNames();  //Initialise names stack (names are just INTs, but will be unique for each atom and bond.)
     glPushName( 0 ); //Push a value onto the stack, it is replaced by each LoadName call during rendering.


     glMatrixMode ( GL_PROJECTION );
     glLoadIdentity();
     gluPickMatrix ( xPos, viewport[3] - yPos, tolerance+1, tolerance+1, viewport );
     CameraSetup();
     ModelSetup();

#ifndef __WXMAC__
     glCallList( ATOMLIST );
     if ( tolerance == 0 && !atomsOnly )
        glCallList( BONDLIST ); // Only select bonds if right over them.
#else
     bool o = ((CrModel*)ptr_to_crObject)->RenderAtoms();
     if ( tolerance == 0 && !atomsOnly )
        o = ((CrModel*)ptr_to_crObject)->RenderBonds();
#endif

#ifdef __CR_WIN__
//For debug uncomment next line and comment the glRenderMode line above.
//    HDC hdc = ::GetDC ( GetSafeHwnd() ); wglMakeCurrent(hdc, m_hGLContext); SwapBuffers (hdc);
#endif

     hits = glRenderMode ( GL_RENDER ); //Switching back to render mode, return value is number of objects hit.

     if ( hits || tolerance )  repeat = false;
     tolerance = 19; // If nothing under the mouse select things close by.
   }

   if ( hits < 0 )
   {
     hits = -hits;
     LOGERR ( "Hit test buffer overflow - contact richard.cooper@chem.ox.ac.uk");
   }

//Hit records in selectbuf have the form:
// uint Number of names (this will always be 1, because we are careful only to call PushName once.)
// uint Min depth of hit primitive
// uint Max depth of hit primitive      
// uint Name



   if ( hits )
   {
//     TEXTOUT ( string ( hits ) + " hits" );
     GLuint highest_point = selectbuf[1];
     GLuint highest_name = selectbuf[3];
     for ( int i = 1; i<hits; i++ )
     {
       if ( selectbuf[ (i*4) + 2 ] < highest_point )
       {
         highest_point = selectbuf[ (i*4) + 1 ];
         highest_name  = selectbuf[ (i*4) + 3 ];
       }
     }

//     if (atomsOnly) { LOGERR( "HitGLID: " + string((int)highest_name) ); }

     *outObject = ((CrModel*)ptr_to_crObject)->FindObjectByGLName ( highest_name );

     if ( *outObject )
     {
       *atomname = (*outObject)->Label();
       return (*outObject)->Type();
     }

   }
   return 0;
}


void CxModel::AutoScale()
{

   GLint viewport[4];
   glGetIntegerv ( GL_VIEWPORT, viewport ); //Get the current viewport.

   GLfloat *feedbuf;

   bool bigger_buf_needed = true;
   int hits = 0;

   while ( bigger_buf_needed )
   {

     feedbuf = new GLfloat[m_fbsize];

     glFeedbackBuffer ( m_fbsize, GL_2D, feedbuf ); 
  
     glRenderMode ( GL_FEEDBACK ); //Instead of rendering, tell OpenGL to put stuff in the FeedBackBuffer.

     glMatrixMode ( GL_PROJECTION );
     glLoadIdentity();
     CameraSetup();
//Can't use ModelSetup() as it translates & scales the molecule!
     glMatrixMode ( GL_MODELVIEW );
     glLoadIdentity();
     glMultMatrixf ( mat );
#ifndef __WXMAC__
     glCallList( ATOMLIST );
     glCallList( BONDLIST );
#else
     bool o = ((CrModel*)ptr_to_crObject)->RenderAtoms();
     o = ((CrModel*)ptr_to_crObject)->RenderBonds();
#endif
     glMatrixMode ( GL_PROJECTION );
     glMatrixMode ( GL_MODELVIEW );

     hits = glRenderMode ( GL_RENDER ); //Switching back to render mode, return value is number of objects hit.

     if ( hits < 0 )
     {
       delete [] feedbuf;
       m_fbsize = m_fbsize * 2;
       ostringstream message;
       message << "Feedback buffer overflows, doubling size to " << m_fbsize;
       LOGSTAT ( message.str() );
       bigger_buf_needed = true;
     }
     else
     {
       bigger_buf_needed = false;
     }        
   }

   CcRect enclosed;
   enclosed.Set( viewport[3], viewport[2],
                 viewport[1], viewport[0] );

   int point = hits, nVert, token;
   while ( point > 0 )
   {
     token = (int)feedbuf [ hits - point ];
     switch ( token ) {
     case GL_PASS_THROUGH_TOKEN:
       point--;
       point--;
       break;
     case GL_POINT_TOKEN:
     case GL_BITMAP_TOKEN:
     case GL_DRAW_PIXEL_TOKEN:
     case GL_COPY_PIXEL_TOKEN:
       point--;
       point -= AdjustEnclose( &enclosed, feedbuf, hits-point );
       break;
     case GL_LINE_TOKEN:
     case GL_LINE_RESET_TOKEN:
       point--;
       point -= AdjustEnclose( &enclosed, feedbuf, hits-point );
       point -= AdjustEnclose( &enclosed, feedbuf, hits-point );
       break;
     case GL_POLYGON_TOKEN:
       point--;
       nVert = (int)feedbuf[hits-point];
       point--;
       for (; nVert > 0; nVert--)
         point -= AdjustEnclose( &enclosed, feedbuf, hits-point );
       break;
     default:
       LOGERR ( "Unknown GL feedback token - contact richard.cooper@chem.ox.ac.uk");
       point--;
     }
   }


   float wscale = (float)viewport[2] / (float)enclosed.Width() ;
   float hscale = (float)viewport[3] / (float)enclosed.Height() ;

   m_xScale = CRMIN ( hscale , wscale ) * 0.9f; //Allow a margin.

   float xpoffset = ((float)viewport[2]/2.0f)-(float)enclosed.MidX();
   float ypoffset = ((float)viewport[3]/2.0f)-(float)enclosed.MidY();

   float xmoffset = xpoffset * 10000.0f / (float) CRMIN ( viewport[2], viewport[3] );
   float ymoffset = ypoffset * 10000.0f / (float) CRMIN ( viewport[2], viewport[3] );

   m_xTrans = xmoffset * m_xScale;
   m_yTrans = ymoffset * m_xScale;

   delete [] feedbuf;


}



int CxModel::AdjustEnclose( CcRect* enc, GLfloat* buf, int point )
{
  enc->mLeft   = CRMIN( (int)buf[point],   enc->mLeft );
  enc->mRight  = CRMAX( (int)buf[point],   enc->mRight );
  enc->mTop    = CRMIN( (int)buf[point+1], enc->mTop );
  enc->mBottom = CRMAX( (int)buf[point+1], enc->mBottom );
  return 2;
}

#ifdef __CR_WIN__
void CxModel::OnMenuSelected(UINT nID)
{

#endif
#ifdef __BOTHWX__
void CxModel::OnMenuSelected(wxCommandEvent & event)
{
      int nID = event.m_id;
#endif

    ((CrModel*)ptr_to_crObject)->MenuSelected( nID );
}


void CxModel::Update(bool rescale)
{
   ModelChanged(rescale);
}


void CxModel::SetIdealHeight(int nCharsHigh)
{
#ifdef __CR_WIN__

    CClientDC cdc(this);
//      cdc.SetBkColor ( RGB ( 255,255,255 ) );
    CFont* oldFont = cdc.SelectObject(CcController::mp_font);
    TEXTMETRIC textMetric;                                                                                       
    cdc.GetTextMetrics(&textMetric);
    cdc.SelectObject(oldFont);
    mIdealHeight = nCharsHigh * textMetric.tmHeight;

#endif
#ifdef __BOTHWX__

      mIdealHeight = nCharsHigh * GetCharHeight();

#endif
}

void CxModel::SetIdealWidth(int nCharsWide)
{
#ifdef __CR_WIN__

    CClientDC cdc(this);
//    cdc.SetBkColor ( RGB ( 255,255,255 ) );
    CFont* oldFont = cdc.SelectObject(CcController::mp_font);
    TEXTMETRIC textMetric;
    cdc.GetTextMetrics(&textMetric);
    cdc.SelectObject(oldFont);
    mIdealWidth = nCharsWide * textMetric.tmAveCharWidth;

#endif
#ifdef __BOTHWX__

      mIdealWidth = nCharsWide * 6; //Fix this ! GetCharWidth();

#endif
}

void  CxModel::SetGeometry( int top, int left, int bottom, int right )
{
#ifdef __CR_WIN__
  MoveWindow(left,top,right-left,bottom-top,true);
#endif
#ifdef __BOTHWX__
  SetSize(left,top,right-left,bottom-top);
#endif
  NewSize(right-left, bottom-top);
  NeedRedraw(true);
}

CXGETGEOMETRIES(CxModel)


int   CxModel::GetIdealWidth()
{
    return mIdealWidth;
}
int   CxModel::GetIdealHeight()
{
    return mIdealHeight;
}

void CxModel::NeedRedraw(bool needrescale)
{
  m_bNeedReScale = m_bNeedReScale || needrescale;
//  if ( needrescale) TEXTOUT ( "Need Redraw with Rescale" );
//  else TEXTOUT ( "Need Redraw without Rescale" );
#ifdef __CR_WIN__
  InvalidateRect(NULL,false);
#endif
#ifdef __BOTHWX__
  m_DoNotPaint = false;
  Refresh();
#endif
}

void CxModel::ModelChanged(bool needrescale) 
{
//  TEXTOUT ( "Model " + string((int)this) + "changed" );
  m_bModelChanged = true;
  m_bFullListOk = false;
  NeedRedraw(needrescale);
}

void CxModel::ChooseCursor( int cursor )
{
#ifdef __CR_WIN__

        switch ( cursor )
        {
                case CURSORZOOMIN:
                        SetCursor( AfxGetApp()->LoadCursor(IDC_CURSOR2) );
                        break;
                case CURSORZOOMOUT:
                        SetCursor( AfxGetApp()->LoadCursor(IDC_CURSOR3) );
                        break;
                case CURSORNORMAL:
                        SetCursor( AfxGetApp()->LoadCursor(IDC_CURSOR1) );
                        break;
                case CURSORCROSS:
                        SetCursor( AfxGetApp()->LoadStandardCursor(IDC_CROSS) );
                        break;
                case CURSORCOPY:
                        SetCursor( AfxGetApp()->LoadCursor(IDC_POINTER_COPY) );
                        break;
                default:
                        SetCursor( AfxGetApp()->LoadCursor(IDC_CURSOR1) );
                        break;
        }
#endif
}

void CxModel::SetDrawStyle( int drawStyle )
{
      m_DrawStyle = drawStyle;
      ModelChanged(false);
}
void CxModel::SetAutoSize( bool size )
{
      m_Autosize = size;
      (CcController::theController)->status.SetZoomedFlag ( !m_Autosize );
      NeedRedraw(size);
}
void CxModel::SetHover( bool hover )
{
      m_Hover = hover;
}
void CxModel::SetShading( bool shade )
{
      m_Shading = shade;
      ModelChanged(false);
}


#ifdef __CR_WIN__

void CxModel::PaintBannerInstead( CPaintDC * dc )
{
  if ( m_bitmapok )
  {
        // Create a memory DC compatible with the paint DC
        CDC banDC;
        banDC.CreateCompatibleDC( dc );

        CBitmap *pBmpOld = banDC.SelectObject( &m_bitmap );

        // Select and realize the palette
        if( dc->GetDeviceCaps(RASTERCAPS) & RC_PALETTE && m_pal.m_hObject != NULL )
        {
                dc->SelectPalette( &m_pal, FALSE );
                dc->RealizePalette();
        }

        CRect rcWnd;
        GetWindowRect( &rcWnd );

        BITMAP bm;
        m_bitmap.GetBitmap(&bm);

        int w = bm.bmWidth;
        int h = bm.bmHeight;

        dc->SetStretchBltMode(COLORONCOLOR);

        dc->StretchBlt(0,0,rcWnd.Width(),rcWnd.Height(),
                   &banDC,
                   0, 0, bm.bmWidth, bm.bmHeight,
                   SRCCOPY);

        // Restore bitmap in banDC
        banDC.SelectObject( pBmpOld );
  }
}

BOOL CxModel::OnEraseBkgnd( CDC* pDC )
{
    return ( TRUE ) ; //prevent flicker
}

#endif

#ifdef __BOTHWX__

void CxModel::PaintBannerInstead( wxPaintDC * dc )
{
  if ( m_bitmapok )
  {
    double x,y;
    dc->GetUserScale(&x,&y);
    dc->SetUserScale( (double)GetWidth() / (double)m_bitmap.GetWidth(),
                      (double)GetHeight()/ (double)m_bitmap.GetHeight()  );
    dc->DrawBitmap(m_bitmap, 0, 0);
    dc->SetUserScale(x,y);
  }
}


void CxModel::OnEraseBackground( wxEraseEvent& evt )
{
    return;  //Reduces flickering. (Window is not erased).
}
#endif

void CxModel::SelectTool ( int toolType )
{
  if (m_mouseMode == CXPOLYSEL)
  {
     ModelChanged(false);
     m_selectionPoints.clear();
  }

  m_mouseMode = toolType;
}


void CxModel::DeletePopup()
{
  if ( m_TextPopup )
  {
#ifdef __CR_WIN__
//    m_TextPopup->DestroyWindow();
    delete m_TextPopup;
#endif
#ifdef __BOTHWX__
    m_TextPopup->Destroy();
    m_DoNotPaint = false;
#endif
    m_TextPopup=nil;
  }
}

void CxModel::CreatePopup(string atomname, CcPoint point)
{
#ifdef __BOTHWX__
  m_DoNotPaint = true;
#endif

  DeletePopup();

#ifdef __CR_WIN__
  string n = string(" ") + atomname + string(" ");

  m_TextPopup = new CStatic();
  m_TextPopup->Create(n.c_str(), SS_SIMPLE|SS_CENTER|WS_BORDER, CRect(0,0,0,0), this);
  m_TextPopup->SetFont(CcController::mp_font);

  CClientDC dc(m_TextPopup);
  CFont* oldFont = dc.SelectObject(CcController::mp_font);

  SIZE size = dc.GetOutputTextExtent(n.c_str(),n.length());
  size.cx += 3;
  size.cy += 2;

  m_TextPopup->ModifyStyleEx(NULL,WS_EX_TOPMOST,0);
  int x = CRMIN(GetWidth() - size.cx, point.x + 20) ;
  x = CRMAX(0,x);
  int y = CRMIN(GetHeight() - size.cy,point.y);
  y = CRMAX(0,y);
  m_TextPopup->MoveWindow(x,y,size.cx,size.cy, FALSE);
  m_TextPopup->ShowWindow(SW_SHOW);
  RedrawWindow();
  dc.SelectObject(oldFont);
#endif
#ifdef __BOTHWX__
  int cx,cy;
  GetTextExtent( atomname.c_str(), &cx, &cy ); //using cxmodel's DC to work out text extent before creation.
                                                   //then can create in one step.
  m_TextPopup = new mywxStaticText(this, -1, atomname.c_str(),
                                 wxPoint(CRMAX(0,point.x-cx-4),CRMAX(0,point.y-cy-4)),
                                 wxSize(cx+4,cy+4),
                                 wxALIGN_CENTER|wxSIMPLE_BORDER) ;
//  m_TextPopup->SetEvtHandlerEnabled(true);

#endif
}


void CxModel::LoadDIBitmap(string filename)
{
#ifdef __CR_WIN__
    if ( m_bitmapbits ) delete [] m_bitmapbits;
    if ( m_bitmapinfo ) delete [] m_bitmapinfo;
    m_bitmapbits = NULL;
    m_bitmapinfo = NULL;

    NeedRedraw(false);

    HANDLE hFileHandle;
    unsigned long lInfoSize = 0;
    unsigned long lBitSize = 0;
    int nTextureWidth;
    int nTextureHeight;

// Open the Bitmap file
    hFileHandle = CreateFile(filename.c_str(),GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_FLAG_SEQUENTIAL_SCAN,NULL);

// Check for open failure (most likely file does not exist).
    if(hFileHandle == INVALID_HANDLE_VALUE) return;

// File is Open. Read in bitmap header information
    BITMAPFILEHEADER        bitmapHeader;
    DWORD dwBytes;
    ReadFile(hFileHandle,&bitmapHeader,sizeof(BITMAPFILEHEADER), &dwBytes,NULL);

    if(dwBytes != sizeof(BITMAPFILEHEADER)) 
    {
        CloseHandle(hFileHandle);
        MessageBox ( "File is corrupt or not a device-independent bitmap", "ERROR", MB_OK);
        return;
    }

// Check format of bitmap file
    if(bitmapHeader.bfType != 'MB') 
    {
        CloseHandle(hFileHandle);
        MessageBox ( "File is not a 24-bit device-independent bitmap", "ERROR", MB_OK);
        return;
    }

// Read in bitmap information structure
    lInfoSize = bitmapHeader.bfOffBits - sizeof(BITMAPFILEHEADER);
    m_bitmapinfo = (BITMAPINFO *) new BYTE[lInfoSize];
    ReadFile(hFileHandle,m_bitmapinfo,lInfoSize,&dwBytes,NULL);

    if(dwBytes != lInfoSize) 
    {
        if(m_bitmapinfo) delete [] m_bitmapinfo;
        m_bitmapinfo = NULL;
        CloseHandle(hFileHandle);
        MessageBox ( "While reading bitmap header - file is corrupt", "ERROR", MB_OK);
        return;
    }

    if ( m_bitmapinfo->bmiHeader.biBitCount != 24 )
    {
        if(m_bitmapinfo) delete [] m_bitmapinfo;
        m_bitmapinfo = NULL;
        CloseHandle(hFileHandle);
        MessageBox ( "Bitmap is not 24-bit DIB.", "ERROR", MB_OK);
        return;
    }



    nTextureWidth = m_bitmapinfo->bmiHeader.biWidth;
    nTextureHeight = m_bitmapinfo->bmiHeader.biHeight;
    lBitSize = m_bitmapinfo->bmiHeader.biSizeImage;
    if(lBitSize == 0) lBitSize = (nTextureWidth * m_bitmapinfo->bmiHeader.biBitCount + 7) / 8 * abs(nTextureHeight);
    
// Allocate space for the actual bitmap
    m_bitmapbits = new BYTE[lBitSize];

// Read in the bitmap bits
    ReadFile(hFileHandle,m_bitmapbits,lBitSize,&dwBytes,NULL);

    if(lBitSize != dwBytes)
    {
        if(m_bitmapbits) delete [] (BYTE *) m_bitmapbits;
        m_bitmapbits = NULL;
        if(m_bitmapinfo) delete [] m_bitmapinfo;
        m_bitmapinfo = NULL;
        CloseHandle(hFileHandle);
        MessageBox ( "While reading bitmap data - file is corrupt", "ERROR", MB_OK);
        return;
    }

    CloseHandle(hFileHandle);

// This is specific to the binary format of the data read in.
    glPixelStorei(GL_UNPACK_ALIGNMENT, 1); 
    glPixelStorei(GL_UNPACK_ROW_LENGTH, 0);
    glPixelStorei(GL_UNPACK_SKIP_ROWS, 0);
    glPixelStorei(GL_UNPACK_SKIP_PIXELS, 0);

#endif
    return;
}

void CxModel::PolyCheck()
{
   if ( m_selectionPoints.size() < 3 ) return;

   setCurrentGL();

   GLint viewport[4];
   glGetIntegerv ( GL_VIEWPORT, viewport ); //Get the current viewport.

   GLfloat *feedbuf;

   bool bigger_buf_needed = true;
   int hits = 0;

   while ( bigger_buf_needed )
   {

     feedbuf = new GLfloat[m_fbsize];

     glFeedbackBuffer ( m_fbsize, GL_2D, feedbuf ); 
  
     glRenderMode ( GL_FEEDBACK ); //Instead of rendering, tell OpenGL to put stuff in the FeedBackBuffer.

     glMatrixMode ( GL_PROJECTION );
     glLoadIdentity();
     CameraSetup();
     ModelSetup();
     ((CrModel*)ptr_to_crObject)->RenderModel(true);

     glMatrixMode ( GL_PROJECTION );
     glMatrixMode ( GL_MODELVIEW );

     hits = glRenderMode ( GL_RENDER ); //Switching back to render mode, return value is number of objects hit.

     if ( hits < 0 )
     {
       delete [] feedbuf;
       m_fbsize = m_fbsize * 2;
       ostringstream message;
       message << "Feedback buffer overflows, doubling size to " << m_fbsize;
       LOGSTAT ( message.str() );
       bigger_buf_needed = true;
     }
     else
     {
       bigger_buf_needed = false;
     }        
   }

   int point = hits, nVert, token;

   int currentGLID = 0, lastGLID = -1;
   int curX = 0, curY = 0;

   while ( point > 0 )
   {
     token = (int)feedbuf [ hits - point ];
     switch ( token ) {
     case GL_PASS_THROUGH_TOKEN:
       point--;
       currentGLID = (int) feedbuf [ hits - point ];
       point--;
       break;
     case GL_POINT_TOKEN:
     case GL_BITMAP_TOKEN:
     case GL_DRAW_PIXEL_TOKEN:
     case GL_COPY_PIXEL_TOKEN:
       point--;
       curX = (int) feedbuf [ hits - point ];
       point--;
       curY = (int) feedbuf [ hits - point ];
       point--;
       break;
     case GL_LINE_TOKEN:
     case GL_LINE_RESET_TOKEN:
       point--;
       curX = (int) feedbuf [ hits - point ];
       point--;
       curY = (int) feedbuf [ hits - point ];
       feedbuf [ hits - point ] = (float) RC_NEXT_LINE_TOKEN;
       break;
     case RC_NEXT_LINE_TOKEN:
       point--;
       curX = (int) feedbuf [ hits - point ];
       point--;
       curY = (int) feedbuf [ hits - point ];
       point--;
       break;
     case GL_POLYGON_TOKEN:
       point--;
       nVert = (int)feedbuf[hits-point];
       point--;
       nVert--;
       curX = (int) feedbuf [ hits - point ];
       if ( nVert > 0 ) feedbuf [ hits - point ] = (float) GL_POLYGON_TOKEN;
       else point--;
       curY = (int) feedbuf [ 1 + hits - point ];
       if ( nVert > 0 ) feedbuf [ 1 + hits - point ] = (float) nVert;
       else point--;
       break;
     default:
       LOGERR ( "Unknown GL feedback token - contact richard.cooper@chem.ox.ac.uk");
       point--;
     }

     if ( ( currentGLID > 0 ) && ( currentGLID != lastGLID ) && ( curX > 0 ) )
     {

// Imagine a horizontal line drawn from the current polygon of the
// current atom to the right. If it cuts the polygon an odd number
// of times, then it is inside.
// Check each polygon segment in turn and add up the number of crossings.
// A crossing occurs if:
//   1. The y-coord of the atom lies inbetween the y-coords of
//      the ends of the line.
//   2. The point of intersection of our imaginary horizonatal line and
//      the extrapolated polygon line lies on the polygon line.
//   3. The x-coord of our atom is less than the x-coord of intersection.

       curY = viewport[3] - curY; // Correct for sense of OpenGL coord system.

       int crossings = 0;

       list<CcPoint>::iterator p1, p2;
       p1 = p2 = m_selectionPoints.begin();
       p2++;
       
       while ( p2 != m_selectionPoints.end() )
       {
         if (  ( ( (*p1).y < curY ) && ( (*p2).y > curY ) ) ||
               ( ( (*p1).y > curY ) && ( (*p2).y < curY ) )    )
         {
            float invgrad = 1000000.0f; // Avoid divide by zero:
            if ( (*p2).y - (*p1).y != 0 ) invgrad = (float)((*p2).x - (*p1).x) / (float)((*p2).y - (*p1).y);

            float xCut = ( (*p1).x + ( (curY - (*p1).y) * invgrad ) );

            if ( ( ( ( (*p1).x < xCut ) && ( (*p2).x > xCut ) ) ||
                   ( ( (*p1).x > xCut ) && ( (*p2).x < xCut ) )    ) &&
                 ( curX < xCut ) )
            {
              crossings++;
            }
         }
         p1++;
         p2++;
       }

       if ( crossings % 2 != 0 )
       {
         CcModelObject* atom;
         atom = ((CrModel*)ptr_to_crObject)->FindObjectByGLName ( currentGLID );
         if ( atom )
         {
           atom->Select(true);
           lastGLID = currentGLID;
         }
       }
     }

     curX = -1;

   }

   delete [] feedbuf;


}



void CxModel::SelectBoxedAtoms(CcRect rectangle, bool select)
{
   setCurrentGL();
   GLint viewport[4];
   glGetIntegerv ( GL_VIEWPORT, viewport ); //Get the current viewport.

   GLuint * selectbuf;

   bool repeat = true;
   int hits = 0;
  
   while ( repeat )
   {
     selectbuf = new GLuint[m_sbsize];
     glSelectBuffer ( m_sbsize, selectbuf );
       
     glRenderMode ( GL_SELECT ); //Instead of rendering, tell OpenGL to put stuff in the SelectBuffer.

     glInitNames();  //Initialise names stack (names are just INTs, but will be unique for each atom and bond.)
     glPushName( 0 ); //Push a value onto the stack, it is replaced by each LoadName call during rendering.

     glMatrixMode ( GL_PROJECTION );
     glPushMatrix();
     glLoadIdentity();
     gluPickMatrix ( rectangle.MidX(), viewport[3] - rectangle.MidY(), rectangle.Sort().Width(), rectangle.Sort().Height(), viewport );
     CameraSetup();
     ModelSetup();
#ifndef __WXMAC__
     glCallList( ATOMLIST );
#else
     bool o = ((CrModel*)ptr_to_crObject)->RenderAtoms();
#endif
     glMatrixMode ( GL_PROJECTION );
     glPopMatrix();
     glMatrixMode ( GL_MODELVIEW );

     hits = glRenderMode ( GL_RENDER ); //Switching back to render mode, return value is number of objects hit.

     if ( hits >= 0 )
     {
       repeat = false;
     }
     else
     {
       repeat = true;
       delete [] selectbuf;
       m_sbsize = m_sbsize * 2;
       ostringstream message;
       message << "Select buffer overflows, doubling size to " << m_sbsize;
       LOGSTAT ( message.str() );
     }
   }

//Hit records in selectbuf have the form:
// uint Number of names (this will always be 1, because we are careful only to call PushName once.)
// uint Min depth of hit primitive
// uint Max depth of hit primitive
// uint Name

   CcModelAtom* atom;
   for ( int i = 0; i<hits; i++ )
   {
     atom = (CcModelAtom*)((CrModel*)ptr_to_crObject)->FindObjectByGLName(selectbuf[(i*4)+3]);
     if ( atom ) atom->Select();
   }
   delete [] selectbuf;

}
