//
//  SHColorSet.m
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import "SHColorSet.h"

@interface SHColorSet()
#if TARGET_OS_IOS
@property (nonatomic, strong) NSDictionary<NSNumber *, UIColor *> *colorMap;
#else
@property (nonatomic, strong) NSDictionary<NSNumber *, NSColor *> *colorMap;
#endif
@end

@implementation SHColorSet

#if TARGET_OS_IOS
-(instancetype)initWithColorMap:(NSDictionary<NSNumber *, UIColor *> *)aColorMap
#else
-(instancetype)initWithColorMap:(NSDictionary<NSNumber *, NSColor *> *)aColorMap
#endif
{
    if (self = [super init])
    {
        self.colorMap = aColorMap;
    }
}

#if TARGET_OS_IOS
-(nonnull UIColor*)colorForCategory:(SHCategory)aCategory
#else
-(nonnull NSColor*)colorForCategory:(SHCategory)aCategory
#endif
{
#if TARGET_OS_IOS
    UIColor *result;
#else
    NSColor *result;
#endif
    
    result = self.colorMap[@(aCategory)];
    
    if (result == nil)
    {
#if TARGET_OS_IOS
        result = UIColor.labelColor;
#else
        result = NSColor.labelColor;
#endif
    }
}

@end
