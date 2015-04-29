//
//  EMElementFactory.h
//  EMStock
//
//  Created by xoHome on 14-10-7.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMBorderView.h"

@class EMTextSegmentCell,EMSegmentedControl;
@protocol EMSegmentCellObject, EMSegmentCell;


@interface EMSegmentCellFactory : NSObject

+ (UIView<EMSegmentCell> *)segmentCellForSegmentControl:(EMSegmentedControl *)segmentControl atIndex:(int)index withObject:(NSObject<EMSegmentCellObject> *)object;

@end


@protocol EMSegmentCellObject <NSObject>
@required
- (Class)cellClass;

@end

@protocol EMSegmentCell <NSObject>
@required
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithSegmentObject:(NSObject<EMSegmentCellObject> *)object;

@optional

//边框线
@property (nonatomic, strong) CALayer *seperateLayer;
 //主要用于指定分隔线离top、bottom的间距
@property (nonatomic, assign) UIEdgeInsets lineInsets;

- (BOOL)shouldUpdateCellWithObject:(id)object;


@end

