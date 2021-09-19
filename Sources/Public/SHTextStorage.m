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
@synthesize numberOfLines;
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
                          string:(NSString *)aString
                         logging:(BOOL)aLogging
{
    if (self = [super init])
    {
        NSTextStorage *s = [[NSTextStorage alloc] initWithString:aString];
        SHStyledLanguage *sl = [[SHStyledLanguage alloc] initWithLanguage:aLanguage
                                                                   colors:aColors];
        [sl processRulesForTextStorage:s
                              withFont:aFont
                               inRange:NSRangeFromString(aString)];
        self.language = sl;
        self.storage = s;
        self.font = aFont;
        self.isLoggingEnabled = aLogging;
        self.numberOfLines = [SHTextStorage numberOfLinesForString:aString];
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
    return [self initWithLanguage:aLanguage
                           colors:aColors
                             font:aFont
                           string:@""
                          logging:false];
}

- (instancetype)initWithString:(NSString *)aString
{
    return [self initWithLanguage:[[SHLanguage alloc] init]
                           colors:@[]
#if TARGET_OS_IOS
                             font:[UIFont monospacedSystemFontOfSize:14 weight:UIFontWeightSemibold]
#else
                             font:[NSFont monospacedSystemFontOfSize:14 weight:NSFontWeightSemibold]
#endif
                           string:aString
                          logging:false];
}

-(instancetype)init
{
    return [self initWithLanguage:[[SHLanguage alloc] init]
                           colors:@[]
#if TARGET_OS_IOS
                             font:[UIFont monospacedSystemFontOfSize:14 weight:UIFontWeightSemibold]
#else
                             font:[NSFont monospacedSystemFontOfSize:14 weight:NSFontWeightSemibold]
#endif
                           string:@""
                          logging:false];
}

- (NSString *)string {
    return self.storage.string;
}

- (NSDictionary<NSString *,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)effectiveRange {
    if (self.isLoggingEnabled) {
        NSLog(@"attributesAtIndex %lu", location);
    }
    return [self.storage attributesAtIndex:location effectiveRange:effectiveRange];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    if (self.isLoggingEnabled) {
        NSLog(@"replaceCharactersInRange (%lu, %lu) with string length = %lu, change in length = %ld", range.location, range.length, aString.length, (NSInteger)aString.length - (NSInteger)range.length);
    }
    NSUInteger numLinesForNewString = [SHTextStorage numberOfLinesForString:aString];
    NSUInteger numLinesForReplacedString = [SHTextStorage numberOfLinesForString: [self.string substringWithRange:range]];
    [self beginEditing];
    [self.storage replaceCharactersInRange:range withString:aString];
    self.numberOfLines += (numLinesForNewString - numLinesForReplacedString);
    [self endEditing];
    [self edited:NSTextStorageEditedCharacters range:range
         changeInLength:(NSInteger)aString.length - (NSInteger)range.length];
}

- (void)setAttributes:(NSDictionary<NSString *, id> *)attributes range:(NSRange)range {
    if (self.isLoggingEnabled) {
        NSLog(@"setAttributes inRange (%lu, %lu)", range.location, range.length);
    }
    [self beginEditing];
    [self.storage setAttributes:attributes range:range];
    [self endEditing];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}

-(void)processEditing {
    
    NSString* str = self.storage.string;
    NSRange adjustedRangeForProcessing = [str lineRangeForRange:self.editedRange];

    if (self.isLoggingEnabled) {
        NSLog(@"processEditing editedRange = (%lu, %lu) adjustedRange = (%lu %lu) tempStr length = %lu, storage length = %lu self.length = %lu numberOfLines = %lu", self.editedRange.location, self.editedRange.length, adjustedRangeForProcessing.location, adjustedRangeForProcessing.length, str.length, self.storage.length, self.length, self.numberOfLines);
    }
    
    [self.language processRulesForTextStorage:self.storage withFont:self.font inRange:adjustedRangeForProcessing];
    
    [super processEditing];
}

+(NSUInteger)numberOfLinesForString:(NSString *)aString {
    NSUInteger numLines, index, stringLength = [aString length];
    for (index = 0, numLines = 0; index < stringLength; numLines++) {
        index = NSMaxRange([aString lineRangeForRange:NSMakeRange(index, 0)]);
    }
    
    BOOL endsInNewline = (stringLength > 0 && [[NSCharacterSet newlineCharacterSet] characterIsMember:[aString characterAtIndex:stringLength - 1]]);

    return MAX(1, numLines) + (endsInNewline ? 1 : 0);
}

@end

