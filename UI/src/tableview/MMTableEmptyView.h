//
//  MMTableEmptyView.h
//  MMTableViewDemo
//
//  Created by Samuel on 15/4/30.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMTableEmptyView : UIView

@property (nonatomic, strong) UILabel *textlabel;
@property (nonatomic, strong) UIImageView *iconImageView;


- (instancetype)initWithFrame:(CGRect)frame;

@end
