//
//  EMStockListModel.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMScrollableList.h"

@interface EMStockListModel : NSObject <EMScrollableProtocol>

- (BOOL)didNeedsRefreshData;
- (CGFloat)refreshInterval;
@end
