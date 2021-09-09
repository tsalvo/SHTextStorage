//
//  SHStyledLanguage.m
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import "SHLanguage.h"
#import "SHStyledLanguage.h"
#import "SHCategory.h"
#import "SHStyledRule.h"
#import "SHColorSet.h"

@interface SHStyledLanguage()
@property (nonatomic, strong) NSArray<SHStyledRule *> *styledRules;
#if TARGET_OS_IOS
@property (nonatomic, strong) UIColor *defaultColor;
#else
@property (nonatomic, strong) NSColor *defaultColor;
#endif
@end

@implementation SHStyledLanguage

@synthesize styledRules;
@synthesize defaultColor;

-(instancetype)initWithLanguage:(SHLanguage *)aLanguage
                    colorSet:(SHColorSet *)aColorSet
{
    if (self = [super init])
    {
        NSMutableArray<SHStyledRule *> *tempArray = [[NSMutableArray alloc] init];
        for (SHRule *rule in aLanguage.rules)
        {
#if TARGET_OS_IOS
            UIColor *color;
#else
            NSColor *color;
#endif
            color = [aColorSet colorForCategory:rule.category];
            SHStyledRule *styledRule = [[SHStyledRule alloc] initWithRule:rule color:color];
            [tempArray addObject:styledRule];
        }
        self.styledRules = tempArray;
        self.defaultColor = [aColorSet colorForCategory:DefaultText];
    }
    
    return self;
}

-(void)processRulesForTextStorage:(NSTextStorage *)aTextSorage
#if TARGET_OS_IOS
                         withFont:(UIFont *)aFont
#else
                         withFont:(NSFont *)aFont
#endif
                          inRange:(NSRange)aRange
{
    NSString* str = [aTextSorage string];
    
    [aTextSorage
     setAttributes: @{
        NSFontAttributeName : aFont,
        NSForegroundColorAttributeName : self.defaultColor
     }
     range: aRange];
    
    for (SHStyledRule *styledRule in self.styledRules)
    {
        NSError *regexError = NULL;
        NSRegularExpression *regex = [NSRegularExpression
            regularExpressionWithPattern: styledRule.rule.regexPattern
            options: styledRule.rule.regexOptions
            error: &regexError];
        [regex enumerateMatchesInString:str options:0 range:aRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            [aTextSorage addAttributes: @{ NSForegroundColorAttributeName : styledRule.color } range: result.range];
        }];
    }
}
@end
