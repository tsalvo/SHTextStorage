//
//  LineLayoutTests.m
//  
//
//  Created by Tom Salvo on 10/3/21.
//

#import <XCTest/XCTest.h>
#import "../../Sources/Public/SHTextSorage.h"
#import "../../Sources/Public/SHLine.h"

static CGFloat const kFontSize = 14;
static CGFloat const kLineHeightTolerance = 0.25;

@interface LineLayoutTests : XCTestCase

@end

@implementation LineLayoutTests

- (void)setUp { }

- (void)tearDown { }

- (void)testThatLineHeightsAreCalculatedToMatchFontLineHeightWhenInitializedWithEmptyStringWithoutALayoutManager {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@""
                                  fontSize:kFontSize];

    XCTAssertEqual(textStorage.lines.count, 1);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, kFontSize, kFontSize * kLineHeightTolerance);
}

- (void)testThatLineHeightsAreCalculatedToMatchFontLineHeightWhenInitializedWithSingleLineStringWithoutALayoutManager {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@"Hello world!"
                                  fontSize:kFontSize];

    XCTAssertEqual(textStorage.lines.count, 1);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, kFontSize, kFontSize * kLineHeightTolerance);
}

- (void)testThatLineHeightsAreCalculatedToMatchFontLineHeightWhenInitializedWithMultiLineStringWithoutALayoutManager {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@"Hello\nworld!"
                                  fontSize:kFontSize];

    XCTAssertEqual(textStorage.lines.count, 2);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, kFontSize, kFontSize * kLineHeightTolerance);
    XCTAssertEqualWithAccuracy(textStorage.lines.lastObject.height, kFontSize, kFontSize * kLineHeightTolerance);
}

- (void)testLineHeightsWithEmptyStringAtInitializationFollowedByLayoutManagerAddition {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@""
                                  fontSize:kFontSize];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(240, 320)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = false;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];

    XCTAssertEqual(textStorage.lines.count, 1);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, kFontSize, kFontSize * kLineHeightTolerance);
}

- (void)testLineHeightsWithShortSingleLineStringAtInitializationFollowedByLayoutManagerAddition {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@"Hello world!"
                                  fontSize:kFontSize];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(240, 320)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = false;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];

    XCTAssertEqual(textStorage.lines.count, 1);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, kFontSize, kFontSize * kLineHeightTolerance);
}

- (void)testLineHeightsWithLongSingleLineStringAtInitializationFollowedByLayoutManagerAddition {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@"sdfhsjndvhjasdhvbsjadhbvjsdhbvjsdhbvjahsd"
                                  fontSize:kFontSize];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(240, 320)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = false;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];

    XCTAssertEqual(textStorage.lines.count, 1);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, 2 * kFontSize, 2 * kFontSize * kLineHeightTolerance);
}

- (void)testLineHeightsWithVeryLongSingleLineStringAtInitializationFollowedByLayoutManagerAddition {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@"sdfhsjndvhjasdhvbsjadhbvjsdhbvjsdhbvjahsdbvjahsdbvjashdbvjhasdvbjashdvbjasdhvbsdjvh"
                                  fontSize:kFontSize];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(240, 320)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = false;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];

    XCTAssertEqual(textStorage.lines.count, 1);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, 3 * kFontSize, 3 * kFontSize * kLineHeightTolerance);
}

- (void)testLineHeightsWithShortMultiLineStringAtInitializationFollowedByLayoutManagerAddition {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@"Hello\nworld!"
                                  fontSize:kFontSize];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(240, 320)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = false;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];

    XCTAssertEqual(textStorage.lines.count, 2);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, kFontSize, kFontSize * kLineHeightTolerance);
    XCTAssertEqualWithAccuracy(textStorage.lines.lastObject.height, kFontSize, kFontSize * kLineHeightTolerance);
}

