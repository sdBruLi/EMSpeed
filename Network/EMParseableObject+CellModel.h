//
//  EMParseableObjectCellModel.h
//  MMTableViewDemo
//
//  Created by Samuel on 15/4/29.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "EMParseableObject.h"
#import "MMCellModel.h"
#import "EMCellModelParser.h"


@interface EMParseableObject(CellModel) <EMCellModelParser>


+ (id<MMCellModel>)cellModelWithData:(NSDictionary *)info cellModelClass:(Class)cls;
+ (NSMutableArray *)cellModelsWithArray:(NSArray *)infos cellModelClass:(Class)cls;


@end
