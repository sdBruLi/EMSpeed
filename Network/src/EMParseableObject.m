//
//  EMParseableObject.m
//  F
//
//  Created by Ryan Wang on 4/14/15.
//  Copyright (c) 2015 Ryan Wang. All rights reserved.
//

#import "EMParseableObject.h"

@implementation EMParseableObject


+ (NSMutableArray *)parseArray:(NSArray *)array
{
    return [self parseArray:array options:0];
}


+ (instancetype)instanceWithData:(NSDictionary *)info
{
    return [self instanceWithData:info options:0];
}


- (instancetype)parse:(NSDictionary *)info
{
    return [self parse:info options:0];
}


+ (NSMutableArray *)parseArray:(NSArray *)array options:(NSUInteger)options
{
    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSMutableArray *objects = [NSMutableArray array];
    for (NSDictionary *e in array) {
        id<EMParser> m = [[self alloc]init];
        [m parse:e options:options];
        [objects addObject:m];
    }
    return objects;
}


+ (instancetype)instanceWithData:(NSDictionary *)info options:(NSUInteger)options
{
    return [[[self alloc] init] parse:info options:options];
}


- (instancetype)parse:(NSDictionary *)info options:(NSUInteger)options
{
    return self;
}

@end



