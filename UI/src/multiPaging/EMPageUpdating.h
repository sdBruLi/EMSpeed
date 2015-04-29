//
//  EMPageUpdating.h
//  UI
//
//  Created by Samuel on 15/4/8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMPageModel.h"

@protocol EMPageUpdating

@required
- (void)updatePageView:(id<EMPageModel>)pageModel;

@end
