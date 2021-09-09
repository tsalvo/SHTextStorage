//
//  SyntaxHighlightTextSorage.m
//  
//
//  Created by Tom Salvo on 9/7/21.
//

#import "SHTextSorage.h"
#import "SHStyledLanguage.h"
#import "SHColorSet.h"
#import "SHLanguage.h"

@interface SHTextStorage()



@end

@implementation SHTextStorage

@synthesize language;
@synthesize storage;
@synthesize font;

- (instancetype)initWithLanguage:(SHLanguage *)aLanguage
                        colorSet:(SHColorSet *)aColorSet
#if TARGET_OS_IOS
                            font:(UIFont *)aFont
#else
                            font:(NSFont *)aFont
#endif
{
    if (self = [super init])
    {
        self.language = [[SHStyledLanguage alloc] initWithLanguage:aLanguage
                                                       colorSet:aColorSet];
        self.storage = [[NSTextStorage alloc] init];
        self.font = aFont;
    }
    return self;
}

- (NSString *)string {
    return self.storage.string;
}

- (NSDictionary<NSString *,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)effectiveRange {
    return [self.storage attributesAtIndex:location effectiveRange:effectiveRange];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    [self.storage replaceCharactersInRange:range withString:aString];
    [self edited:NSTextStorageEditedCharacters range:range
         changeInLength:(NSInteger)aString.length - (NSInteger)range.length];
}

- (void)setAttributes:(NSDictionary<NSString *, id> *)attributes range:(NSRange)range {
    [self beginEditing];
    [self.storage setAttributes:attributes range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

-(void)processEditing {
    NSString* str = [self string];
    
    NSRange adjustedRangeForProcessing = NSRangeFromString(str);
    
    if (self.editedRange.location != 0 || self.editedRange.length != self.length)
    {
        adjustedRangeForProcessing = [str lineRangeForRange: self.editedRange];
    }
    
    [self.language processRulesForTextStorage:self.storage withFont:self.font inRange:adjustedRangeForProcessing];
    
    [super processEditing];
}

@end

