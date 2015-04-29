//
//  EMInfoNewsModel.h
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "EMHTTPRequestModel.h"
#import "MMMutableDataSource.h"


@interface EMVIPModel : EMHTTPRequestModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) int Id;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) MMMutableDataSource *dataSource;
@property (nonatomic, strong) NSArray *cellIdentifiers;
@property (nonatomic, assign) id actionDelegate;

- (id)initWithTitle:(NSString *)title
                 Id:(int)Id
                url:(NSString *)url;

- (AFHTTPRequestOperation *)modelWithUrl:(NSString *)url block:(void (^)(id, AFHTTPRequestOperation *, BOOL))block;
// subclass over write
- (BOOL)parseURLResponse:(NSDictionary*)dictionary url:(NSString*)url;

@end
