//
//  EMParseableObjectCellModel.m
//  MMTableViewDemo
//
//  Created by Samuel on 15/4/29.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "EMParseableCellModel.h"


@implementation EMParseableCellModel

+ (id<MMCellModel>)cellModelWithData:(NSDictionary *)info
                           cellClass:(Class)cls
{
    EMParseableCellModel *obj = [self instanceWithData:info];
    
    id<MMCellModel> cellModel = [[cls alloc] init];
    [cellModel parseItem:obj];
    
    return cellModel;
}

+ (NSMutableArray *)cellModelsWithArray:(NSArray *)infos
                              cellClass:(Class)cls
{
    NSMutableArray *cellModels = [NSMutableArray array];
    
    for (NSDictionary *info in infos) {
        id<MMCellModel> cellModel = [self cellModelWithData:info cellClass:cls];
        [cellModels addObject:cellModel];
    }
    
    return cellModels;
}

@end





