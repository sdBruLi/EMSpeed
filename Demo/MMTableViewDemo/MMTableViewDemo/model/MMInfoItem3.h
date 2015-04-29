//
//  MMInfoItem2.h
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MMCellModel.h"
#import "EMParseableObject.h"
#import "NSObject+reflect.h"


@interface MMInfoItem3 : EMParseableObject <MMCellModel>

@property (nonatomic, strong) NSString *n_id;
@property (nonatomic, strong) NSString *n_id_id;
@property (nonatomic, strong) NSString *n_title;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *c;
@property (nonatomic, strong) NSString *n;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)parse:(NSDictionary *)info options:(NSUInteger)options;

@end

