//
//  MMTableViewController.m
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MMTableViewController.h"
#import "MMMutableDataSource.h"



@interface MMTableViewController (){
}

@end

@implementation MMTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self tableViewDidRegisterTableViewCell];
}


- (void)createTableView
{
    self.tableView.frame = self.view.bounds;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
}

- (void)tableViewDidRegisterTableViewCell
{
    // 子类实现
}

- (void)reloadPages:(MMMutableDataSource *)dataSource
{
    if (self.dataSource != dataSource)
    {
        self.dataSource = dataSource;
        self.tableView.delegate = self;
        self.tableView.dataSource = dataSource;
        [self.tableView reloadData];
    }
}


- (void)didReceiveMemoryWarning
{
    if ( [self isViewLoaded] && nil == self.view.window)
    {
        self.tableView = nil;
    }
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload
{
    self.tableView = nil;
    [super viewDidUnload];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [self.dataSource.items objectAtIndex:indexPath.section];
    if ([arr count]>indexPath.row) {
        id<MMCellModel> item = [arr objectAtIndex:indexPath.row];
        if (item.height) {
            return item.height;
        }
    }
    
    return kMMCellDefaultHeight;
}


@end
