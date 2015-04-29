//
//  EMInfoNewsCell.h
//  EMStock
//
//  Created by Mac mini 2012 on 14-10-29.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+reflect.h"


@interface EMInfoNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jianLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end


extern NSString *infoDateStringByString(NSString *str);
extern NSString *infoDateStringByStringNewsList(NSString *str);
extern NSString* infoURLWebGuidAndCSSType(NSString *string);
