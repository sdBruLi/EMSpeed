//
//  EMThemeImageSegmentedCell.h
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMImageSegmentedCell.h"

@interface EMThemeImageSegmentedCellObject : EMTextSegmentCellObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;

+ (instancetype)objectWithTitle:(NSString *)title image:(UIImage *)image;

@end


@interface EMThemeImageSegmentedCell : EMImageSegmentedCell

@end
