////////////////////////////////////////////////////////////////////////

//   CRYSTALS Interface      Class CxModList

////////////////////////////////////////////////////////////////////////

//   Filename:  CxModList.cpp
//   Authors:   Richard Cooper

#include    "crystalsinterface.h"
#include    "cxmodlist.h"

#include    "cxgrid.h"
#include    "cxwindow.h"
#include    "crmodlist.h"
#include    "ccmodelatom.h"
#include    "cccontroller.h"
#include    <math.h>

int CxModList::mModListCount = kModListBase;

CxModList *    CxModList::CreateCxModList( CrModList * container, CxGrid * guiParent )
{
    CxModList  *theModList = new CxModList( container );
#ifdef __CR_WIN__
    theModList->Create(WS_CHILD|WS_VISIBLE|LVS_REPORT|LVS_OWNERDRAWFIXED|LVS_SHOWSELALWAYS|WS_VSCROLL, CRect(0,0,5,5), guiParent, mModListCount++);
    theModList->ModifyStyleEx(NULL,WS_EX_CLIENTEDGE,0);
    theModList->SetFont(CcController::mp_font);
    theModList->m_listboxparent = guiParent;
#endif
#ifdef __BOTHWX__
      theModList->Create(guiParent, -1, wxPoint(0,0), wxSize(10,10),
                          wxLC_REPORT);
#endif
    theModList->AddCols();
    return theModList;
}

CxModList::CxModList( CrModList * container )
      : BASEMODLIST()
{
    ptr_to_crObject = container;

    mItems = 0;
    mVisibleLines = 0;
    m_numcols = 0;
    m_colWidths = nil;
    m_colTypes = nil;
    nSortedCol = -1;
    bSortAscending = true;
    m_ProgSelecting = 0;
    IDlist = nil;
    m_IDlist_size = 0;
}

void CxModList::AddCols()
{
    m_numcols=12;
    CcString colHeader[12];
    colHeader[0] = "Id";
    colHeader[1] = "Type";
    colHeader[2] = "Serial";
    colHeader[3] = "x";
    colHeader[4] = "y";
    colHeader[5] = "z";
    colHeader[6] = "occ";
    colHeader[7] = "Type";
    colHeader[8] = "Ueq";
    colHeader[9] = "Residue";
    colHeader[10] = "Part";
    colHeader[11] = "Spare";

    m_colWidths = new int[m_numcols];
    m_colTypes  = new int[m_numcols];

    for ( int i = 0; i < m_numcols ; i++ )
    {
      m_colTypes[i] = COL_INT; //Always start with INT. This will fail to REAL, and then to TEXT.
#ifdef __CR_WIN__
      m_colWidths[i] = max(10,GetStringWidth(colHeader[i].ToCString())+5);
      InsertColumn( i, colHeader[i].ToCString(), LVCFMT_LEFT, 10, i );
#endif
#ifdef __BOTHWX__
      int w,h;
      GetTextExtent(colHeader[i].ToCString(),&w,&h);
      m_colWidths[i] = max(10,w);
      InsertColumn( i, colHeader[i].ToCString(), wxLIST_FORMAT_LEFT, 10 );
#endif
      SetColumnWidth( i, m_colWidths[i]);
    }
}


CxModList::~CxModList()
{
    RemoveModList();
    delete [] m_colWidths;
    delete [] m_colTypes;
}


void    CxModList::SetVisibleLines( int lines )
{
    mVisibleLines = lines;
}

CXSETGEOMETRY(CxModList)

CXGETGEOMETRIES(CxModList)


int CxModList::GetIdealWidth()
{
    int totWidth = 15; // 5 pixels extra.
    for (int i = 0; i<m_numcols; i++)
    {
        totWidth += m_colWidths[i];
    }
    return ( totWidth );
}

int CxModList::GetIdealHeight()
{
#ifdef __CR_WIN__
    int lines = mVisibleLines;
    CClientDC cdc(this);
    CFont* oldFont = cdc.SelectObject(CcController::mp_font);
    TEXTMETRIC textMetric;
    cdc.GetTextMetrics(&textMetric);
    cdc.SelectObject(oldFont);
    return lines * ( textMetric.tmHeight + 2 );
#endif
#ifdef __BOTHWX__
      return mVisibleLines * ( GetCharHeight() + 2 );
#endif
}

int CxModList::GetValue()
{
    return 0;
}



#ifdef __CR_WIN__
BEGIN_MESSAGE_MAP(CxModList, CListCtrl)
    ON_WM_CHAR()
    ON_WM_DRAWITEM()
    ON_WM_PAINT()
    ON_WM_KILLFOCUS()
    ON_WM_SETFOCUS()
