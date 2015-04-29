//
//  EMElementFactory.m
//  EMStock
//
//  Created by xoHome on 14-10-7.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMSegmentCellFactory.h"
#import "EMTextSegmentCell.h"


@interface EMSegmentCellFactory()
@property (nonatomic, copy) NSMutableDictionary* objectToCellMap;
@end

@implementation EMSegmentCellFactory

- (instancetype)init {
    if ((self = [super init])) {
        _objectToCellMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (UIView<EMSegmentCell> *)segmentCellForSegmentControl:(EMSegmentedControl *)segmentControl
                                                atIndex:(int)index
                                             withObject:(NSObject<EMSegmentCellObject> *)object
{
    if ([object isKindOfClass:[NSString class]])
    {
        EMTextSegmentCell *label = [[EMTextSegmentCell alloc] initWithSegmentObject:object];
        
        return label;
    }
    else
    {
        return [[[object cellClass] alloc] initWithSegmentObject:object];
    }
}

@end




