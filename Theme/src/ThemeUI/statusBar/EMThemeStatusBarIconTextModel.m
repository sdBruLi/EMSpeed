//
//  EMIconTextStatusBarData.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMThemeStatusBarIconTextModel.h"
#import "EMThemeIconTextStatusBar.h"

@implementation EMThemeStatusBarIconTextModel
@synthesize viewClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewClass = [EMThemeIconTextStatusBar class];
    }
    
    return self;
}
@end
