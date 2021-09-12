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
#import "SHRule.h"
#import "SHColor.h"

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
                         colors:(NSArray<SHColor *> *)aColors
{
    if (self = [super init])
    {
#if TARGET_OS_IOS
        NSMutableDictionary<NSNumber *, UIColor *> *colorMap = [NSMutableDictionary dictionary];
#else
        NSMutableDictionary<NSNumber *, NSColor *> *colorMap = [NSMutableDictionary dictionary];
#endif
        
        for (SHColor *shColor in aColors)
        {
            colorMap[@(shColor.category)] = shColor.color;
        }
        
        NSMutableArray<SHStyledRule *> *tempArray = [[NSMutableArray alloc] init];
        for (SHRule *rule in aLanguage.rules)
        {
#if TARGET_OS_IOS
            UIColor *color;
#else
            NSColor *color;
#endif
            
            color = colorMap[@(rule.category)];
            
            if (color == nil)
            {
#if TARGET_OS_IOS
                color = UIColor.labelColor;
#else
                color = NSColor.labelColor;
#endif
            }
            
            SHStyledRule *styledRule = [[SHStyledRule alloc] initWithRule:rule color:color];
            [tempArray addObject:styledRule];
        }
        self.styledRules = [NSArray arrayWithArray:[tempArray copy]];
        
#if TARGET_OS_IOS
            UIColor *color;
#else
            NSColor *color;
#endif
        
        color = colorMap[@(SHCategoryDefault)];
        
        if (color == nil)
        {
#if TARGET_OS_IOS
                color = UIColor.labelColor;
#else
                color = NSColor.labelColor;
#endif
        }
        self.defaultColor = color;
    }
    
    return self;
}

-(instancetype)init
{
    self = [self initWithLanguage:[[SHLanguage alloc] init] colors:@[]];
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
        NSString *attribute = styledRule.rule.isBackgroundRule ? NSBackgroundColorAttributeName : NSForegroundColorAttributeName;
        [regex enumerateMatchesInString:str options:0 range:aRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            [aTextSorage addAttributes: @{ attribute : styledRule.color } range: result.range];
        }];
    }
}
@end
