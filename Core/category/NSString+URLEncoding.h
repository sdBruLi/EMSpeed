//
//  EMEncoding.h
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-6.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSString (EncodingAdditions)

/**
 *  URL encode
 *
 *  @return encode后的字符串
 */
- (NSString *)em_URLEncodedString;


/**
 *  URL decode
 *
 *  @return decode后的字符串
 */
- (NSString *)em_URLDecodedString;


/**
 *  获取时间戳
 *
 *  @return 时间戳字符串
 */
+ (NSString *)em_generateTimestamp;


/**
 *  生成一个UUID
 *
 *  @return UUID字符串
 */
+ (NSString *)em_generateUUID;


/**
 *  url根据&和=号, 解成字典
 *
 *  @return 字典
 */
- (NSDictionary *)em_toResponseDictionary;


@end

