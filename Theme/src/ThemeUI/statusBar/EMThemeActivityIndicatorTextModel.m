//
//  EMActivityIndicatorTextData.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMThemeActivityIndicatorTextModel.h"
#import "EMThemeActivityIndicatorTextStatusBar.h"

@implementation EMThemeActivityIndicatorTextModel
@synthesize viewClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewClass = [EMThemeActivityIndicatorTextStatusBar class];
    }
    
    return self;
}

@end
