//
//  UITableView+cellAction.h
//  EMStock
//
//  Created by deng flora on 6/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableView(CellAction)

/**
 *  此方法用来实行，当cell中有输入框等响应有弹出视图的情况，当点击cell中的control 会弹出一个弹出层，需要将此cell滚动至可视范围内
 *
 *  @param cell          当前control所在cell
 *  @param visibleHeight 当前可视范围的高度
 */
- (void)em_tableViewCell:(UITableViewCell *)cell scrollToVisibleWithVisibleHeight:(CGFloat)visibleHeight;

@end