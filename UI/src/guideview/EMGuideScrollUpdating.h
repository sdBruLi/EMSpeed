//
//  EMGuideScrollCell.h
//  UIDemo
//
//  Created by Samuel on 15/4/27.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMGuideScrollModel.h"

@protocol EMGuideScrollUpdating <NSObject>
@required

- (void)updateGuideViewWithModel:(id<EMGuideScrollModel>)model;

@end
