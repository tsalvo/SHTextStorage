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

@interface InitializationTests : XCTestCase

@end

@implementation InitializationTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testBasicInit {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSArray<SHRule *> *rules = @[
        [[SHRule alloc] initWithPattern:@"(\\s|^)(lda|sta)(\\s|$)"
                                options:NSRegularExpressionCaseInsensitive | NSRegularExpressionAnchorsMatchLines
                               category:Keyword]
    ];
    SHLanguage *language = [[SHLanguage alloc] initWithName:@"6502 Asssembly (ASM6)" rules: rules];
    
    SHColorSet *colorSet = [[SHColorSet alloc] initWithColorMap:@{
#if TARGET_OS_IOS
        @(DefaultText) : UIColor.labelColor
#else
        @(DefaultText) : NSColor.labelColor
#endif
    }];
    
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithLanguage:language
                                                                colorSet:colorSet
#if TARGET_OS_IOS
                                                                    font:[UIFont monospacedSystemFontOfSize:14 weight: UIFontWeightSemibold]];
#else
                                                                    font:[NSFont monospacedSystemFontOfSize:14 weight: NSFontWeightSemibold]];
#endif
    
}


@end