- (void)testLineHeightsWithLongMultiLineStringAtInitializationFollowedByLayoutManagerAddition {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@"sdfhsjndvhjasdhvbsjadhbvjsdhbvjsdhbvjahsd\nsdfhsjndvhjasdhvbsjadhbvjsdhbvjsdhbvjahsd"
                                  fontSize:kFontSize];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(240, 320)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = false;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];

    XCTAssertEqual(textStorage.lines.count, 2);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, 2 * kFontSize, 2 * kFontSize * kLineHeightTolerance);
    XCTAssertEqualWithAccuracy(textStorage.lines.lastObject.height, 2 * kFontSize, 2 * kFontSize * kLineHeightTolerance);
}

- (void)testLineHeightsWithVaryingMultiLineStringAtInitializationFollowedByLayoutManagerAddition {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@"Hello world\nsdfhsjndvhjasdhvbsjadhbvjsdhbvjsdhbvjahsd"
                                  fontSize:kFontSize];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(240, 320)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = false;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];

    XCTAssertEqual(textStorage.lines.count, 2);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, kFontSize, kFontSize * kLineHeightTolerance);
    XCTAssertEqualWithAccuracy(textStorage.lines.lastObject.height, 2 * kFontSize, 2 * kFontSize * kLineHeightTolerance);
}

- (void)testLineHeightsWithEmptyStringAtInitializationFollowedByLayoutManagerAdditionAndSingleLineAppend {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@""
                                  fontSize:kFontSize];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(240, 320)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = false;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"Hello World"];

    XCTAssertEqual(textStorage.lines.count, 1);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, kFontSize, kFontSize * kLineHeightTolerance);
}

- (void)testLineHeightsWithEmptyStringAtInitializationFollowedByLayoutManagerAdditionAndNewlineAppend {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@""
                                  fontSize:kFontSize];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(240, 320)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = false;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"\n"];

    XCTAssertEqual(textStorage.lines.count, 2);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, kFontSize, kFontSize * kLineHeightTolerance);
    XCTAssertEqualWithAccuracy(textStorage.lines.lastObject.height, kFontSize, kFontSize * kLineHeightTolerance);
}

- (void)testLineHeightsWithEmptyStringAtInitializationFollowedByLayoutManagerAdditionAndLongSingleLineAppend {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@""
                                  fontSize:kFontSize];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(240, 320)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = false;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"sdfhsjndvhjasdhvbsjadhbvjsdhbvjsdhbvjahsd"];

    XCTAssertEqual(textStorage.lines.count, 1);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, 2 * kFontSize, 2 * kFontSize * kLineHeightTolerance);
}

- (void)testLineHeightsWithEmptyStringAtInitializationFollowedByLayoutManagerAdditionAndMultiLineAppend {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@""
                                  fontSize:kFontSize];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(240, 320)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = false;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"Hello\nworld!"];

    XCTAssertEqual(textStorage.lines.count, 2);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, kFontSize, kFontSize * kLineHeightTolerance);
    XCTAssertEqualWithAccuracy(textStorage.lines.lastObject.height, kFontSize, kFontSize * kLineHeightTolerance);
}

- (void)testLineHeightsWithEmptyStringAtInitializationFollowedByLayoutManagerAdditionAndVaryingLengthMultiLineAppend {
    SHTextStorage *textStorage = [[SHTextStorage alloc]
                                  initWithString:@""
                                  fontSize:kFontSize];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(240, 320)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = false;
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"Hello world\nsdfhsjndvhjasdhvbsjadhbvjsdhbvjsdhbvjahsd"];

    XCTAssertEqual(textStorage.lines.count, 2);
    XCTAssertEqualWithAccuracy(textStorage.lines.firstObject.height, kFontSize, kFontSize * kLineHeightTolerance);
    XCTAssertEqualWithAccuracy(textStorage.lines.lastObject.height, 2 * kFontSize, 2 * kFontSize * kLineHeightTolerance);
}

@end
