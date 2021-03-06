//
//  MMBaseCell.h
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-13.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMCellModel.h"

/**
 *  cell需要实现的一个 更新界面的接口
 */
@protocol MMCellUpdating

@required

/**
 *  更新cell的界面中的内容
 *
 *  @param cellModel cell中显示的数据
 */
- (void)update:(id<MMCellModel>)cellModel;

@optional
- (void)update:(id<MMCellModel>)cellModel indexPath:(NSIndexPath *)indexPath;


@end