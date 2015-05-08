//
//  EMListDemoModel.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMNameListItem.h"
#import "EMNameListCell.h"

@implementation EMNameListItem

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
        self.Class = [EMNameListCell class];
        self.reuseIdentify = @"EMListCell";
        self.isRegisterByClass = NO;
    }
    
    return self;
}

@end