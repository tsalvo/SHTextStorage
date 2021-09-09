//
//  SHColorSet.h
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

#import "SHCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHColorSet : NSObject

#if TARGET_OS_IOS
-(UIColor*)colorForCategory:(SHCategory)aCategory;
#else
-(NSColor*)colorForCategory:(SHCategory)aCategory;
#endif

@end

NS_ASSUME_NONNULL_END
