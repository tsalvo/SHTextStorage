//
//  SHColor.m
//  
//
//  Created by Tom Salvo on 9/9/21.
//

#import "SHColor.h"

@implementation SHColor

-(instancetype)initWithCategory:(SHCategory)aCategory color:(SH_SYSTEM_COLOR_TYPE *)aColor
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
                            color:SH_SYSTEM_COLOR_TYPE.labelColor];
}

@end
