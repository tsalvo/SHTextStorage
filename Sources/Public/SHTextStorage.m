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
#import "SHLine.h"

@interface SHTextStorage()
#if TARGET_OS_IOS
@property (nonatomic, strong) UIFont *font;
#else
@property (nonatomic, strong) NSFont *font;
#endif
@property (nonatomic, strong) SHStyledLanguage *language;
@property (nonatomic, strong) NSTextStorage *storage;
@property (nonatomic) BOOL isLoggingEnabled;
@property (nonatomic) double lineHeight;
@property (nonatomic) CGFloat lastKnownTextContainerWidth;
@property (nonatomic) NSUInteger lastKnownCharactersPerLine;
@property (nonatomic, strong) NSMutableArray<SHLine *> *lines;
@end

@implementation SHTextStorage

@synthesize isLoggingEnabled;
@synthesize lines;
@synthesize lineHeight;
@synthesize lastKnownTextContainerWidth;
@synthesize lastKnownCharactersPerLine;
@synthesize language;
@synthesize storage;
@synthesize font;

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                        colors:(NSArray<SHColor *> *)aColors
                        fontSize:(CGFloat)aFontSize
                          string:(NSString *)aString
                         logging:(BOOL)aLogging
{
    if (self = [super init])
    {
        NSTextStorage *s = [[NSTextStorage alloc] initWithString:aString];
        SHStyledLanguage *sl = [[SHStyledLanguage alloc] initWithLanguage:aLanguage
                                                                   colors:aColors];
#if TARGET_OS_IOS
        UIFont *f = [UIFont monospacedSystemFontOfSize:14 weight:UIFontWeightSemibold];
        CGFloat lH = f.lineHeight;
#else
        NSFont *f = [NSFont monospacedSystemFontOfSize:14 weight:NSFontWeightSemibold];
        CGFloat lH = ceilf(f.ascender + ABS(f.descender) + f.leading);
#endif
        [sl processRulesForTextStorage:s
                              withFont:f
                               inRange:NSRangeFromString(aString)];
        self.language = sl;
        self.storage = s;

        self.font = f;
        self.isLoggingEnabled = aLogging;

        self.lineHeight = lH;
        self.lines = [NSMutableArray arrayWithArray:[SHTextStorage linesForString:aString
                                                                         withFont:f
                                                                       lineHeight:lH
                                                                charactersPerLine:NSUIntegerMax]];
        self.lastKnownCharactersPerLine = NSUIntegerMax;
        self.lastKnownTextContainerWidth = CGFLOAT_MAX;
    }
    return self;
}

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                        colors:(NSArray<SHColor *> *)aColors
                        fontSize:(CGFloat)aFontSize
                          string:(NSString *)aString
{
    return [self initWithLanguage:aLanguage
                           colors:aColors
                         fontSize:aFontSize
                           string:aString
                          logging:false];
}

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                        colors:(NSArray<SHColor *> *)aColors
                        fontSize:(CGFloat)aFontSize
{
    return [self initWithLanguage:aLanguage
                           colors:aColors
                         fontSize:aFontSize
                           string:@""
                          logging:false];
}

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                        colors:(NSArray<SHColor *> *)aColors
                        fontSize:(CGFloat)aFontSize
                         logging:(BOOL)aLogging
{
    return [self initWithLanguage:aLanguage
                           colors:aColors
                         fontSize:aFontSize
                           string:@""
                          logging:aLogging];
}

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                          colors:(NSArray<SHColor *> *)aColors
                         logging:(BOOL)aLogging
{
    return [self initWithLanguage:aLanguage
                           colors:aColors
                         fontSize:14
                           string:@""
                          logging:aLogging];
}

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                        colors:(NSArray<SHColor *> *)aColors
{
    return [self initWithLanguage:aLanguage
                           colors:aColors
                         fontSize:14
                           string:@""
                          logging:false];
}

- (instancetype)initWithString:(NSString *)aString
                      fontSize:(CGFloat)aFontSize
                        logging:(BOOL)aLogging
{
    return [self initWithLanguage:[[SHLanguage alloc] init]
                           colors:@[]
                         fontSize:aFontSize
                           string:aString
                          logging:aLogging];
}

- (instancetype)initWithString:(NSString *)aString
                      fontSize:(CGFloat)aFontSize
{
    return [self initWithLanguage:[[SHLanguage alloc] init]
                           colors:@[]
                         fontSize:aFontSize
                           string:aString
                          logging:false];
}

- (instancetype)initWithString:(NSString *)aString
{
    return [self initWithLanguage:[[SHLanguage alloc] init]
                           colors:@[]
                         fontSize:14
                           string:aString
                          logging:false];
}

-(instancetype)init
{
    return [self initWithLanguage:[[SHLanguage alloc] init]
                           colors:@[]
                         fontSize:14
                           string:@""
                          logging:false];
}

