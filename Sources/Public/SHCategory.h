//
//  SHCategory.h
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import <Foundation/Foundation.h>

#ifndef SHCategory_h
#define SHCategory_h

typedef NS_ENUM(NSInteger, SHCategory) {
    SHCategoryDefault = 0,
    SHCategoryComment = 1,
    SHCategoryKeyword = 2,
    SHCategoryDirective = 3,
    SHCategoryName = 4,
    SHCategoryDecimal = 5,
    SHCategoryHex = 6,
    SHCategoryBinary = 7,
    SHCategoryTextLiteral = 8,
    SHCategoryDecimalLiteral = 9,
    SHCategoryHexLiteral = 10,
    SHCategoryBinaryLiteral = 11,
    SHCategoryExternalName = 12
};

#endif /* SHCategory_h */
