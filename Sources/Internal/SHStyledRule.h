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
#import "SHSharedSystemTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHStyledRule : NSObject

@property (nonatomic, strong) SHRule *rule;
@property (nonatomic) BOOL isBackgroundRule;
@property (nonatomic, strong) SH_SYSTEM_COLOR_TYPE *color;

-(instancetype) initWithRule:(SHRule *)aRule
                       color:(nullable SH_SYSTEM_COLOR_TYPE *)aColor NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
