//
//  MMRefreshTableViewController.m
//  TTTT
//
//  Created by Mac mini 2012 on 15-3-2.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MMRefreshTableViewController.h"


@interface MMRefreshTableViewController () {
    
    BOOL _isEmptyViewHidden;
}

@end

@implementation MMRefreshTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        self.enableRefreshHeader = YES;
        self.enableRefreshFooter = YES;
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.enableRefreshHeader = YES;
        self.enableRefreshFooter = YES;
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.enableRefreshHeader = YES;
    self.enableRefreshFooter = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 下拉刷新
    if (self.enableRefreshHeader) {
        [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    }
    
    // 上拉刷新
    if (self.enableRefreshFooter) {
        [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    }
}

- (void)headerRefreshing
{
    // 子类实现
    
    // 不要忘记调用
    [self.tableView.header endRefreshing];
}

- (void)footerRefreshing
{
    // 子类实现
    
    
    // 不要忘记调用
    [self.tableView.footer endRefreshing];
}

@end
