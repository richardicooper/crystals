/*
 *  CrystalSystem.cpp
 *  Space Groups
 *
 *  Created by Stefan Pantos on Thu Dec 05 2002.
 *  Copyright (c) 2002 __MyCompanyName__. All rights reserved.
 *
 */
 
/*** Naming conventions ***
 ** Variable/Constant **
 * These conventions should be followed as closely as possible when coding in the file.
 * All variable names should start with one of the following lower case letters.
 * t - variables which are declared locally to the method/function
 * i - variables which are members of the object.
 * g - variables which are global to the file.
 * p - variables which are parameters to a method/function.
 * k - constants
 *
 * All variables should be have descriptive names which. Should use capitalization in 
 * variable names.
 *
 * e.g.. 
 * double tSomeVariable;   //A variable which is declared inside method.
 * double pSomeParameter   //A variable which is a parameter to a method/function
 *
 ** Classes/Structures/Typedefs **
 * All these should have the first letter as a capital and the first letter of any word 
 * in the name should be a capital letter. All other letters should be lower case.
 * 
 * e.g.
 * class MyClass
 * {
 * 	function name	
 * };
 */
//#include "stdafx.h"
#include "CrystalSystem.h"
#if defined(_WIN32)
#include <Boost/regex.h>
#else
#include <regex.h>
#endif
#include <fstream>

#include "StringClasses.h"
#include "MathFunctions.h"
#include "Exceptions.h"
#include <iomanip>
#include "Stats.h"
#include <fcntl.h>
#include <errno.h>
#include <iterator>

using namespace std;

static regex_t* iHeaderRE  =NULL;
static regex_t* iFirstNumRE  =NULL;
static regex_t* iFirstNSpRE  =NULL;
static regex_t* iTableRE  =NULL;
static regex_t* iTableArgsRE =NULL;

void initCrysRegEx()
{
    if (iHeaderRE == NULL)
    {
        char tHeaderRE[] = "^([[:digit:]]+)\t([hkl0-]{3}[hkl0-]?)\t(\\[[0123456789;. -]+\\])[[:space:]]*$";
            //Checks the format of the header line.
        char tFirstNumRE[] = "([[:digit:]]),?[[:space:]]?"; 
            //Takes the first number of a , delimited list of numbers.
        char tFirstNSpRE[] = "([^\t]+)(\t([^\t].+))?";	
            //Takes the first non-space part of the heading line and returns the point of it in $1
        char tTableRE[] = "([^\t]+)(\t[^\t].*)?";
            //Gets the first non-tab part of the line and returns its placing in $1.
        char tTableArgsRE[] = "([^\t]+)\t([[:digit:]]+), ([[:digit:]]+)";
            //The header line of the table. This contains the name of the system and the number of condition columns and the number of point group columns.
        iHeaderRE  = new regex_t;
        
        iFirstNumRE  = new regex_t;
        iFirstNSpRE  = new regex_t;
        iTableRE  = new regex_t;
        iTableArgsRE = new regex_t;
        regcomp(iHeaderRE, tHeaderRE, REG_EXTENDED);
        regcomp(iFirstNumRE, tFirstNumRE, REG_EXTENDED);
        regcomp(iFirstNSpRE, tFirstNSpRE, REG_EXTENDED);
        regcomp(iTableRE, tTableRE, REG_EXTENDED);
        regcomp(iTableArgsRE, tTableArgsRE, REG_EXTENDED);
    }
}

void deinitRE()
{
    if (iHeaderRE != NULL)
    {
        delete iHeaderRE;
        delete iFirstNumRE;
        delete iFirstNSpRE;
        delete iTableRE;
        delete iTableArgsRE;
        iHeaderRE = NULL;
        iFirstNumRE = NULL;
        iFirstNSpRE = NULL;
        iTableRE = NULL;
        iTableArgsRE = NULL;
    }
}

Region::Region(char* pLine):Matrix<short>(3, 3)
{
    const size_t tMatches = 4;
    regmatch_t tMatch[tMatches];
    
    bzero(tMatch, sizeof(regmatch_t)*tMatches);
    if (regexec(iHeaderRE, pLine, tMatches, tMatch, 0))
    {
        throw MyException(kUnknownException, "Region had an invalid format!");
    }
    iName = new char[(int)(tMatch[2].rm_eo - tMatch[2].rm_so +1)];
    iName[(int)(tMatch[2].rm_eo - tMatch[2].rm_so)] = 0;
    strncpy(iName, tMatch[2].rm_so+pLine, (int)tMatch[2].rm_eo - tMatch[2].rm_so);
    char* tTempString = new char[(int)(tMatch[1].rm_eo - tMatch[1].rm_so +1)];
    strncpy(tTempString, (int)tMatch[1].rm_so+pLine, tMatch[1].rm_eo - tMatch[1].rm_so);
    tTempString[(int)(tMatch[1].rm_eo - tMatch[1].rm_so)] = 0;
    iID = strtol(tTempString, NULL, 10);
    delete[] tTempString;
    tTempString = new char[(int)(tMatch[3].rm_eo - tMatch[3].rm_so +1)];
    strncpy(tTempString, (int)tMatch[3].rm_so+pLine, (int)tMatch[3].rm_eo - tMatch[3].rm_so);
    tTempString[(int)(tMatch[3].rm_eo - tMatch[3].rm_so)] = 0;
    MatrixReader tMatrix(tTempString);
    (*(Matrix<short>*)this) = tMatrix;
    delete[] tTempString;
}

