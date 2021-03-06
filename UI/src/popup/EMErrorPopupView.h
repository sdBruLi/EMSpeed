//
//  EMErrorView.h
//  EMStock
//
//  Created by Samuel on 15/3/24.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMPopupView.h"

/**
 *  自定义错误风格的弹框
 */
@interface EMErrorPopupView : EMPopupView


/**
 *  点击事件block
 */
@property (nonatomic, copy) em_popupview_event_block_t block;


/**
 *  根据文字弹出弹框
 *
 *  @param text 文字
 *
 *  @return 实例 EMErrorPopupView
 */
+ (instancetype)errorPopupWithText:(NSString *)text;


/**
 *  根据文字弹出弹框
 *
 *  @param text  文字
 *  @param block 点击事件block
 *
 *  @return 实例 EMErrorPopupView
 */
+ (instancetype)errorPopupWithText:(NSString *)text
                             block:(em_popupview_event_block_t)block;


- (void)show;
- (void)dismiss;

@end
