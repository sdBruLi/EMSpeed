//
//  EMActivatorTextStatusBar.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMActivityIndicatorTextStatusBar.h"
#import "EMActivityIndicatorTextModel.h"


@implementation EMActivityIndicatorTextStatusBar


- (instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, EMScreenWidth(), EMStatusBarHeight());
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_titleLabel];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_indicatorView];
        _indicatorView.transform = CGAffineTransformMakeScale(.5f, .5f);
        
    }
    
    return self;
}

- (void)updateStatusBar:(id<EMStatusBarModel>)model
{
    if ([model isKindOfClass:[EMActivityIndicatorTextModel class]]) {
        EMActivityIndicatorTextModel *data = (EMActivityIndicatorTextModel *)model;
        
        _titleLabel.text = data.title;
        
        _indicatorView.hidden = !data.hasActivityIndicator;
        if (!_indicatorView.hidden) {
            if (data.isActivityIndicatorAnimating) {
                [_indicatorView startAnimating];
            }
            else {
                [_indicatorView stopAnimating];
            }
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = _indicatorView.frame;
    frame.origin.x = 2;
    frame.origin.y = CGRectGetHeight(self.frame)/2-_indicatorView.frame.size.height/2;
    _indicatorView.frame = frame;
    
    frame = self.bounds;
    frame.origin.x = CGRectGetMaxX(_indicatorView.frame) + 2;
    frame.size.width = self.bounds.size.width - frame.origin.x;
    _titleLabel.frame = frame;
}


@end
