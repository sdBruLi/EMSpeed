//
//  EMStockListViewController.m
//  EMStock
//
//  Created by flora on 14-9-15.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMScrollableListViewController.h"
#import "EMBorderView.h"
#import "UIView+autoLayout.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "UIFont+FontAwesome.h"
#import "UIView+AutoLayout.h"
#import "EMPriceHeaderButton.h"
#import "MMCellModel.h"
#import "MMCellUpdating.h"
#import "EMScrollableCellProtocol.h"


#define kTitleTableViewWidth 90
#define kContentTableViewWidth 300
#define kTableHeaderHeight 30
#define kScrollTipLabelSize CGSizeMake(10, 24)

NSString *const EMScrollableListCellSelectedNotification = @"EMStocklistCellSelectedNotification";
NSString *const EMScrollableListCellHighlightedNotification = @"EMStocklistCellHighlightedNotification";


@interface EMScrollableListViewController ()
{
}
@property (nonatomic, assign) CGFloat titleTableWidth;
@property (nonatomic, assign) CGFloat contentTableWidth;
@property (nonatomic, assign) CGFloat tableHeaderHeight;

@end

@implementation EMScrollableListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCellChangeSelectStatus:) name:EMScrollableListCellSelectedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCellChangeHighligtedStatus:) name:EMScrollableListCellHighlightedNotification object:nil];
        
        self.titleTableWidth = kTitleTableViewWidth;
        self.contentTableWidth = kContentTableViewWidth;
        self.tableHeaderHeight = kTableHeaderHeight;
        
        _scrollableList = [[EMScrollableList alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EMScrollableListCellSelectedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EMScrollableListCellHighlightedNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadTableView];
}

- (UIView *)createBackgroundView
{
    UIView *listBackgroundView = [[UIView alloc] init];
    return listBackgroundView;
}


/**
 *创建tableView
 *视图层次，做nameTableView，右priceTableView，priceTableView 上加载priceTableView。
 *
 */
- (void)loadTableView
{
    _backgroundView = [self createBackgroundView];
    _titleTableView = [self createTitleTableView];
    _contentTableView = [self createContentTableView];
    _contentScrollView = [self createContentScrollView];
    _scrollTipImageViewLeft = [self createLeftScrollTipLabel];
    _scrollTipImageViewRight = [self createRightScrollTipLabel];
    
    [self.view addSubview:_backgroundView];
    [_backgroundView addSubview:_titleTableView];
    [_backgroundView addSubview:_contentScrollView];
    [_contentScrollView addSubview:_contentTableView];
    [_backgroundView addSubview:_scrollTipImageViewLeft];
    [_backgroundView addSubview:_scrollTipImageViewRight];
    
    [self registerTableViewCell];
    [self setViewConstraints];
}

- (UITableView *)createTitleTableView
{
    UITableView *titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    titleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    titleTableView.autoresizingMask = UIViewAutoresizingNone;
    titleTableView.contentInset = UIEdgeInsetsZero;
    titleTableView.backgroundView = nil;
    titleTableView.showsVerticalScrollIndicator = NO;
    [titleTableView setDataSource:self];
    [titleTableView setDelegate:self];
    
    return titleTableView;
}

- (UITableView *)createContentTableView
{
    UITableView *contentTableView = [[UITableView alloc] init];
    contentTableView.backgroundColor = [UIColor clearColor];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.contentInset = UIEdgeInsetsZero;
    contentTableView.backgroundView = nil;
    contentTableView.showsHorizontalScrollIndicator = NO;
    contentTableView.showsVerticalScrollIndicator = NO;
    contentTableView.autoresizesSubviews = YES;
    [contentTableView setDataSource:self];
    [contentTableView setDelegate:self];
    
    return contentTableView;
}

- (UIScrollView *)createContentScrollView
{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.showsHorizontalScrollIndicator = NO;
    [contentScrollView setDelegate:self];
    
    return contentScrollView;
}

