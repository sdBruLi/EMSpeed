//
//  EMPageImageView.h
//  UI
//
//  Created by Samuel on 15/4/9.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMPageUpdating.h"

@interface EMPageImageView : UIImageView <EMPageUpdating> {
}

- (instancetype)initWithFrame:(CGRect)frame;
- (void)updatePageView:(id <EMPageModel>)pageModel;

@end