//
//  EMOverlayerFunctionGuidCell.h
//  EMStock
//
//  Created by xoHome on 14-10-22.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMGuideScrollModel.h"
#import "EMGuideScrollUpdating.h"


@interface EMGuideScrollOverlayerItem : NSObject<EMGuideScrollModel>

@property (nonatomic, strong) UIImage *image;

@end


@interface EMGuideScrollOverlayerCell : UIImageView<EMGuideScrollUpdating>
{
    
}
@end
