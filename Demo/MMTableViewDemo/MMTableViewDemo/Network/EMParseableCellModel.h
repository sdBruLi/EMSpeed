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

@interface EMParseableCellModel : EMParseableObject <EMCellModelParser>


+ (id<MMCellModel>)cellModelWithData:(NSDictionary *)info
                           cellClass:(Class)cls;
+ (NSMutableArray *)cellModelsWithArray:(NSArray *)infos
                              cellClass:(Class)cls;


@end