//    ON_WM_ERASEBKGND()
    ON_COMMAND_RANGE(kMenuBase, kMenuBase+1000, OnMenuSelected)
    ON_NOTIFY(HDN_ITEMCLICKA, 0, OnHeaderClicked)
      ON_NOTIFY(HDN_ITEMCLICKW, 0, OnHeaderClicked)
    ON_NOTIFY_REFLECT( LVN_ITEMCHANGED, ItemChanged )
    ON_NOTIFY_REFLECT( NM_RCLICK,  RightClick )
END_MESSAGE_MAP()
#endif
#ifdef __BOTHWX__
BEGIN_EVENT_TABLE(CxModList, wxListCtrl)
     EVT_CHAR( CxModList::OnChar )
END_EVENT_TABLE()
#endif


void CxModList::Focus()
{
    SetFocus();
}

CXONCHAR(CxModList)



void CxModList::AddRow(int id, CcString * rowOfStrings, bool selected,
                               bool disabled)
{
    if ( id <= mItems )
    {
//Find ID in existing list.
      for ( int i=0; i<mItems; i++ )
      {
        if ( IDlist[i] == id )
        {
            for( int j=0; j<m_numcols; j++)
#ifdef __CR_WIN__
                SetItemText( i, j, rowOfStrings[j].ToCString());
#endif
#ifdef __BOTHWX__
                SetItem( i, j, rowOfStrings[j].ToCString());
#endif

            if ( selected )
#ifdef __CR_WIN__
               SetItemState(i, LVIS_SELECTED, LVIS_SELECTED);
#endif
#ifdef __BOTHWX__
               SetItemState(i, wxLIST_STATE_SELECTED, wxLIST_STATE_SELECTED);
#endif
            else
#ifdef __CR_WIN__
               SetItemState(i, 0, LVIS_SELECTED);
#endif
#ifdef __BOTHWX__
               SetItemState(i, 0, wxLIST_STATE_SELECTED);
#endif
            return;
        }

      }

    }

    int i = mItems;

// A new item. Extend id list.
    if ( id > m_IDlist_size )
    {
       m_IDlist_size = max(m_IDlist_size,id) * 2;
       int * newIDlist = new int[m_IDlist_size];
       for ( i = 0; i < mItems; i++ )
       {
          newIDlist[i] = IDlist[i];
       }
       if ( IDlist ) delete [] IDlist;
       IDlist = newIDlist;
    }

    IDlist[id-1] = id;
    mItems = id;

#ifdef __CR_WIN__
    int nItem = InsertItem(mItems, _T(""));
    for (int j = 0; j < m_numcols; j++)
    {
        SetItemText(nItem, j, rowOfStrings[j].ToCString());
        int width = GetStringWidth(rowOfStrings[j].ToCString());
#endif
#ifdef __BOTHWX__
    int nItem = InsertItem(mItems-1, _T(""));
    for (int j = 0; j < m_numcols; j++)
    {
        SetItem( nItem, j, rowOfStrings[j].ToCString());
        int width,h;
        GetTextExtent(rowOfStrings[j].ToCString(),&width,&h);
#endif
        if ( width + 15 > m_colWidths[j] ) // if no change, don't set width.
        {
           m_colWidths[j] = width + 15;
           SetColumnWidth(j,m_colWidths[j]);
        }
        if ( m_colTypes[j] != COL_TEXT )   // if already text, don't bother testing.
        {
          int type = WhichType(rowOfStrings[j]);
          m_colTypes[j] = max(m_colTypes[j], type);
        }
    }
    if ( selected )
#ifdef __CR_WIN__
       SetItemState(i, LVIS_SELECTED, LVIS_SELECTED);
#endif
#ifdef __BOTHWX__
       SetItemState(i, wxLIST_STATE_SELECTED, wxLIST_STATE_SELECTED);
#endif
    else
#ifdef __CR_WIN__
       SetItemState(i, 0, LVIS_SELECTED);
#endif
#ifdef __BOTHWX__
       SetItemState(i, 0, wxLIST_STATE_SELECTED);
#endif

    return;
}


#ifdef __CR_WIN__
void CxModList::DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct)
{
        CDC* pDC = CDC::FromHandle(lpDrawItemStruct->hDC);
        CRect rcItem(lpDrawItemStruct->rcItem);
        int nItem = lpDrawItemStruct->itemID;

        // Save dc state
        int nSavedDC = pDC->SaveDC();

        // Get item image and state info
        LV_ITEM lvi;
        lvi.mask = LVIF_IMAGE | LVIF_STATE;
        lvi.iItem = nItem;
        lvi.iSubItem = 0;
        lvi.stateMask = 0xFFFF;         // get all state flags
        GetItem(&lvi);

        // Should the item be highlighted?
        bool bHighlight =((lvi.state & LVIS_DROPHILITED)
                                || ( (lvi.state & LVIS_SELECTED)
                                        && ((GetFocus() == this)
                                                || (GetStyle() & LVS_SHOWSELALWAYS)
                                                )
                                        )
                                );


        // Get rectangles for drawing
        CRect rcBounds, rcLabel;
        GetItemRect(nItem, rcBounds, LVIR_BOUNDS);
        GetItemRect(nItem, rcLabel, LVIR_LABEL);
        CRect rcCol( rcBounds );


        CString sLabel = GetItemText( nItem, 0 );

        // Labels are offset by a certain amount
        // This offset is related to the width of a space character
        int offset = pDC->GetTextExtent(_T(" "), 1 ).cx*2;

        CRect rcHighlight;
        CRect rcWnd;
        GetClientRect(&rcWnd);
        rcHighlight = rcBounds;
        rcHighlight.left = rcLabel.left;
        rcHighlight.right = rcWnd.right+1;   // Add 1 to prevent trails

        // Draw the background color
        if( bHighlight )
        {
                pDC->SetTextColor(::GetSysColor(COLOR_HIGHLIGHTTEXT));
                pDC->SetBkColor(::GetSysColor(COLOR_HIGHLIGHT));
                pDC->FillRect(rcHighlight, &CBrush(::GetSysColor(COLOR_HIGHLIGHT)));
        }
        else
                pDC->FillRect(rcHighlight, &CBrush(::GetSysColor(COLOR_WINDOW)));



        // Set clip region
        rcCol.right = rcCol.left + GetColumnWidth(0);
        CRgn rgn;
        rgn.CreateRectRgnIndirect(&rcCol);
        pDC->SelectClipRgn(&rgn);
        rgn.DeleteObject();


        // Draw item label - Column 0
        rcLabel.left += offset/2;
        rcLabel.right -= offset;

        pDC->DrawText(sLabel,-1,rcLabel,DT_LEFT | DT_SINGLELINE | DT_NOPREFIX | DT_NOCLIP
                                | DT_VCENTER | DT_END_ELLIPSIS);


        // Draw labels for remaining columns
        LV_COLUMN lvc;
        lvc.mask = LVCF_FMT | LVCF_WIDTH;

        rcBounds.right = rcHighlight.right > rcBounds.right ? rcHighlight.right :
                                                        rcBounds.right;
        rgn.CreateRectRgnIndirect(&rcBounds);
        pDC->SelectClipRgn(&rgn);

        for(int nColumn = 1; GetColumn(nColumn, &lvc); nColumn++)
        {
                rcCol.left = rcCol.right;
                rcCol.right += lvc.cx;

                sLabel = GetItemText(nItem, nColumn);
                if (sLabel.GetLength() == 0)
                        continue;

                // Get the text justification
                UINT nJustify = DT_LEFT;
                switch(lvc.fmt & LVCFMT_JUSTIFYMASK)
                {
                case LVCFMT_RIGHT:
                        nJustify = DT_RIGHT;
                        break;
                case LVCFMT_CENTER:
                        nJustify = DT_CENTER;
                        break;
                default:
                        break;
                }

                rcLabel = rcCol;
                rcLabel.left += offset;
                rcLabel.right -= offset;

                pDC->DrawText(sLabel, -1, rcLabel, nJustify | DT_SINGLELINE |
                                        DT_NOPREFIX | DT_VCENTER | DT_END_ELLIPSIS);
        }

        // Draw focus rectangle if item has focus
        if (lvi.state & LVIS_FOCUSED && (GetFocus() == this))
                pDC->DrawFocusRect(rcHighlight);


        // Restore dc
        pDC->RestoreDC( nSavedDC );
}
#endif

