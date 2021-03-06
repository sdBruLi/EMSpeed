//
//  MMVIPTableViewController.h
//  MMTableViewDemo
//
//  Created by Samuel on 15/4/30.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MMTableViewController.h"
#import "MMInfoCell.h"

@class MMInfoModel;

@interface MMInfoTableViewController : MMTableViewController <MMInfoCellDelegate> {
    MMInfoModel *_model;
}

@property (nonatomic, strong) Class infoModelClass;
@end
