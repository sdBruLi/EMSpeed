//
//  EMHorizontalPagingView.h
//  Coll
//
//  Created by Samuel on 15/4/16.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMCollectionDataSource;
@protocol MMCollectionCellModel;


typedef NS_ENUM(NSUInteger, EMHorizontalPagingControlAlignment)
{
    EMHorizontalPagingControlAlignmentLeft,
    EMHorizontalPagingControlAlignmentCenter,
    EMHorizontalPagingControlAlignmentRight,
};


typedef void (^horizontalPagingView_didTap_block)(id<MMCollectionCellModel> model, NSIndexPath *indexPath);


@interface EMHorizontalPagingView : UIView <UICollectionViewDelegate, UIScrollViewDelegate>{
    
    UICollectionView *_collectionView;
    UIPageControl *_pageControl;
    MMCollectionDataSource *_dataSource;
    
    EMHorizontalPagingControlAlignment _alignment;
    UIEdgeInsets _pageControlEdgeInsets;
}

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) UIPageControl *pageControl;

@property (nonatomic, strong) MMCollectionDataSource *dataSource;
@property (nonatomic, assign) EMHorizontalPagingControlAlignment alignment;
@property (nonatomic, assign) UIEdgeInsets pageControlEdgeInsets;

@property (nonatomic, strong) horizontalPagingView_didTap_block didTapBlock;

- (instancetype)initWithFrame:(CGRect)frame;

@end