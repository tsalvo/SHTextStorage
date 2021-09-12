//
//  SHStyledRule.h
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

#import "SHRule.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHStyledRule : NSObject

@property (nonatomic, strong) SHRule *rule;
@property (nonatomic) BOOL isBackgroundRule;
#if TARGET_OS_IOS
@property (nonatomic, strong) UIColor *color;
#else
@property (nonatomic, strong) NSColor *color;
#endif

-(instancetype) initWithRule:(SHRule *)aRule
#if TARGET_OS_IOS
                       color:(nullable UIColor *)aColor NS_DESIGNATED_INITIALIZER;
#else
                       color:(nullable NSColor *)aColor NS_DESIGNATED_INITIALIZER;
#endif


@end

NS_ASSUME_NONNULL_END