#ifdef __CR_WIN__
void CxModList::RepaintSelectedItems()
{
        CRect rcBounds, rcLabel;

        // Invalidate focused item so it can repaint
        int nItem = GetNextItem(-1, LVNI_FOCUSED);

        if(nItem != -1)
        {
                GetItemRect(nItem, rcBounds, LVIR_BOUNDS);
                GetItemRect(nItem, rcLabel, LVIR_LABEL);
                rcBounds.left = rcLabel.left;

                InvalidateRect(rcBounds, false);
        }

        // Invalidate selected items depending on LVS_SHOWSELALWAYS
        if(!(GetStyle() & LVS_SHOWSELALWAYS))
        {
                for(nItem = GetNextItem(-1, LVNI_SELECTED);
                        nItem != -1; nItem = GetNextItem(nItem, LVNI_SELECTED))
                {
                        GetItemRect(nItem, rcBounds, LVIR_BOUNDS);
                        GetItemRect(nItem, rcLabel, LVIR_LABEL);
                        rcBounds.left = rcLabel.left;

                        InvalidateRect(rcBounds, false);
                }
        }

        UpdateWindow();
}
#endif

//BOOL CxModList::OnEraseBkgnd( CDC* pDC )
//{
//    return ( TRUE ) ; //prevent flicker
//}

