//
//  MMMenuController.m
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MMMenuController.h"
#import "MMInfoViewController.h"
#import "MMVIPTableController.h"
#import "MMInfoModel.h"
#import "MMInfoTableViewController.h"
#import "MMVIPTableViewController.h"

@interface MMMenuController ()


@end

@implementation MMMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"demo";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self rowTitles] count];
}

- (NSArray *)rowTitles{
    static NSArray *__titles = nil;
    
    if (__titles==nil) {
        __titles = @[@"cellModel 风格1", @"cellModel 风格2", @"item 风格3", @"vip资讯支持上拉下拉刷新", @"从xib创建",  @"从xib创建 支持上下拉刷新"];
    }
    
    return __titles;
}


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"theCell";
    
    UITableViewCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [[self rowTitles] objectAtIndex:indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = nil;
    
    if (indexPath.row<3) {
        MMInfoViewController *infoVC = [[MMInfoViewController alloc] init];
        
        if (indexPath.row==0) {
            infoVC.infoModelClass = [MMInfoModel class];
        }
        else if (indexPath.row==1){
            infoVC.infoModelClass = [MMInfoModel2 class];
        }
        else if (indexPath.row==2){
            infoVC.infoModelClass = [MMInfoModel3 class];
        }
        
        vc = infoVC;
    }
    else if (indexPath.row==3) {
        vc = [[MMVIPTableController alloc] init];
    }
    else if (indexPath.row==4) {
        vc = [[MMInfoTableViewController alloc] initWithNibName:@"MMInfoTableViewController" bundle:nil];
        vc.title = [[self rowTitles] objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    else if (indexPath.row==5) {
        vc = [[MMVIPTableViewController alloc] initWithNibName:@"MMVIPTableViewController" bundle:nil];
        vc.title = [[self rowTitles] objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    
    vc.title = [[self rowTitles] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
