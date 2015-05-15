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

- (instancetype)mutableObjectFromJSONData;
- (instancetype)objectFromJSONData;


+ (NSMutableArray *)parseArray:(NSArray *)array;
+ (instancetype)instanceWithData:(NSDictionary *)info;
- (instancetype)parse:(NSDictionary *)info;

@end

