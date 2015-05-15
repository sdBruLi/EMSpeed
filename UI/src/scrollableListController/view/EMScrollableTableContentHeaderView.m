//
//  EMScrollableTableTitleView.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-11.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMScrollableTableContentHeaderView.h"

@implementation EMScrollableTableContentHeaderItem

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;

- (id)init
{
    self = [super init];
    if (self) {
        self.height = 30;
        self.Class = [EMScrollableTableContentHeaderView class];
        self.reuseIdentify = @"EMScrollableTableContentHeaderView";
        self.isRegisterByClass = NO;
    }
    
    return self;
}

@end


@implementation EMScrollableTableContentHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.border = EMBorderStyleRight | EMBorderStyleTop | EMBorderStyleBottom;
}

- (void)update:(id<MMCellModel>)cellModel
{
    
}

@end