- (void)registerTableViewCell
{
    [_titleTableView registerNib:[UINib nibWithNibName:@"EMNameListCell" bundle:nil] forCellReuseIdentifier:@"EMNameListCell"];
    [_contentTableView registerNib:[UINib nibWithNibName:@"EMContentListCell" bundle:nil] forCellReuseIdentifier:@"EMContentListCell"];
}

- (UILabel *)createLeftScrollTipLabel
{
    CGSize tipSize = kScrollTipLabelSize;
    CGFloat originY = .5 * (self.tableHeaderHeight - tipSize.height);
    UILabel *scrollTipImageViewLeft = [self scrollTipLabel:FAIconAngleLeft];
    scrollTipImageViewLeft.frame = CGRectMake(kTitleTableViewWidth-tipSize.width, originY, tipSize.width, tipSize.height);
    scrollTipImageViewLeft.hidden = YES;
    
    return scrollTipImageViewLeft;
}

- (UILabel *)createRightScrollTipLabel
{
    CGSize tipSize = kScrollTipLabelSize;
    CGFloat originY = .5 * (self.tableHeaderHeight - tipSize.height);
    UILabel *scrollTipImageViewRight = [self scrollTipLabel:FAIconAngleRight];
    scrollTipImageViewRight.frame = CGRectMake(self.view.frame.size.width - tipSize.width, originY, tipSize.width, tipSize.height);
    
    return scrollTipImageViewRight;
}

- (UILabel *)scrollTipLabel:(FAIcon)faicon
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];;
    label.text = [NSString fontAwesomeIconStringForEnum:faicon];
    label.font = [UIFont fontAwesomeFontOfSize:24];
    return label;
}

- (void)setViewConstraints
{
    CGSize tipSize = CGSizeMake(10, 24);
    CGFloat originY = .5 * (self.tableHeaderHeight - tipSize.height);
    
    [_backgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_contentScrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_scrollTipImageViewRight setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSString *tipRightFormatString = [NSString stringWithFormat:@"|-(>=30)-[_scrollTipImageViewRight(==%d)]-0-|",(int)tipSize.width];
    NSString *VtipRightFormatString = [NSString stringWithFormat:@"V:|-%f-[_scrollTipImageViewRight(==%d)]",originY,(int)tipSize.height];
    
    NSMutableArray *tmpConstraints = [NSMutableArray array];
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:tipRightFormatString
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:NSDictionaryOfVariableBindings(_scrollTipImageViewRight)]];
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:VtipRightFormatString
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:NSDictionaryOfVariableBindings(_scrollTipImageViewRight)]];
    [_backgroundView addConstraints:tmpConstraints];
    [_backgroundView em_addConstraintsWithContentInsets:UIEdgeInsetsMake(0, kTitleTableViewWidth, 0, 0) subView:_contentScrollView];
    [self.view em_addConstraintsWithContentInsets:_contentInsets subView:_backgroundView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}


/**
 *重新加载priceHeaderView上的子视图（button）
 *先复用之前的button，后创建新的button，多余的button从原始图上移除
 *大盘指数、重点指数不支持排序
 *根据当前排序的正序、倒序分配指示箭头
 */
