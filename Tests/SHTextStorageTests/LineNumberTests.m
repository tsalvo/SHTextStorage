//
//  LineNumberTests.m
//  
//
//  Created by Tom Salvo on 9/18/21.
//

#import <XCTest/XCTest.h>
#import "../../Sources/Public/SHTextSorage.h"

@interface LineNumberTests : XCTestCase

@end

@implementation LineNumberTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testNumberOfLinesAfterInitializationWithNoStringSpecified {
    SHTextStorage *textStorage = [[SHTextStorage alloc] init];
    XCTAssertEqual(textStorage.numberOfLines, 1);
}

- (void)testNumberOfLinesAfterInitializationWithEmptyString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@""];
    XCTAssertEqual(textStorage.numberOfLines, 1);
}

- (void)testNumberOfLinesAfterInitializationWithNewLineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"\n"];
    XCTAssertEqual(textStorage.numberOfLines, 2);
}

- (void)testNumberOfLinesAfterInitializationWithOneLineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello world"];
    XCTAssertEqual(textStorage.numberOfLines, 1);
}

- (void)testNumberOfLinesAfterInitializationWithMultilineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello\nworld"];
    XCTAssertEqual(textStorage.numberOfLines, 2);
}

- (void)testNumberOfLinesAfterAppendingOneLineStringToEmptyString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@""];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"hello world"];
    XCTAssertEqual(textStorage.numberOfLines, 1);
}

- (void)testNumberOfLinesAfterAppendingNewlineStringToEmptyString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@""];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"\n"];
    XCTAssertEqual(textStorage.numberOfLines, 2);
}

- (void)testNumberOfLinesAfterAppendingMultilineStringToEmptyString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@""];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"hello\nworld"];
    XCTAssertEqual(textStorage.numberOfLines, 2);
}

- (void)testNumberOfLinesAfterAppendingOneLineStringToOneLineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello"];
    [textStorage replaceCharactersInRange:NSMakeRange(5, 0) withString:@" world"];
    XCTAssertEqual(textStorage.numberOfLines, 1);
}

- (void)testNumberOfLinesAfterAppendingNewlineStringToOneLineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello"];
    [textStorage replaceCharactersInRange:NSMakeRange(5, 0) withString:@"\n"];
    XCTAssertEqual(textStorage.numberOfLines, 2);
}

- (void)testNumberOfLinesAfterAppendingMultilineStringToOneLineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello"];
    [textStorage replaceCharactersInRange:NSMakeRange(5, 0) withString:@"\nworld"];
    XCTAssertEqual(textStorage.numberOfLines, 2);
}

- (void)testNumberOfLinesAfterAppendingNewlineStringToMultilineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello\nworld"];
    [textStorage replaceCharactersInRange:NSMakeRange(11, 0) withString:@"\n"];
    XCTAssertEqual(textStorage.numberOfLines, 3);
}

- (void)testNumberOfLinesAfterAppendingMultilineStringToMultilineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello\nworld"];
    [textStorage replaceCharactersInRange:NSMakeRange(11, 0) withString:@"!!!\n!!!!"];
    XCTAssertEqual(textStorage.numberOfLines, 3);
}

- (void)testNumberOfLinesAfterFullStringReplacementOfOneLineStringWithEmptyString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello"];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 5) withString:@""];
    XCTAssertEqual(textStorage.numberOfLines, 1);
}

- (void)testNumberOfLinesAfterFullStringReplacementOfOneLineStringWithOneLineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello"];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 5) withString:@"world!"];
    XCTAssertEqual(textStorage.numberOfLines, 1);
}

- (void)testNumberOfLinesAfterFullStringReplacementOfOneLineStringWithNewlineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello"];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 5) withString:@"\n"];
    XCTAssertEqual(textStorage.numberOfLines, 2);
}

- (void)testNumberOfLinesAfterFullStringReplacementOfOneLineStringWithMultilineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello"];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 5) withString:@"\nworld!"];
    XCTAssertEqual(textStorage.numberOfLines, 2);
}

- (void)testNumberOfLinesAfterFullStringReplacementOfMultilineStringWithEmptyString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello\nworld!"];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 12) withString:@""];
    XCTAssertEqual(textStorage.numberOfLines, 1);
}

- (void)testNumberOfLinesAfterFullStringReplacementOfMultilineStringWithOneLineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello\nworld!"];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 12) withString:@"hello world"];
    XCTAssertEqual(textStorage.numberOfLines, 1);
}

- (void)testNumberOfLinesAfterFullStringReplacementOfMultilineStringWithNewlineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello\nworld!"];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 12) withString:@"\n"];
    XCTAssertEqual(textStorage.numberOfLines, 2);
}

- (void)testNumberOfLinesAfterFullStringReplacementOfMultilineStringWithMultilineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello\nworld!"];
    [textStorage replaceCharactersInRange:NSMakeRange(0, 12) withString:@"hello\nworld\ntest"];
    XCTAssertEqual(textStorage.numberOfLines, 3);
}

- (void)testNumberOfLinesAfterPartialStringReplacementOfOneLineStringWithEmptyString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello world!"];
    [textStorage replaceCharactersInRange:NSMakeRange(5, 1) withString:@""];
    XCTAssertEqual(textStorage.numberOfLines, 1);
}

- (void)testNumberOfLinesAfterPartialStringReplacementOfOneLineStringWithOneLineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello world!"];
    [textStorage replaceCharactersInRange:NSMakeRange(5, 1) withString:@"to the "];
    XCTAssertEqual(textStorage.numberOfLines, 1);
}

- (void)testNumberOfLinesAfterPartialStringReplacementOfOneLineStringWithNewLineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello world!"];
    [textStorage replaceCharactersInRange:NSMakeRange(5, 1) withString:@"\n"];
    XCTAssertEqual(textStorage.numberOfLines, 2);
}

- (void)testNumberOfLinesAfterPartialStringReplacementOfOneLineStringWithMultiLineString {
    SHTextStorage *textStorage = [[SHTextStorage alloc] initWithString:@"hello world!"];
    [textStorage replaceCharactersInRange:NSMakeRange(5, 1) withString:@"\nto the\n"];
    XCTAssertEqual(textStorage.numberOfLines, 3);
}

@end
