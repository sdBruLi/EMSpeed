//
//  NSString+Extended.m
//  EMStock
//
//  Created by deng flora on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString(Utility)

- (NSString *)em_trim
{
	NSCharacterSet *ws = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	NSString *trimmed = [self stringByTrimmingCharactersInSet:ws];
	return trimmed;
}

- (CGSize)em_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)asize
{
    CGSize size;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    size = [self sizeWithFont:font constrainedToSize:asize];
#pragma clang diagnostic pop
	return size;
}

- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
    
}

- (NSString *)em_firstLetterCapitalized
{
    if ([self length]>0) {
        NSString *firstChar = [self substringToIndex:1];
        NSString *tmpStr = [self stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[firstChar uppercaseString]];
        return tmpStr;
    }
    else{
        return self;
    }
}



- (BOOL)em_hasLetter
{
    for(int i =0 ;i<[self length]; i++) {
        char c = [self characterAtIndex:i];
        if ((c >='A'&& c<='Z') || (c >='a'&& c<='z')) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)em_isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,16}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


- (BOOL)em_isPureNumandCharacters
{
    if([self length] > 0)
    {
        NSString *regex = [NSString stringWithFormat:@"[0-9]{%lu}", (unsigned long)[self length]];
        NSPredicate* _pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL bRes =  ([_pred evaluateWithObject:self]);
        return bRes;
    }
    return NO;
}


- (BOOL)em_isPhoneNumber
{
    return (11 == [self length]) ? [self em_isPureNumandCharacters] : NO;
}


@end


