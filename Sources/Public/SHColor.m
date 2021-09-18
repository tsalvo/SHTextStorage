//
//  SHColor.m
//  
//
//  Created by Tom Salvo on 9/9/21.
//

#import "SHColor.h"

@implementation SHColor

#if TARGET_OS_IOS
-(instancetype)initWithCategory:(SHCategory)aCategory color:(UIColor *)aColor
#else
-(instancetype)initWithCategory:(SHCategory)aCategory color:(NSColor *)aColor
#endif
{
    if (self = [super init])
    {
        self.color = aColor;
        self.category = aCategory;
    }
    
    return self;
}

-(instancetype)init
{
    return [self initWithCategory:SHCategoryDefault
#if TARGET_OS_IOS
                            color:UIColor.labelColor];
#else
                            color:NSColor.labelColor];
#endif
}

@end
