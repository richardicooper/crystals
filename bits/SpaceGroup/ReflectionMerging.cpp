/*
 *  ReflectionMerging.cpp
 *  Space Groups
 *
 *  Created by Stefan on Wed Jul 16 2003.
 *  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
 *
 */

#include "ReflectionMerging.h"
#include "MathFunctions.h"
#include "Collections.h"
#include "UnitCell.h"
#include "RunParameters.h"
#if defined(_WIN32)
    #include "PCPort.h"
#endif
#include <math.h>
#include <float.h>
#include <iostream>
#include <iterator>

#define kGuessThreshHold 30
#define kRFactorAcceptValue 0.1

/*
 * returns whether the HKL pMat1 is greater then HKL pMat2
 * 
 */
inline bool greaterHKL(const Matrix<short>& pMat1, const Matrix<short>& pMat2)
{
    if (pMat1.getValue(2) > pMat2.getValue(2))
        return true;
    else if (pMat1.getValue(2) < pMat2.getValue(2))
        return false;
    else
    {
        if (pMat1.getValue(1) > pMat2.getValue(1))
            return true;
        else if (pMat1.getValue(1) < pMat2.getValue(1))
            return false;
        else
        {
            if (pMat1.getValue(0) > pMat2.getValue(0))
                return true;
            else
                return false;
        }
    }
    return false;
}

class LaueClassMatrices
{
    private:
        Array<MatrixReader*>* iMatrices;
    public:
        LaueClassMatrices();
        ~LaueClassMatrices();
        Matrix<short>* getMatrix(unsigned int pIndex) const;
};
/*
 * Creates a large array containing all the unique matrices.
 */
LaueClassMatrices::LaueClassMatrices():iMatrices(NULL)
{
    MatrixReader* tMatrices[39];
 
	tMatrices[0] = new MatrixReader("[-1 -1 0; 0 1 0; 0 0 1]");
	tMatrices[1] = new MatrixReader("[-1 0 0; 0 -1 0; 0 0 1]");
	tMatrices[2] = new MatrixReader("[-1 0 0; 0 0 1; 0 -1 0]");
	tMatrices[3] = new MatrixReader("[-1 0 0; 0 1 0; 0 0 -1]");
	tMatrices[4] = new MatrixReader("[-1 0 0; 0 1 0; 0 0 1]");
	tMatrices[5] = new MatrixReader("[0 1 0; -1 -1 0; 0 0 1]");
	tMatrices[6] = new MatrixReader("[-1 1 0; 1 0 0; 0 0 1]");
	tMatrices[7] = new MatrixReader("[-1 0 0; 1 1 0; 0 0 1]");
	tMatrices[8] = new MatrixReader("[0 -1 0; -1 0 0; 0 0 1]");
	tMatrices[9] = new MatrixReader("[0 -1 0; 0 0 1; -1 0 0]");
	tMatrices[10] = new MatrixReader("[-1 -1 0; 1 0 0; 0 0 1]");
	tMatrices[11] = new MatrixReader("[0 -1 0; 1 0 0; 0 0 -1]");
	tMatrices[12] = new MatrixReader("[0 -1 0; 1 0 0; 0 0 1]");
	tMatrices[13] = new MatrixReader("[0 0 -1; 0 1 0; -1 0 0]");
	tMatrices[14] = new MatrixReader("[0 0 -1; 1 0 0; 0 -1 0]");
	tMatrices[15] = new MatrixReader("[0 0 1; -1 0 0; 0 -1 0]");
	tMatrices[16] = new MatrixReader("[0 0 1; 0 -1 0; -1 0 0]");
	tMatrices[17] = new MatrixReader("[0 0 1; 0 1 0; -1 0 0]");
	tMatrices[18] = new MatrixReader("[0 0 1; 0 1 0; 1 0 0]");
	tMatrices[19] = new MatrixReader("[0 0 1; 1 0 0; 0 -1 0]");
	tMatrices[20] = new MatrixReader("[0 0 1; 1 0 0; 0 1 0]");
	tMatrices[21] = new MatrixReader("[0 1 0; -1 0 0; 0 0 -1]");
	tMatrices[22] = new MatrixReader("[0 1 0; -1 0 0; 0 0 1]");
	tMatrices[23] = new MatrixReader("[1 1 0; -1 0 0; 0 0 1]");
	tMatrices[24] = new MatrixReader("[0 1 0; 0 0 -1; -1 0 0]");
	tMatrices[25] = new MatrixReader("[0 1 0; 0 0 1; -1 0 0]");
	tMatrices[26] = new MatrixReader("[0 1 0; 0 0 1; 1 0 0]");
	tMatrices[27] = new MatrixReader("[0 1 0; 1 0 0; 0 0 -1]");
	tMatrices[28] = new MatrixReader("[0 1 0; 1 0 0; 0 0 1]");
	tMatrices[29] = new MatrixReader("[1 0 0; -1 -1 0; 0 0 1]");
	tMatrices[30] = new MatrixReader("[0 -1 0; 1 1 0; 0 0 1]");
	tMatrices[31] = new MatrixReader("[1 0 0; 0 -1 0; 0 0 -1]");
	tMatrices[32] = new MatrixReader("[1 0 0; 0 -1 0; 0 0 1]");
	tMatrices[33] = new MatrixReader("[1 0 0; 0 0 -1; 0 -1 0]");
	tMatrices[34] = new MatrixReader("[1 0 0; 0 0 1; 0 -1 0]");
	tMatrices[35] = new MatrixReader("[1 0 0; 0 0 1; 0 1 0]");
	tMatrices[36] = new MatrixReader("[1 0 0; 0 1 0; 0 0 -1]");
	tMatrices[37] = new MatrixReader("[1 0 0; 0 1 0; 0 0 1]");
	tMatrices[38] = new MatrixReader("[1 1 0; 0 -1 0; 0 0 1]");

    iMatrices = new Array<MatrixReader*>(tMatrices, 39);
}

