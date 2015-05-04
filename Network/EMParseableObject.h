//
//  EMParseableObject.h
//  F
//
//  Created by Ryan Wang on 4/14/15.
//  Copyright (c) 2015 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMParser.h"

@interface EMParseableObject : NSObject <EMParser>

+ (NSMutableArray *)parseArray:(NSArray *)array;
+ (instancetype)instanceWithData:(NSDictionary *)info;
- (instancetype)parse:(NSDictionary *)info;


+ (NSMutableArray *)parseArray:(NSArray *)array options:(NSUInteger)options;
+ (instancetype)instanceWithData:(NSDictionary *)info options:(NSUInteger)options;
- (instancetype)parse:(NSDictionary *)info options:(NSUInteger)options;

@end

