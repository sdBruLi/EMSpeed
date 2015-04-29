//
//  EMMallScrollADData.h
//  EMStock
//
//  Created by zhangzhiyao on 14-10-9.
//  Copyright (c) 2014年 flora. All rights reserved.
//广告模块的数据模型

#import <Foundation/Foundation.h>

@class EMPageScrollData;

@protocol EMPageModel <NSObject>

@property (nonatomic,strong) NSString *title;   // 标题
@property (nonatomic,strong) NSString *img;     // image url
@property (nonatomic,strong) NSString *url;     // 跳转url
@property (nonatomic, strong) Class viewClass;  // view的class

@required
- (UIView *)viewWithData:(id<EMPageModel>)data;

@end


