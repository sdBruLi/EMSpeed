//
//  MMVIPTableController.h
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMRefreshTableController.h"

@class EMVIPModel;

@interface MMVIPTableController : MMRefreshTableController {
    EMVIPModel *_model;
}

@end