#ifdef __CR_WIN__
void CxModList::OnPaint()
{

        // in full row select mode, we need to extend the clipping region
        // so we can paint a selection all the way to the right
        if ( (GetStyle() & LVS_TYPEMASK) == LVS_REPORT )
        {
                CRect rcBounds;
                GetItemRect(0, rcBounds, LVIR_BOUNDS);


                CRect rcClient;
                GetClientRect(&rcClient);
                if(rcBounds.right < rcClient.right)
                {
                        CPaintDC dc(this);

                        CRect rcClip;
                        dc.GetClipBox(rcClip);

                        rcClip.left = min(rcBounds.right-1, rcClip.left);
                        rcClip.right = rcClient.right;

                        InvalidateRect(rcClip, false);
                }
        }

        CListCtrl::OnPaint();
}
#endif

#ifdef __CR_WIN__
void CxModList::OnKillFocus(CWnd* pNewWnd)
{
        CListCtrl::OnKillFocus(pNewWnd);

        // check if we are losing focus to label edit box
        if(pNewWnd != NULL && pNewWnd->GetParent() == this)
                return;

        // repaint items that should change appearance
        if((GetStyle() & LVS_TYPEMASK) == LVS_REPORT)
                RepaintSelectedItems();
}
#endif


#ifdef __CR_WIN__
void CxModList::OnSetFocus(CWnd* pOldWnd)
{
        CListCtrl::OnSetFocus(pOldWnd);

        // check if we are getting focus from label edit box
        if(pOldWnd!=NULL && pOldWnd->GetParent()==this)
                return;

        // repaint items that should change appearance
        if((GetStyle() & LVS_TYPEMASK)==LVS_REPORT)
                RepaintSelectedItems();
}
#endif



#ifdef __CR_WIN__
void CxModList::ItemChanged( NMHDR * pNMHDR, LRESULT* pResult )
{
    NM_LISTVIEW* pnmv = (NM_LISTVIEW FAR *) pNMHDR;


    //Flags pnmv->uOldState and uNewState.    Meaning
    //                0             0         Nothing, happens on setup.
    //                0             1         Gained caret focus (but not selection) (I don't think this happens)
    //                0             2         Item has become selected
    //                0             3         Selected and has caret.
    //                1             0         Lost caret.
    //                2             0         Unselected.
    //                3             0         Unselected and lost caret.

// we are only interested in changes from (or to) {0|1} to {2|3}

    if(m_ProgSelecting > 0)
    {
        m_ProgSelecting--;
    }
    else
    {

        int item = (int)pnmv->iItem;
        if (pnmv->uNewState <= 1 && pnmv->uOldState >= 2) //Unselect Item.
        {
           ((CrModList*)ptr_to_crObject)->SendValue("UNSELECTED_N" + CcString((int)pnmv->iItem + 1) ); //Send the index
           int id = IDlist[item]-1;
//           TEXTOUT ( "Unselect. item=" + CcString(item) + ", id=" + CcString(id) );
           ((CrModList*)ptr_to_crObject)->SelectAtomByPosn(id,false);
        }
        else if (pnmv->uNewState >= 2 && pnmv->uOldState <= 1) //Select Item
        {
           ((CrModList*)ptr_to_crObject)->SendValue("SELECTED_N" + CcString((int)pnmv->iItem + 1) ); //Send the index only.
           int id = IDlist[item]-1;
//           TEXTOUT ( "Select. item=" + CcString(item) + ", id=" + CcString(id) );
           ((CrModList*)ptr_to_crObject)->SelectAtomByPosn(id,true);
        }


    }
}
#endif

//         Copyright 1997-1998 CodeGuru
//         Contact : webmaster@codeguru.com

//         Modified to sort based on REAL, INT or TEXT. R.Cooper Nov 98.

//         Clever sort replaced with straight insertion so that previous
//         sorts still remain in effect if there is no difference in the
//         current sorted values.                       R.Cooper Nov 98.

//         Sort of items in place replaced with an indexed sort on the column data
//         which is then applied to the whole list. This saves an incredible
//         amount of time.                              R.Cooper Nov 98.

#ifdef __CR_WIN__
void CxModList::OnHeaderClicked(NMHDR* pNMHDR, LRESULT* pResult)
{
        HD_NOTIFY *phdn = (HD_NOTIFY *) pNMHDR;

        if( phdn->iButton == 0 )
        {
                // User clicked on header using left mouse button
                if( phdn->iItem == nSortedCol )
                        bSortAscending = !bSortAscending;
                else
                        bSortAscending = true;

                nSortedCol = phdn->iItem;
                SortItems( m_colTypes[nSortedCol], nSortedCol, bSortAscending );

        }
        *pResult = 0;
}
#endif

