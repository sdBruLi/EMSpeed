//
//  EMActivityIndicatorTextData.h
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMStatusBarModel.h"

@interface EMActivityIndicatorTextModel : NSObject <EMStatusBarModel>

@property (nonatomic, assign) BOOL isActivityIndicatorAnimating; // 是否有动画
@property (nonatomic, assign) BOOL hasActivityIndicator; // 是否有loading

- (UIView<EMStatusBarUpdating> *)statusBarWithData:(id<EMStatusBarModel>)data;
@end
