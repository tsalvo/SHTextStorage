//
//  SHStyledRule.m
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import "SHStyledRule.h"

@implementation SHStyledRule

@synthesize rule;
@synthesize color;

-(instancetype)initWithRule:(SHRule *)aRule
#if TARGET_OS_IOS
                          color:(UIColor *)aColor
#else
                          color:(NSColor *)aColor
#endif
{
    if (self = [super init])
    {
        self.rule = aRule;
        self.color = aColor;
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