Matrix<short>* LaueClassMatrices::getMatrix(unsigned int pIndex) const
{
    return (Matrix<short>*)((*iMatrices)[pIndex]);
}

LaueClassMatrices::~LaueClassMatrices()
{
    for (int i = 0; i < 39; i ++)
    {
        delete (*iMatrices)[i];
    }
    delete iMatrices;
}

char* gLaueGroup; //For outputing the current Laue Group when merging.

static LaueClassMatrices gLaueMatrices;
/*
 * the laue group of matrices
 */
class LaueGroups::LaueGroup:public MyObject
{
private:
    LaueGroups::systemID iCrystalSystem;
    Array<unsigned short>* iMatIndices;
    MergedData* iMergedData;
    char* iLaueGroup;
public:    
    LaueGroup(const LaueGroups::systemID pSys, const char* pLaueGroup, const unsigned short pIndices[], const int pNumMat):iCrystalSystem(pSys), iMergedData(NULL)
    {
        iMatIndices = new Array<unsigned short>(pIndices, pNumMat);
        iLaueGroup = new char[strlen(pLaueGroup)+1];
        strcpy(iLaueGroup, pLaueGroup);
    }
    
    
    ~LaueGroup()
    {
        if (iMergedData != NULL)
        {
            delete iMergedData;
            iMergedData = NULL;
        }
        delete iMatIndices;
        delete[] iLaueGroup;
    }
    
    LaueGroups::systemID getCrystalSystem() const
    {
        return iCrystalSystem;
    }
    
    Array<unsigned short>& getMatIndices() const
    {
       return *iMatIndices;
    }
    
    std::ostream& output(std::ostream& pStream) const
    {
        pStream.width(13);
        pStream << iLaueGroup;
        pStream << "  |";
        if (getRFactor() == -1)
        {
            pStream.width(13);
            return pStream << right << " - ";
        }
        pStream.width(13);
        pStream.precision(4);
        return pStream << (float)getRFactor() << "   " ;
    }
    
    float getRFactor() const
    {
        gLaueGroup = iLaueGroup;
        if (iMergedData)
            return iMergedData->getRFactor();
        return -1;
    }
  
    char* laueGroup()
    {
        return iLaueGroup;
    }
    
