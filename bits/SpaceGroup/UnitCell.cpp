/*
 *  UnitCell.cpp
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
 * e.g.
 * float tSomeVariable;   //A variable which is declared inside method.
 * float pSomeParameter   //A variable which is a parameter to a method/function
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
#include "UnitCell.h"
#include "Exceptions.h"
#include <iostream.h>
#include "MathFunctions.h"
#include "StringClasses.h"
#if defined(_WIN32)
#include <Boost/regex.h>
#else
#include <regex.h>
#endif


void UnitCell::setA(float pA)
{
    iA = pA;
}

void UnitCell::setB(float pB)
{
    iB = pB;
}

void UnitCell::setC(float pC)
{
    iC = pC;
}

void UnitCell::setAlpha(float pAlpha)
{
    iAlpha = pAlpha;
}

void UnitCell::setBeta(float pBeta)
{
    iBeta = pBeta;
}

void UnitCell::setGamma(float pGamma)
{
    iGamma = pGamma;
}

float UnitCell::getA()
{
    return iA;
}

float UnitCell::getB()
{
    return iB;
}

float UnitCell::getC()
{
    return iB;
}

float UnitCell::getAlpha()
{
    return iAlpha;
}

float UnitCell::getBeta()
{
    return iBeta;
}

float UnitCell::getGamma()
{
    return iGamma;
}

void UnitCell::setSEA(float pSEA)
{
    iSEA = pSEA;
}

void UnitCell::setSEB(float pSEB)
{
    iSEB = pSEB;
}

void UnitCell::setSEC(float pSEC)
{
    iSEC = pSEC;
}

void UnitCell::setSEAlpha(float pSEAlpha)
{
    iSEAlpha = pSEAlpha;
}

void UnitCell::setSEBeta(float pSEBeta)
{
    iSEBeta = pSEBeta;
}

void UnitCell::setSEGamma(float pSEGamma)
{
    iSEGamma = pSEGamma;
}

float UnitCell::getSEA()
{
    return iSEA;
}

float UnitCell::getSEB()
{
    return iSEB;
}

float UnitCell::getSEC()
{
    return iSEC;
}

float UnitCell::getSEAlpha()
{
    return iSEAlpha;
}

float UnitCell::getSEBeta()
{
    return iSEBeta;
}

float UnitCell::getSEGamma()
{
    return iSEGamma;
}

char* UnitCell::guessCrystalSystem()
{
    float tAs[7];
    float tGs[6];
    
    
    float temp = iAlpha - 90;
    tAs[0] = sqr(temp); 
    temp = iGamma - 90;
    tAs[1] = sqr(temp);  
    temp = iBeta - 90;
    tAs[2] = sqr(temp);  
    temp = iGamma - 120;
    tAs[3] = sqr(temp);  
    temp = iAlpha - iBeta;
    tAs[4] = sqr(temp);  
    temp = iAlpha - iGamma;
    tAs[5] = sqr(temp);  
    temp = iBeta - iGamma;
    tAs[6] = sqr(temp); 

    temp = iB - iA;
    tGs[0] = 1/sqr(temp); 
    temp = iB - iC;
    tGs[1] = 1/sqr(temp); 
    temp = iC - iA;
    tGs[2] = 1/sqr(temp); 
    temp = iA - iB;
    tGs[3] = sqr(temp); 
    temp = iA - iC;
    tGs[4] = sqr(temp); 
    temp = iB - iC;
    tGs[5] = sqr(temp); 

    float tMonoA = (tAs[1] + tAs[2] + tGs[0] + tGs[2])/4;
    float tMonoB = (tAs[0] + tAs[1] + tGs[0] + tGs[1])/4;
    float tMonoC = (tAs[0] + tAs[2] + tGs[2] + tGs[1])/4;
    float tOrth = (tAs[0] +  tAs[1] +  tAs[2])/3;
    float tTetr = (tAs[0] + tAs[1] + tAs[2] + tGs[3])/4;
    float tTriHexHex = (tAs[0] + tAs[2] + tAs[3] + tGs[3])/4;
    float tTriRho = (tAs[4] + tAs[5] + tAs[6] + tGs[3] + tGs[4] + tGs[5])/6;
    float tCubic = (tAs[0] + tAs[1] + tAs[2] + tGs[3] + tGs[4] + tGs[5])/6;
    
	std::cout << "tMonoA: " << tMonoA << "\n" <<
    "tMonoB: " << tMonoB <<  "\n" <<
    "tMonoC: " << tMonoC <<  "\n" <<
    "tOrth: " << tOrth <<  "\n" <<
    "tTetr: " << tTetr << "\n" <<
    "tTriHexHex: " << tTriHexHex << "\n" <<
    "tTriRho: " << tTriRho <<  "\n" <<
    "tCubic: " << tCubic << "\n";
/*    
"Triclinic"
"MonoclinicB"
"MonoclinicC"
"MonoclinicA"
"Orthorhombic"
"Tetragonal"
"Trigonal"
"Hexagonal"
"Cubic"
*/
    return NULL;
}

