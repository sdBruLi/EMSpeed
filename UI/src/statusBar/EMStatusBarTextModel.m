//
//  EMStatusBarData.m
//  UI
//
//  Created by Samuel on 15/4/9.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMStatusBarTextModel.h"
#import "EMTextStatusBar.h"

@implementation EMStatusBarTextModel

@synthesize title;
@synthesize viewClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"";
        self.viewClass = [EMTextStatusBar class];
    }
    
    return self;
}

- (UIView<EMStatusBarUpdating> *)statusBarWithData:(id<EMStatusBarModel>)data
{
    UIView<EMStatusBarUpdating> *view = [[self.viewClass alloc] initWithFrame:CGRectZero];
    
    
    
    return view;
}

@end
