//
//  UIImage+theme.h
//  EMStock
//
//  Created by xoHome on 14-11-9.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(theme)


/**
 *  根据图片名返回某种style的图片
 *
 *  @param key 图片名
 *
 *  @return 图片
 */
+ (UIImage *)imageForKey:(NSString *)key;


/**
 *  根据当前的场景读取图片
 *
 *  @param name 图片文件名
 *
 *  @return 图片
 */
+ (UIImage *)themeImageNamed:(NSString *)name;


/**
 *  从本地存储文件中读取主题色相关图片
 *  获取当前主题色文件存储地址
 *  获取当前主题色图片名称
 *  从本地读取主题色图片
 *
 *  @param name 图片名称
 *  @param ext  图片文件类型
 *
 *  @return 图片
 */
+ (UIImage *)localThemeImageNamed:(NSString *)name extension:(NSString*)ext;


/**
 *  从本地存储文件中读取主题色相关图片
 *  获取当前主题色文件存储地址
 *  获取当前主题色图片名称
 *  从本地读取主题色图片
 *
 *  @param name 图片名称
 *
 *  @return 图片
 */
+ (UIImage *)localThemeImageNamed:(NSString *)name;

@end
