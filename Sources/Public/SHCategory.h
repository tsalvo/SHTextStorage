//
//  SHCategory.h
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#ifndef SHCategory_h
#define SHCategory_h

typedef NS_ENUM(NSInteger, SHCategory) {
    DefaultText = 0,
    CommentText = 1,
    Keyword = 2,
    Directive = 3,
    Name = 4,
    Decimal = 5,
    Hex = 6,
    Binary = 7,
    TextLiteral = 8,
    DecimalLiteral = 9,
    HexLiteral = 10,
    BinaryLiteral = 11,
    ExternalName = 12
};

#endif /* SHCategory_h */