-(void)reloadContentHeaderView
{
//    NSArray* buttons = [NSArray arrayWithArray:[_priceHeaderView subviews]];
//    CGFloat beginY = 0;
//    CGFloat beginX = _stockList.xSpace;
//    int reuseIndex = 0;
//    for (int i = 0; i < _stockList.fieldsCount; i++)
//    {
//        EMPriceHeaderButton *button = nil;
//        if (i < [buttons count])
//        {
//            button = [buttons objectAtIndex:i];
//            reuseIndex++;
//        }
//        else
//        {
//            button = [[EMPriceHeaderButton alloc] init];
//            [button addTarget:self action:@selector(doActionResort:) forControlEvents:UIControlEventTouchDown];
//        }
//		[button setTitle:_stockList.fieldsName[i] forState:UIControlStateNormal];
//		button.fieldSort = _stockList.fieldsSort[i];
//        button.fieldName = _stockList.fieldsName[i];
//        button.frame = CGRectMake(beginX-.5*_stockList.xSpace, beginY, _stockList.fieldsWidths[i]+_stockList.xSpace, _priceHeaderView.frame.size.height);
//        beginX += (_stockList.xSpace + _stockList.fieldsWidths[i]);
//        
//		if(_stockList.groupId != _group_zs && _stockList.groupId != _group_impzs && button.fieldSort != __sort_None)
//        {
//			if(button.fieldSort == abs(_stockList.sortId))
//            {
//                NSString *orderTag = (_stockList.sortId < 0) ? @"↑" : @"↓";
//                [button setTitle:[NSString stringWithFormat:@"%@%@", button.fieldName,orderTag]
//                        forState:UIControlStateNormal];
//                _currentOrderButton = button;
//			}
//            [button setEnabled:YES];
//		}
//		else
//        {
//            [button setEnabled:NO];
//        }
//        [_priceHeaderView addSubview:button];
//	}
//    
//    while (reuseIndex < [buttons count])
//    {
//        UIButton *button = [buttons objectAtIndex:reuseIndex];
//        [button removeFromSuperview];
//        reuseIndex++;
//    }
//
//    [_priceHeaderView  bringSubviewToFront:_scrollTipImageViewLeft];
//    [_priceHeaderView  bringSubviewToFront:_scrollTipImageViewRight];
}

- (void)didReceiveMemoryWarning
{
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && self.view.window == nil)
    {
//        [_stockList reset];
        _titleTableView.delegate    = nil;
        _titleTableView.dataSource  = nil;
        _contentTableView.delegate   = nil;
        _contentTableView.dataSource = nil;
        _contentScrollView.delegate  = nil;
        
        _backgroundView = nil;
        _titleHeaderView = nil;
        _contentHeaderView = nil;
        _titleTableView = nil;
        _contentTableView = nil;
        _contentScrollView = nil;
//        _refreshHeaderView = nil;
    }
    [super didReceiveMemoryWarning];    
}