-(void)addLayoutManager:(NSLayoutManager *)aLayoutManager {
    [super addLayoutManager:aLayoutManager];
    
    if (self.layoutManagers.firstObject != nil && self.layoutManagers.firstObject.textContainers.firstObject != nil) {
        CGFloat containerWidth = self.layoutManagers.firstObject.textContainers.firstObject.size.width;
#if !TARGET_OS_IOS
        self.lineHeight = [self.layoutManagers.firstObject defaultLineHeightForFont:self.font];
#endif
        
        if (containerWidth != self.lastKnownTextContainerWidth) {
            self.lastKnownCharactersPerLine = [SHTextStorage numCharactersPerLineWithFont:self.font inWidth:containerWidth];
            self.lastKnownTextContainerWidth = containerWidth;
        }
        
        self.lines = [NSMutableArray arrayWithArray:[SHTextStorage linesForString:self.string
                                                                         withFont:self.font
                                                                       lineHeight:self.lineHeight
                                                                charactersPerLine:self.lastKnownCharactersPerLine]];
    }
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
    NSUInteger numLinesForReplacedString = [SHTextStorage numberOfLinesForString:[self.string substringWithRange:range]];
    NSUInteger replacementStartLine = [SHTextStorage lineNumberIndexForIndex:range.location inString:self.string];
    NSRange startLineRange = [self.lines objectAtIndex:replacementStartLine].range;
    
    [self beginEditing];
    [self.storage replaceCharactersInRange:range withString:aString];
    if (self.layoutManagers.firstObject != nil && self.layoutManagers.firstObject.textContainers.firstObject != nil) {
        SHLine *firstReplacedLine = [self.lines objectAtIndex:replacementStartLine];
        firstReplacedLine.range = NSMakeRange(startLineRange.location, firstReplacedLine.range.length);
        CGFloat containerWidth = self.layoutManagers.firstObject.textContainers.firstObject.size.width;

        if (containerWidth != self.lastKnownTextContainerWidth) {
            self.lastKnownCharactersPerLine = [SHTextStorage numCharactersPerLineWithFont:self.font inWidth:containerWidth];
            self.lastKnownTextContainerWidth = containerWidth;
        }
        
        [self.lines replaceObjectsInRange:NSMakeRange(replacementStartLine, numLinesForReplacedString)
                     withObjectsFromArray:[SHTextStorage linesForString:aString
                                                               withFont:self.font
                                                             lineHeight:self.lineHeight
                                                      charactersPerLine:self.lastKnownCharactersPerLine]];
    } else {
        [self.lines replaceObjectsInRange:NSMakeRange(replacementStartLine, numLinesForReplacedString)
                     withObjectsFromArray:[SHTextStorage linesForString:aString
                                                               withFont:self.font
                                                             lineHeight:self.lineHeight
                                                      charactersPerLine:self.lastKnownCharactersPerLine]];
    }
    [self endEditing];
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:(NSInteger)aString.length - (NSInteger)range.length];
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
    NSString *str = self.storage.string;
    NSRange adjustedRangeForProcessing = [str lineRangeForRange:self.editedRange];

    if (self.isLoggingEnabled) {
        NSLog(@"processEditing editedRange = (%lu, %lu) adjustedRange = (%lu %lu) tempStr length = %lu, storage length = %lu self.length = %lu numberOfLines = %lu", self.editedRange.location, self.editedRange.length, adjustedRangeForProcessing.location, adjustedRangeForProcessing.length, str.length, self.storage.length, self.length, self.lines.count);
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

+(NSUInteger)lineNumberIndexForIndex:(NSUInteger)aIndex inString:(NSString *)aString {
    NSUInteger lineNumber, index, stringLength = [aString length];
    NSUInteger targetIndex = MIN(stringLength, aIndex);
    for (index = 0, lineNumber = 0; index < targetIndex; lineNumber++) {
        index = NSMaxRange([aString lineRangeForRange:NSMakeRange(index, 0)]);
    }
    
    return lineNumber > 0 ? lineNumber - 1 : lineNumber;
}

+(NSArray <SHLine *>*)linesForString:(NSString *)aString
#if TARGET_OS_IOS
                            withFont:(UIFont*)aFont
#else
                            withFont:(NSFont*)aFont
#endif
                          lineHeight:(double)aLineHeight
                   charactersPerLine:(NSUInteger)aCharactersPerLine {
    if (aString.length == 0) {
        return @[[[SHLine alloc] initWithRange:NSMakeRange(0, 0) height:aLineHeight]];
    }
    NSMutableArray <SHLine *>* lines = [NSMutableArray array];
    NSRange lineRange;
    NSUInteger numLines, index, wrappedLines, stringLength = [aString length];
    double wrappedHeight;
    for (index = 0, numLines = 0; index < stringLength; numLines++) {
        lineRange = [aString lineRangeForRange:NSMakeRange(index, 0)];
        wrappedLines = lineRange.length / aCharactersPerLine + (lineRange.length % aCharactersPerLine == 0 ? 0 : 1);
        wrappedHeight = MAX(1, wrappedLines) * aLineHeight;
        SHLine *line = [[SHLine alloc] initWithRange:lineRange height:wrappedHeight];
        [lines addObject:line];
        index = NSMaxRange(lineRange);
    }
    
    BOOL endsInNewline = (stringLength > 0 && [[NSCharacterSet newlineCharacterSet] characterIsMember:[aString characterAtIndex:stringLength - 1]]);
    if (endsInNewline) {
        lineRange = NSMakeRange(index, 0);
        SHLine *line = [[SHLine alloc] initWithRange:lineRange height:aLineHeight];
        [lines addObject:line];
    }
    
    return lines;
}

#if TARGET_OS_IOS
+(NSUInteger)numCharactersPerLineWithFont:(UIFont*)aFont
#else
+(NSUInteger)numCharactersPerLineWithFont:(NSFont*)aFont
#endif
                                  inWidth:(CGFloat)aWidth {
    NSUInteger numCharsPerLine = 0;
    CGFloat measureStrWidth = 0;

    NSMutableString *measureStr = [NSMutableString stringWithString:@""];
    while (measureStrWidth < aWidth) {
        [measureStr appendString:@" "];
        numCharsPerLine++;
        measureStrWidth = [measureStr sizeWithAttributes:@{ NSFontAttributeName : aFont }].width;
    }
    
    return numCharsPerLine;
}

@end

