//
//  JGOVerbalExpressions.h
//  JGOVerbalExpressions
//
//  Created by Jan Gorman on 11.08.13.
//  Copyright (c) 2013 Jan Gorman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGOVerbalExpressions : NSObject

extern JGOVerbalExpressions *VerEx();

- (JGOVerbalExpressions *)startOfLine;

- (JGOVerbalExpressions *)endOfLine;

- (JGOVerbalExpressions *)then:(NSString *)string;

- (JGOVerbalExpressions *)find:(NSString *)string;

- (JGOVerbalExpressions *)maybe:(NSString *)string;

- (JGOVerbalExpressions *)lineBreak;

- (JGOVerbalExpressions *)br;

- (JGOVerbalExpressions *)anything;

- (JGOVerbalExpressions *)something;

- (JGOVerbalExpressions *)somethingBut:(NSString *)string;

- (JGOVerbalExpressions *)tab;

- (JGOVerbalExpressions *)word;

- (JGOVerbalExpressions *)anyOf:(NSString *)string;

- (JGOVerbalExpressions *)any:(NSString *)string;

- (JGOVerbalExpressions *)multiple:(NSString *)string;

- (JGOVerbalExpressions *)or:(NSString *)string;

- (JGOVerbalExpressions *)anythingBut:(NSString *)string;

- (JGOVerbalExpressions *)addModifier:(char)modifier;

- (JGOVerbalExpressions *)removeModifier:(char)modifier;

- (JGOVerbalExpressions *)withAnyCase;

- (BOOL)test:(NSString *)stringToTest;

- (NSString *)replace:(NSString *)string with:(NSString *)with;

- (NSString *)description;

@end
