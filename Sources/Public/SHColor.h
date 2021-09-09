//
//  SHColor.h
//  
//
//  Created by Tom Salvo on 9/9/21.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

#import "SHCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHColor : NSObject
#if TARGET_OS_IOS
@property (nonatomic, strong) UIColor *color;
#else
@property (nonatomic, strong) NSColor *color;
#endif
@property (nonatomic) SHCategory category;

#if TARGET_OS_IOS
-(instancetype)initWithCategory:(SHCategory)aCategory color:(UIColor *)aColor NS_DESIGNATED_INITIALIZER;
#else
-(instancetype)initWithCategory:(SHCategory)aCategory color:(NSColor *)aColor NS_DESIGNATED_INITIALIZER;
#endif
@end

NS_ASSUME_NONNULL_END
