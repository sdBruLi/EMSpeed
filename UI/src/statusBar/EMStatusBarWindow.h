//
//  EMTextStatusBar.h
//  YCStock
//
//  Created by meiosis chen on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMStatusBarUpdating.h"
#import "EMStatusBarModel.h"

/**
 *  状态栏文字窗口
 */
@interface EMStatusBarWindow : UIWindow
{
    UIView<EMStatusBarUpdating> *_statusBar0;
    UIView<EMStatusBarUpdating> *_statusBar1;
    BOOL _isSwaped;
    
    BOOL _isAnimating;
    NSMutableArray *_array;
}

@property (nonatomic, assign) BOOL isAutoHidden; // 播放到最后一个时是否自动隐藏, 默认YES

+ (EMStatusBarWindow *)sharedManager;

+ (void)showStatusBarWithModel:(id<EMStatusBarModel>)data;
+ (void)showStatusBarWithArray:(NSArray *)array; // id<EMStatusBarModel> 数组

+ (void)hiddenStatusBarAnimated:(BOOL)animated;


@end
