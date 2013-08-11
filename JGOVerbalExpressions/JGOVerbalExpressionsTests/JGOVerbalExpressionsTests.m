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

@property(nonatomic, strong) JGOVerbalExpressions *verbEx;

@end

@implementation JGOVerbalExpressionsTests

- (void)setUp {
    [super setUp];
    self.verbEx = [[JGOVerbalExpressions alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testURL {
    [[[[[self.verbEx.startOfLine
            then:@"http"]
            maybe:@"s"]
            then:@"://"]
            maybe:@"www."]
            anythingBut:@" "].endOfLine;

    NSString *valid = @"http://www.google.com";

    STAssertTrue([self.verbEx test:valid], nil);

    NSString *invalid = @"http://www.google .com";

    STAssertFalse([self.verbEx test:invalid], nil);
}

- (void)testSomething {
    self.verbEx.something;

    NSString *valid = @"This string contains something";

    STAssertTrue([self.verbEx test:valid], nil);
}

- (void)testCaseInsensitive {
    [[self.verbEx any:@"a"] addModifier:'i'];

    NSString *valid = @"AAAA";

    STAssertTrue([self.verbEx test:valid], nil);

    [self.verbEx removeModifier:'i'];

    STAssertFalse([self.verbEx test:valid], nil);
}

- (void)testCaseSensitive {
    [self.verbEx any:@"a"];

    NSString *invalid = @"AAAA";

    STAssertFalse([self.verbEx test:invalid], nil);

    NSString *valid = @"aaaa";
    STAssertTrue([self.verbEx test:valid], nil);
}

@end
