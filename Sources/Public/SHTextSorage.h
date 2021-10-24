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
@class SHLanguage, SHColor, SHStyledLanguage, SHLine;
@interface SHTextStorage : NSTextStorage
#if TARGET_OS_IOS
@property (nonatomic, strong, readonly) UIFont *font;
#else
@property (nonatomic, strong, readonly) NSFont *font;
#endif
@property (nonatomic, strong, readonly) NSMutableArray<SHLine *> *lines;

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                        colors:(NSArray<SHColor *> *)aColors
                        fontSize:(CGFloat)aFontSize
                          string:(NSString *)aString
                         logging:(BOOL)aLogging NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                        colors:(NSArray<SHColor *> *)aColors
                        fontSize:(CGFloat)aFontSize
                          string:(NSString *)aString;

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                        colors:(NSArray<SHColor *> *)aColors
                        fontSize:(CGFloat)aFontSize
                         logging:(BOOL)aLogging;

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                          colors:(NSArray<SHColor *> *)aColors
                        fontSize:(CGFloat)aFontSize;

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                          colors:(NSArray<SHColor *> *)aColors;

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                          colors:(NSArray<SHColor *> *)aColors
                         logging:(BOOL)aLogging;

- (instancetype)initWithString:(NSString *)aString
                      fontSize:(CGFloat)aFontSize
                        logging:(BOOL)aLogging;

- (instancetype)initWithString:(NSString *)aString
                      fontSize:(CGFloat)aFontSize;

- (instancetype)initWithString:(NSString *)aString;

@end

NS_ASSUME_NONNULL_END
