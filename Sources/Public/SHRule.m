//
//  SHRule.m
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import "SHRule.h"

@implementation SHRule

@synthesize regexPattern;
@synthesize regexOptions;
@synthesize category;
@synthesize isBackgroundRule;

-(instancetype)initWithPattern:(NSString *)aPattern
                        options:(NSRegularExpressionOptions)aOptions
                       category:(SHCategory)aCategory
{
    if (self = [super init])
    {
        self.regexOptions = aOptions;
        self.regexPattern = aPattern;
        self.category = aCategory;
        
        switch (aCategory)
        {
            case SHCategoryErrorBackground:
            case SHCategoryWarningBackground:
                self.isBackgroundRule = true;
                break;
            default:
                self.isBackgroundRule = false;
        }
    }

    return self;
}

-(instancetype)init
{
    self = [self initWithPattern:@"" options:0 category:SHCategoryDefault];
}
@end
