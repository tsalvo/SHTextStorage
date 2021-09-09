//
//  SHRule.m
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import "SHRule.h"

@implementation SHRule
-(instancetype) initWithPattern:(NSString *)aPattern
                        options:(NSRegularExpressionOptions)aOptions
                       category:(SHCategory)aCategory
{
    if (self = [super init])
    {
        self.regexOptions = aOptions;
        self.regexPattern = aPattern;
        self.category = aCategory;
    }

    return self;
}
@end
