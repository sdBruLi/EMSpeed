//
//  EMIconTextStatusBarData.h
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMStatusBarModel.h"

@interface EMStatusBarIconTextModel : NSObject<EMStatusBarModel>

@property (nonatomic, strong) NSString *iconName;// 图标

- (UIView<EMStatusBarUpdating> *)statusBarWithData:(id<EMStatusBarModel>)data;

@end