Region::~Region()
{
    delete[] iName;
}


char* Region::getName()
{
    return iName;
}

int Region::getID()
{
    return iID;
}

bool Region::contains(Matrix<short> &pHKL, LaueGroup &pLaueGroup, Matrix<short>& pResultMatrix)
{
	Matrix<short> tMatrixResult;
	Matrix<short> tNewHKLResult;
	Matrix<short> tWorkHKL(pHKL);
	Matrix<short> tZero(1, 3, 0);
	
	uint tNumMat = pLaueGroup.numberOfMatrices();
	
	for (int i = 0; i < 2; i++)
	{
		for (uint i = 0; i < tNumMat; i++)
		{ 
			tNewHKLResult = pLaueGroup.getMatrix(i) * pHKL;
			tMatrixResult = (*this) * tNewHKLResult;	//Multiply the two matrices to see if this reflection satisfy the condition
			if (tMatrixResult == tNewHKLResult)
			{
				pResultMatrix = tNewHKLResult;
				return true;
			}
		}
		tZero.sub(pHKL, tWorkHKL);
	}
	return false;
}

std::ostream& Region::output(std::ostream& pStream)
{
    pStream << iID << "\t" << iName << "\t" << (*(Matrix<short>*)this) << "\n";
    return pStream;
}

std::ostream& operator<<(std::ostream& pStream, Region& pHeader)
{
    return pHeader.output(pStream);
}

Regions::Regions():vector<Region*>()
{}

Regions::~Regions()
{
	vector<Region*>::iterator tIter;
	
    for (tIter = begin(); tIter != end(); tIter++)
    {
        Region* tRegion = *tIter;
		if (tRegion)
			delete tRegion;
    }
}

Matrix<short>* Regions::getMatrix(int pIndex)
{
    Region* tRegion = (*this)[pIndex];
    if (!tRegion)
    {
        throw MyException(kUnknownException, "Region with that ID doesn't exist.");
    }
    return tRegion;
}

char* Regions::getName(int pIndex)
{
    Region* tRegion = (*this)[pIndex];
    
    if (!tRegion)
    {
        throw MyException(kUnknownException, "Region with that ID doesn't exist.");
    }
    return tRegion->getName();
}

int Regions::getID(int pIndex)
{
    Region* tRegion = (*this)[pIndex];
    
    if (!tRegion)
    {
        throw MyException(kUnknownException, "Region with that ID doesn't exist.");
    }
    return tRegion->getID();
}

std::ostream& Regions::output(std::ostream& pStream)
{
    int tSize = size();
    for (int i = 0; i < tSize; i++)
    {
        Region* tRegion = (*this)[i];
        if (tRegion)
        {
            std::cout << *tRegion << "\n";
        }
        else
        {
            std::cout << "null\n";
        }
    }
    return pStream;
}

char* Regions::addRegion(char* pLine)	//Returns the point which the line at the start of this string finishs
{
    char* tNext = strchr(pLine, '\n');
    Region* tRegion = NULL;
    if (tNext == NULL)
    {
        tRegion = new Region(pLine);
    }
    else
    {
        char *tString = new char[(int)(tNext-pLine)+1];
        tString[(int)(tNext-pLine)] = 0;
        strncpy(tString, pLine, (int)(tNext-pLine));
        tRegion = new Region(tString);
        tNext++;
		delete[] tString;
    }
	if (size() < (size_t)tRegion->getID()+1)
	{
		resize(tRegion->getID()+1);
	}
	if ((*this)[tRegion->getID()])
	{
		delete tRegion;
	}
	else
	{
		(*this)[tRegion->getID()] = tRegion;
	}
    return tNext;
}

void Regions::readFrom(filebuf& pFile)
{
    char tHeaderLine[] = "ID	Name	Matrix";
    std::istream tFile(&pFile);
    char tLine[255];
    int tLineNum = 0;
    
    do
    {
        tFile.getline(tLine, 255);
        String::trim(tLine);
    }while (strstr(tLine, tHeaderLine) == NULL && !tFile.eof());
    do
    {
        tFile.getline(tLine, 255);
        String::trim(tLine);
        try
        {
            if (tLine[0] != '\0')
                addRegion(tLine);
        }
        catch (MyException eE)
        {
            char tError[255];
            sprintf(tError, "On line %d", tLineNum);
            eE.addError(tError);
            throw eE;
        }
        tLineNum ++;
    }
    while (!tFile.eof() && strlen(tLine)>0);
}

std::ostream& operator<<(std::ostream& pStream, Regions& pHeaders)
{
    return pHeaders.output(pStream);
}

ConditionColumn::ConditionColumn()
{
    iRegionConditions = new vector<Index>();
    iConditions = new vector<Indexs*>();
}

ConditionColumn::~ConditionColumn()
{
	vector<Indexs*>::iterator tIter;
	for (tIter = iConditions->begin(); tIter != iConditions->end(); tIter++)
	{
		delete (*tIter);
	}   
    delete iConditions;
    delete iRegionConditions;
}

