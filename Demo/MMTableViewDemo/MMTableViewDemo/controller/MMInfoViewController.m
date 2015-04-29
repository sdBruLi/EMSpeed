//
//  ViewController.m
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-26.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MMInfoViewController.h"
#import "MMInfoModel.h"
#import "MJRefresh.h"

@interface MMInfoViewController ()

@end

@implementation MMInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (_model == nil) {
        MMInfoModel *model = [[[self theInfoModelClass] alloc] init];
        model.delegate = self;
        _model = model;
    }
    
    NSString *url = @"http://mt.emoney.cn/2pt/zx/GetBShareNews";
    [_model POST:url param:nil block:^(id respondObject, AFHTTPRequestOperation *operation, BOOL success) {
        if (success && ((MMInfoModel *)_model).dataSource) {
            [self reloadPages:((MMInfoModel *)_model).dataSource];
        }
        else{
            //                           [self loadEmptyView];
        }
        
        [self.tableView.header endRefreshing];
    }];
}


- (void)tableViewDidRegisterTableViewCell
{
    // 子类实现
    [self.tableView registerNib:[UINib nibWithNibName:@"MMInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MMInfoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMInfoCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MMInfoCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMInfoCell3" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MMInfoCell3"];
}


- (void)MMInfoCellDoPressBuy:(MMInfoCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    MMInfoModel *model = (MMInfoModel *)_model;
    MMInfoCellModel *cm = [model.dataSource itemAtIndexPath:indexPath];
    
    NSLog(@"买入 title = %@", cm.title);
}

- (void)MMInfoCellDoPressSell:(MMInfoCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    MMInfoModel *model = (MMInfoModel *)_model;
    MMInfoCellModel *cm = [model.dataSource itemAtIndexPath:indexPath];
    
    NSLog(@"卖出 title = %@", cm.title);
}

- (Class)theInfoModelClass
{
    return _infoModelClass ? _infoModelClass : [MMInfoModel class];
}

@end
