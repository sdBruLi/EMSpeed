//
//  EMSegmentCellFactory+Theme.m
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMThemeSegmentCellFactory.h"
#import "EMThemeTextSegmentCell.h"

@implementation EMThemeSegmentCellFactory


+ (UIView<EMSegmentCell> *)segmentCellForSegmentControl:(EMSegmentedControl *)segmentControl
                                                atIndex:(int)index
                                             withObject:(NSObject<EMSegmentCellObject> *)object
{
    if ([object isKindOfClass:[NSString class]])
    {
        EMThemeTextSegmentCell *label = [[EMThemeTextSegmentCell alloc] initWithSegmentObject:object];
        
        return label;
    }
    else
    {
        return [[[object cellClass] alloc] initWithSegmentObject:object];
    }
}

@end

