//
//  MMStockWebModel.m
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-13.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MMInfoModel.h"
#import "MMInfoCell.h"
#import "MMInfoCell2.h"
#import "MMInfoItem.h"
#import "MMInfoItem3.h"
#import "EMParseableObject+CellModel.h"
#import "EMHTTPResponse.h"

@implementation MMInfoModel
@synthesize dataSource = _dataSource;


- (BOOL)parseHTTPResponse:(EMHTTPResponse *)response
                      URL:(NSString *)URLString
{
    id responseObject = response.responseData;
    
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSArray *array = [responseObject objectForKey:@"o"];
        
        if ([array count] == 0) {
            return NO;
        }
        
        Class cls = [MMInfoCellModel class];
        NSMutableArray *cellModels = [MMInfoItem cellModelsWithArray:array cellModelClass:cls];
        
        
        for (MMInfoCellModel *cellModel in cellModels) {
            cellModel.delegate = self.delegate;
        }
        
        if ([cellModels count] > 0) {
            _dataSource = [[MMMutableDataSource alloc] init];
            [_dataSource addNewSection:@"" withItems:cellModels];
            
            return YES;
        }
    }
    
    return NO;
}


@end


@implementation MMInfoModel2

- (BOOL)parseResponseObject:(id)responseObject
                        URL:(NSString *)URLString
{
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSArray *array = [responseObject objectForKey:@"o"];
        
        if ([array count] == 0) {
            return NO;
        }
        
        Class cls = [MMInfoCellModel2 class];
        NSMutableArray *items = [MMInfoItem cellModelsWithArray:array cellModelClass:cls];
        
        if ([items count] > 0) {
            _dataSource = [[MMMutableDataSource alloc] init];
            [_dataSource addNewSection:@"" withItems:items];
            
            return YES;
        }
    }
    
    return NO;
}

@end


@implementation MMInfoModel3

- (BOOL)parseResponseObject:(id)responseObject
                        URL:(NSString *)URLString
{
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSArray *array = [responseObject objectForKey:@"o"];
        
        NSMutableArray *items = nil;
        
        if ([array count] > 0) {
            items = [MMInfoItem3 parseArray:array];
        }
        
        if ([items count] > 0) {
            _dataSource = [[MMMutableDataSource alloc] init];
            [_dataSource addNewSection:@"" withItems:items];
        }
        
        return YES;
    }
    
    return NO;
}

@end



