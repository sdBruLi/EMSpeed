//
//  EMStockListViewController.h
//  EMStock
//
//  Created by flora on 14-9-15.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>


NSString *const EMStocklistCellSelectedNotification;
NSString *const EMStocklistCellHighlightedNotification;

@protocol MMCellModel;


@protocol EMModelProtocol <NSObject>

@optional

+ (id)modelWithBlock:(void (^)(NSOperation *operation, BOOL success))block;
- (id)modelWithBlock:(void (^)(NSOperation *operation, BOOL success))block;

@end



@protocol EMListProtocol <EMModelProtocol>

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) BOOL reloading;
@property (nonatomic, assign) BOOL didNeedsRequest;

@required
- (Class)titleTableViewClass;
- (Class)contentTableViewClass;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (BOOL)isCached;
- (BOOL)resetDataWithCurrentRow:(NSInteger)row;

- (id<MMCellModel>)titleItemAtIndexPath:(NSIndexPath *)indexPath;
- (id<MMCellModel>)contentItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray *)visiableItems;
- (int)currentSelectedIndex:(NSIndexPath *)indexPath;

@end


@interface EMScrollableList : NSObject <EMListProtocol>


@end


@interface EMStockListModel : NSObject <EMListProtocol>

- (BOOL)didNeedsRefreshData;
- (CGFloat)refreshInterval;
@end



@class EMBorderView;
@interface EMStockListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIEdgeInsets _contentInsets;
    
    UIView *_stockListView;
    UITableView  *_titleTableView;
    UITableView  *_contentTableView;
    UIScrollView *_contentScrollView;

    EMBorderView *_titleHeaderView;
    UIButton     *_titleHeaderButton;
    EMBorderView *_contentHeaderView;
    
    //行情数据左右滚动提示视图
    UILabel *_scrollTipImageViewLeft;
    UILabel *_scrollTipImageViewRight;
    
    //数据模块，负责数据的收发、数据绘制解析等工作
    EMScrollableList *_scrollableList;
    
    NSMutableArray *_operationArray;
}


@property (nonatomic, strong) EMScrollableList *scrollableList;

/**
 *请求返回数据后加载数据
 *读取缓存数据后加载数据
 */
- (void)didLoadDataSource;


@end