void ConditionColumn::addRegion(signed char pIndex)
{
	Index tIndex(pIndex);
    iRegionConditions->push_back(tIndex);
}

void ConditionColumn::addCondition(signed char pIndex, size_t pRow)
{
	if (pRow+1 > iConditions->size())
	{
		iConditions->resize(pRow+1, NULL);
	}
    if (iConditions->at(pRow) ==NULL)
    {
        iConditions->at(pRow) = new Indexs(pIndex);
    }
    else
    {
        iConditions->at(pRow)->addIndex(pIndex);
    }
}

void ConditionColumn::addEmptyCondition(size_t pRow)
{
	if (pRow+1 > iConditions->size())
	{
		iConditions->resize(pRow+1, NULL);
	}
    iConditions->at(pRow) = NULL;
}

void ConditionColumn::setRegion(char* pRegion)
{
    int tOffset = 0;
    const size_t tMatches = 3;
    regmatch_t tMatch[tMatches];
    
    bzero(tMatch, sizeof(regmatch_t)*3);
    while (!regexec(iFirstNumRE, pRegion+tOffset, tMatches, tMatch, 0))
    {
        int pIndex = strtol(pRegion+tOffset, NULL, 10);
        addRegion((signed char)pIndex);
        tOffset += (int)tMatch[0].rm_eo;
        bzero(tMatch, sizeof(regmatch_t)*3);
    }
}

int ConditionColumn::getRegion(const size_t pIndex)
{
    return (*iRegionConditions)[pIndex].get();
}

vector<Index>* ConditionColumn::getRegions()
{
    return iRegionConditions;
}

int ConditionColumn::countRegions()
{
    return iRegionConditions->size();
}

int ConditionColumn::length()
{
    return iConditions->size();
}

Indexs* ConditionColumn::getConditions(size_t pIndex)
{
    return iConditions->at(pIndex);
}

std::ostream& ConditionColumn::output(std::ostream& pStream, Regions* pRegions, Conditions* pConditions)
{
    int tNumConditions = iConditions->size();
    int tNumHeader = iRegionConditions->size();
    
    for (int i = 0; i < tNumHeader; i++)
    {
        pStream << pRegions->getName(getRegion(i));
        if (i+1 != tNumHeader)
        {
            pStream << ", ";
        }
    }
    pStream << "\n\n";
    for (int i = 0; i <= tNumConditions; i++)
    {
        Indexs*  tConditions = iConditions->at(i);
        if (tConditions)
        {
            tConditions->output(pStream);
        }
        else
        {
            pStream << "-";
        }
        pStream << "\n";
    }
    return pStream;
}

Index::Index(signed char pValue):Number<signed char>(pValue)
{}
        
Index::Index(const Index& pObject):Number<signed char>(pObject)
{}

signed char Index::get()
{
    return value();
}

std::ostream& Index::output(std::ostream& pStream)
{
    return pStream << (int)iValue;
}

std::ostream& operator<<(std::ostream& pStream, Index& pIndex)
{
    return pIndex.output(pStream);
}

Indexs::Indexs(signed char pIndex):vector<Index*>()
{
    push_back(new Index(pIndex));
}

void Indexs::addIndex(signed char pIndex)
{
    push_back(new Index(pIndex));
}

signed char Indexs::getValue(int pIndex)
{
    return (*this)[pIndex]->get();
}

Indexs::~Indexs()
{
	vector<Index*>::iterator tIter;
	
    for (tIter = begin(); tIter != end(); tIter++)
    {
        Index* tIndex = *tIter;
		if (tIndex)
			delete tIndex;
	}
}

std::ostream& Indexs::output(std::ostream& pStream)
{
    int tCount = size();
    char* tString = new char[tCount*2+3];
    tString[0] = '\0';
    for (int i = 0; i < tCount;  i++)
    {
        if (i+1==tCount)
        {
            sprintf(tString, "%s%d", tString, (*this)[i]->get());
        }
        else
        {
            sprintf(tString, "%s%d ", tString, (*this)[i]->get());
        }
    }
    pStream << tString;
    delete tString;
    return pStream;
}

std::ostream& operator<<(std::ostream& pStream, Indexs& pIndexs)
{
    return pIndexs.output(pStream);
}

Table::Table(char* pName, Regions* pRegions, Conditions* pConditions, int pNumColumns, int pNumPointGroups):iSGColumn(vector<SGColumn>(pNumPointGroups))
{
    iName = new char[strlen(pName)+1];	//Allocate enought space for the name
    strcpy(iName, pName);	//Copy the name into the classes storage
    String::upcase(iName);	//Make sure that the name is in upper case
    iRegions = pRegions;	//Keep a reference to the headers
    iConditions = pConditions;	//Keep a reference to the conditions
    iColumns = new vector<ConditionColumn*>(pNumColumns, (ConditionColumn*)NULL);	//Allocate the space for the condition columns of the table
    for (int i = 0; i < pNumColumns; i++)
    {
        iColumns->at(i) = new ConditionColumn();	//Allocate and initalise the condition columns
    }
}
        
