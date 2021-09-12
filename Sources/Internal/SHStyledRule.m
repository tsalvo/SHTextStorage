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
#if TARGET_OS_IOS
                          color:(nullable UIColor *)aColor
#else
                          color:(nullable NSColor *)aColor
#endif
{
    if (self = [super init])
    {
#if TARGET_OS_IOS
        UIColor *tempColor = aColor;
#else
        NSColor *tempColor = aColor;
#endif
        
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
#if TARGET_OS_IOS
            tempColor = tempIsBackgroundRule ? UIColor.clearColor : UIColor.labelColor;
#else
            tempColor = tempIsBackgroundRule ? NSColor.clearColor : NSColor.labelColor;
#endif
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
#if TARGET_OS_IOS
                        color:UIColor.labelColor];
#else
                        color:NSColor.labelColor];
#endif
    return self;
}
@end
