//
//  MMInfoCell2.m
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-26.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MMInfoCell2.h"
#import "MMInfoItem.h"

@implementation MMInfoCell2

- (void)update:(id<MMCellModel>)cellModel
{
    if ([cellModel isKindOfClass:[MMInfoCellModel2 class]]) {
        MMInfoCellModel2 *cm = cellModel;
        self.titleLabel.text = cm.title;
        self.dateLabel.text = cm.dateString;
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation MMInfoCellModel2

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;

- (void)parseItem:(MMInfoItem *)item
{
    self.Class = [MMInfoCell2 class];
    
    // cell model 数据的处理在这里
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:item.date];
    
    [dateFormatter setDateFormat:@"MM/dd HH:mm"];
    self.dateString = [dateFormatter stringFromDate:date];
    
    self.title = [NSString stringWithFormat:@"标题:%@", item.n_title];
    
    self.height = 115;
}

- (float)calculateHeight
{
    /**
     *  计算高度
     */
    
    
    return self.height;
}


@end