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
@class SHLanguage, SHColor, SHStyledLanguage;
@interface SHTextStorage : NSTextStorage

@property (nonatomic, strong) SHStyledLanguage *language;
@property (nonatomic, strong) NSTextStorage *storage;
#if TARGET_OS_IOS
@property (nonatomic, strong) UIFont *font;
#else
@property (nonatomic, strong) NSFont *font;
#endif
@property (nonatomic) BOOL isLoggingEnabled;
@property (nonatomic) NSUInteger numberOfLines;

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                        colors:(NSArray<SHColor *> *)aColors
#if TARGET_OS_IOS
                            font:(UIFont *)aFont
#else
                            font:(NSFont *)aFont
#endif
                          string:(NSString *)aString
                         logging:(BOOL)aLogging NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                          colors:(NSArray<SHColor *> *)aColors
#if TARGET_OS_IOS
                            font:(UIFont *)aFont;
#else
                            font:(NSFont *)aFont;
#endif

- (instancetype)initWithString:(NSString *)aString;

@end

NS_ASSUME_NONNULL_END