    void buildMergedData(const HKLData& pHKLs, const RunParameters& pRunPara)
    {        
       // const static short kMin[] = {SHRT_MIN, SHRT_MIN, SHRT_MIN}; 
        size_t tReflNum = pHKLs.length();
         Matrix<short> tCurHKL(1, 3);
         Matrix<short> tTempHKL(1, 3);
         Matrix<short> tZero(1, 3, 0);
        short tHLimit = 0;
        short tKLimit;
        short tLLimit;
        
        if (pRunPara.iUnitCell.getA() != 0)
        {
            tHLimit = (short)rint(pRunPara.iUnitCell.calcMaxIndex(10000, pRunPara.iUnitCell.getA()));
            tKLimit = (short)rint(pRunPara.iUnitCell.calcMaxIndex(10000, pRunPara.iUnitCell.getB()));
            tLLimit = (short)rint(pRunPara.iUnitCell.calcMaxIndex(10000, pRunPara.iUnitCell.getC()));
        }
        if (iMergedData != NULL)
        {
            delete iMergedData;
        }
        iMergedData = new MergedData(tReflNum);
        
        for (unsigned int j = 0; j < tReflNum; j++)
        {
            if (tHLimit > 0)    //If it is filtering
            {
                if (pHKLs.get(j)->tHKL->getValue(0) < tHLimit)
                {
                    if (pHKLs.get(j)->tHKL->getValue(1) < tKLimit)
                    {
                            if (pHKLs.get(j)->tHKL->getValue(2) > tKLimit)
                                continue;
                    }
                    else
                    {
                        continue;
                    }
                }
                else
                {   
                    continue;
                }
            }
            tCurHKL = (*pHKLs.get(j)->tHKL);   //Set current max hkl value
            for (size_t i = 0; i < iMatIndices->size(); i++) //Run through all the matrices.
            {
                (gLaueMatrices.getMatrix((*iMatIndices)[i]))->mul(*pHKLs.get(j)->tHKL, tTempHKL); //Multiply the hkl value with the current matrix
                
				for (int j = 0; j < 2; j++) //Do this twice
                {
                    if (greaterHKL(tTempHKL, tCurHKL)) //see if this new HKL value is greater then the last. This is just for consistancy could just as well be least hkl value or something.
                    {
                        tCurHKL = tTempHKL;
                    }
                    tZero.sub(tTempHKL, tTempHKL); //Invert the hkl value.
                }
            }
            iMergedData->add(tCurHKL, *pHKLs.get(j));
        }
    }
    
    float unitCellGuessRating(const RunParameters& pRunPara)const
    {
        Matrix<float> tMetricTensor(pRunPara.iUnitCell.metricTensor());
        Matrix<float> tDiff(3,3);
        Matrix<float> tOperator(3, 3);
        Matrix<float> tOperatorTranspose(3, 3);

        float tScalarDiff = 0;
        for (size_t i = 0; i < iMatIndices->size(); i++) //Run through all the matrices.
        {   
            tOperator = (*gLaueMatrices.getMatrix((*iMatIndices)[i])); //Get the current metrix operator.
            tOperatorTranspose = tOperator;
            tOperatorTranspose.transpose(); //Transpose the matrix
            tOperatorTranspose.mul(tMetricTensor, tDiff); //Multiply the metric tensor by the current transpose of the matrix
            tDiff.mul(tOperator, tOperatorTranspose); //Multiply the metric tensor by the current matrix
            
            tMetricTensor.sub(tOperatorTranspose, tDiff); 
            tScalarDiff = max(tDiff.abssum(), tScalarDiff);
        }
        return tScalarDiff;
    }
};