Table::~Table()
{
	vector<ConditionColumn*>::iterator tColIter;
    delete[] iName;	//Release the space used by the name
    
    for (tColIter = iColumns->begin(); tColIter != iColumns->end(); tColIter++) //Run though each condition column deallocating as you go.
    {
		if (*tColIter)	//Make sure that there is some memory to be deallocated.
        {
            delete (*tColIter);
        }
    }
    delete iColumns;	//Deallocate the arrays which stored the columns
}

void Table::columnRegions(char* pRegions, size_t pColumn)
{
    const size_t tMatches = 4;
    regmatch_t tMatch[tMatches];
    
    bzero(tMatch, sizeof(regmatch_t)*tMatches);
    if (regexec(iFirstNSpRE, pRegions, tMatches, tMatch, 0))
    {
        return;
    }
    char* tString = new char[(int)(tMatch[1].rm_eo-tMatch[1].rm_so+1)];
    tString[(int)(tMatch[1].rm_eo-tMatch[1].rm_so)] = 0;
    strncpy(tString, pRegions+(int)tMatch[1].rm_so, (int)tMatch[1].rm_eo-tMatch[1].rm_so);	//get the first element on the line
    if (pColumn < iColumns->size())
    {
        iColumns->at(pColumn)->setRegion(tString);
    }
    else
    {
        size_t tSpaceGroupLen = pColumn-iColumns->size();
        
        if (iSGColumn.size()<=tSpaceGroupLen)
        {
            throw MyException(kUnknownException, "Table heading has bad format.");
        }
        iSGColumn.at(tSpaceGroupLen).setPointGroup(tString);
    }
    delete[] tString;
    if (tMatch[2].rm_so==-1)
    {
        return;
    }
    columnRegions(pRegions+tMatch[3].rm_so, pColumn+1);
}

void Table::readColumnRegions(char* pRegions)
{
    columnRegions(pRegions, 0);
}

void Table::addLine(char* pLine, size_t pColumn)
{
    const size_t tMatches = 3;
    regmatch_t tMatch[tMatches];
    
    bzero(tMatch, sizeof(regmatch_t)*tMatches);
    if (regexec(iTableRE, pLine, tMatches, tMatch, 0))
    {
        return;
    }
    char* tString = new char[(int)(tMatch[1].rm_eo-tMatch[1].rm_so+1)];
    tString[(int)tMatch[1].rm_eo-tMatch[1].rm_so] = 0;
    strncpy(tString, pLine+(int)tMatch[1].rm_so, (int)tMatch[1].rm_eo-tMatch[1].rm_so);	//Get the first element in the line
    int pRow = iColumns->at(0)->length();	//Get the row which we are at.
    if (pColumn != 0)
    {
        pRow --;
    }
    if (pColumn < iColumns->size())
    {
        addCondition(tString, iColumns->at(pColumn), pRow);
    }
    else
    {
        iSGColumn.at(pColumn-iColumns->size()).add(tString, pRow);
    }
    addLine(pLine+(int)tMatch[1].rm_eo , pColumn+1);
    delete tString;
}


void Table::addCondition(char* pCondition, ConditionColumn* pColumn, size_t pRow)
{
    char* tNextNumber;
    long tNumber = strtol(pCondition, &tNextNumber, 10);
    
    if (tNextNumber == pCondition)
    {
        if (pCondition[0] == '-')
        {
            pColumn->addEmptyCondition(pRow);
        }
        return;
    }
    pColumn->addCondition((signed char)tNumber, pRow);
    if (tNextNumber[0] == 0)
    {
        return;
    }
    addCondition(tNextNumber+1, pColumn, pRow);
}
 
void Table::addLine(char* pLine)
{
    addLine(pLine, 0);
}

#include <ctype.h>

bool emptyLine(char* pLine)
{
    int i = 0;
    while (pLine[i] != 0)
    {
        if (!isspace(pLine[i]))
        {
            return false;
        }
    }
    return true;
}

char* Table::getName()
{
    return iName;
}

size_t Table::numSGColumns()
{
    return iSGColumn.size();
}

SpaceGroups* Table::getSpaceGroup(int pLineNum, int pPointGroupNum)
{
	return iSGColumn.at(pPointGroupNum).at(pLineNum);
}

vector<Index>* Table::getRegions(int pI) const
{
    return iColumns->at(pI)->getRegions();
}
        
void Table::readFrom(filebuf& pFile)
{
    int tLineNum = 1;
    std::istream tFile(&pFile);
    char tLine[255];
    do
    {
        tFile.getline(tLine, 255);
        String::trim(tLine);
        tLineNum++;
    }while (!tFile.eof() && emptyLine(tLine));
    while (!tFile.eof() && strlen(tLine)>0)
    {
        try
        {
            addLine(tLine);
            tFile.getline(tLine, 255);
            String::trim(tLine);
            tLineNum++;
        }
        catch (MyException eE)
        {
            char tError[255];
            sprintf(tError, "On line %d", tLineNum);
            eE.addError(tError);
            throw eE;
        }
    }
}

bool Table::hasSpaceGroupInColumns(vector<int>& pColumnNums, uint pRowNumber)
{
	vector<int>::iterator tIter;
	
	for (tIter = pColumnNums.begin(); tIter != pColumnNums.end(); tIter++)
	{
		if (iSGColumn.at((*tIter)).at(pRowNumber)->count() > 0) 
		{
			return true;
		}
	}
	return false;
}

