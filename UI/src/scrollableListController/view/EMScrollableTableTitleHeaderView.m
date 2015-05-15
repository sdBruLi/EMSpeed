//
//  EMScrollableTableTitleView.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-11.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMScrollableTableTitleHeaderView.h"

@implementation EMScrollableTableTitleHeaderItem

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;


- (id)init
{
    self = [super init];
    if (self) {
        self.height = 30;
        self.Class = [EMScrollableTableTitleHeaderView class];
        self.reuseIdentify = @"EMScrollableTableTitleHeaderView";
        self.isRegisterByClass = NO;
    }
    
    return self;
}

@end


@implementation EMScrollableTableTitleHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.border = EMBorderStyleLeft | EMBorderStyleTop | EMBorderStyleBottom;
}

- (void)update:(id<MMCellModel>)cellModel
{
    
}

@end