LaueGroups::LaueGroups()//:Array<LaueGroup*>(14)
{
    LaueGroup* tArray[14];
    const unsigned short tIndices[] = {37, //Triclinic
				       37, 31, //2/m 1 1
                                       37, 3, //1 2/m 1
                                       37, 1, //1 1 2/m
				       37, 4, 32, 1, //2/m 2/m 2/m
				       37, 11, 1, 22, //4/m
				       37, 12, 1, 4, 22, 28, 32, 8,//4/m m m
				       37, 10, 5, //-3
				       37, 10, 5, 7, 38, 8, //-3 m 1
				       37, 10, 5, 28, 29, 0, //  -3 1 m
				       37, 30, 10, 1, 6, 23, //6/m
				       37, 30, 10, 1, 5, 23, 7, 28, 38, 29, 8, 0, //6/m m m
				       37, 26, 20, 36, 25, 19, 24, 15, 14, 3, 9, 31,//m -3
				       37, 26, 20, 36, 25, 19, 24, 15, 14, 3, 9, 31, 28, 18, 35, 27, 17, 34, 13, 2, 33, 21, 16, 11};//m -3 m
    /* The laue groups should always bin in order of symmetry as other methods rely this order on this*/
    tArray[0] = new LaueGroup(kTriclinicID, "-1", tIndices, 1); //Triclinic
    tArray[1] = new LaueGroup(kMonoclinicAID, "2/m 1 1", &(tIndices[1]), 2); //2/m 1 1
    tArray[2] = new LaueGroup(kMonoclinicBID, "1 2/m 1", &(tIndices[3]), 2); //1 2/m 1
    tArray[3] = new LaueGroup(kMonoclinicCID, "1 1 2/m", &(tIndices[5]), 2); //1 1 2/m
    tArray[4] = new LaueGroup(kOrtharombicID, "2/m 2/m 2/m", &(tIndices[7]), 4); //2/m 2/m 2/m
    tArray[5] = new LaueGroup(kTetragonalID, "4/m", &(tIndices[11]), 3); //4/m
    tArray[6] = new LaueGroup(kTetragonalID, "4/m m m", &(tIndices[15]), 8); //4/m m m
    tArray[7] = new LaueGroup(kTrigonalID, "-3", &(tIndices[23]), 3); //-3
    tArray[8] = new LaueGroup(kTrigonalID, "-3 m 1", &(tIndices[26]), 6); //-3 m 1
    tArray[9] = new LaueGroup(kTrigonalID, "-3 1 m", &(tIndices[32]), 6); //  -3 1 m
    tArray[10] = new LaueGroup(kHexagonalID, "6/m", &(tIndices[38]), 6); //6/m
    tArray[11] = new LaueGroup(kHexagonalID, "6/m m m", &(tIndices[44]), 12); //6/m m m
    tArray[12] = new LaueGroup(kCubicID, "m -3", &(tIndices[56]), 12); //m -3
    tArray[13] = new LaueGroup(kCubicID, "m -3 m", &(tIndices[68]), 24); //m -3 m

    iGroups = new Array<LaueGroup*>(tArray, 14);
}

size_t LaueGroups::count()
{
    return iGroups->size();
}

Array<unsigned short>& LaueGroups::getGroupIndice(const SystemRef pSystemRef, const unsigned short pGroupNum) const
{
    return (*iGroups)[pSystemRef+pGroupNum]->getMatIndices();
}


LaueGroups::systemID LaueGroups::unitCellID2LaueGroupID(const UnitCell::systemID pID)
{
    switch (pID)
    {
        case UnitCell::kTriclinic:
            return LaueGroups::kTriclinicID;
        break;
        case UnitCell::kMonoclinicA:
            return LaueGroups::kMonoclinicBID;
        break;
        case UnitCell::kMonoclinicB:
            return LaueGroups::kMonoclinicBID;
        break;
        case UnitCell::kMonoclinicC:
            return kMonoclinicBID;
        break;
        case UnitCell::kOrtharombic:
            return LaueGroups::kOrtharombicID;
        break;
        case UnitCell::kTetragonal:
            return LaueGroups::kTetragonalID;
        break;
        case UnitCell::kTrigonal:
            return LaueGroups::kTrigonalID;
        break;
        case UnitCell::kTrigonalRhom:
            return kTrigonalID;
        break;
        case UnitCell::kHexagonal:
            return LaueGroups::kHexagonalID;
        break ;
        case UnitCell::kCubic:
            return LaueGroups::kCubicID;
        break;
    }
    return LaueGroups::kTriclinicID;
}

