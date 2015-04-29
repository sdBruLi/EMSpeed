//
//  EMOverlayerFunctionGuidCell.m
//  EMStock
//
//  Created by xoHome on 14-10-22.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMGuideScrollOverlayerCell.h"

@implementation EMGuideScrollOverlayerItem
@synthesize cellClass;
@synthesize contentMode;

- (id)init
{
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeCenter;
        self.cellClass = [EMGuideScrollOverlayerCell class];
    }
    return self;
}

@end

@implementation EMGuideScrollOverlayerCell



- (void)updateGuideViewWithModel:(id<EMGuideScrollModel>)model
{
    if ([model isKindOfClass:[EMGuideScrollOverlayerItem class]]) {
        EMGuideScrollOverlayerItem *item = model;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.6f];
        self.contentMode = item.contentMode;
        self.image = item.image;
    }
}

@end
