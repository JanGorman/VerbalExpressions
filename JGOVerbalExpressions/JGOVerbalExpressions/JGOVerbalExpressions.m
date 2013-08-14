//
//  JGOVerbalExpressions.m
//  JGOVerbalExpressions
//
//  Created by Jan Gorman on 11.08.13.
//  Copyright (c) 2013 Jan Gorman. All rights reserved.
//

#import "JGOVerbalExpressions.h"

@interface JGOVerbalExpressions () {
    int options;
    NSString *prefixes;
    NSString *suffixes;
    NSMutableString *source;
}

@end

@implementation JGOVerbalExpressions

JGOVerbalExpressions *VerEx() {
    return [[JGOVerbalExpressions alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        options = 0;
        prefixes = @"";
        suffixes = @"";
        source = [[NSMutableString alloc] initWithString:@""];
    }
    return self;
}

- (JGOVerbalExpressions *)add:(NSString *)string {
    [source appendString:[NSRegularExpression escapedPatternForString:string]];
    return self;
}

- (JGOVerbalExpressions *)add:(NSString *)string withFormat:(NSString *)format {
    [source appendFormat:format, [NSRegularExpression escapedPatternForString:string]];
    return self;
}

- (JGOVerbalExpressions *)startOfLine {
    prefixes = @"^";
    return self;
}

- (JGOVerbalExpressions *)endOfLine {
    suffixes = @"$";
    return self;
}

- (JGOVerbalExpressions *)then:(NSString *)string {
    return [self add:string withFormat:@"(%@)"];
}

- (JGOVerbalExpressions *)maybe:(NSString *)string {
    return [self add:string withFormat:@"(%@)?"];
}

- (JGOVerbalExpressions *)anything {
    [source appendString:@"(.*)"];
    return self;
}

- (JGOVerbalExpressions *)something {
    [source appendString:@"(.+)"];
    return self;
}

- (JGOVerbalExpressions *)somethingBut:(NSString *)string {
    return [self add:string withFormat:@"([^%@]+)"];
}

- (JGOVerbalExpressions *)tab {
    return [self add:@"\t"];
}

- (JGOVerbalExpressions *)anyOf:(NSString *)string {
    return [self add:string withFormat:@"[%@]"];
}

- (JGOVerbalExpressions *)any:(NSString *)string {
    return [self anyOf:string];
}

- (JGOVerbalExpressions *)multiple:(NSString *)string {
    switch ([string characterAtIndex:0]) {
        case '*':
        case '+':
            break;
        default:
            [string stringByAppendingString:@"+"];
            break;
    }

    return [self add:string];
}

- (JGOVerbalExpressions *)or:(NSString *)string {
    if ([prefixes rangeOfString:@"("].location == NSNotFound) {
        prefixes = [prefixes stringByAppendingString:@"("];
    }

    if ([suffixes rangeOfString:@")"].location == NSNotFound) {
        suffixes = [suffixes stringByAppendingString:[NSString stringWithFormat:@")%@", suffixes]];
    }

    [self add:@")|("];

    return string ? [self then:string] : self;
}

- (JGOVerbalExpressions *)anythingBut:(NSString *)string {
    return [self add:string withFormat:@"([^%@]*)"];
}

- (JGOVerbalExpressions *)addModifier:(char)modifier {
    switch (modifier) {
        case 'd':
            options |= NSRegularExpressionUseUnixLineSeparators;
            break;
        case 'i':
            options |= NSRegularExpressionCaseInsensitive;
            break;
        case 'x':
            options |= NSRegularExpressionAllowCommentsAndWhitespace;
            break;
        case 's':
            options |= NSRegularExpressionDotMatchesLineSeparators;
            break;
        case 'U':
            options |= NSRegularExpressionUseUnicodeWordBoundaries;
            break;
        default:
            break;
    }

    return self;
}

- (JGOVerbalExpressions *)removeModifier:(char)modifier {
    switch (modifier) {
        case 'd':
            options ^= NSRegularExpressionUseUnixLineSeparators;
            break;
        case 'i':
            options ^= NSRegularExpressionCaseInsensitive;
            break;
        case 'x':
            options ^= NSRegularExpressionAllowCommentsAndWhitespace;
            break;
        case 's':
            options ^= NSRegularExpressionDotMatchesLineSeparators;
            break;
        case 'U':
            options ^= NSRegularExpressionUseUnicodeWordBoundaries;
            break;
        default:
            break;
    }
    return self;
}

- (NSRegularExpression *)getExpression:(NSError **)error {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"%@%@%@", prefixes,
                                                                                                              source, suffixes]
                                                                           options:options
                                                                             error:error];
    return regex;
}

- (BOOL)test:(NSString *)stringToTest {
    NSError *error;
    NSRegularExpression *regex = [self getExpression:&error];

    NSAssert(!error, @"Invalid regular expression");

    return [regex numberOfMatchesInString:stringToTest options:0 range:NSMakeRange(0, stringToTest.length)] > 0;
}

- (NSString *)description {
    return [self getExpression:nil].pattern;
}

@end
