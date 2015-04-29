//
//  NSObject+NSDate_description.h
//  EMStock
//
//  Created by flora deng on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 常用的一些转换类型
 */
typedef NS_ENUM(NSUInteger, EMDateStringType) {
    EMDateStringDefault,    // MM月dd日 HH:mm
    EMDateStringDay,        // MM月dd日
    EMDateStringTime,       // HH:mm
    EMDateStringYear,       // YYYY年MM月dd日
    EMDateStringFull,       // YYYY年MM月dd日 HH:mm
};

/**
 *  日期和字符串 互相转化
 */
@interface NSDate (String)


/**
 *  date转字符串 MM月dd日 HH:mm
 *
 *  @return 返回字符串
 */
+ (NSString *)em_dateDescription;


/**
 *  date转字符串  MM月dd日 HH:mm
 *
 *  @return 返回字符串
 */
- (NSString *)em_stringFromDate;


/**
 *  字符串转date  MM月dd日 HH:mm
 *
 *  @param string 字符串
 *
 *  @return 返回日期
 */
+ (NSDate *)em_dateFromString:(NSString *)string;


/**
 *  字符串转date, 根据常用的type
 *
 *  @param dateType 日期格式类型
 *
 *  @return 字符串
 */
- (NSString *)em_stringWithDateType:(EMDateStringType)dateType;


/**
 *  string转date, 根据常用的type
 *
 *  @param string   字符串
 *  @param dateType 日期格式类型
 *
 *  @return 日期
 */
+ (NSDate *)em_dateWithString:(NSString *)string
                         type:(EMDateStringType)dateType;


/**
 *  字符串转date, 自定义, 效率略低些
 *
 *  @param formate  字符串
 *  @param amSymbol 上午格式
 *  @param pmSymbol 下午格式
 *
 *  @return 字符串
 */
- (NSString *)em_stringWithDateFormate:(NSString *)formate
                              amSymbol:(NSString *)amSymbol
                              pmSymbol:(NSString *)pmSymbol;


@end




