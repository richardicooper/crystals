/*
 *  CrystalSystem.h
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
#ifndef __CRYSTAL_SYSTEM_H__
#define __CRYSTAL_SYSTEM_H__
#include "Matrices.h"
#include "BaseTypes.h"
#include "Collections.h"
#include "SpaceGroups.h"
#include "Wrappers.h"
#include "HKLData.h"
#include "Conditions.h"
#include <fstream>
#include <vector>
#include <map>

using namespace std;
struct ElemStats;

class Heading:public Matrix<short>
{
    private:
        char*	iName;
        int 	iID;
    public:
        Heading(char* pLines);
        ~Heading();
        char* getName();
        int getID();
        std::ostream& Heading::output(std::ostream& pStream);
};

class Headings:public vector<Heading*>
{
    public:
        Headings();
        ~Headings();
        Matrix<short>* getMatrix(int pIndex);
        char* getName(int pIndex);
        int getID(int pIndex);
        std::ostream& output(std::ostream& pStream);
        char* addHeading(char* pLine);
        void readFrom(filebuf& pFile);
};

std::ostream& operator<<(std::ostream& pStream, Heading& pHeader);
std::ostream& operator<<(std::ostream& pStream, Headings& pHeaders);

//This is just my own rapper class for an integer type.
class Index:public Number<signed char>
{
    public:
        Index(signed char pValue);
        Index(Index& pObject);
        signed char get();
        std::ostream& output(std::ostream& pStream);
};

std::ostream& operator<<(std::ostream& pStream, Index& pIndex);

class Indexs:public vector<Index*>
{
    public:
        Indexs(signed char pIndex);
        ~Indexs();
        void addIndex(signed char pIndex);
        signed char getValue(int pIndex);
        std::ostream& output(std::ostream& pStream);
};

std::ostream& operator<<(std::ostream& pStream, Indexs& pIndexs);

class ConditionColumn:virtual public Column
{
    private:
        ArrayList<Index>* iHeadingConditions;
        ArrayList<Indexs>* iConditions;	
    public:
        ConditionColumn();
        ~ConditionColumn();
        void addHeading(signed char pIndex);
        void setHeading(char* pHeading);
        int getHeading(const int pIndex);
        ArrayList<Index>* getHeadings();
        void addCondition(signed char pIndex, int pRow);
        void addEmptyCondition(int pRow);
        Indexs* getConditions(int pIndex);
        int length();
        int countHeadings();
        std::ostream& output(std::ostream& pStream, Headings* pHeadings, Conditions* pConditions);
};

class Table:public MyObject
{
    private:
        char* iName;
        ArrayList<ConditionColumn>* iColumns;	//The conditions. Null means that there is no condition.
        ArrayList<SGColumn>* iSGColumn;	//Columns of space groups.
        Headings* iHeadings;
        Conditions* iConditions;
	void columnHeadings(char* pHeadings, int pColumn);
        void addLine(char* pLine, int pColumn);
        void addCondition(char* pCondition, ConditionColumn* pColumn, int pRow);
        void addSpaceGroup(char* pSpaceGroup, SGColumn* pSGColumn, int pRow);
    public:
        Table(char* pName, Headings* pHeadings, Conditions* pConditions, int pNumColumns, int pNumPointGroups);
        ~Table();
        void addLine(char* pLine);
	void readColumnHeadings(char* pHeadings);
        void readFrom(filebuf& pFile);
        char* getName();
        ArrayList<Index>* getHeadings(int pI) const;
        int getNumPointGroups();	
        SpaceGroups* getSpaceGroup(int pLineNum, int pPointGroupNum);
        Indexs* getConditions(int pRow, int pColumn);
        int numberOfColumns();
        int numberOfRows();
        int chiralPointGroups(int pPointGroupIndeces[]);
        int dataUsed(signed char pIndices[], const int pMax) const;
        int conditionsUsed(signed char pIndices[], const int pMax) const;
        std::ostream& output(std::ostream& pStream);
        std::ofstream& outputLine(int pLineNum, std::ofstream& pStream);
        std::ofstream& outputLine(int pLineNum, std::ofstream& pStream, int tPointGroups[]);
        std::ostream& outputLine(int pLineNum, std::ostream& pStream, int pColumnCount=8);
        std::ostream& outputLine(int pLineNum, std::ostream& pStream, int pPointGroups[], int pColumnCount=8);
};

std::ostream& operator<<(std::ostream& pStream, Table& pTable);

class Tables:public map<char*, Table*, ltstr>
{
    private:
        Headings* iHeadings;
        Conditions* iConditions;
    public:
        Tables(char* pFileName);
        ~Tables();
        Headings* getHeadings();
	    Conditions* getConditions();
        void readFrom(filebuf& pFile);
        Table* findTable(char* pName);
        std::ostream& output(std::ostream& pStream);
};

std::ostream& operator <<(std::ostream& pStream, Tables& pTables);

class Stats;

class RankedSpaceGroups:public MyObject
{
    private:
        class RowRating:public Float	//The value is the mean value;
        {
            private:
                void addConditionRatings(Stats& pStats, Indexs* tIndexs,  Index* pHeadingIndex);
                void addRating(const ElemStats* pStats);
            public:
                int iRowNum;	//The number of the row in the table.
                int iTotNumVal;	//Total number of values include in these stats.
                float iSumRat1;	//Sum of rating value using on (Averager intensity Non-matched / (Averager intensity Non-matched+Averager intensity matched))
                float iSumRat2;	//Sum of rating value using on (Averager intensity Non-matched / (Averager intensity Non-matched+Averager intensity matched))
                float iSumSqrRat1;	//Sum of square rating value using on (Averager intensity Non-matched / (Averager intensity Non-matched+Averager intensity matched))
                float iSumSqrRat2;	//Sum of square rating value using on (Averager intensity Non-matched / (Averager intensity Non-matched+Averager intensity matched))
                bool iFiltered;
                RowRating(int pRow, Table& pTable, Stats& pStats);
                RowRating& operator=(const RowRating& pRowRating);
        };
        
        MultiTree<RowRating> iSortedRatings;
        Table* iTable;			//The table which the rattings have been made for. Reference to the table. Table should never be released by this class.
        bool iChiral;
        void addToList(RowRating& pRating);
    public:
        RankedSpaceGroups(Table& pTable, Stats& pStats, bool pChiral);
        std::ofstream& output(std::ofstream& pStream);
        std::ostream& output(std::ostream& pStream);
};

//class CrystalSystem
//{
//	protected:
//		//CrystalSystemID iID;
//		string iName;
//		list<LaueGroups*> iLaueGroups;
//		Table* iTables;
//	public:
//		CrystalSystem(Table* pTable,   
//		bool contains(LaueGroup* );
//};
//
//class CrystalSystems:protected list<CrystalSystem*>
//{
//	public:
//		CrystalSystems(char* pFileName);
//		static CrystalSystems* defaultObject();
//		CrystalSystem* crystalSystemForLaueGroup(LaueGroup*);
//};

std::ostream& operator<<(std::ostream& pStream, RankedSpaceGroups& pRank);
std::ofstream& operator<<(std::ofstream& pStream, RankedSpaceGroups& pRank);
#endif
