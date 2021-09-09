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

NS_ASSUME_NONNULL_BEGIN
@class SHLanguage, SHColor;
@interface SHStyledLanguage : NSObject

-(instancetype)initWithLanguage:(SHLanguage *)aLanguage
                         colors:(NSArray<SHColor *> *)aColors NS_DESIGNATED_INITIALIZER;

-(void)processRulesForTextStorage:(NSTextStorage *)aTextSorage
#if TARGET_OS_IOS
                         withFont:(UIFont *)aFont
#else
                         withFont:(NSFont *)aFont
#endif
                          inRange:(NSRange)aRange;

@end

NS_ASSUME_NONNULL_END
