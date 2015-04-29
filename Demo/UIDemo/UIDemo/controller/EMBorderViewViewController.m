//
//  EMBorderViewViewController.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMBorderViewViewController.h"
#import "EMBorderView.h"
#import "EMThemeBorderView.h"

@interface EMBorderViewViewController ()

@end

@implementation EMBorderViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    EMThemeBorderView *border1 = [[EMThemeBorderView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    border1.border = EMBorderStyleLeft;
//    border1.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.f];
//    border1.borderColor = [UIColor redColor];
    [self.view addSubview:border1];
    
    EMThemeBorderView *border2 = [[EMThemeBorderView alloc] initWithFrame:CGRectMake(150, 10, 100, 100)];
    border2.border = EMBorderStyleRight;
//    border2.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.f];
//    border2.borderColor = [UIColor redColor];
    [self.view addSubview:border2];
    
    EMThemeBorderView *border3 = [[EMThemeBorderView alloc] initWithFrame:CGRectMake(10, 130, 100, 100)];
    border3.border = EMBorderStyleTop;
    [self.view addSubview:border3];
    
    EMThemeBorderView *border4 = [[EMThemeBorderView alloc] initWithFrame:CGRectMake(150, 130, 100, 100)];
    border4.border = EMBorderStyleBottom;
    [self.view addSubview:border4];
    
    EMThemeBorderView *border5 = [[EMThemeBorderView alloc] initWithFrame:CGRectMake(10, 250, 100, 100)];
    border5.border = EMBorderStyleAll;
    [self.view addSubview:border5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
