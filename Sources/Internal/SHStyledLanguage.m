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
@property (nonatomic, strong) SH_SYSTEM_COLOR_TYPE *defaultColor;
@end

@implementation SHStyledLanguage

@synthesize styledRules;
@synthesize defaultColor;

-(instancetype)initWithLanguage:(SHLanguage *)aLanguage
                         colors:(NSArray<SHColor *> *)aColors
{
    if (self = [super init])
    {
        NSMutableDictionary<NSNumber *, SH_SYSTEM_COLOR_TYPE *> *colorMap = [NSMutableDictionary dictionary];
        
        for (SHColor *shColor in aColors)
        {
            colorMap[@(shColor.category)] = shColor.color;
        }
        
        NSMutableArray<SHStyledRule *> *tempArray = [[NSMutableArray alloc] init];
        for (SHRule *rule in aLanguage.rules)
        {
            SH_SYSTEM_COLOR_TYPE *color;
            color = colorMap[@(rule.category)];
            
            SHStyledRule *styledRule = [[SHStyledRule alloc] initWithRule:rule color:color];
            [tempArray addObject:styledRule];
        }
        self.styledRules = [NSArray arrayWithArray:[tempArray copy]];
        
        SH_SYSTEM_COLOR_TYPE *color = colorMap[@(SHCategoryDefault)];
        
        if (color == nil)
        {
            color = SH_SYSTEM_COLOR_TYPE.labelColor;
        }
        self.defaultColor = color;
    }
    
    return self;
}

-(instancetype)init
{
    return [self initWithLanguage:[[SHLanguage alloc] init] colors:@[]];
}

-(void)processRulesForTextStorage:(NSTextStorage *)aTextSorage
                         withFont:(SH_SYSTEM_FONT_TYPE *)aFont
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
        NSString *attribute = styledRule.isBackgroundRule ? NSBackgroundColorAttributeName : NSForegroundColorAttributeName;
        [regex enumerateMatchesInString:str options:0 range:aRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            [aTextSorage addAttributes: @{ attribute : styledRule.color } range: result.range];
        }];
    }
}
@end
