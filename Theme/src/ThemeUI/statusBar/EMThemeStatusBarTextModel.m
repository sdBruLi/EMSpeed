//
//  EMStatusBarData.m
//  UI
//
//  Created by Samuel on 15/4/9.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMThemeStatusBarTextModel.h"
#import "EMThemeTextStatusBar.h"

@implementation EMThemeStatusBarTextModel

@synthesize viewClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewClass = [EMThemeTextStatusBar class];
    }
    
    return self;
}

@end
