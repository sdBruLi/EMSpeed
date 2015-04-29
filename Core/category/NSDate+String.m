//
//  NSObject+NSDate_description.m
//  EMStock
//
//  Created by flora deng on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDate+String.h"

static NSDateFormatter *g_currentDateFormatter = nil;

@implementation NSDate(String)

+ (NSString *)em_dateDescription
{
    return [[NSDate date] em_stringWithDateType:EMDateStringDefault];
}


- (NSString*)em_stringFromDate
{
    return [self em_stringWithDateType:EMDateStringDefault];
}


+ (NSDate *)em_dateFromString:(NSString *)string
{
    NSDateFormatter *dateFormatter = [NSDate fullFormatter];
    return [dateFormatter dateFromString:string];
}


- (NSString *)em_stringWithDateType:(EMDateStringType)dateType
{
    NSDateFormatter *dateFormatter = nil;
    
    switch (dateType) {
        case EMDateStringDefault:
            dateFormatter = [NSDate defaultFormatter];
            break;
        case EMDateStringDay:
            dateFormatter = [NSDate dayFormatter];
            break;
        case EMDateStringTime:
            dateFormatter = [NSDate timeFormatter];
            break;
        case EMDateStringYear:
            dateFormatter = [NSDate timeFormatter];
            break;
        case EMDateStringFull:
            dateFormatter = [NSDate fullFormatter];
            break;
    }
    
    return [dateFormatter stringFromDate:self];
}

+ (NSDate *)em_dateWithString:(NSString *)string
                      type:(EMDateStringType)dateType
{
    NSDateFormatter *dateFormatter = nil;
    
    switch (dateType) {
        case EMDateStringDefault:
            dateFormatter = [NSDate defaultFormatter];
            break;
        case EMDateStringDay:
            dateFormatter = [NSDate dayFormatter];
            break;
        case EMDateStringTime:
            dateFormatter = [NSDate timeFormatter];
            break;
        case EMDateStringYear:
            dateFormatter = [NSDate timeFormatter];
            break;
        case EMDateStringFull:
            dateFormatter = [NSDate fullFormatter];
        break;
    }
    
    return [dateFormatter dateFromString:string];
}


+ (NSDateFormatter *)defaultFormatter
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"defaultFormatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
                threadDictionary[@"defaultFormatter"] = dateFormatter;
            }
        }
    }
    
    return dateFormatter;
}


+ (NSDateFormatter *)dayFormatter
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"defaultDayFormatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MM月dd日"];
                threadDictionary[@"defaultDayFormatter"] = dateFormatter;
            }
        }
    }
    
    return dateFormatter;
}


+ (NSDateFormatter *)timeFormatter
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"defaultTimeFormatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH:mm"];
                threadDictionary[@"defaultTimeFormatter"] = dateFormatter;
            }
        }
    }
    
    return dateFormatter;
}


+ (NSDateFormatter *)fullFormatter
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"defaultFullFormatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                threadDictionary[@"defaultFullFormatter"] = dateFormatter;
            }
        }
    }
    
    return dateFormatter;
}

- (NSString *)em_stringWithDateFormate:(NSString *)formate
                           amSymbol:(NSString *)amSymbol
                           pmSymbol:(NSString *)pmSymbol
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:formate];
    [format setAMSymbol:amSymbol];
    [format setPMSymbol:pmSymbol];
    
    return [format stringFromDate:self];
}

@end