std::ostream& printCrystConst(std::ostream& pStream)
{
    int i = 0;
    char* tText = crystalSystemConst(i);
    while (tText != NULL)
    {
        pStream << i << ": " << tText << "\n";
        i ++;
        tText = crystalSystemConst(i);
    }
    return pStream;
}

char* getCrystalSystem()
{
    char* iSelect = new char[255];
    char* tString = NULL;
    char* tEnd = NULL;
    
    do
    {
        std::cout << "\n" << printCrystConst << "Select crystal system:";
        std::cin >> iSelect;
        tString = crystalSystemConst(strtol(iSelect, &tEnd, 10));
    }
    while (iSelect[0] == '\0' || tEnd[0] != '\0' || tString == NULL);
    delete[] iSelect;
    return tString;
}

char* crystalSystemConst(int pIndex)
{
    switch (pIndex)
    {
        case 0:
            return "Triclinic";
        break;
        case 1:
            return "MonoclinicA";
        break;
        case 2:
            return "MonoclinicB";
        break;
        case 3:
            return "MonoclinicC";
        break;
        case 4:
            return "Orthorhombic";
        break;
        case 5:
            return "Tetragonal";
        break;
        case 6:
            return "Trigonal";
        break;
        case 7:
            return "Trigonal(Rhom)";
        break;
        case 8:
            return "Hexagonal";
        break;
        case 9:
            return "Cubic";
        break;
    }
    return NULL;
}

UnitCell::UnitCell(char* pPath)
{
    readInUnitCell(pPath);
}

/*void UnitCell::UnitCell(float pA, float pB, float pC, float pAlpha, float, pBeta, float pGamma)
{
    
}
*/

void UnitCell::readInUnitCell(char* pPath)	//Reads in from the file provided
{
    char tLine[255];
    
    regex_t tAngles;
    regex_t tLengths;
    
    /**************************************/
    /*** Open File ready to be read in	***/
    /**************************************/
    FILE* tFile = fopen(pPath, "r");
    if (tFile == NULL)
    {
        throw FileException(errno);
    }
    
    /**************************************/
    /*** Set up the regular expressions ***/
    /**************************************/
     regcomp(&tAngles, 
     "continue[[:space:]]+alpha[[:space:]]*=[[:space:]]*([-+]?[[:digit:]]+(\\.[[:digit:]]+)?)[[:space:]]+beta[[:space:]]*=[[:space:]]*([-+]?[[:digit:]]+(\\.[[:digit:]]+)?)[[:space:]]+gamma[[:space:]]*=[[:space:]]*([-+]?[[:digit:]]+(\\.[[:digit:]]+)?)",
      REG_EXTENDED);
    regcomp(&tLengths, 
     "real[[:space:]]+a[[:space:]]*=[[:space:]]*([-+]?[[:digit:]]+(\\.[[:digit:]]+)?)[[:space:]]+b[[:space:]]*=[[:space:]]*([-+]?[[:digit:]]+(\\.[[:digit:]]+)?)[[:space:]]+c[[:space:]]*=[[:space:]]*([-+]?[[:digit:]]+(\\.[[:digit:]]+)?)",
      REG_EXTENDED);
    regmatch_t tMatch[8];
    
    while (fgets(tLine, 255, tFile))
    {
        if (!regexec(&tAngles, tLine, 8, tMatch, 0))
        {
            String tAlpha(tLine, (int)tMatch[1].rm_so, (int)tMatch[1].rm_eo);
            String tBeta(tLine, (int)tMatch[3].rm_so, (int)tMatch[3].rm_eo);
            String tGamma(tLine, (int)tMatch[5].rm_so, (int)tMatch[5].rm_eo);
            iAlpha = tAlpha.toDouble();
            iBeta = tBeta.toDouble();
            iGamma = tGamma.toDouble();
        }
        else if (!regexec(&tLengths, tLine, 8, tMatch, 0))
        {
            String tA(tLine, (int)tMatch[1].rm_so, (int)tMatch[1].rm_eo);
            String tB(tLine, (int)tMatch[3].rm_so, (int)tMatch[3].rm_eo);
            String tC(tLine, (int)tMatch[5].rm_so, (int)tMatch[5].rm_eo);
            iA = tA.toDouble();
            iB = tB.toDouble();
            iC = tC.toDouble();
        }
    }
    fclose(tFile);
}