std::ofstream& Table::outputLine(int pLineNum, std::ofstream& pStream)
{
    vector<ConditionColumn*>::iterator tColIter;
   
    for (tColIter = iColumns->begin(); tColIter != iColumns->end(); tColIter++)
    {
        Indexs* tIndexs = (*tColIter)->getConditions(pLineNum);
        if (tIndexs == NULL)
        {
            pStream << "-\n";
        }
        else
        {
           pStream << *(tIndexs) << "\n";
        }
    }
    long tNumSGs = 0;
	int tLengthSpaceGroup = iSGColumn.size();
    for (int i = 0; i < tLengthSpaceGroup; i++)
    {
        SpaceGroups* tSpaceGroups = iSGColumn.at(i).at(pLineNum);
        tNumSGs += tSpaceGroups->count();
    }
    pStream << "SPACEGROUPS " << tNumSGs << "\n";

    for (int i = 0; i < tLengthSpaceGroup; i++)
    {
        SpaceGroups* tSpaceGroups = iSGColumn.at(i).at(pLineNum);
        if (tSpaceGroups->count() > 0)
            pStream << *(tSpaceGroups) << "\n";
    }
    return pStream;
}

std::ofstream& Table::outputLine(int pLineNum, std::ofstream& pStream, set<int, ltint>& tPointGroups)
{
    vector<ConditionColumn*>::iterator tColIter;
   
    for (tColIter = iColumns->begin(); tColIter != iColumns->end(); tColIter++)
    {
        Indexs* tIndexs = (*tColIter)->getConditions(pLineNum);
        if (tIndexs == NULL)
        {
            pStream << "-\n";
        }
        else
        {
           pStream << *(tIndexs) << "\n";
        }
    }
    long tNumSGs = 0;
	set<int, ltint>::iterator tIter;
	
    for (tIter = tPointGroups.begin(); tIter != tPointGroups.end(); tIter++)
    {
        SpaceGroups* tSpaceGroups = iSGColumn.at((*tIter)).at(pLineNum);
        tNumSGs += tSpaceGroups->count();
    }
    pStream << "SPACEGROUPS " << tNumSGs << "\n";
    for (tIter = tPointGroups.begin(); tIter != tPointGroups.end(); tIter++)
    {
        SpaceGroups* tSpaceGroups = iSGColumn.at((*tIter)).at(pLineNum);
        if (tSpaceGroups->count() > 0)
            pStream << *(tSpaceGroups) << "+ \n";
    }
    return pStream;
}

std::ostream& Table::outputLine(int pLineNum, std::ostream& pStream, int pColumnSize)
{
    vector<ConditionColumn*>::iterator tColIter;
   
    for (tColIter = iColumns->begin(); tColIter != iColumns->end(); tColIter++)
    {
        Indexs* tIndexs = (*tColIter)->getConditions(pLineNum);
        if (tIndexs == NULL)
        {
            pStream << setw(pColumnSize) << "-" << " ";
        }
        else
        {
           pStream << setw(pColumnSize) << *(tIndexs) << " ";
        }
    }
	
	int tLengthSpaceGroup = iSGColumn.size();
    for (int i = 0; i < tLengthSpaceGroup; i++)
    {
        SpaceGroups* tSpaceGroup = iSGColumn.at(i).at(pLineNum);
        pStream << setw(pColumnSize) << *(tSpaceGroup) << " ";
    }
    pStream << "\n";
    return pStream;
}

std::ostream& Table::outputLine(int pLineNum, std::ostream& pStream, set<int, ltint>& tPointGroups, int pColumnSize = 8)
{
    vector<ConditionColumn*>::iterator tColIter;
   
    for (tColIter = iColumns->begin(); tColIter != iColumns->end(); tColIter++)
    {
        Indexs* tIndexs = (*tColIter)->getConditions(pLineNum);
        if (tIndexs == NULL)
        {
            pStream << setw(pColumnSize) <<  "-";
        }
        else
        {
           pStream << setw(pColumnSize) << *(tIndexs);
        }
    }
	set<int, ltint>::iterator tIter;
	
    for (tIter = tPointGroups.begin(); tIter != tPointGroups.end(); tIter++)
    {
        SpaceGroups* tSpaceGroup = iSGColumn.at((*tIter)).at(pLineNum);
        pStream << setw(pColumnSize) << *(tSpaceGroup) << " ";
    }
    pStream << "\n";
    return pStream;
}

std::ostream& Table::output(std::ostream& pStream)
{
    vector<ConditionColumn*>::iterator tColIter;
	
    pStream << iName << "\n";
    for (tColIter = iColumns->begin(); tColIter != iColumns->end(); tColIter++)
    {
        int tRegionNumber = (*tColIter)->countRegions();
        for (int j = 0; j < tRegionNumber; j ++)
        {
            pStream << (*tColIter)->getRegion(j) << "\t";
        }
    }
    int tLengthSpaceGroup = iSGColumn.size();
    for (int i = 0; i < tLengthSpaceGroup; i++)
    {
        pStream << iSGColumn.at(i).getPointGroup() << "\t";
        pStream << "\t";
    }
    pStream << "\n";
    if (iColumns->size() > 0)
    {
        int tNumOfLines = iColumns->at(0)->length();
        for (int i =0; i < tNumOfLines; i++)
        {
            outputLine(i, pStream);
        }
    }
    return pStream;
}

