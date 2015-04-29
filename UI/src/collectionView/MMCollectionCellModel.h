//
//  MMCollectionCellModel.h
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-27.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MMCellModel.h"

/**
 *  cell的viewmodel, 一个cell对应一个cellModel
 */

@protocol MMCollectionCellModel <MMCellModel>


/**
 *  单个item的尺寸
 */
@property (nonatomic, assign) CGSize layoutSize;



@end

