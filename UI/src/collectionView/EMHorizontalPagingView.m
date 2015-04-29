//
//  EMHorizontalPagingView.m
//  Coll
//
//  Created by Samuel on 15/4/16.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMHorizontalPagingView.h"
#import "MMCollectionDataSource.h"

@implementation EMHorizontalPagingView
@synthesize collectionView = _collectionView;
@synthesize pageControl = _pageControl;
@synthesize dataSource = _dataSource;
@synthesize alignment = _alignment;
@synthesize pageControlEdgeInsets = _pageControlEdgeInsets;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        [self addSubview:_pageControl];
        
        self.pageControlEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 10);
        self.alignment = EMHorizontalPagingControlAlignmentLeft;
        
    }
    
    return self;
}

- (void)setDataSource:(MMCollectionDataSource *)dataSource
{
    _collectionView.dataSource = dataSource;
    [dataSource registerCellForView:_collectionView];
    
    if ([dataSource.sections count] > 0) {
        _pageControl.numberOfPages = [[dataSource itemsAtSection:0] count];
        int index = _collectionView.contentOffset.x/self.frame.size.width;
        _pageControl.currentPage = index;
    }
}

- (MMCollectionDataSource *)dataSource
{
    return (MMCollectionDataSource *)_collectionView.dataSource;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _collectionView.frame = self.bounds;
    
    switch (self.alignment) {
        case EMHorizontalPagingControlAlignmentLeft:
        {
            CGSize size = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
            CGPoint pageControlCenter = CGPointMake(ceilf(size.width/2.f)+_pageControlEdgeInsets.right, self.bounds.size.height-_pageControlEdgeInsets.bottom);
            _pageControl.center = pageControlCenter;
        }
            break;
        case EMHorizontalPagingControlAlignmentCenter:
        {
            CGPoint pageControlCenter = CGPointMake(self.center.x, self.bounds.size.height-_pageControlEdgeInsets.bottom);
            _pageControl.center = pageControlCenter;
        }
            break;
        case EMHorizontalPagingControlAlignmentRight:
        {
            CGSize size = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
            CGPoint pageControlCenter = CGPointMake(self.bounds.size.width-ceilf(size.width/2.f)-_pageControlEdgeInsets.left, self.bounds.size.height-_pageControlEdgeInsets.bottom);
            _pageControl.center = pageControlCenter;
        }
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_collectionView.dataSource isKindOfClass:[MMCollectionDataSource class]]) {
        MMCollectionDataSource *ds = (MMCollectionDataSource *)_collectionView.dataSource;
        id<MMCollectionCellModel> item = [ds itemAtIndexPath:indexPath];
        
        return item.layoutSize;
    }
    
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didTapBlock && [_collectionView.dataSource isKindOfClass:[MMCollectionDataSource class]]) {
        MMCollectionDataSource *ds = (MMCollectionDataSource *)_collectionView.dataSource;
        id<MMCollectionCellModel> item = [ds itemAtIndexPath:indexPath];
        self.didTapBlock(item, indexPath);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x/self.frame.size.width;
    _pageControl.currentPage = index;
}

@end
