//
//  EMHTTPResponseParse.h
//  EMNetworkManager
//
//  Created by Mac mini 2012 on 15-5-4.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>


@class EMHTTPResponse;
@protocol EMHTTPResponseParse <NSObject>


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