- (void)viewDidUnload
{
//    [_stockList reset];
    _titleTableView.delegate    = nil;
    _titleTableView.dataSource  = nil;
    _contentTableView.delegate   = nil;
    _contentTableView.dataSource = nil;
    _contentScrollView.delegate  = nil;
    _backgroundView = nil;
    _titleHeaderView = nil;
    _contentHeaderView = nil;
    _titleTableView = nil;
    _contentTableView = nil;
    _contentScrollView = nil;
//    _refreshHeaderView = nil;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark -
#pragma mark sort action

-(void)doActionResort:(EMPriceHeaderButton*)button
{
//    if (_currentOrderButton && [_currentOrderButton isEqual:button] == NO)
//    {
//        [_currentOrderButton setTitle:_currentOrderButton.fieldName forState:UIControlStateNormal];
//    }
//    
//	int oldSordId = _stockList.sortId;
//	if(abs(_stockList.sortId) == abs((int)button.fieldSort))
//    {
//		_stockList.sortId = -_stockList.sortId;
//	}
//	else
//    {
//		_stockList.sortId = (int)button.fieldSort;
//	}
//    
//	if(oldSordId != _stockList.sortId)
//	{
//        if(button.fieldSort == abs(_stockList.sortId))
//        {
//            NSString *orderTag = (_stockList.sortId < 0) ? @"↑" : @"↓";
//            [button setTitle:[NSString stringWithFormat:@"%@%@", button.fieldName,orderTag]
//                    forState:UIControlStateNormal];
//        }
//        
//        [self requestDatasource];
//	}
}

#pragma mark -
#pragma mark request

/**
 *1、请求数据 _reloading 标记置为 YES
 *2、回包后将 _reloading 标记置为 NO
 *3、设置 _refreshHeaderView 完成加载
 *4、分发解析后数据，视图重新加载数据
 *5、判断是否需要自动更新行情数据
 */
- (void)requestDatasource
{
    _scrollableList.reloading = YES;
    
   NSOperation *operation =
    [_scrollableList modelWithBlock:^(NSOperation *operation, BOOL success) {
        _scrollableList.reloading = NO;
        [_operationArray removeObject:operation];
        
        if (success)
        {
            [self didLoadDataSource];
        }
    }];
    
    if (operation)
    {
        [_operationArray addObject:operation];
    }
}

/**
 *根据新数据加载视图
 *1、数据根据视图宽度计算每一项的数据的宽度 fieldWidth
 *2、根据计算结果重新加载priceHeaderView
 *3、加载两个 TableView
 */
- (void)didLoadDataSource
{
    [self layoutContentTableView];
    [self reloadContentHeaderView];
    
    [_titleTableView reloadData];
    [_contentTableView reloadData];
}


- (void)layoutContentTableView
{
    CGFloat contentWidth = [_scrollableList calculateContentTableViewWidth:_contentScrollView.frame.size.width];
    CGRect contentRect = _contentTableView.frame;
    contentRect.size.width = contentWidth;
    _contentTableView.frame = contentRect;
    _contentScrollView.contentSize = CGSizeMake(contentWidth, _contentScrollView.frame.size.height);
    _contentHeaderView.frame = CGRectMake(0, 0, contentWidth, self.tableHeaderHeight);
}


/**
 *加载缓存数据
 *如果有缓存且在盘后 返回NO
 *否则 返回yes
 */
- (BOOL)loadCacheData
{
    if ([_scrollableList isCached])
    {
        [self didLoadDataSource];
    }
    return NO;
}

#pragma mark -
#pragma mark UITableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_scrollableList numberOfRowsInSection:section];
}

