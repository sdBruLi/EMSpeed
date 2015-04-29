//
//  EMMallScrollADView.h
//  EMStock
//
//  Created by zhangzhiyao on 14-10-9.
//  Copyright (c) 2014年 flora. All rights reserved.
//
//广告模块，可展示一张广告图片、也可展示多张广告图片
//
//
//

#import <UIKit/UIKit.h>
#import "StyledPageControl.h"

@class EMMultiPagingView;
@protocol EMPageModel;

@protocol EMPagingViewDelegate <NSObject>

@optional
- (void)adView:(EMMultiPagingView *)adView didSelectAdData:(NSObject<EMPageModel> *)data;

@end


typedef NS_ENUM(NSUInteger, EMMultiPagingPageControlAlignment)
{
    EMMultiPagingPageControlAlignmentLeft,
    EMMultiPagingPageControlAlignmentCenter,
    EMMultiPagingPageControlAlignmentRight,
};



@interface EMMultiPagingView : UIView <UIScrollViewDelegate>{
    UIImageView *_placeholderImageView;
    UIScrollView *_scrollView;
    StyledPageControl *_pageControl;
    int _current;
    
    NSMutableArray *_imageviews;
    NSArray *_pageItems;
    
    NSTimer *_timer;
}

@property (nonatomic, weak) id<EMPagingViewDelegate> delegate;
@property (nonatomic, strong) NSArray *pageItems;
@property (nonatomic, assign) EMMultiPagingPageControlAlignment pageControlAlignment; // 默认是居中

@end
