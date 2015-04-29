//
//  EMThemeSegmentedControl.m
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMThemeSegmentedControl.h"
#import "EMThemeSegmentCellFactory.h"

@implementation EMThemeSegmentedControl


- (void)applyTheme{
    self.backgroundColor = [UIColor colorForKey:@"common_segmentBgColor"];
}

- (Class)segmentCellFactoryClass
{
    return [EMThemeSegmentCellFactory class];
}

- (Class)selectedViewClassWithStyle:(EMSegmentSelectedIndicatorStyle)style
{
    if (style == EMSegmentSelectedIndicatorStyleArrowBar) {
        return [EMSegmentSelectedIndicatorArrowBar class];
    }
    else if (style == EMSegmentSelectedIndicatorStyleArrowLine) {
        return [EMSegmentSelectedIndicatorArrowLine class];
    }
    
    // add more style here...
    
    return nil;
}

# pragma mark - 不同的颜色


- (void)registerThemeChangeNotificaiton {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:RNThemeManagerDidChangeThemes object:nil];
}

- (instancetype)initWithItems:(NSArray *)items {
    if (self = [super initWithItems:items]) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self applyTheme];
}

- (void)themeDidChangeNotification:(NSNotification *)notification {
    [self applyTheme];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
