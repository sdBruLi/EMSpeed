//
//  EMScrollableList.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMScrollableProtocol.h"
#import "MMMutableDataSource.h"

@interface EMScrollableList : NSObject <EMScrollableProtocol>

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign, getter=isReloading) BOOL reloading;
@property (nonatomic, assign) BOOL didNeedsRequest;
@property (nonatomic, strong) MMMutableDataSource *titleDataSource;
@property (nonatomic, strong) MMMutableDataSource *contentDataSource;

- (instancetype)init;

- (Class)titleCellClassWithIndexPath:(NSIndexPath *)indexPath;
- (Class)contentCellClassWithIndexPath:(NSIndexPath *)indexPath;

- (NSUInteger)numberOfRowsInSection:(NSInteger)section;
- (BOOL)isCached;
- (BOOL)resetDataWithCurrentRow:(NSInteger)row;

- (id<MMCellModel>)titleItemAtIndexPath:(NSIndexPath *)indexPath;
- (id<MMCellModel>)contentItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray *)visiableItems;
- (int)currentSelectedIndex:(NSIndexPath *)indexPath;

- (CGFloat)calculateTitleTableViewWidth:(CGFloat)width;
- (CGFloat)calculateContentTableViewWidth:(CGFloat)width;


- (id)modelWithBlock:(void (^)(NSOperation *operation, BOOL success))block;

@end