//
//  EMActivatorTextStatusBar.h
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMStatusBarUpdating.h"


@interface EMActivityIndicatorTextStatusBar : UIView <EMStatusBarUpdating>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end
