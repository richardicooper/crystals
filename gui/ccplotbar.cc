////////////////////////////////////////////////////////////////////////
//   CRYSTALS Interface      Class CcPlotBar
////////////////////////////////////////////////////////////////////////

//   Filename:  CcPlotBar.cc
//   Authors:   Richard Cooper and Steve Humphreys
//   Created:   10.11.2001 10:28

// $Log: not supported by cvs2svn $
// Revision 1.4  2001/11/13 13:54:30  ckp2
// Catch fontsize spiralling infinitely downwards...
//
// Revision 1.3  2001/11/13 10:54:27  ckpgroup
// SH: Log Axis Scaling fixed.
//
// Revision 1.2  2001/11/12 16:24:28  ckpgroup
// SH: Graphical agreement analysis
//
// Revision 1.1  2001/10/10 12:44:49  ckp2
// The PLOT classes!
//
//

#include	<math.h>
#include    "crystalsinterface.h"
#include    "crconstants.h"
#include    "ccplotdata.h"
#include    "ccplotbar.h"
#include    "crplot.h"
#include    "cctokenlist.h"
#include    "cccontroller.h"
#include	"ccpoint.h"

#ifdef __BOTHWX__
#include <wx/thread.h>
#endif

// set the graph type
CcPlotBar::CcPlotBar( )
{
	m_Axes.m_GraphType = Plot_GraphBar;
}

CcPlotBar::~CcPlotBar()
{
}


// parse input destined for bar-graphs
Boolean CcPlotBar::ParseInput( CcTokenList * tokenList )
{
	// first see if the command is for the parent class
    CcPlotData::ParseInput( tokenList );

    Boolean hasTokenForMe = true;
    while ( hasTokenForMe )
    {
        switch ( tokenList->GetDescriptor(kPlotClass) )
        {
			// a bar-graph label
			case kTPlotLabel:
			{
				tokenList->GetToken();	// 'LABEL'
				
				// next is the label for the nth data item
				CcString nlabel = tokenList->GetToken();

				// check there is enough space for this string
				if(m_NextItem >= m_SeriesLength)
				{
					LOGWARN("Series length needs extending: reallocating memory");

					// check m_SeriesLength is non-zero
					if(m_SeriesLength == 0) m_SeriesLength = 10;

					// allocate new memory 
					CcString* templabels = new CcString[m_SeriesLength * 1.5];
					float *   tempdata = 0;
					
					// loop through the previous set of bar-labels, copying data to the new one
					for(int j=0; j<m_SeriesLength; j++)		
					{
						templabels[j] = m_Axes.m_Labels[j].ToCString();
					}

					// free the previously allocated memory, point to the new area
					delete [] m_Axes.m_Labels;					
					m_Axes.m_Labels = templabels;

					// loop through the series, copy data to newly allocated memory
					for(int i=0; i< m_NumberOfSeries; i++)
					{
						tempdata = new float[m_SeriesLength * 1.5];

						for(j=0; j<m_SeriesLength; j++)
						{
							tempdata[j] = ((CcSeriesBar*)m_Series[i])->m_Data[j];
						}

						// delete the previous memory area, point to the new one.
						delete ((CcSeriesBar*)m_Series[i])->m_Data;
						((CcSeriesBar*)m_Series[i])->m_Data = tempdata;
					}

				// the series has now been extended
				m_SeriesLength *= 1.5;
				}
				
				// copy this label to m_Label[n]
				m_Axes.m_Labels[m_NextItem] = nlabel.ToCString();

				break;
			}
			// a set of data items to match a previously-given label
			case kTPlotData:
			{
				// again ditch the DATA token
				tokenList->GetToken();

				// now record the data itself
				for(int i=0; i< (m_NumberOfSeries); i++)
				{
					CcString ndata = tokenList->GetToken();
					float tempdata = atof(ndata.ToCString());

					// changes axis range if necessary
					m_Axes.CheckData(Axis_Y, tempdata);			
				
					if(m_Axes.m_AxisLog[Axis_Y])
					{
						if(tempdata <= 0)
						{
							LOGWARN("Negative data passed to a LOG plot...");
						}
						else tempdata = log10(tempdata);
					}

					// and copy this to m_Series[i]->m_Data[n]
					((CcSeriesBar*)m_Series[i])->m_Data[m_NextItem] = tempdata;
				}

				m_NextItem++;		// make sure next label / data pair goes into the next slot
				
				// make sure the x axis knows how many items there are...
				if(m_NextItem > m_Axes.m_Max[Axis_X]) m_Axes.m_Max[Axis_X]++;

				break;
			}
            default:
            {
                hasTokenForMe = false;
                break; // We leave the token in the list and exit the loop
            }
        }
    }

    return true;
}