Indexs* Table::getConditions(int pRow, size_t pColumn)
{
    ConditionColumn* tColumn = iColumns->at(pColumn);
    if (tColumn)
    {
        return tColumn->getConditions(pRow);
    }
    return NULL;
}

int Table::numberOfColumns()
{
    return iColumns->size();
}

int Table::numberOfRows()
{
    return iSGColumn.at(0).size();
}

set<int, ltint>& Table::columnsFor(LaueGroup& pLaueGroup,  set<int, ltint>& pColumnIndeces)
{
	size_t tSGColNum = numSGColumns();
	
	pColumnIndeces.clear();
	for (size_t i = 0; i < tSGColNum; i++)
	{
		vector<CrystSymmetry>::iterator tPointGroupIter;
		
		 for (tPointGroupIter = iSGColumn.at(i).getPointGroup().begin(); 
			tPointGroupIter != iSGColumn.at(i).getPointGroup().end();
				tPointGroupIter++)
		{
			//Is the point group a subgroup of the laue group.
			if (pLaueGroup.contains(*tPointGroupIter))
			{
				pColumnIndeces.insert(pColumnIndeces.end(), i);
			}
		}
	}
	return pColumnIndeces;
}

set<int, ltint>& Table::chiralColumns(set<int, ltint>& pPointGroupIndeces)
{
	size_t tSGColNum = this->numSGColumns();
	
	pPointGroupIndeces.clear();
	
	for (size_t i = 0; i< tSGColNum; i++)
	{
		vector<CrystSymmetry>::iterator tPointGroupIter;
		
		 for (tPointGroupIter = iSGColumn.at(i).getPointGroup().begin(); 
			tPointGroupIter != iSGColumn.at(i).getPointGroup().end();
				tPointGroupIter++)
		{
			//Is it a chiral point group
			if (tPointGroupIter->find("-", 0) == string::npos && tPointGroupIter->find("m", 0) == string::npos)
			{
				pPointGroupIndeces.insert(pPointGroupIndeces.end(), i);
			}
		}
	}
	return pPointGroupIndeces;
}

int Table::dataUsed(signed char pIndices[], const size_t pMax) const
{
	set<signed char> tIndices;
    vector<ConditionColumn*>::iterator tColIter;
   
    for (tColIter = iColumns->begin(); tColIter != iColumns->end(); tColIter++)
    {
        vector<Index>::iterator tIndexsIter;
        for (tIndexsIter = (*tColIter)->getRegions()->begin(); tIndexsIter != (*tColIter)->getRegions()->end(); tIndexsIter ++)
        {
			signed char tIndex =tIndexsIter->get();
            tIndices.insert(tIndex);
        }
    }
	if (tIndices.size() < pMax)
    {
        pIndices[tIndices.size()] = -1;
    }
	copy(tIndices.begin(), tIndices.end(), pIndices); 
    return tIndices.size();
}

int Table::conditionsUsed(signed char pIndices[], const size_t pMax) const
{    
	set<signed char> tIndices;
    vector<ConditionColumn*>::iterator tColIter;
   
    for (tColIter = iColumns->begin(); tColIter != iColumns->end(); tColIter++)
    {
        ConditionColumn* tColumn = (*tColIter);
        int tLength = tColumn->length();
        for (int j = 0; j < tLength; j++)
        {
            Indexs* tIndexs = tColumn->getConditions(j);
            if (tIndexs)
            {
                int tNumIndices = tIndexs->size();
                for (int k = 0; k < tNumIndices; k++)
                {
                    signed char tIndex = tIndexs->getValue(k);
                    tIndices.insert(tIndex);
                }
            }
        }
    }
    
    if (tIndices.size() < pMax)
    {
        pIndices[tIndices.size()] = -1;
    }
	copy(tIndices.begin(), tIndices.end(), pIndices); 
    return tIndices.size();
}

std::ostream& operator<<(std::ostream& pStream, Table& pTable)
{
    return pTable.output(pStream);
}

Tables::Tables(char* pFileName):map<char*, Table*, ltstr>()
{
    filebuf tFile;
    initCrysRegEx();
    if (tFile.open(pFileName, std::ios::in) == NULL)
    {
        throw FileException(errno);
    }
    iConditions = new Conditions();
    iRegions = new Regions();
    iRegions->readFrom(tFile);
    iConditions->readFrom(tFile);
    readFrom(tFile);
    tFile.close(); 
}
        
Tables::~Tables()
{	
	while (!empty())
	{
		Table* tTable = (*begin()).second;
		erase(begin());
        if (tTable)
        {
            delete tTable;
        }
	}
    delete iRegions;
    delete iConditions;
    deinitRE();
}

Regions* Tables::getRegions()
{
    return iRegions;
}

Conditions* Tables::getConditions()
{
    return iConditions;
}

