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
#import "../Internal/SHSharedSystemTypes.h"

NS_ASSUME_NONNULL_BEGIN
@interface SHColor : NSObject
@property (nonatomic, strong) SH_SYSTEM_COLOR_TYPE *color;
@property (nonatomic) SHCategory category;

-(instancetype)initWithCategory:(SHCategory)aCategory color:(SH_SYSTEM_COLOR_TYPE *)aColor NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
