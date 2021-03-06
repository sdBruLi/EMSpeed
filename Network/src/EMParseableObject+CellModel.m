//
//  EMParseableObjectCellModel.m
//  MMTableViewDemo
//
//  Created by Samuel on 15/4/29.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "EMParseableObject+CellModel.h"


@implementation EMParseableObject(CellModel)

+ (id<MMCellModel>)cellModelWithData:(NSDictionary *)dictionary
                      cellModelClass:(Class)cls
{
    EMParseableObject *obj = [self instanceWithData:dictionary];
    
    id<MMCellModel> cellModel = [[cls alloc] init];
    [cellModel parseItem:obj];
    
    return cellModel;
}

+ (NSMutableArray *)cellModelsWithArray:(NSArray *)array
                         cellModelClass:(Class)cls
{
    NSMutableArray *cellModels = [NSMutableArray array];
    
    for (NSDictionary *info in array) {
        id<MMCellModel> cellModel = [self cellModelWithData:info cellModelClass:cls];
        [cellModels addObject:cellModel];
    }
    
    return cellModels;
}

@end





