/*
 *  BaseTypes.h
 *  Space Groups
 *
 *  Created by Stefan on Wed Jun 25 2003.
 *  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
 *
 *
 *   This file is for putting file types which need to be extended to be of any use.
 */
 
#if !defined(__BASE_TYPES_H__)
#define __BASE_TYPES_H__

#include "ComClasses.h"

/*!
 * @class Column 
 * @description Not yet documented.
 * @abstract
*/
class Column:public MyObject
{
    public:

        /*!
         * @function setHeading 
         * @description Not yet documented.
         * @abstract
         */
        void setHeading(char* pHeading);

        /*!
         * @function length 
         * @description Not yet documented.
         * @abstract
         */
        int length();
};

typedef struct _Range_
{
	unsigned int location;
	size_t length;
}Range;
#endif