UnitCell::systemID LaueGroups::laueGroupID2UnitCellID(LaueGroups::systemID pID)
{
    switch (pID)
    {
        case LaueGroups::kTriclinicID:
            return UnitCell::kTriclinic;
        break;
        case LaueGroups::kMonoclinicAID:
            return UnitCell::kMonoclinicA;
        break;
        case LaueGroups::kMonoclinicBID:
            return UnitCell::kMonoclinicB;
        break;
        case LaueGroups::kMonoclinicCID:
            return UnitCell::kMonoclinicC;
        break;
        case LaueGroups::kOrtharombicID:
            return UnitCell::kOrtharombic;
        break;
        case LaueGroups::kTetragonalID:
            return UnitCell::kTetragonal;
        break;
        case LaueGroups::kTrigonalID:
            return UnitCell::kTrigonal;
        break;
        case LaueGroups::kHexagonalID:
            return UnitCell::kHexagonal;
        break ;
        case LaueGroups::kCubicID:
            return UnitCell::kCubic;
        break;
    };
    return UnitCell::kTriclinic;
}

LaueGroups::~LaueGroups()
{
    for (unsigned int i = 0; i < iGroups->size(); i++)
    {
	delete (*iGroups)[i];
    }
    delete iGroups;
}

bool LaueGroups::mergeForAll(const HKLData& pHKLs, const bool pThrowRefl, const RunParameters& pRunParam)const
{
    bool tMerged = false;
    
    for (size_t i = 0; i < iGroups->size(); i++)
    {
        if ((*iGroups)[i]->unitCellGuessRating(pRunParam) < kGuessThreshHold)
        {
            (*iGroups)[i]->buildMergedData(pHKLs, pRunParam);
			(*iGroups)[i]->getRFactor();
            if (!tMerged && (*iGroups)[i]->getRFactor() == 0)
            {
                tMerged = true;
                std::cout << "\n\tData already been merged at least for one laue group!\n\tWill merge for all the laue groups";
            }
        }
    }
    MergedData::releaseReflections();
    return tMerged;
}

LaueGroups::systemID LaueGroups::guessSystem(const HKLData& pHKLs, const RunParameters& pRunParam)
{
    size_t tBest = 0;
    float tLowestRF = FLT_MAX;
    float tHighestRF = FLT_MIN;
    float tRFactor;
    bool tMergedAlready = LaueGroups::mergeForAll(pHKLs, true, pRunParam);
    
	if (tMergedAlready)
	{
		for (size_t i = 1; i < iGroups->size(); i++)
		{
			tRFactor = (*iGroups)[i]->getRFactor();
			if (tRFactor > 0)
			{
				tHighestRF = max(tHighestRF, tRFactor);
				tLowestRF = min(tLowestRF, tRFactor);
			}
		}
		if (tHighestRF/tLowestRF < 7)
		{
			tLowestRF = 0;
		}
	}
	else
		tLowestRF = (*iGroups)[0]->getRFactor(); //Triclinic will have the smallest RFactor if it hasn't been merged
    for (size_t i = 1; i < iGroups->size(); i++)
    {
        tRFactor = (*iGroups)[i]->getRFactor();
        if (tRFactor >= 0)
        {
            if (tRFactor == 0 || tRFactor/tLowestRF < 10) //If the R-Factor is not equal to 0
            {
                tBest = i;
            }
        }
    }
    return (*iGroups)[tBest]->getCrystalSystem();
}

SystemRef LaueGroups::getSystemRef(unsigned short* pNumGroup, const LaueGroups::systemID pSystem) const
{
    unsigned short i = 0;
    unsigned short tResult;

    (*pNumGroup) = 0;
    while (i < iGroups->size() && (*iGroups)[i]->getCrystalSystem() != pSystem)
    {i++;}
    tResult = i;
    while (i < iGroups->size() && (*iGroups)[i]->getCrystalSystem()==pSystem)
    {(*pNumGroup)++; i++;};
    if ((*pNumGroup) > 0)
    {
	return tResult;
    }
    return 0;
}

LaueGroups::systemID LaueGroups::getCrystalSystemFor(const SystemRef pSystemRef)
{
    return (*iGroups)[pSystemRef]->getCrystalSystem();
}

void LaueGroups::mergeSystemGroup(const HKLData& pHKLData, const SystemRef pSystemRef, const unsigned short pGroupID, const RunParameters& pRunPara)
{
    (*iGroups)[pSystemRef+pGroupID]->buildMergedData(pHKLData, pRunPara);
}

std::ostream& LaueGroups::output(std::ostream& pStream)
{
    pStream.width(15);
	std::cout << "  Laue Group   |    R-Factor   \n";
    for (size_t i = 0; i < iGroups->size(); i++)
    {
        if ((*iGroups)[i]->getRFactor() >= 0)
        {
            (*iGroups)[i]->output(pStream) << "\n";
        }
    }
    return pStream;
}

