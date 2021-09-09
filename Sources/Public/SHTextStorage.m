//
//  SyntaxHighlightTextSorage.m
//  
//
//  Created by Tom Salvo on 9/7/21.
//

#import "SHTextSorage.h"
#import "SHStyledLanguage.h"
#import "SHColor.h"
#import "SHLanguage.h"

@implementation SHTextStorage

@synthesize isLoggingEnabled;
@synthesize language;
@synthesize storage;
@synthesize font;

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                        colors:(NSArray<SHColor *> *)aColors
#if TARGET_OS_IOS
                            font:(UIFont *)aFont
#else
                            font:(NSFont *)aFont
#endif
                         logging:(BOOL)aLogging
{
    if (self = [super init])
    {
        self.language = [[SHStyledLanguage alloc] initWithLanguage:aLanguage
                                                            colors:aColors];
        self.storage = [[NSTextStorage alloc] init];
        self.font = aFont;
        self.isLoggingEnabled = aLogging;
    }
    return self;
}

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                        colors:(NSArray<SHColor *> *)aColors
#if TARGET_OS_IOS
                            font:(UIFont *)aFont
#else
                            font:(NSFont *)aFont
#endif
{
    self = [self initWithLanguage:aLanguage colors:aColors font:aFont logging:false];
    return self;
}



-(instancetype)init
{
    self = [self initWithLanguage:[[SHLanguage alloc] init]
                           colors:@[]
#if TARGET_OS_IOS
                             font:[UIFont monospacedSystemFontOfSize:14 weight:UIFontWeightSemibold]];
#else
                             font:[NSFont monospacedSystemFontOfSize:14 weight:NSFontWeightSemibold]];
#endif
    
    return self;
}

- (NSString *)string {
    return self.storage.string;
}

- (NSDictionary<NSString *,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)effectiveRange {
    if (self.isLoggingEnabled)
    {
        NSLog(@"attributesAtIndex %lu", location);
    }
    return [self.storage attributesAtIndex:location effectiveRange:effectiveRange];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    if (self.isLoggingEnabled)
    {
        NSLog(@"replaceCharactersInRange (%lu, %lu) with string length = %lu, change in length = %ld", range.location, range.length, aString.length, (NSInteger)aString.length - (NSInteger)range.length);
    }
    [self beginEditing];
    [self.storage replaceCharactersInRange:range withString:aString];
    [self endEditing];
    [self edited:NSTextStorageEditedCharacters range:range
         changeInLength:(NSInteger)aString.length - (NSInteger)range.length];
}

- (void)setAttributes:(NSDictionary<NSString *, id> *)attributes range:(NSRange)range {
    if (self.isLoggingEnabled)
    {
        NSLog(@"setAttributes inRange (%lu, %lu)", range.location, range.length);
    }
    [self beginEditing];
    [self.storage setAttributes:attributes range:range];
    [self endEditing];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}

-(void)processEditing {
    
    NSString* str = self.storage.string;
    NSRange adjustedRangeForProcessing = NSRangeFromString(str);
    
    if (self.editedRange.location != 0 || self.editedRange.length != self.length)
    {
        adjustedRangeForProcessing = [str lineRangeForRange: self.editedRange];
    }
    
    if (self.isLoggingEnabled)
    {
        NSLog(@"processEditing editedRange = (%lu, %lu) adjustedRange = (%lu %lu) tempStr length = %lu, storage length = %lu", self.editedRange.location, self.editedRange.length, adjustedRangeForProcessing.location, adjustedRangeForProcessing.length, str.length, self.storage.length);
    }
    
    [self.language processRulesForTextStorage:self.storage withFont:self.font inRange:adjustedRangeForProcessing];
    
    [super processEditing];
}

@end