// draw all the bar-graph specific stuff
void CcPlotBar::DrawView()
{
    if(attachedPlot)
    {
		// setup variables for scaling / positioning of graphs
		int xgap = 260;		// horizontal gap between graph and edge of window
		int ygap = 400;		// and the vertical gap

		// variables used for loops
		int i=0;
		int j=0;

		// check the axis divisions have been calculated
		if(!m_AxesOK) m_AxesOK = m_Axes.CalculateDivisions();

		// gap between division markers on x and y axes
		int xdivoffset = (2400-2*xgap) / (m_Axes.m_NumDiv[Axis_X]);			
		int ydivoffset = (2400-2*ygap) / (m_Axes.m_NumDiv[Axis_Y]);			

		// axis dimensions after rounding
		int axisheight = ydivoffset * (m_Axes.m_NumDiv[Axis_Y]);
		int axiswidth = xdivoffset * (m_Axes.m_NumDiv[Axis_X]);
		
		// offset if more than one series
		int xseroffset = xdivoffset / m_NumberOfSeries;			

		// take the axis height, work out where zero is...
		int xorigin = 2400 - xgap + ((axiswidth * m_Axes.m_Min[Axis_X]) / (m_Axes.m_Max[Axis_X] - m_Axes.m_Min[Axis_X]));
		int yorigin = 2400 - ygap + (axisheight * (m_Axes.m_AxisMin[Axis_Y] / (m_Axes.m_AxisMax[Axis_Y] - m_Axes.m_AxisMin[Axis_Y])));

		//this is the value of y at the origin (may be non-zero for span-graphs)
		float yoriginvalue = 0;
		if(m_Axes.m_AxisScaleType == Plot_AxisSpan && m_Axes.m_AxisMin[Axis_Y] > 0) 
		{
			yorigin = 2400 - ygap;
			yoriginvalue = m_Axes.m_AxisDivisions[Axis_Y][0];
		}
		
		// draw a grey background
		attachedPlot->SetColour(200,200,200);
		attachedPlot->DrawRect(xgap, ygap, 2400-xgap, 2400-ygap, true);
		
		// now loop through the data items, drawing each one
		// if there are 'm_Next' data items, each will use 2200/m_Next as an offset
		// NB draw data bars FIRST, so axes / markers are always visible
		int offset = (2400-2*xgap) / m_NextItem;
		xseroffset = offset / m_NumberOfSeries;
		int x1,y1,x2,y2;

		// loop first through the series
		for(j=0; j<m_NumberOfSeries; j++)
		{
			// set to series colour
			attachedPlot->SetColour(m_Colour[0][j],m_Colour[1][j],m_Colour[2][j]);	

			// loop through the data members of this series
			for(i=0; i<m_NextItem; i++)
			{
				x1 = xgap + i*offset + j*xseroffset + 5;
				x2 = x1 + xseroffset - 5;
				y1 = yorigin;
				y2 = yorigin - (axisheight * ((((CcSeriesBar*)m_Series[j])->m_Data[i] - yoriginvalue) / (m_Axes.m_AxisMax[Axis_Y] - m_Axes.m_AxisMin[Axis_Y])));

				attachedPlot->DrawRect(x1,y1,x2,y2, true);
			}
		}

		// call the axis drawing code (draw on top of data bars)
		m_Axes.DrawAxes(attachedPlot);		

		// display all the above
		attachedPlot->Display();
    }
}

// create the data series
void CcPlotBar::CreateSeries(int numser, int* type)
{
	// create an array of pointers to data series
	m_Series = new CcSeries*[numser];
	m_NumberOfSeries = numser;

	// fill the array with bar-series
	for(int i=0; i<numser; i++)
	{
		switch(type[i])
		{
			default:
			{
				m_Series[i] = new CcSeriesBar();
				break;
			}
		}
	}
}

// allocate memory within each series
void CcPlotBar::AllocateMemory(int length)
{
	// an array of pointers to CcString text labels
	m_Axes.m_Labels = new CcString[length];
	for(int j=0; j<length; j++)
		m_Axes.m_Labels[j] = j;
	
	m_SeriesLength = length;
	m_NextItem = 0;

	// allocate the data memory space here
	for(int i=0; i<m_NumberOfSeries; i++)
	{
		m_Series[i]->AllocateMemory(length);
	}
}

////////////////////////////////////////////////////////////////////////////////////////////
//
//	The CcSeriesBar stuff
//
////////////////////////////////////////////////////////////////////////////////////////////

CcSeriesBar::CcSeriesBar()
{
	m_Data	 = 0;
}

// free up any allocated memory
CcSeriesBar::~CcSeriesBar()
{
	if(m_Data) delete [] m_Data;
	m_Data = 0;
}

// handle any messages (none used at present)
Boolean CcSeriesBar::ParseInput( CcTokenList * tokenList )
{
    CcSeries::ParseInput( tokenList );

    Boolean hasTokenForMe = true;
    while ( hasTokenForMe )
    {
        switch ( tokenList->GetDescriptor(kPlotClass) )
        {
            default:
            {
                hasTokenForMe = false;
                break; // We leave the token in the list and exit the loop
            }
        }
    }

    return true;
}

// allocate memory for this series
void CcSeriesBar::AllocateMemory(int length)
{
	m_Data = new float[length];
	for(int j=0; j<length; j++)
	{
		m_Data[j] = 0;
	}
}