// SortItems            - Sort the list based on column text
// Returns              - Returns true for success
// colType              - INT, REAL or TEXT. Makes sure correct sort is done.
// nCol                 - column that contains the text to be sorted
// bAscending           - indicate sort order
#ifdef __CR_WIN__
bool CxModList::SortItems( int colType, int nCol, bool bAscending)
{
    int nColCount = ((CHeaderCtrl*)GetDlgItem(0))->GetItemCount();
    if( nCol >= nColCount)
            return false;

    int size = GetItemCount();

    int *intsToSort = nil;
    float *floatsToSort = nil;
    CString *stringsToSort = nil;

    int* index = new int[size+1];

    switch ( colType )
    {
    case COL_INT:
        intsToSort = new int[size+1];
        break;
    case COL_REAL:
        floatsToSort = new float [size+1];
        break;
    case COL_TEXT:
        stringsToSort = new CString[size+1];
        break;
    }

    index[0] = 0;
    for ( int i = 0; i < size; i++ )
    {
        index[i+1] = i+1;
        CString s = GetItemText(i, nCol);
        switch ( colType )
        {
        case COL_INT:
            intsToSort[i+1] = atoi(s);
            break;
        case COL_REAL:
            floatsToSort[i+1] = (float)atof(s);
            break;
        case COL_TEXT:
            stringsToSort[i+1] = s;
            break;
        }
    }

// Sort the items along with the index. This is a straight insertion sort
// so that previous sorts remain in effect for a given value of this sort.
    for ( int element = 2; element <= size; element++)
    {
        switch ( colType )
        {
        case COL_INT:
            intsToSort[0] = intsToSort[element];
            break;
        case COL_REAL:
            floatsToSort[0] = floatsToSort[element];
            break;
        case COL_TEXT:
            stringsToSort[0] = stringsToSort[element];
            break;
        }
        int hold = index[element];
        int IDhold = IDlist[element-1];
        bool repeat = true;
        int place;
        for ( place = element - 1; repeat; place-- )
        {
            if (place > 0)
            {
                switch ( colType )
                {
                case COL_INT:
                    if(    (  bAscending && (intsToSort[place] <= intsToSort[0]))
                        || ( !bAscending && (intsToSort[place] >= intsToSort[0])) )
                    {
                        repeat              = false;
                        index[place+1]      = hold;
                        IDlist[place]       = IDhold;
                        intsToSort[place+1] = intsToSort[0];
                    }
                    else
                    {
                        index[place+1]      = index[place];
                        IDlist[place]      = IDlist[place-1];
                        intsToSort[place+1] = intsToSort[place];
                    }
                    break;
                case COL_REAL:
                    if(    (  bAscending && (floatsToSort[place] <= floatsToSort[0]))
                        || ( !bAscending && (floatsToSort[place] >= floatsToSort[0])) )
                    {
                        repeat                = false;
                        index[place+1]        = hold;
                        IDlist[place]       = IDhold;
                        floatsToSort[place+1] = floatsToSort[0];
                    }
                    else
                    {
                        index[place+1]        = index[place];
                        IDlist[place]      = IDlist[place-1];
                        floatsToSort[place+1] = floatsToSort[place];
                    }
                    break;
                case COL_TEXT:
                    if(    (  bAscending && (stringsToSort[place] <= stringsToSort[0]))
                        || ( !bAscending && (stringsToSort[place] >= stringsToSort[0])) )
                    {
                        repeat                 = false;
                        index[place+1]         = hold;
                        IDlist[place]       = IDhold;
                        stringsToSort[place+1] = stringsToSort[0];
                    }
                    else
                    {
                        index[place+1]         = index[place];
                        IDlist[place]      = IDlist[place-1];
                        stringsToSort[place+1] = stringsToSort[place];
                    }
                    break;
                }
            }
            else
            {
                switch ( colType )
                {
                case COL_INT:
                    intsToSort[1] = intsToSort[0];
                    break;
                case COL_REAL:
                    floatsToSort[1] = floatsToSort[0];
                    break;
                case COL_TEXT:
                    stringsToSort[1] = stringsToSort[0];
                    break;
                }
                index[1] = hold;
                IDlist[0]      = IDhold;
                repeat = false;
            }
        }
    }

//The array should be in the right order now, if errors are occuring they are
//probably from the next section which sorts the original list into the same order.

//  int ic;
    LV_ITEM insertItem;
    LV_ITEM moveItem;
    CStringArray rowText;
    rowText.SetSize( nColCount );

    bool *sorted = new bool[size+1];
    for (i = 0; i <= size; i++)
        sorted[i] = false;

    for ( int j = 1; j <= size; j++)
    {

        if ( sorted[j] == false )
        {
            int newPoint = j;
            for( i=0; i<nColCount; i++)
                rowText[i] = GetItemText(newPoint - 1, i);

            insertItem.mask = LVIF_IMAGE | LVIF_PARAM | LVIF_STATE;
            insertItem.iItem = newPoint - 1;
            insertItem.iSubItem = 0;
            insertItem.stateMask =  LVIS_CUT | LVIS_DROPHILITED |
                                    LVIS_FOCUSED |  LVIS_SELECTED |
                                    LVIS_OVERLAYMASK | LVIS_STATEIMAGEMASK;
            GetItem( &insertItem );
//          TRACE("Storing item at %d \n",newPoint);

            sorted[newPoint] = true;

            while ( index[newPoint] != j )
            {
                moveItem.mask = LVIF_IMAGE | LVIF_PARAM | LVIF_STATE;
                moveItem.iItem = index[newPoint] - 1;
                moveItem.iSubItem = 0;
                moveItem.stateMask = LVIS_CUT | LVIS_DROPHILITED |
                                    LVIS_FOCUSED |  LVIS_SELECTED |
                                    LVIS_OVERLAYMASK | LVIS_STATEIMAGEMASK;
                GetItem( &moveItem );
                moveItem.iItem = newPoint - 1;
                m_ProgSelecting = 2;
                SetItem( &moveItem );
                m_ProgSelecting = 0;


//              TRACE("Moving item from %d to %d \n",index[newPoint],newPoint);
                for( i=0; i<nColCount; i++)
                    SetItemText(newPoint-1, i, GetItemText(index[newPoint]-1, i));

                newPoint = index[newPoint];
                sorted[newPoint] = true;
            }

//          TRACE("Moving stored item ( from %d ) to %d \n",j,newPoint);
            for( i=0; i<nColCount; i++)
                SetItemText( newPoint - 1, i, rowText[i]);
            insertItem.iItem = newPoint - 1;
            m_ProgSelecting = 2;
            SetItem( &insertItem );
            m_ProgSelecting = 0;
        }                     
    }
    delete [] index;
    delete [] intsToSort;
    delete [] floatsToSort;
    delete [] stringsToSort;
    delete [] sorted;

    return true;

}
#endif





