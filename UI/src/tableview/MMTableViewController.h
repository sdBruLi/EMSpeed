//
//  MMTableViewController.h
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMMutableDataSource;
@class MMDataSource;

/**
 *  同MMTableController, 主要用于storyboard
 */

@interface MMTableViewController : UITableViewController {
    UIView *_emptyView;
}

/**
 *  数据源
 */
@property (nonatomic, strong) MMMutableDataSource *dataSource;

/**
 *  空视图, 默认会有一个空视图
 */
@property (nonatomic, strong) UIView *emptyView;

/**
 *  是否自动显示空视图
 */
@property (nonatomic, assign) BOOL autoDisplayEmptyView;

/**
 *  重新加载列表界面
 *
 *  @param dataSource 数据源
 */
- (void)reloadPages:(MMMutableDataSource *)dataSource;


/**
 *  注册tableview cell
 *  子类实现
 */
- (void)tableViewDidRegisterTableViewCell; // 子类实现



@end

extern const CGFloat kMMCellDefaultHeight;
