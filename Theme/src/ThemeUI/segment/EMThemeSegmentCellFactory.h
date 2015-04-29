//
//  EMSegmentCellFactory+Theme.h
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMSegmentCellFactory.h"
#import "EMThemeProtocol.h"
#import "EMTextSegmentCell.h"

@interface EMThemeSegmentCellFactory : EMSegmentCellFactory

+ (UIView<EMSegmentCell> *)segmentCellForSegmentControl:(EMSegmentedControl *)segmentControl
                                                atIndex:(int)index
                                             withObject:(NSObject<EMSegmentCellObject> *)object;

@end