/*
 * Calculates the sum of the abs differences in an array of floats.
 */
float sumdiff(Array<float>& pValues, float pMean)
{
    float tTotal = 0;
    
    for (size_t i = 0; i < pValues.size(); i++)
    {
        tTotal += fabsf(pMean - pValues[i]);
    }
    return tTotal;
}

//static multiset<Reflection*, lsreflection>* gSortedReflections = NULL;
static size_t gNumRefl = 0;
static Reflection* gReflections = NULL;

MergedData::MergedData(const size_t pNumRefl):iUpto(0), iRFactor(-1)
{
    if (gNumRefl < pNumRefl)
    {
        gNumRefl = pNumRefl;
        if (gReflections != NULL)
        {
            delete[] gReflections;
            gReflections = NULL;
        }
    }
    if (gReflections == NULL)
    {
        gReflections = new Reflection[gNumRefl];
    }
/*    if (gSortedReflections == NULL)
    {
        gSortedReflections = new multiset<Reflection*, lsreflection>();
    }
    gSortedReflections->clear();*/
}

MergedData::~MergedData()
{
	
}

void MergedData::add(const Matrix<short>& pHKL, const Reflection& pRefl)
{
    gReflections[iUpto].setHKL(pHKL);
    gReflections[iUpto].i = pRefl.i;
    gReflections[iUpto].iSE = pRefl.iSE;
	iUpto ++;
    //gSortedReflections->insert(&(gReflections[iUpto++]));
}

void MergedData::releaseReflections()
{
    if (gReflections != NULL)
    {
        delete[] gReflections; //Release all the global reflections used.
        gReflections = NULL;    //Make sure that we know that this is need.
      //  gSortedReflections->clear(); //Clear all the reflections which where in the sorted list because they no longer exist
        //delete gSortedReflections;  //Release the memory
        //gSortedReflections = NULL; 
    }
}

float MergedData::calculateRFactor()
{
	static Matrix<short>* tCurHKL;
        static Array<float> tValues(23);                //I don't think that this should need to be any greater then 23 elements long.
        tValues.clear();                                //Clear the values from the last time they were used.
       // multiset<Reflection*, lsreflection>::iterator tIter = gSortedReflections->begin(); //Start at the first 
        register float tSumSum = 0;                              //Make sure that every thing is set to 0
        register float tMeanDiffSum = 0;
        register float tSum = 0;
        
		unsigned int i = 0;
		
        int tNumMerged = 0, tNumResRef=0;
        cout << gLaueGroup << "\n";
        tCurHKL = (*(gSortedReflections->begin()))->tHKL; //Save the pointer to the current hkl value
        while (tIter != gSortedReflections->end()) //Run through all the reflections
        {
            if (  !((*(*tIter)->tHKL) == (*tCurHKL))) //If the HKL value has changed then 
			{
				if (tValues.size()>1) //As long as there are more then one reflection
				{
							tNumMerged += tValues.size();
							
					tSum = fabsf(sum(tValues.getPointer(), tValues.size()));
					tSumSum += tSum;
								
					tMeanDiffSum += sumdiff(tValues, tSum/tValues.size());
				}
				tCurHKL = (*tIter)->tHKL; //Save the next hkl value
				tValues.clear();   //Remove all the old intensities
				tNumResRef  ++;
			}
            tValues.add((*tIter)->i);  //Save the intensity
            tIter++; //Move on to the next reflection in the list.
        }
        if (tSumSum == 0)
            iRFactor = 0;
        else
            iRFactor = tMeanDiffSum/tSumSum; //In the desciption this is multiplied by
	//But as these values are for comparison there isn't much point
	cout << iRFactor << "\n";
        return iRFactor;
}

std::ostream& MergedData::output(std::ostream& pStream) const
{
    return pStream << "R-Factor: " << iRFactor;
}

std::ostream& operator<<(std::ostream& pStream, const MergedData& tData)
{
    return tData.output(pStream);
}

std::ostream& operator<<(std::ostream& pStream, LaueGroups& tData)
{
    return tData.output(pStream);
}