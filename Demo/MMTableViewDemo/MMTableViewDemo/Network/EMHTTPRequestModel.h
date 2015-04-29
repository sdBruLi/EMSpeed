//
//  EMStockWebModel.h
//  EMStock
//
//  Created by Mac mini 2012 on 14-9-19.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "AFNetworking.h"

@class EMHTTPResponse;
@protocol EMHTTPResponseParse <NSObject>

@required

/**
 *  解析HTTP请求返回的对象, 如果是标准格式, 会将最外层的字典(包含status, updatetime, data字段)解析,
 *  如果不是标准格式, 则需要自己重写了
 *
 *  @param responseObject HTTP请求返回的对象
 *  @param url            HTTP请求的URL
 *
 *  @return 是否解析成功
 */
- (BOOL)parseResponseObject:(id)responseObject
                        URL:(NSString *)URLString;

@optional

/**
 *  解析HTTP请求返回的对象, 如果是标准格式下, 只需要实现这个方法就可以了, 所有数据已保存在EMHTTResponse中
 *
 *  @param response  经过解析的EMHTTResponse对象
 *  @param URLString HTTP请求的URL
 *
 *  @return 是否解析成功
 */
- (BOOL)parseHTTPResponse:(EMHTTPResponse *)response
                      URL:(NSString *)URLString;




@end


@interface EMHTTPRequestModel : NSObject <EMHTTPResponseParse>


- (instancetype)init;


- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                          param:(NSDictionary *)param
                          block:(void (^)(id respondObject, AFHTTPRequestOperation *operation, BOOL success))block;


- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                           param:(NSDictionary *)param
                           block:(void (^)(id respondObject, AFHTTPRequestOperation *operation, BOOL success))block;


- (BOOL)parseResponseObject:(id)responseObject
                        URL:(NSString *)URLString;


- (BOOL)parseHTTPResponse:(EMHTTPResponse *)response
                      URL:(NSString *)URLString;

@end
