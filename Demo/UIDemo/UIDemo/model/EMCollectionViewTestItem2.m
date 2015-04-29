//
//  UICollectionViewTestItem.m
//  Coll
//
//  Created by Samuel on 15/4/16.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMCollectionViewTestItem2.h"
#import "EMCollectionViewTestCell2.h"

@implementation EMCollectionViewTestItem2

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
        self.Class = [EMCollectionViewTestCell2 class];
        self.reuseIdentify = @"EMCollectionViewTestCell2";
        self.title = @"title";
        self.layoutSize = CGSizeMake(EMScreenWidth(), self.height);
        self.isRegisterByClass = YES;
    }
    
    return self;
}

- (float)calculateHeight
{
    return self.height;
}

@end