//
//  MMInfoCell2.h
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-26.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMCellModel.h"
#import "MMCellUpdating.h"


@interface MMInfoCell2 : UITableViewCell<MMCellUpdating>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end


@interface MMInfoCellModel2 : NSObject<MMCellModel>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *dateString;

@end
