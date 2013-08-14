//
//  JGOVerbalExpressionsTests.m
//  JGOVerbalExpressionsTests
//
//  Created by Jan Gorman on 11.08.13.
//  Copyright (c) 2013 Jan Gorman. All rights reserved.
//

#import "JGOVerbalExpressionsTests.h"
#import "JGOVerbalExpressions.h"

@interface JGOVerbalExpressionsTests ()

@end

@implementation JGOVerbalExpressionsTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testURL {
    JGOVerbalExpressions *tester = [[[[[[VerEx().startOfLine
            then:@"http"]
            maybe:@"s"]
            then:@"://"]
            maybe:@"www."]
            anythingBut:@" "]
            endOfLine];

    NSString *valid = @"http://www.google.com";

    STAssertTrue([tester test:valid], nil);

    NSString *invalid = @"http://www.google .com";

    STAssertFalse([tester test:invalid], nil);
}

- (void)testSomething {
    JGOVerbalExpressions *tester = VerEx().something;

    NSString *valid = @"This string contains something";

    STAssertTrue([tester test:valid], nil);
}

- (void)testCaseInsensitive {
    JGOVerbalExpressions *tester = [[VerEx() any:@"a"] addModifier:'i'];

    NSString *valid = @"AAAA";

    STAssertTrue([tester test:valid], nil);

    [tester removeModifier:'i'];

    STAssertFalse([tester test:valid], nil);
}

- (void)testCaseSensitive {
    JGOVerbalExpressions *tester = [VerEx() any:@"a"];

    NSString *invalid = @"AAAA";

    STAssertFalse([tester test:invalid], nil);

    NSString *valid = @"aaaa";
    STAssertTrue([tester test:valid], nil);
}

- (void)testLineBreak {
    JGOVerbalExpressions *tester = [[[[VerEx() startOfLine] then:@"foo"] lineBreak] then:@"bar"];

    NSString *invalid = @"foobar";

    STAssertFalse([tester test:invalid], nil);

    NSString *valid = @"foo\r\nbar";

    NSLog(@"%@", tester);

    STAssertTrue([tester test:valid], nil);
}

@end
