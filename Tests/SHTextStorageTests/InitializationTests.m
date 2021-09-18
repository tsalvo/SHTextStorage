//
//  Test.m
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import <XCTest/XCTest.h>
#import "../../Sources/Public/SHLanguage.h"
#import "../../Sources/Public/SHTextSorage.h"
#import "../../Sources/Public/SHCategory.h"
#import "../../Sources/Public/SHColor.h"

@interface InitializationTests : XCTestCase

@end

@implementation InitializationTests

- (void)setUp
{
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testBasicInit
{
    NSArray<SHRule *> *rules = @[
        [[SHRule alloc] initWithPattern:@"(\\s|^)(lda|sta)(\\s|$)"
                                options:NSRegularExpressionCaseInsensitive | NSRegularExpressionAnchorsMatchLines
                               category:SHCategoryKeyword]
    ];
    SHLanguage *language = [[SHLanguage alloc] initWithName:@"6502 Asssembly (ASM6)" rules: rules];
    NSArray<SHColor *> *colors = @[
#if TARGET_OS_IOS
        [[SHColor alloc] initWithCategory:SHCategoryDefault color:UIColor.labelColor]
#else
        [[SHColor alloc] initWithCategory:SHCategoryDefault color:NSColor.labelColor]
#endif
    ];

    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithLanguage:language
                                                                  colors:colors
#if TARGET_OS_IOS
                                                                    font:[UIFont monospacedSystemFontOfSize:14 weight: UIFontWeightSemibold]];
#else
                                                                    font:[NSFont monospacedSystemFontOfSize:14 weight: NSFontWeightSemibold]];
#endif
    
    XCTAssertNotNil(textStorage);
}


@end