//Work out whether a string is REAL, INT or TEXT.

int CxModList::WhichType(CcString text)
{
    int i;
//Test one: Any characters other than space, number or point.
    for (i = 0; i < text.Length(); i++)
    {
        if (   text[i] != ' '
            && text[i] != '1'
            && text[i] != '2'
            && text[i] != '3'
            && text[i] != '4'
            && text[i] != '5'
            && text[i] != '6'
            && text[i] != '7'
            && text[i] != '8'
            && text[i] != '9'
            && text[i] != '0'
            && text[i] != '-'
            && text[i] != '.' ) return COL_TEXT;
    }

//Test two: One token only.
//Test two(b): Minus sign in correct place if present.
    bool inLeadingSpace = true;
    bool inFinalSpace = false;
    for (i = 0; i < text.Length(); i++)
    {
        if(inLeadingSpace)
        {
            if ( text[i] != ' ' )
            {
                inLeadingSpace = false;
            }
        }
        else
        {
            if ( text[i] == ' ' )
            {
                inFinalSpace = true;
            }
            if ( text[i] == '-' )
            {
                return COL_TEXT; //if we're not in leading space, or first char, there should be no minus sign.
            }
        }

        if(inFinalSpace)
        {
            if ( text[i] != ' ' )
            {
                return COL_TEXT;
            }
        }
    }



//Test three: One point symbol in the text.
    bool pointFound = false;
    for (i = 0; i < text.Length(); i++)
    {
        if ( text[i] == '.' )
        {
            if(pointFound)
            {
                return COL_TEXT;
            }
            else
            {
                pointFound = true;
            }
        }
    }

    if(pointFound)
    {
        return COL_REAL;
    }
    else
    {
        return COL_INT;
    }

}


#ifdef __CR_WIN__
void CxModList::SelectAll(bool select)
{
    int size = GetItemCount();
    m_ProgSelecting = size;
    LV_ITEM moveItem;

    for ( int i = 0; i < size; i++ )
    {
        moveItem.mask = LVIF_IMAGE | LVIF_PARAM | LVIF_STATE;
        moveItem.iItem = i;
        moveItem.iSubItem = 0;
        moveItem.stateMask = LVIS_CUT | LVIS_DROPHILITED |
                            LVIS_FOCUSED |  LVIS_SELECTED |
                            LVIS_OVERLAYMASK | LVIS_STATEIMAGEMASK;
        GetItem( &moveItem );
        if(select)
            moveItem.state |= LVIS_SELECTED;
        else
            moveItem.state &= (~LVIS_SELECTED);
        SetItem( &moveItem );
    }

}
#endif

