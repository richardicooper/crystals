/*
 *  main.cpp
 *  Space Groups
 *
 *  Created by Stefan Pantos on Tue Oct 29 2002.
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
#if defined(_WIN32)
#include <direct.h>
#endif

#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "HKLData.h"
#include "Exceptions.h"
#include "CrystalSystem.h"
#include "Stats.h"
#include "UnitCell.h"

#include "StringClasses.h"

using namespace std;

#if !defined(_WIN32)
#define _TCHAR const char
#define TCHAR char
#define kDefaultTables "/Tables.txt"
#else
#define kDefaultTables "\\Tables.txt"
#define PATH_MAX _MAX_PATH
#endif


typedef struct RunStruct
{
    Path iFileName;		//File name for the hkl data.
    Path iTablesFile;		//The file name of the tables file.
    Path iOtherInfoFile;	//The name of a file for more informtion.
    bool iChiral;		//False is not nessaseraly chiral. false chiral
    bool iRequestChirality;	//If this is true then the user will be asked if the file crystal is chiral.
    bool iVerbose;
    char* iCrystalSys;		//Crystal System
}RunStruct;

void runTest(RunStruct *pRunData)
{
    std::cout << "Reading in tables...";
	struct timeval time1;
    struct timeval time2;
    gettimeofday(&time1, NULL);
    Tables* tTables = new Tables(pRunData->iTablesFile.getCString());
    gettimeofday(&time2, NULL);
    std::cout << "\n" << (float)(time2.tv_sec - time1.tv_sec)+(float)(time2.tv_usec-time1.tv_usec)/1000000 << "s\n";
    std::cout << "\nReading in hkl data...";
    gettimeofday(&time1, NULL);
    HKLData* tHKL = new HKLData(pRunData->iFileName.getCString());
    gettimeofday(&time2, NULL);
    std::cout << "\n" << (float)(time2.tv_sec - time1.tv_sec)+(float)(time2.tv_usec-time1.tv_usec)/1000000 << "s\n";
    std::cout << "\nCalculating probabilities...";
    gettimeofday(&time1, NULL);
    Table* tTable = tTables->findTable(pRunData->iCrystalSys);
    Stats* tStats = new Stats(tTables->getHeadings(), tTables->getConditions());
    int tNumRef = tHKL->numberOfReflections();
    for (int i = 0; i < tNumRef; i++)
    {
        Reflection* tReflection = tHKL->getReflection(i);
        tStats->addReflection(tReflection);
    }
    gettimeofday(&time2, NULL);
    
    std::cout <<"\n" << (float)(time2.tv_sec - time1.tv_sec)+(float)(time2.tv_usec-time1.tv_usec)/1000000 << "s\n";
    gettimeofday(&time1, NULL);
    tStats->calProbs();
    gettimeofday(&time2, NULL);
    if (pRunData->iVerbose)
        std::cout << *tStats << "\n";
    std::cout <<"\n" << (float)(time2.tv_sec - time1.tv_sec)+(float)(time2.tv_usec-time1.tv_usec)/1000000 << "s\n";
    std::cout << "\nRanking space groups...";
    gettimeofday(&time1, NULL);
    RankedSpaceGroups* tRankings = new RankedSpaceGroups(*tTable, *tStats, pRunData->iChiral);
    gettimeofday(&time2, NULL);
    std::cout <<"\n" << (float)(time2.tv_sec - time1.tv_sec)+(float)(time2.tv_usec-time1.tv_usec)/1000000 << "s\n";
    std::cout << "\n" << *tRankings << "\n";
    if (tStats->filtered())
    {
        std::cout << "\nThis data may have already been filtered!\n";
    }
    delete tRankings;
    delete tStats;
    delete tHKL;
    delete tTables;
    std::cout << MyObject::objectCount() << " objects left.\n";
}

void initRunStruct(RunStruct *pRunStruct)
{
#if defined(_WIN32)
	char * tWorkingPath = (char*)malloc(PATH_MAX);
	_getcwd(tWorkingPath, PATH_MAX);
#else
	char * tWorkingPath = NULL;
	tWorkingPath = getcwd(NULL, PATH_MAX);
#endif
    pRunStruct->iTablesFile.initFormated("%s%s", tWorkingPath, kDefaultTables);
    free(tWorkingPath);
    pRunStruct->iCrystalSys = new char[20];
    pRunStruct->iCrystalSys[0] = 0;
    pRunStruct->iRequestChirality = true;
    pRunStruct->iChiral = false;
    pRunStruct->iVerbose = false;
}

bool handleArg(int *pPos, int pMax, _TCHAR * argv[], RunStruct *pRunData)
{
    if (strcmp(argv[(*pPos)], "-c") == 0)
    {
        pRunData->iChiral = true;
        pRunData->iRequestChirality = false;
        (*pPos)++;
        return true;
    }
    else if (strcmp(argv[(*pPos)], "-nc") == 0)
    {
        pRunData->iChiral = false;
        pRunData->iRequestChirality = false;
        (*pPos)++;
        return true;
    }
    else if (strcmp(argv[*pPos], "-v")==0)
    {
        pRunData->iVerbose = true;
        (*pPos)++;
        return true;
    }
    else if (strcmp(argv[*pPos], "-f")==0)
    {
        (*pPos)++;
        if (*pPos < pMax && argv[*pPos][0] != '-')
        {
            pRunData->iFileName.init(argv[*pPos]);
            (*pPos)++;
            return true;
        }
    }
    else if (strcmp(argv[*pPos], "-t")==0)
    {
        (*pPos)++;
        if (*pPos < pMax && argv[*pPos][0] != '-')
        {
            pRunData->iTablesFile.init(argv[*pPos]);
            (*pPos)++;
            return true;
        }
    }
	else if (strcmp(argv[*pPos], "-e") == 0)
	{
		(*pPos)++;
        if (*pPos < pMax && argv[*pPos][0] != '-')
        {
            pRunData->iOtherInfoFile.init(argv[*pPos]);
            (*pPos)++;
            return true;
        }
	}
    else if (strcmp(argv[*pPos], "-s")==0)
    {
        (*pPos)++;
        if (*pPos < pMax && argv[*pPos][0] != '-')
        {
            char* tEnd;
            int tValue = strtol(argv[*pPos], &tEnd, 10);
            char* pSystem = crystalSystemConst(tValue);
            if (tEnd != argv[*pPos]+strlen(argv[*pPos]) || pSystem == NULL)
            {
                return false;
            }
            strcpy(pRunData->iCrystalSys, pSystem);
            (*pPos)++;
            return true;
        }
    }
    return false;
}

bool handleArgs(int pArgc, _TCHAR* argv[], RunStruct *pRunData)
{
    int tCount = 1;
    while (tCount < pArgc)
    {
        if (!handleArg(&tCount, pArgc, argv, pRunData))
        {
            std::cout << "Usage: " << argv[0] << "[-f hklfile] [-t tablefile] [-e extradatafile] [-c|-nc] [-s system]\n";
            std::cout << "-f hklfile: The path of the hkl file to read in.\n";
            std::cout << "-t tablefile: The path of the table file.\n";
			std::cout << "-e extradatafile: The path to a file which contains other data such as the unit cell.\n";
            std::cout << "[-c| -nc]: -c The structure is chiral. -nc The crystal isn't necessarily chiral.\n";
            std::cout << "-s system#: The crystal system table to use.\n";
            std::cout << "-v: verbose output\n";
            std::cout << "Valid values for system are:\n" <<
            "\t0: Triclinic" <<
            "\t1: MonoclinicA\n" <<
            "\t2: MonoclinicB\n" <<
            "\t3: MonoclinicC\n" <<
            "\t4: Orthorhombic\n" <<
            "\t5: Tetragonal\n" <<
            "\t6: Trigonal\n" <<
            "\t7: Trigonal(rhom)\n" <<
            "\t8: Hexagonal\n" <<
            "\t9: Cubic\n";
            return false;
        }
    }
    return true;
}

void getParamsFromUser(RunStruct *pRunData)
{
    if (pRunData->iFileName.getCString()[0] == 0)
    {
        std::cout << "Enter hkl file path: ";
        std::cin >> pRunData->iFileName;
        pRunData->iFileName.removeOutterQuotes();
    }
    char tReply;
    while (pRunData->iRequestChirality)
    {
        std::cout << "Is the crystal chiral? [y/n]";
    	std::cin >> tReply;
        if (tReply == 'N' || tReply == 'n')
        {
            pRunData->iChiral = false;
            pRunData->iRequestChirality = false;
        }
        else if (tReply == 'Y' || tReply == 'y')
        {
            pRunData->iChiral = true;
            pRunData->iRequestChirality = false;
        }
    }
    if (pRunData->iCrystalSys[0] == 0)
    {
        if (pRunData->iOtherInfoFile.getCString()[0] != 0)
        {
                UnitCell tUnitCell(pRunData->iOtherInfoFile.getCString());
                tUnitCell.guessCrystalSystem();
        }
        strcpy(pRunData->iCrystalSys, getCrystalSystem());
    }
}

#if !defined(_WIN32)
int main(int argc, const char * argv[])
#else
int _tmain(int argc, _TCHAR* argv[])
#endif
{
    std::cout << argv[0] << "\n";   
    RunStruct tRunStruct;
    initRunStruct(&tRunStruct);
    if (!handleArgs(argc, argv, &tRunStruct))
    {
        return 0;
    }
    getParamsFromUser(&tRunStruct);
    
    try
    {
        runTest(&tRunStruct);
    }
    catch (MyException eE)
    {
        std::cout << "\n" << eE.what() << "\n";
    }   
    delete tRunStruct.iCrystalSys;
    return 0;
}