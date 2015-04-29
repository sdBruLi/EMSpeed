//
//  EMLaunchGuidView.m
//  EMStock
//
//  Created by flora on 14/11/14.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMGuideScrollLaunchCell.h"

@implementation EMGuideScrollLaunchItem
@synthesize contentMode;
@synthesize cellClass;

- (id)init
{
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeCenter;
        self.cellClass = [EMGuideScrollLaunchCell class];
    }
    return self;
}

@end

@implementation EMGuideScrollLaunchCell

- (void)updateGuideViewWithModel:(id<EMGuideScrollModel>)model
{
    if ([model isKindOfClass:[EMGuideScrollLaunchItem class]]) {
        EMGuideScrollLaunchItem *item = model;
        self.backgroundColor = item.backgroundColor;
        self.contentMode = item.contentMode;
        self.image = item.image;
    }
}

@end
