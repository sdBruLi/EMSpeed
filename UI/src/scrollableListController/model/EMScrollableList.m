//
//  EMScrollableList.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMScrollableList.h"
#import "EMNameListItem.h"
#import "EMContentListItem.h"
#import "EMScrollableTableTitleHeaderView.h"
#import "EMScrollableTableContentHeaderView.h"
#import "MMCellModel.h"

@implementation EMScrollableList

@synthesize cellHeight;
@synthesize reloading;
@synthesize didNeedsRequest;
@synthesize titleHeaderItem;
@synthesize contentHeaderItem;
@synthesize titleDataSource;
@synthesize contentDataSource;


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 44;
        self.reloading = NO;
        self.didNeedsRequest = YES;
        
        int numberOfItems = 15;
        NSMutableArray *items = [NSMutableArray array];
        for (int i=0; i<numberOfItems; i++) {
            EMNameListItem *item = [[EMNameListItem alloc] init];
            [items addObject:item];
        }
        self.titleDataSource = [[MMMutableDataSource alloc] initWithItems:@[items] sections:@[@""]];
        
        items = [NSMutableArray array];
        for (int i=0; i<numberOfItems; i++) {
            EMContentListItem *item = [[EMContentListItem alloc] init];
            [items addObject:item];
        }
        self.contentDataSource = [[MMMutableDataSource alloc] initWithItems:@[items] sections:@[@""]];
        
        self.titleHeaderItem = [[EMScrollableTableTitleHeaderItem alloc] init];
        self.contentHeaderItem = [[EMScrollableTableContentHeaderItem alloc] init];
    }
    
    return self;
}

- (Class)titleCellClassWithIndexPath:(NSIndexPath *)indexPath
{
    id<MMCellModel> model = [self.titleDataSource itemAtIndexPath:indexPath];
    return model.Class;
}

- (Class)contentCellClassWithIndexPath:(NSIndexPath *)indexPath
{
    id<MMCellModel> model = [self.contentDataSource itemAtIndexPath:indexPath];
    return model.Class;
}

- (NSUInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self.titleDataSource numberOfItemsAtSection:section];
}

- (BOOL)isCached
{
    return NO;
}

- (BOOL)resetDataWithCurrentRow:(NSInteger)row
{
    return YES;
}

- (id<MMCellModel>)titleItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.titleDataSource itemAtIndexPath:indexPath];
}

- (id<MMCellModel>)contentItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.contentDataSource itemAtIndexPath:indexPath];
}

- (NSArray *)visiableItems
{
    return nil;
}

- (int)currentSelectedIndex:(NSIndexPath *)indexPath
{
    return 0;
}

- (CGFloat)calculateTitleTableViewWidth:(CGFloat)width
{
    return 90;
}

- (CGFloat)calculateContentTableViewWidth:(CGFloat)width
{
    return 800;
}

- (CGFloat)tableViewHeaderHeight
{
    return MAX(self.titleHeaderItem.height, self.contentHeaderItem.height) ;
}

- (BOOL)hasMorePages
{
    return YES;
}

- (CGFloat)titleCellHeightAtIndex:(NSIndexPath *)indexPath
{
    id<MMCellModel> model = [self.titleDataSource itemAtIndexPath:indexPath];
    return model.height;
}

- (CGFloat)contentCellHeightAtIndex:(NSIndexPath *)indexPath
{
    id<MMCellModel> model = [self.contentDataSource itemAtIndexPath:indexPath];
    return model.height;
}

@end
