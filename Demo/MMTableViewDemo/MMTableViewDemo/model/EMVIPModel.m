//
//  EMInfoNewsModel.m
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "EMVIPModel.h"
#import "MMMutableDataSource.h"
#import "EMInfoNewsItem.h"

NSString *infoNewsIDStringWithObject(id obj);

@implementation EMVIPModel

- (id)initWithTitle:(NSString *)title
                 Id:(int)Id
                url:(NSString *)url
{
    self = [super init];
    if (self) {
        self.title = title;
        self.Id = Id;
        self.url = url;
    }
    
    return self;
}

- (AFHTTPRequestOperation *)modelWithUrl:(NSString *)url block:(void (^)(id, AFHTTPRequestOperation *, BOOL))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    return [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self parseURLResponse:responseObject url:url];
        block(responseObject, operation, YES);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, operation, NO);
    }];
}

- (BOOL)parseURLResponse:(NSDictionary*)dictionary url:(NSString *)url
{
    if (dictionary==nil || [[dictionary allKeys] count]<=0) {
        return NO;
    }
    
    //    BOOL isMore = [url rangeOfString:@"lastid"].location != NSNotFound;
    BOOL isRefresh = [url rangeOfString:@"topid"].location != NSNotFound;
    
    NSMutableArray *vipNewsItems = nil;
    NSString *newsTitle = @"VIP资讯";
    
    MMMutableDataSource *ds = (MMMutableDataSource *)self.dataSource;
    if ([ds itemsAtSectionWithTitle:newsTitle]) {
        vipNewsItems = [NSMutableArray arrayWithArray:[ds itemsAtSectionWithTitle:newsTitle]];
    }
    
    if (vipNewsItems==nil) {
        vipNewsItems = [NSMutableArray array];
    }
    
    // VIP新闻
    NSArray *vip = nil;
    if (isRefresh) {
        vip = [NSArray arrayWithArray:[[[dictionary objectForKey:@"news"] reverseObjectEnumerator] allObjects]];
    }
    else{
        vip = [dictionary objectForKey:@"news"];
    }
    
    if (vip && [vip count]>0) {
        for (int i=0; i<[vip count]; i++) {
            NSDictionary *dict = [vip objectAtIndex:i];
            EMInfoNewsItem *tmp = [[EMInfoNewsItem alloc] initWithDictionary:dict];
            tmp.jianText = [NSString stringWithFormat:@"%d", i+1];
            [vipNewsItems addObject:tmp];
        }
    }
    
    MMMutableDataSource *dsTmp = [[MMMutableDataSource alloc] init];
    [dsTmp addNewSection:@"VIP资讯" withItems:vipNewsItems];
    
    NSString *refresh = infoNewsIDStringWithObject([dictionary objectForKey:@"refresh"]);
    NSString *moreID = infoNewsIDStringWithObject([dictionary objectForKey:@"more"]);
    if ([moreID length]>0) {
        if (![moreID isEqualToString:@"-1"]) {
            dsTmp.nextPageURL = [NSString stringWithFormat:@"%@?lastid=%@", self.url, moreID];
        }
        else{
            dsTmp.nextPageURL = nil;
        }
    }
    else{
        dsTmp.nextPageURL = ds.nextPageURL;
    }
    
    if ([refresh length]>0) {
        dsTmp.refreshURL = [NSString stringWithFormat:@"%@?topid=%@", self.url, refresh];
    }
    else{
        dsTmp.refreshURL = ds.refreshURL;
    }
    
    self.dataSource = dsTmp;
    
    return YES;
}


@end


NSString *infoNewsIDStringWithObject(id obj)
{
    if ([obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    }
    
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%d", [((NSNumber *)obj) intValue]];
    }
    
    return nil;
}