#ifdef __CR_WIN__
CcString CxModList::GetCell(int row, int col)
{
    CString temp = GetItemText(row, col);
    CcString retVal = temp.GetBuffer(temp.GetLength());
    return retVal;
}
#endif
#ifdef __BOTHWX__
CcString CxModList::GetCell(int row, int col)
{
 return CcString("Unimplemented");
}
#endif

#ifdef __CR_WIN__
void CxModList::SelectPattern(CcString * strings, bool select)
{
    int size = GetItemCount();
    bool match = true;
    for ( int i = 0; i < size; i++ )
    {
        match = true;
        for ( int j = 0; ( ( j < m_numcols ) && match ); j++ )
        {
            if (  ! ( strings[j] == "*" ) )
            {
                switch ( m_colTypes[j] )
                {
                case COL_INT:
                    if ( strings[j].Sub(1,1) == ">" )
                    {
                        if( atoi(strings[j].Sub(2,-1).ToCString()) >= atoi(GetCell(i,j).ToCString()) )
                            match = false;
                    }
                    else if ( strings[j].Sub(1,1) == "<" )
                    {
                        if( atoi(strings[j].Sub(2,-1).ToCString()) <= atoi(GetCell(i,j).ToCString()) )
                            match = false;
                    }
                    else
                    {
                        if( atoi(strings[j].ToCString()) != atoi(GetCell(i,j).ToCString()) )
                            match = false;
                    }
                    break;
                case COL_REAL:
                    if ( strings[j].Sub(1,1) == ">" )
                    {
                        if( atof(strings[j].Sub(2,-1).ToCString()) >= atof(GetCell(i,j).ToCString()) )
                            match = false;
                    }
                    else if ( strings[j].Sub(1,1) == "<" )
                    {
                        if( atof(strings[j].Sub(2,-1).ToCString()) <= atof(GetCell(i,j).ToCString()) )
                            match = false;
                    }
                    else
                    {
                        if( atof(strings[j].ToCString()) != atof(GetCell(i,j).ToCString()) )
                            match = false;
                    }
                    break;
                case COL_TEXT:
                    if( ! ( strings[j] == GetCell(i,j) ) ) match = false;
                    break;
                }
            }
        }
        if (match)
        {
            m_ProgSelecting++;
            LV_ITEM setItem;
            setItem.mask = LVIF_IMAGE | LVIF_PARAM | LVIF_STATE;
            setItem.iItem = i;
            setItem.iSubItem = 0;
            setItem.stateMask = LVIS_CUT | LVIS_DROPHILITED |
                                LVIS_FOCUSED |  LVIS_SELECTED |
                                LVIS_OVERLAYMASK | LVIS_STATEIMAGEMASK;
            GetItem( &setItem );
            if(select)
                setItem.state |= LVIS_SELECTED;
            else
                setItem.state &= (~LVIS_SELECTED);
            SetItem( &setItem );
        }
    }
}
#endif

#ifdef __BOTHWX__
CcString CxModList::GetListItem(int item)
{
 return CcString("unimplemented");
}
#endif

#ifdef __CR_WIN__
CcString CxModList::GetListItem(int item)
{
    int nColCount = ((CHeaderCtrl*)GetDlgItem(0))->GetItemCount();
    CString textresult = "";

    for( int i=0; i<nColCount; i++)
        textresult += GetItemText(item, i) + " ";

    CcString result = textresult.GetBuffer(textresult.GetLength());
    return result;
}
#endif

#ifdef __CR_WIN__
void    CxModList::InvertSelection()
{
    int size = GetItemCount();
    m_ProgSelecting = size;
    LV_ITEM moveItem;

    for ( int i = 0; i < size; i++ )
    {
        moveItem.mask = LVIF_IMAGE | LVIF_PARAM | LVIF_STATE;
        moveItem.iItem = i;
        moveItem.iSubItem = 0;
        moveItem.stateMask = LVIS_CUT | LVIS_DROPHILITED |
                            LVIS_FOCUSED |  LVIS_SELECTED |
                            LVIS_OVERLAYMASK | LVIS_STATEIMAGEMASK;
        GetItem( &moveItem );

        bool select = (( moveItem.state & LVIS_SELECTED ) != 0);

        if(select)
            moveItem.state &= (~LVIS_SELECTED);
        else
            moveItem.state |= LVIS_SELECTED;
        SetItem( &moveItem );
    }

}
#endif


#ifdef __BOTHWX__
int CxModList::GetNumberSelected()
{
  return -1;
}
#endif