/**
 *判断当前加载行是否在缓存数据区间内
 *如果超过了缓存数据区间，记录当前行
 *
 *由于通过 tableview 对象判断，区分应该加载什么数据
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_scrollableList resetDataWithCurrentRow:indexPath.row];

    if ([tableView isEqual:_titleTableView])
    {
        return [self nameTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else
    {
        return [self contentTableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)nameTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<MMCellModel> item = [_scrollableList titleItemAtIndexPath:indexPath];
    return [self tableView:tableView item:item indexPath:indexPath];
}

- (UITableViewCell *)contentTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<MMCellModel> item = [_scrollableList contentItemAtIndexPath:indexPath];
    return [self tableView:tableView item:item indexPath:indexPath];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
                          item:(id<MMCellModel>)item
                     indexPath:(NSIndexPath *)indexPath
{
    Class class = item.Class;
    
    if (class != NULL)
    {
        NSString* identifier = NSStringFromClass(class);
        id cell = (id)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        if ([cell respondsToSelector:@selector(update:indexPath:)]) {
            [cell update:item indexPath:indexPath];
        }
        else if ([cell respondsToSelector:@selector(update:)]) {
            [cell update:item];
        }
        
        if ([cell isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *aCell = cell;
            if ([aCell respondsToSelector:@selector(setLayoutMargins:)]) {
                aCell.layoutMargins = UIEdgeInsetsZero;
                aCell.preservesSuperviewLayoutMargins = NO;
            }
        }
        
        return cell;
    }
    else
    {
        return [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _titleTableView) {
        return [_scrollableList titleCellHeightAtIndex:indexPath];
    }
    else if (tableView == _contentTableView) {
        return [_scrollableList contentCellHeightAtIndex:indexPath];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.tableHeaderHeight;
}

- (UIView *)headerWithTableView:(UITableView *)tableView
                           item:(id<MMCellModel>)item
                         height:(CGFloat)headerHeight
{
    UIView *view = nil;
    if (item.isRegisterByClass) {
        view = [[item.Class alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, headerHeight)];
    }
    else{
        UINib *nib = [UINib nibWithNibName:item.reuseIdentify bundle:[NSBundle mainBundle]];
        view = [[nib instantiateWithOwner:self options:0] lastObject];
    }
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_titleTableView])
    {
        if (_titleHeaderView == nil) {
            UIView *view = [self headerWithTableView:tableView
                                 item:_scrollableList.titleHeaderItem
                               height:[_scrollableList tableViewHeaderHeight]];
            _titleHeaderView = view;
        }
        
        return _titleHeaderView;
    }
    else
    {
        if (_contentHeaderView == nil) {
            UIView *view = [self headerWithTableView:tableView
                                        item:_scrollableList.contentHeaderItem
                                      height:[_scrollableList tableViewHeaderHeight]];
            _contentHeaderView = view;
        }
        
        return _contentHeaderView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *items = [_scrollableList visiableItems];
//    int current = [_scrollableList currentSelectedIndex:indexPath];

    // 接来的事情, 自己处理了好伐
}

#pragma mark -
#pragma mark UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *) scrollView
{
	CGPoint offset = [scrollView contentOffset];
	if(offset.x == 0 && [scrollView isKindOfClass:[UITableView class]])
	{
        UIScrollView *destinationScollView = ([scrollView isEqual:_contentTableView] ? _titleTableView : _contentTableView);
        [destinationScollView setContentOffset:offset];
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
				  willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        if ([scrollView isKindOfClass:[UITableView class]])
        {
            [self loadDataWhenUserDragDown];
        }
        else if ([scrollView isEqual:_contentScrollView])
        {
            [self updateScrollTipImageViewStatus];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]])
    {
        [self loadDataWhenUserDragDown];
    }
    else if ([scrollView isEqual:_contentScrollView])
    {
        [self updateScrollTipImageViewStatus];
    }
}

- (void)loadDataWhenUserDragDown
{
    if(_scrollableList.didNeedsRequest)
    {
        [self requestDatasource];
        _scrollableList.didNeedsRequest = NO;
    }
    else
    {
        [self didLoadDataSource];
    }
}

- (void)updateScrollTipImageViewStatus
{
    if (_contentTableView.contentOffset.y < -5)
    {
        _scrollTipImageViewLeft.hidden = YES;
        _scrollTipImageViewRight.hidden = YES;
    }
    else
    {
        CGPoint contentoffset = _contentScrollView.contentOffset;
        _scrollTipImageViewLeft.hidden = (contentoffset.x > 0) ? NO : YES;
        _scrollTipImageViewRight.hidden = (contentoffset.x + _contentScrollView.frame.size.width >= _contentScrollView.contentSize.width) ? YES : NO;
    }
}

#pragma mark -
#pragma mark high light notification

- (void)didCellChangeSelectStatus:(NSNotification *)notification
{
    UITableViewCell<EMScrollableCellProtocol> *currentCell = notification.object;
    
    UITableView *otherTableView = currentCell.isTitleTableViewCell ? _contentTableView : _titleTableView;
    
    if (currentCell.selected)
    {
        [otherTableView selectRowAtIndexPath:currentCell.indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else
    {
        [otherTableView deselectRowAtIndexPath:currentCell.indexPath animated:NO];
    }
}

- (void)didCellChangeHighligtedStatus:(NSNotification *)notification
{
    UITableViewCell<EMScrollableCellProtocol> *currentCell = notification.object;
    UITableView *otherTableView = currentCell.isTitleTableViewCell ? _contentTableView : _titleTableView;
    
    UITableViewCell *cell = [otherTableView cellForRowAtIndexPath:currentCell.indexPath];
	[cell setHighlighted:currentCell.highlighted];
}

@end