void tableAttributesLine(char* pLine, char* pSystemName, int *pNumOfCondCols, int *pNumOfSGCols)
{
    const size_t tMatches = 4;
    regmatch_t tMatch[tMatches];
    
    bzero(tMatch, sizeof(regmatch_t)*tMatches);
    if (regexec(iTableArgsRE, pLine, tMatches, tMatch, 0))
    {
        throw MyException(kUnknownException, "Table has bad format!");
    }
    *pNumOfCondCols = strtol(pLine+tMatch[2].rm_so, NULL, 10);
    *pNumOfSGCols = strtol(pLine+tMatch[3].rm_so, NULL, 10);
    pSystemName[(int)(tMatch[1].rm_eo-tMatch[1].rm_so)] = 0;
    strncpy(pSystemName, pLine+(int)tMatch[1].rm_so, (int)tMatch[1].rm_eo-tMatch[1].rm_so);
}

void Tables::readFrom(filebuf& pFile)
{
    std::istream tFile(&pFile);
    char tLine[255];
 
    while (!tFile.eof())
    {
        tFile.getline(tLine, 255);
        String::trim(tLine);
        if (!emptyLine(tLine))
        {
            char tSystemName[255]; // This it either monoclinic orthorombic etc. 
            int tNumOfCondCols, tNumOfSGCols;
            Table* tTable;
            
            try
            {
                tableAttributesLine(tLine, tSystemName, &tNumOfCondCols, &tNumOfSGCols);
                tTable = new Table(tSystemName, iRegions, iConditions, tNumOfCondCols, tNumOfSGCols); 
            }
            catch (MyException eE)
            {
                char tError[255];
                sprintf(tError, "In Table %s", tSystemName);
                eE.addError(tError);
                throw eE;
            }
            tFile.getline(tLine, 255);
            String::trim(tLine);
            if (!emptyLine(tLine))
            {
                try
                {
                    tTable->readColumnRegions(tLine);
                    tTable->readFrom(pFile);
                }
                catch (MyException eE)
                {
                    char tError[255];
                    sprintf(tError, "In Table %s", tSystemName);
                    eE.addError(tError);
                    throw eE;
                }
            }
            (*this)[tTable->getName()] = tTable;
        }
    }
}

/* Returns name which was found in pName*/
Table* Tables::findTable(char* pName)
{
    return (*this)[pName];
}

std::ostream& Tables::output(std::ostream& pStream)
{
	map<char*, Table*, ltstr>::iterator tIter;
	
    for (tIter = begin(); tIter != end(); tIter++)
    {
        Table* tTable = (*tIter).second;
        if (tTable)
        {
            pStream << *tTable;
        }
    }
    return pStream;
}

std::ostream& operator <<(std::ostream& pStream, Tables& pTables)
{
    return pTables.output(pStream);
};

bool hasChiralSpaceGroup(set<int, ltint>& pPGroupNumbers, Table& pTable, int pRow)
{
    set<int, ltint>::iterator tIter;
	
	for (tIter = pPGroupNumbers.begin(); tIter != pPGroupNumbers.end(); tIter++)
    {
        SpaceGroups* tSpaceGroups = pTable.getSpaceGroup(pRow, (*tIter));
        if (tSpaceGroups->count() == 0)
        {
            return false;
        }
    }
    return true;
}

RankedSpaceGroups::RankedSpaceGroups(Table& pTable, Stats& pStats, bool pChiral, LaueGroup& pLaueGroup):iChiral(pChiral), iLaueGroup(pLaueGroup)
{	
  //  int* tPGroupNumbers =  NULL;
	set<int, ltint> tLaueGPoinGColNums;
	set<int, ltint> tChiralPGroupColNums;
	vector<int> tResultingColumns;
	
	pTable.columnsFor(pLaueGroup, tLaueGPoinGColNums);  //get the columns for the laue groups
    if (iChiral)  	//If this is a chiral structure then get the information for filtering the list.
    {		
		pTable.chiralColumns(tChiralPGroupColNums);
		set_intersection(tChiralPGroupColNums.begin(), tChiralPGroupColNums.end(),
		tLaueGPoinGColNums.begin(), tLaueGPoinGColNums.end(), inserter(tResultingColumns, tResultingColumns.end())); //save the intersection of the two sets. These are are the columns which are needed.
    }
	else
	{
		tResultingColumns.insert(tResultingColumns.begin(), tLaueGPoinGColNums.begin(), tLaueGPoinGColNums.end());
	}
    int tCount = pTable.numberOfRows();
    for (int i = 0; i < tCount; i++)
    {
        if(pTable.hasSpaceGroupInColumns(tResultingColumns, i))
        {
            RowRating iRating(i, pTable, pStats);
            addToList(iRating);	//Add the rating for the current row into the order list of rows.
        }
    }
    iTable = &pTable;
}

RowRating::RowRating(int pRow, Table& pTable, Stats& pStats):Float(0)
{
    int tCount = pTable.numberOfColumns(); 
    
    iRowNum = pRow;
    iTotNumVal = 0;
    iSumRat1 = 0;
    iSumRat2 = 0;
    iSumSqrRat1 = 0;
    iSumSqrRat2 = 0;
    iFiltered = false;
    
    for (int i = 0; i < tCount; i++)
    {
        vector<Index>* tRegions = pTable.getRegions(i);
        int tHCount = tRegions->size();
        for (int j =0; j < tHCount; j++)
        {
            Indexs* tIndexs = pTable.getConditions(pRow, i);
            addConditionRatings(pStats, tIndexs, &((*tRegions)[j]));
        }
    }
    iValue = (iSumRat1+iSumRat2)/(2*iTotNumVal);
    iValue += iFiltered?1:0;
}

