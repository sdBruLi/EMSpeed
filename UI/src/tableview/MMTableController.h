//
//  EMMTableViewController.h
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-13.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "UIKit/UIKit.h"

@class MMMutableDataSource;
@class MMDataSource;

/**
 *  tableController 列表
 */
@interface MMTableController : UIViewController <UITableViewDelegate>{

    UITableView *_tableView;
}

/**
 *  tableview
 */
@property (nonatomic, strong) UITableView *tableView;


/**
 *  数据源
 */
@property (nonatomic, strong) MMMutableDataSource *dataSource;


@property (nonatomic, strong) UIView *emptyView;


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


/**
 *  显示空白界面
 *
 *  @param hidden 空白界面
 */
- (void)setEmptyViewHidden:(BOOL)hidden;


/**
 *  是否是空的datasource
 *
 *  @return 是否是空的datasource
 */
- (BOOL)isEmptyDatasource;


@end



