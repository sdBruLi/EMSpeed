//
//  EMCollectionViewTestCell.m
//  Coll
//
//  Created by Samuel on 15/4/15.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMCollectionViewTestCell.h"
#import "EMCollectionViewTestItem.h"

@implementation EMCollectionViewTestCell

- (void)update:(id<MMCollectionCellModel>)cellModel
{
    if ([cellModel isKindOfClass:[EMCollectionViewTestItem class]]) {
        EMCollectionViewTestItem *item = cellModel;
        
        self.titleLabel.text = item.title;
        self.imgv.image = [UIImage imageNamed:item.imgName];
    }
}

- (void)update:(id<MMCollectionCellModel>)cellModel indexPath:(NSIndexPath *)indexPath
{
    if ([cellModel isKindOfClass:[EMCollectionViewTestItem class]]) {
        EMCollectionViewTestItem *item = cellModel;
        
        self.titleLabel.text = item.title;
        self.imgv.image = [UIImage imageNamed:item.imgName];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

@end

