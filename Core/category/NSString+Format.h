//
//  NSString+format.h
//  EMStock
//
//  Created by flora on 14-6-24.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Format)

/**
 *  将流量字符串转化, 流量值(byte), 转化为带K,M,G,T的字符串, 例如1204 -> 1KB
 *
 *  @param flowLen 流量值(byte)
 *
 *  @return 转换后的字符串
 */
+ (NSString *)em_stringWithFlowLength:(int)flowLen;


/**
 *  纯数字电话号码, 转换为带-号的电话号码格式
 *
 *  @return 电话号码格式字符串
 */
- (NSString *)em_phoneNumberDescription;


@end
