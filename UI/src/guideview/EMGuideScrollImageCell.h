//
//  EMGuideImageView.h
//  UIDemo
//
//  Created by Samuel on 15/4/27.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMGuideScrollModel.h"
#import "EMGuideScrollUpdating.h"

@interface EMGuideScrollImageItem : NSObject <EMGuideScrollModel>

@property (nonatomic, strong) UIImage *image;
@end


@interface EMGuideScrollImageCell : UIImageView <EMGuideScrollUpdating>

@end
