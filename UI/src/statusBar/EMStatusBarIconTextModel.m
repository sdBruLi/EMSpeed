//
//  EMIconTextStatusBarData.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMStatusBarIconTextModel.h"
#import "EMIconTextStatusBar.h"

@implementation EMStatusBarIconTextModel

@synthesize title;
@synthesize iconName;
@synthesize viewClass;


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"";
        self.viewClass = [EMIconTextStatusBar class];
    }
    
    return self;
}

- (UIView<EMStatusBarUpdating> *)statusBarWithData:(id<EMStatusBarModel>)data
{
    UIView<EMStatusBarUpdating> *view = [[self.viewClass alloc] initWithFrame:CGRectZero];
    
    return view;
}


@end
