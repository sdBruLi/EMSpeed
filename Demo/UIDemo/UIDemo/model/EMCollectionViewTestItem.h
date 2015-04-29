//
//  UICollectionViewTestItem.h
//  Coll
//
//  Created by Samuel on 15/4/16.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCollectionCellModel.h"

@interface EMCollectionViewTestItem : NSObject <MMCollectionCellModel>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgName;
@end