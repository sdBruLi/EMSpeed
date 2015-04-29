//
//  EMEncoding.m
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-6.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (OAURLEncodingAdditions)

- (NSString *)em_URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    return result;
}

- (NSString*)em_URLDecodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
}

#pragma mark 获得时间戳
+ (NSString *)em_generateTimestamp
{
    return [NSString stringWithFormat:@"%ld", time(NULL)];
}

#pragma mark 获得随时字符串
+ (NSString *)em_generateUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    return (__bridge NSString *)string;
}

- (NSDictionary *)em_toResponseDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *arr1 = [self componentsSeparatedByString:@"&"];
    
    for (int i = 0; i < [arr1 count]; i++)
    {
        NSString *sub = [arr1 objectAtIndex:i];
        NSArray *arr2 = [sub componentsSeparatedByString:@"="];
        if ([arr2 count]>=2) {
            NSString *key = [arr2 objectAtIndex:0];
            NSString *value = [arr2 objectAtIndex:1];
            [dict setObject:value forKey:key];
        }
    }
    return dict;
}


@end