#ifdef __CR_WIN__
int CxModList::GetNumberSelected()
{
    int size = GetItemCount();
    LV_ITEM moveItem;
    int count = 0;

    for ( int i = 0; i < size; i++ )
    {
        moveItem.mask = LVIF_IMAGE | LVIF_PARAM | LVIF_STATE;
        moveItem.iItem = i;
        moveItem.iSubItem = 0;
        moveItem.stateMask = LVIS_CUT | LVIS_DROPHILITED |
                            LVIS_FOCUSED |  LVIS_SELECTED |
                            LVIS_OVERLAYMASK | LVIS_STATEIMAGEMASK;
        GetItem( &moveItem );
        if (( moveItem.state & LVIS_SELECTED ) != 0) count++;

    }
    return count;
}
#endif

#ifdef __BOTHWX__
void CxModList::GetSelectedIndices(  int * values )
{
  return;
}
#endif
#ifdef __CR_WIN__
void CxModList::GetSelectedIndices(  int * values )
{
    int size = GetItemCount();
    int count = 0;
    LV_ITEM moveItem;

    for ( int i = 0; i < size; i++ )
    {
        moveItem.mask = LVIF_IMAGE | LVIF_PARAM | LVIF_STATE;
        moveItem.iItem = i;
        moveItem.iSubItem = 0;
        moveItem.stateMask = LVIS_CUT | LVIS_DROPHILITED |
                            LVIS_FOCUSED |  LVIS_SELECTED |
                            LVIS_OVERLAYMASK | LVIS_STATEIMAGEMASK;
        GetItem( &moveItem );
        if (( moveItem.state & LVIS_SELECTED ) != 0)
        {
            values[count] = i;
            count ++;
        }
    }
    return;
}
#endif

void CxModList::Update(int newsize) 
{
//  TEXTOUT ( "Model " + CcString((int)this) + "changed" );
// Fetch new atom info from ModelDoc.

       if (newsize != mItems)
       {
          DeleteAllItems();
          mItems = 0;
          delete [] IDlist;
          m_IDlist_size = 0;
          IDlist =  nil;
       }

//       m_listboxparent->LockWindowUpdate();

#ifdef __CR_WIN__
       SetRedraw(FALSE);
//       SendMessage(WM_SETREDRAW,FALSE,0);
       ((CrModList*)ptr_to_crObject)->DocToList();
       SetRedraw(TRUE);
//       SendMessage(WM_SETREDRAW,TRUE,0);
       Invalidate(FALSE);
#endif
#ifdef __BOTHWX__
//       SendMessage((HWND)GetHWND(),WM_SETREDRAW,FALSE,0);
       ((CrModList*)ptr_to_crObject)->DocToList();
//       SendMessage((HWND)GetHWND(),WM_SETREDRAW,TRUE,0);
       Refresh();
#endif

}


#ifdef __CR_WIN__
void CxModList::RightClick( NMHDR * pNMHDR, LRESULT* pResult )
{
 NMITEMACTIVATE* lpnmitem = (LPNMITEMACTIVATE) pNMHDR;

// TEXTOUT("Right click! "+CcString(lpnmitem->iItem));

 int iitem = lpnmitem->iItem;

 CPoint p = lpnmitem->ptAction;
 ClientToScreen(&p); // change the coordinates of the click from window to screen coords so that the menu appears in the right place

 int px = p.x;
 int py = p.y;

 if ( iitem >= 0 )
 {
   LV_ITEM lvi;
   lvi.mask = LVIF_IMAGE | LVIF_STATE;
   lvi.iItem = lpnmitem->iItem;
   lvi.iSubItem = 0;
   lvi.stateMask = 0xFFFF;         // get all state flags
   GetItem(&lvi);
// Is item highlighted?
   bool bHighlight = (lvi.state & LVIS_SELECTED) != 0;

   int id = IDlist[iitem]-1;


   if ( bHighlight )
   {
//item is selected, but only one: show SINGLE menu.
//item is selected, more than one: show GROUP menu. Let Cr decide.
    ((CrModList*)ptr_to_crObject)->ContextMenu(px, py, id, 2);
   }
   else
   {
//item is not selected: show SINGLE menu.
    ((CrModList*)ptr_to_crObject)->ContextMenu(px, py, id, 3);
   }
  }
  else
  {
//Click missed all items: show NONE menu.
    ((CrModList*)ptr_to_crObject)->ContextMenu(px, py, -1, 1);
  }
 *pResult = 1;

}
#endif


#ifdef __CR_WIN__
void CxModList::OnMenuSelected(UINT nID)
{
    ((CrModList*)ptr_to_crObject)->MenuSelected( nID );
}
#endif

void CxModList::CxEnsureVisible(CcModelAtom* va)
{
//Find atom id in list
       int id;
       for ( id = 0; id < mItems; id++ )
       {
          if ( IDlist[id] == va->id ) break;
       }
       EnsureVisible(id,false); //Call library function to ensure it is shown.
}

