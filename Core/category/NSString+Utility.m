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

- (CGSize)em_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize
{
    if (EMOSVersionLessThan(7.0)) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGSize size = [self sizeWithFont:font constrainedToSize:maxSize];
#pragma clang diagnostic pop
        return size;
    } else {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSDictionary *stringAttributes = [NSDictionary dictionaryWithObjects:@[font, paragraphStyle] forKeys:@[NSFontAttributeName, NSParagraphStyleAttributeName]];
        CGRect newRect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:stringAttributes context:nil];
        CGSize sizeAlignedToPixel = CGSizeMake(ceilf(newRect.size.width), ceilf(newRect.size.height));
        
        // 经过调研, sizeWithFont 与 label的text 高度计算值有1个像素的差异, 因此在这边高度+1了, 否则label会显示不全
        return CGSizeMake(sizeAlignedToPixel.width, sizeAlignedToPixel.height + 1);
    }
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


