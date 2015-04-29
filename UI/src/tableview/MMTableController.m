//
//  EMMTableViewController.m
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-13.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MMTableController.h"
#import "MMMutableDataSource.h"

const CGFloat kMMCellDefaultHeight = 44;

@interface MMTableController () {
    BOOL _isEmptyViewHidden;
}

@end

@implementation MMTableController
@synthesize tableView = _tableView;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isEmptyViewHidden = YES;
        
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    [self tableViewDidRegisterTableViewCell];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = self.view.bounds;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
    }
    
    return _tableView;
}

- (void)tableViewDidRegisterTableViewCell
{
    // 子类实现
    NSLog(@"子类未实现 tableViewDidRegisterTableViewCell");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)reloadPages:(MMMutableDataSource *)dataSource
{
    if (self.dataSource != dataSource)
    {
        self.dataSource = dataSource;
        _tableView.delegate = self;
        _tableView.dataSource = dataSource;
        [_tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    if ( [self isViewLoaded] && nil == self.view.window)
    {
        _tableView = nil;
    }
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload
{
    _tableView = nil;
    [super viewDidUnload];
}


#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [self.dataSource.items objectAtIndex:indexPath.section];
    CGFloat height = tableView.rowHeight;
    
    id<MMCellModel> item = [items objectAtIndex:indexPath.row];
    height = item.height;
    
    if (height == 0) {
        if ([item respondsToSelector:@selector(calculateHeight)]) {
            height = [item calculateHeight];
        }
    }
    
    return height;
}


- (void)setEmptyViewHidden:(BOOL)hidden
{
    _emptyView.hidden = hidden;
}

- (UIView *)emptyView
{
    if (_emptyView == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.tableView.bounds];
        label.text = @"暂无数据~~";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        
        UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon.png"]];
        [label addSubview:imgv];
        imgv.center = CGPointMake(CGRectGetMidX(label.frame), label.frame.size.height/2.f - 20 - imgv.frame.size.height/2);
        
        _emptyView = label;
    }
    
    return _emptyView;
}

- (BOOL)isEmptyDatasource
{
    if (self.dataSource) {
        return [self.dataSource.items count] == 0 || [self.dataSource.sections count] == 0;
    }
    
    return YES;
}

@end
