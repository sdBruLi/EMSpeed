//
//  EMStockListModel.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMStockListModel.h"

@implementation EMStockListModel

- (BOOL)didNeedsRefreshData
{
    return YES;
}

- (CGFloat)refreshInterval
{
    return 6.f;//[EMUserCustomData sharedData].refreshInterval;
}

@end