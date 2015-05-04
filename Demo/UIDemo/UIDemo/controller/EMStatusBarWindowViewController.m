//
//  EMStatusBarWindowViewController.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMStatusBarWindowViewController.h"
#import "EMStatusBarWindow.h"
#import "EMThemeStatusBarIconTextModel.h"
#import "EMThemeStatusBarTextModel.h"
#import "EMThemeActivityIndicatorTextModel.h"
#import "EMContext.h"

@interface EMStatusBarWindowViewController ()

@end

@implementation EMStatusBarWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = [UIColor redColor];
    btn1.frame = CGRectMake(30, 100, 120, 40);
    [btn1 addTarget:self action:@selector(doAnim1) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"单条标题" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor redColor];
    btn2.frame = CGRectMake(170, 100, 120, 40);
    [btn2 addTarget:self action:@selector(doAnim2) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"图标+标题" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.backgroundColor = [UIColor redColor];
    btn3.frame = CGRectMake(30, 160, 120, 40);
    [btn3 addTarget:self action:@selector(doAnim3) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitle:@"多条标题" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.backgroundColor = [UIColor redColor];
    btn4.frame = CGRectMake(170, 160, 120, 40);
    [btn4 addTarget:self action:@selector(doAnim4) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setTitle:@"组合标题" forState:UIControlStateNormal];
    [self.view addSubview:btn4];

}

- (void)doAnim1
{
    EMThemeStatusBarTextModel *bar1 = [[EMThemeStatusBarTextModel alloc] init];
    bar1.title = @"Hello, 我是一个标题";
    [EMStatusBarWindow showStatusBarWithModel:bar1];
}

- (void)doAnim2
{
    EMThemeStatusBarIconTextModel *bar1 = [[EMThemeStatusBarIconTextModel alloc] init];
    bar1.title = @"Hello, 我是一个带有图标的标题";
    bar1.iconName = EMUIResName(@"radio_on.png");
    [EMStatusBarWindow showStatusBarWithModel:bar1];
}

- (void)doAnim3
{
    EMThemeStatusBarTextModel *bar1 = [[EMThemeStatusBarTextModel alloc] init];
    bar1.title = @"尼玛 我是个标题1111111";
    
    EMThemeStatusBarTextModel *bar2 = [[EMThemeStatusBarTextModel alloc] init];
    bar2.title = @"尼玛 我是个标题2222222";
    
    EMThemeStatusBarTextModel *bar3 = [[EMThemeStatusBarTextModel alloc] init];
    bar3.title = @"尼玛 我是个标题3333333";
    
    [EMStatusBarWindow showStatusBarWithArray:@[bar1, bar2, bar3]];
}

- (void)doAnim4
{
    EMThemeStatusBarIconTextModel *bar1 = [[EMThemeStatusBarIconTextModel alloc] init];
    bar1.title = @"尼玛 我是个标题1111";
    bar1.iconName = @"radio_on.png";
    
    EMThemeStatusBarTextModel *bar2 = [[EMThemeStatusBarTextModel alloc] init];
    bar2.title = @"尼玛 我是个标题22222222";
    
    EMThemeStatusBarTextModel *bar3 = [[EMThemeStatusBarTextModel alloc] init];
    bar3.title = @"尼玛 我是个标题3333333";
    
    EMThemeStatusBarTextModel *bar4 = [[EMThemeStatusBarTextModel alloc] init];
    bar4.title = @"尼玛 我是个标题4444444";
    
    EMThemeActivityIndicatorTextModel *bar5 = [[EMThemeActivityIndicatorTextModel alloc] init];
    bar5.title = @"尼玛 我是个标题555555";
    bar5.isActivityIndicatorAnimating = YES;
    
    [EMStatusBarWindow showStatusBarWithArray:@[bar1, bar2, bar3, bar4, bar5]];
}

- (void)dd
{
    [EMStatusBarWindow hiddenStatusBarAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [EMStatusBarWindow hiddenStatusBarAnimated:NO];
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
