//
//  EMListDemoModel.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMContentListItem.h"
#import "EMContentListCell.h"

@implementation EMContentListItem

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;

@synthesize code;
@synthesize name;


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 44;
        self.Class = [EMContentListCell class];
        self.reuseIdentify = @"EMContentListCell";
        self.isRegisterByClass = NO;
    }
    
    return self;
}

@end