//
//  EMButtonTableViewCell.h
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMCellUpdating.h"
#import "EMThemeProtocol.h"

@interface EMMenuTableViewCell : UITableViewCell <MMCellUpdating>
@property (weak, nonatomic) IBOutlet UILabel *buttonTitleLabel;

@end
