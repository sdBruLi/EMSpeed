//
//  EMLaunchGuidView.h
//  EMStock
//
//  Created by flora on 14/11/14.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMGuideScrollModel.h"
#import "EMGuideScrollUpdating.h"

@interface EMGuideScrollLaunchItem : NSObject<EMGuideScrollModel>

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIColor *backgroundColor;

@end


@interface EMGuideScrollLaunchCell : UIImageView<EMGuideScrollUpdating>
{
    
}
@end
