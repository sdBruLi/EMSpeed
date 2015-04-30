//
//  NSString+utility.h
//  EMStock
//
//  Created by deng flora on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSString(Utility)


/**
*  去掉前后空白处
*
*  @return 处理后的字符串
*/
- (NSString *)em_trim;


/**
 *  根据字体和尺寸, 计算字符串高度
 *
 *  @param font  字体大小
 *  @param asize 容器最大尺寸
 *
 *  @return 尺寸
 */
- (CGSize)em_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize;


/**
 *  首字母大写
 *
 *  @return 处理后的字符串
 */
- (NSString *)em_firstLetterCapitalized;


/**
 *  字符串中是否有字母
 *
 *  @return BOOL
 */
- (BOOL)em_hasLetter;


/**
 *  是否是email格式
 *
 *  @return 正确或错误
 */
- (BOOL)em_isEmail;


/**
 *  纯数字
 *
 *  @return 正确或错误
 */
- (BOOL)em_isPureNumandCharacters;


/**
 *  是否11位纯数字手机号
 *
 *  @return 正确或失败
 */
- (BOOL)em_isPhoneNumber;


@end

