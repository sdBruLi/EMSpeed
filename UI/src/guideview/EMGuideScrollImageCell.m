//
//  EMGuideImageView.m
//  UIDemo
//
//  Created by Samuel on 15/4/27.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMGuideScrollImageCell.h"


@implementation EMGuideScrollImageItem
@synthesize cellClass;
@synthesize contentMode;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellClass = [EMGuideScrollImageCell class];
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return self;
}

@end

@implementation EMGuideScrollImageCell

- (void)updateGuideViewWithModel:(id<EMGuideScrollModel>)model
{
    if ([model isKindOfClass:[UIImage class]]) {
        self.image = (UIImage *)model;
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    else if ([model isKindOfClass:[EMGuideScrollImageItem class]]) {
        EMGuideScrollImageItem *item = (EMGuideScrollImageItem *)model;
        self.image = item.image;
        self.contentMode = item.contentMode;
    }
}

@end
