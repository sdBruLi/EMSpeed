//
//  EMHTTPResponse.h
//  EMStock
//
//  Created by Ryan Wang on 4/13/15.
//  Copyright (c) 2015 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMHTTPResponse : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSDate *updateTime;
@property (nonatomic, strong) id responseData; // dictionary or array

+ (instancetype)responseWithResponseObject:(NSDictionary *)responseObject;



/**
 *  判断是否为EM标准的JSON数据返回格式, 字典包含status, updatetime, data字段
 *
 *  @param responseObject 输入需要判断的对象
 *
 *  @return 是否
 */
+ (BOOL)isEMStandardResponse:(id)responseObject;

@end
