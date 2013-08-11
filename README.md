VerbalExpressions
=================

## Objective-C Verbal Expressions made easy
A library to help you construct regular expressions in Objective-C. Based on the excellent [JSVerbalExpressions](https://github.com/VerbalExpressions/JSVerbalExpressions "JSVerbalExpressions").

## Installation
Add JGOVerbalExpressions.h and JGOVerbalExpressions.m to your project.

## Examples

### Test if we have a valid URL 
```Objective-C

JGOVerbalExpressions* verbEx = [[JGOVerbalExpressions alloc] init];

[[[[[verbEx.startOfLine
       then:@"http"]
      maybe:@"s"]
       then:@"://"]
      maybe:@"www."]
anythingBut:@" "].endOfLine;

NSString *URL = @"http://www.google.com";

BOOL test = [verbEx test:URL];
```

## TODO
Implement some more of the features found in the [API](https://github.com/VerbalExpressions/JSVerbalExpressions/wiki "API").