//
//  SHLanguages.m
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import "SHLanguages.h"
#import "SHLanguage.h"
#import "SHRule.h"

@interface SHLanguages()
@property (nonatomic, strong) SHLanguage *asm6_6502;
@end

@implementation SHLanguages
-(instancetype)init
{
    if (self = [super init])
    {
        self.asm6_6502 = [[SHLanguage alloc] initWithName:@"6502 Asssembly (ASM6)" rules:@[
            [[SHRule alloc] initWithPattern:@"(\\s|^)(clc|cld|cli|dex|dey|inx|iny|nop|pha|pla|rti|rts|sei|tax|tay|tsx|txa|txs|tya|adc|and|asl|bcc|bcs|beq|bit|bmi|bne|bpl|brk|bvc|bvs|clv|cmp|cpx|cpy|dec|eor|inc|jmp|jsr|lda|ldx|ldy|lsr|ora|php|plp|rol|ror|sbc|sec|sed|sta|stx|sty)(\\s|$)"
                                    options:NSRegularExpressionCaseInsensitive | NSRegularExpressionAnchorsMatchLines
                                   category:Keyword],
            [[SHRule alloc] initWithPattern:@"(\\s|^)(\\.?)(pad|org|byte|word|align|incbin|bin|include|incsrc|error|enum|ende|rept|endr|macro|endm|ifdef|ifndef|if|else|elseif|endif|base|fillvalue|dsb|dsw|hex|dl|dh|db|dw|equ)(\\s|$)"
                                    options:NSRegularExpressionCaseInsensitive | NSRegularExpressionAnchorsMatchLines
                                   category:Directive],
            [[SHRule alloc] initWithPattern:@"\\$([0-9a-f])+"
                                    options:NSRegularExpressionCaseInsensitive
                                   category:Hex],
            [[SHRule alloc] initWithPattern:@"#\\$([0-9a-f])+"
                                    options:NSRegularExpressionCaseInsensitive
                                   category:HexLiteral],
            [[SHRule alloc] initWithPattern:@"\\%([0-1])+"
                                    options:0
                                   category:Binary],
            [[SHRule alloc] initWithPattern:@"#\\%([0-1])+"
                                    options:0
                                   category:BinaryLiteral],
            [[SHRule alloc] initWithPattern:@"#([0-9])+"
                                    options:0
                                   category:Decimal],
            [[SHRule alloc] initWithPattern:@","
                                    options:0
                                   category:DefaultText],
            [[SHRule alloc] initWithPattern:@";(.*)$"
                                    options:NSRegularExpressionAnchorsMatchLines
                                   category:CommentText],
        ]];
    }
}
@end
