//
//  SHStyledRule.m
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import "SHStyledRule.h"

@implementation SHStyledRule
-(instancetype) initWithRule:(SHRule *)aRule
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
@end
