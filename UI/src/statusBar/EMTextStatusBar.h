//
//  EMStatusBarLabel.h
//  UI
//
//  Created by Samuel on 15/4/9.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMStatusBarUpdating.h"


@interface EMTextStatusBar : UIView <EMStatusBarUpdating>
@property (nonatomic, strong) UILabel *titleLabel;

- (void)updateStatusBar:(id<EMStatusBarModel>)model;

@end
