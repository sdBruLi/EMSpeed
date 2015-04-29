//
//  MMRefreshTableViewController.h
//  TTTT
//
//  Created by Mac mini 2012 on 15-3-2.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MMTableViewController.h"
#import "MJRefresh.h"


/**
 *  同MMRefreshTableController, 主要用于storyboard
 */

@interface MMRefreshTableViewController : MMTableViewController


/**
 *  初始化时设置, 默认YES
 */
@property (nonatomic, assign) BOOL enableRefreshHeader;


/**
 *  初始化时设置, 默认YES
 */
@property (nonatomic, assign) BOOL enableRefreshFooter;


/**
 *  下拉刷新触发时调用, 子类实现即可
 */
- (void)headerRefreshing;


/**
 *  上拉刷新触发时调用, 子类实现即可
 */
- (void)footerRefreshing;


@end

extern const CGFloat kMMCellDefaultHeight;
