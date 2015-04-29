//
//  EMStatusBarData.h
//  UI
//
//  Created by Samuel on 15/4/9.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMStatusBarModel.h"

@interface EMStatusBarTextModel : NSObject <EMStatusBarModel>

- (UIView<EMStatusBarUpdating> *)statusBarWithData:(id<EMStatusBarModel>)data;
@end
