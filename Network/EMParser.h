//
//  EMParse.h
//  F
//
//  Created by Ryan Wang on 4/14/15.
//  Copyright (c) 2015 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EMParser <NSObject>

@required

- (instancetype)parse:(NSDictionary *)info options:(NSUInteger)options; // 子类需要实现的方法

@optional
+ (instancetype)instanceWithData:(NSDictionary *)info options:(NSUInteger)options;
+ (NSMutableArray *)parseArray:(NSArray *)infos options:(NSUInteger)options;

@end
