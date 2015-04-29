//
//  UICollectionViewTestItem.m
//  Coll
//
//  Created by Samuel on 15/4/16.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMCollectionViewTestItem.h"
#import "EMCollectionViewTestCell.h"
#import "EMCollectionViewTestCell2.h"

@implementation EMCollectionViewTestItem

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize layoutSize;
@synthesize isRegisterByClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 140;
        self.Class = [EMCollectionViewTestCell class];
        self.reuseIdentify = @"EMCollectionViewTestCell";
        self.title = @"title";
        self.layoutSize = CGSizeMake(EMScreenWidth(), self.height);
        self.isRegisterByClass = NO;
    }
    
    return self;
}

- (float)calculateHeight
{
    return self.height;
}

@end