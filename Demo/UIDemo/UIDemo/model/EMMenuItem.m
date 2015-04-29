//
//  EMButtonItem.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMMenuItem.h"
#import "EMMenuTableViewCell.h"

@implementation EMMenuItem
@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 44;
        self.Class = [EMMenuTableViewCell class];
        self.reuseIdentify = @"EMButtonTableViewCell";
        self.isRegisterByClass = NO;
    }
    
    return self;
}

@end
