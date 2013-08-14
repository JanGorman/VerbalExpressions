VerbalExpressions
=================

## Objective-C regular expressions made easy
A library to help you construct regular expressions in Objective-C. Based on the excellent [JSVerbalExpressions](https://github.com/VerbalExpressions/JSVerbalExpressions "JSVerbalExpressions").

## Installation
Add JGOVerbalExpressions.h and JGOVerbalExpressions.m to your project.

## Examples

### Test if we have a valid URL 
```Objective-C
JGOVerbalExpressions *tester = [[[[[[VerEx().startOfLine
        then:@"http"]
        maybe:@"s"]
        then:@"://"]
        maybe:@"www."]
        anythingBut:@" "]
        endOfLine];

NSString *URL = @"http://www.google.com";

BOOL test = [tester test:URL];

// Display the pattern used
NSLog(@"%@", teser);
```

### Replacing strings
```Objective-C
NSString *string = @"Replace bird with a duck";

JGOVerbalExpressions *expression = [VerEx() find:@"bird"];

NSString *result = [expression replace:string with:@"duck"];

NSLog(@"%@", result);
```

## TODO
Implement some more of the features found in the [API](https://github.com/VerbalExpressions/JSVerbalExpressions/wiki "API").
