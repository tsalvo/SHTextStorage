//
//  SHStyledRule.m
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import "SHStyledRule.h"
#import "SHCategory.h"

@implementation SHStyledRule

@synthesize rule;
@synthesize color;
@synthesize isBackgroundRule;

-(instancetype)initWithRule:(SHRule *)aRule
                          color:(nullable SH_SYSTEM_COLOR_TYPE *)aColor
{
    if (self = [super init])
    {
        SH_SYSTEM_COLOR_TYPE *tempColor = aColor;
        BOOL tempIsBackgroundRule = false;
        switch (aRule.category)
        {
            case SHCategoryErrorBackground:
            case SHCategoryWarningBackground:
                tempIsBackgroundRule = true;
                break;
            default:
                tempIsBackgroundRule = false;
        }
        
        if (tempColor == nil)
        {
            tempColor = tempIsBackgroundRule ? SH_SYSTEM_COLOR_TYPE.clearColor : SH_SYSTEM_COLOR_TYPE.labelColor;
        }
        
        self.rule = aRule;
        self.color = tempColor;
        self.isBackgroundRule = tempIsBackgroundRule;
    }
    
    return self;
}

-(instancetype)init
{
    self = [self initWithRule:[[SHRule alloc] init]
                        color:SH_SYSTEM_COLOR_TYPE.labelColor];
    return self;
}
@end