RowRating::RowRating(const RowRating& pRating):Float(pRating)
{
	*this = pRating;
}

void RowRating::addConditionRatings(Stats& pStats, Indexs* tIndexs, Index* pRegionIndex)
{
    if (tIndexs)
    {
        int tCount = tIndexs->size();
        for (int i = 0; i < tCount; i++)
        {
            int tRow = tIndexs->getValue(i);
            const ElemStats* tElement = pStats.getElem(pRegionIndex->get(), tRow);
            addRating(tElement);
        }
    }
    else
    {
        iTotNumVal++;
    }
}

void RowRating::addRating(const ElemStats* pStats)
{
    iTotNumVal++;
    iSumRat1 += pStats->tRating1;
    iSumRat2 += pStats->tRating2;
    iSumSqrRat1 += sqr(pStats->tRating1);
    iSumSqrRat2 += sqr(pStats->tRating2);
    iFiltered |= pStats->iFiltered ;
}

RowRating& RowRating::operator=(const RowRating& pRowRating)
{
    (Float)(*this) = (Float)pRowRating;
    iRowNum = pRowRating.iRowNum;
    iTotNumVal = pRowRating.iTotNumVal;
    iSumRat1 = pRowRating.iSumRat1;
    iSumRat2 = pRowRating.iSumRat2;
    iSumSqrRat1 = pRowRating.iSumSqrRat1;
    iSumSqrRat2 = pRowRating.iSumSqrRat2;
    iFiltered = pRowRating.iFiltered;
    return *this;
}

void RankedSpaceGroups::addToList(RowRating& pRating)
{
    insert(pRating);
}

std::ofstream& RankedSpaceGroups::output(std::ofstream& pStream)	//Used when outputing the ranked space groups to a file.
{
    multiset<RowRating, RRlt>::iterator tRatingIter;
//    RowRating* tCurrentRating;
        
    pStream << "RESULTS " << size() << "\n";
    set<int, ltint> tChiralPointGroups;
	set<int, ltint> tLaueGroupPointGroups;
	set<int, ltint> tPointGroups;
    
	iTable->columnsFor(iLaueGroup, tLaueGroupPointGroups);
    if (iChiral)
    {
        iTable->chiralColumns(tChiralPointGroups);
		set_intersection(tChiralPointGroups.begin(), tChiralPointGroups.end(),
		tLaueGroupPointGroups.begin(), tLaueGroupPointGroups.end(), inserter(tPointGroups, tPointGroups.end()));
    }
	else
		tPointGroups.insert(tLaueGroupPointGroups.begin(), tLaueGroupPointGroups.end());
    //tRatingIter->reset();
	for (tRatingIter = begin(); tRatingIter != end(); tRatingIter++)
	{
        pStream << "SCORE " << tRatingIter->value() << "\n";
        pStream << "PROMOTED ";
        if (tRatingIter->iFiltered)
            pStream << "YES\n";
        else
            pStream << "NO\n";
		iTable->outputLine(tRatingIter->iRowNum, pStream, tPointGroups);
    }
    //delete tRatingIter;
  //  delete tPointGroups;
    return pStream;
}

std::ostream& RankedSpaceGroups::output(std::ostream& pStream)
{
	multiset<RowRating, RRlt>::iterator tRatingIter;
	set<int, ltint> tChiralPointGroups;
	set<int, ltint> tLaueGroupPointGroups;
    set<int, ltint> tPointGroups;
	
    iTable->columnsFor(iLaueGroup, tLaueGroupPointGroups);
    if (iChiral)
    {
        iTable->chiralColumns(tChiralPointGroups);
		set_intersection(tChiralPointGroups.begin(), tChiralPointGroups.end(),
		tLaueGroupPointGroups.begin(), tLaueGroupPointGroups.end(), inserter(tPointGroups, tPointGroups.end()));
    }
	else
		tPointGroups.insert(tLaueGroupPointGroups.begin(), tLaueGroupPointGroups.end());
    pStream << "A '*' indicates that the row has been promoted because it seems that the data has been previously filtered for the centering.\n\n";
    for (tRatingIter = begin(); tRatingIter != end(); tRatingIter++)
	{
        pStream << setw(3) << tRatingIter->iRowNum << " " << setprecision(4) << setw(9) << tRatingIter->value() << " ";
        if (tRatingIter->iFiltered)
            pStream << " * ";
        else
            pStream << " + ";
		iTable->outputLine(tRatingIter->iRowNum, pStream, tPointGroups);	//Output only set point group list.
    }
    //delete tRatingIter;
    return pStream;
}

std::ostream& operator<<(std::ostream& pStream, RankedSpaceGroups& pRank)
{
    return pRank.output(pStream);
}

std::ofstream& operator<<(std::ofstream& pStream, RankedSpaceGroups& pRank)
{
    return pRank.output(pStream);
}
