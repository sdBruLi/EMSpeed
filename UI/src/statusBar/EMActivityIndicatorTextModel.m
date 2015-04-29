//
//  EMActivityIndicatorTextData.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMActivityIndicatorTextModel.h"
#import "EMActivityIndicatorTextStatusBar.h"

@implementation EMActivityIndicatorTextModel

@synthesize title;
@synthesize hasActivityIndicator;
@synthesize isActivityIndicatorAnimating;
@synthesize viewClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"";
        self.viewClass = [EMActivityIndicatorTextStatusBar class];
        self.hasActivityIndicator = YES;
        self.isActivityIndicatorAnimating = YES;
    }
    
    return self;
}

- (UIView<EMStatusBarUpdating> *)statusBarWithData:(id<EMStatusBarModel>)data
{
    UIView<EMStatusBarUpdating> *view = [[self.viewClass alloc] initWithFrame:CGRectZero];
    
    return view;
}

@end
