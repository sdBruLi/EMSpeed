//
//  EMThemeDownloadManager.h
//  EMStock
//
//  Created by zhangzhiyao on 15-1-29.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMModelProtocol.h"
#import "EMProgressDownloadButton.h"

@interface EMThemeDownloadManager : NSObject<EMModelProtocol> {
    
}

+ (instancetype)sharedManager;

- (void)loadTheme:(NSString *)themeName downloadButton:(EMProgressDownloadButton*)downloadButton completion:(void (^)(BOOL success,NSString *result))completion;
- (void)download:(NSString*)urlStr themeName:(NSString*)themeName downloadButton:(EMProgressDownloadButton*)downloadButton completion:(void (^)(BOOL success,NSString *result))completion;
- (void)cancelDownload;

/**
 * 下载的主题色图片的读取地址，当前主题色对应的地址
 *
 *  @return 图片文件地址
 */
+ (NSString *)currentThemeImageDirectory;


/**
 * 下载的主题色图片的读取地址，指定主题色对应的地址
 *
 *  @return 图片文件地址
 */
+ (NSString *)themeImageDirectory:(NSString *)themeName;

@end
