//
//  EMButtonItem.h
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCellModel.h"

@interface EMMenuItem : NSObject <MMCellModel>

@property (nonatomic, strong) NSString *title;

@end
