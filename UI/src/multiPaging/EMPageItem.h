//
//  EMPageData.h
//  UI
//
//  Created by Samuel on 15/4/9.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMPageModel.h"

@interface EMPageItem : NSObject<EMPageModel>

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
