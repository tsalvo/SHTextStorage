//
//  SyntaxHighlightTextSorage.h
//  
//
//  Created by Tom Salvo on 9/7/21.
//
#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface SHTextStorage : NSTextStorage

@end

NS_ASSUME_NONNULL_END
