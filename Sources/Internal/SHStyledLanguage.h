//
//  SHStyledLanguage.h
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

#import "SHSharedSystemTypes.h"

NS_ASSUME_NONNULL_BEGIN
@class SHLanguage, SHColor;
@interface SHStyledLanguage : NSObject

-(instancetype)initWithLanguage:(SHLanguage *)aLanguage
                         colors:(NSArray<SHColor *> *)aColors NS_DESIGNATED_INITIALIZER;

-(void)processRulesForTextStorage:(NSTextStorage *)aTextSorage
                         withFont:(SH_SYSTEM_FONT_TYPE *)aFont
                          inRange:(NSRange)aRange;

@end

NS_ASSUME_NONNULL_END
